import { Box, Button } from "@mui/material";
import { DataGrid } from "@mui/x-data-grid";
import React, { useState, useEffect } from "react";
import Head from "../../Components/Head";
import { Modal } from 'antd';
import './team.css'; // Import the custom CSS
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { ConfigProvider } from 'antd';
import { useTheme } from "@mui/material";
import { tokens } from "../../theme";
import { fetchWithAuth } from "../../Components/fetchWithAuth/fetchWithAuth";
import { jwtDecode } from 'jwt-decode';

const User = () => {
  const [rows, setRows] = useState([]);
  const token = sessionStorage.getItem('token');
  const [loading, setLoading] = useState(false);
  const [open, setOpen] = useState(false);
  const [selectedRow, setSelectedRow] = useState(null);
  const [roles, setRoles] = useState([]); // State to store roles
  const [branches, setBranches] = useState([]);
  const [addOpen, setAddOpen] = useState(false);
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  const decodedToken = jwtDecode(token); // Decode the JWT token to get user information
  const tokenUserId = decodedToken.UserId; // Extract userId from the decoded token
  const tokenRole = decodedToken.Role;

  // Define initial state values
  const initialState = {
    username: '',
    password: '',
    branch: '',
    balance: '',
    activeStatus: '',
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    role: ''
  };

  // Use a single state object to manage form fields
  const [formState, setFormState] = useState(initialState);

  const showModal = (row) => {
    setSelectedRow(row); // Update selectedRow with the selected row
    // Set form state based on selectedRow values
    setFormState({
      id: row.userId,
      username: row.userName || '',
      password: row.password || '',
      branch: row.branchId || '',
      balance: row.balance || '',
      activeStatus: row.activeStatus !== null ? row.activeStatus.toString() : '',
      firstName: row.firstName || '',
      lastName: row.lastName || '',
      email: row.email || '',
      phone: row.phone || '',
      role: row.roleId || ''
    });
    setOpen(true);
  };

  const handleOk = () => {
    const userData = formState;

    // If activeStatus is set to true, reset accessFail to 0
    if (userData.activeStatus === 'true') {
      userData.accessFail = 0;
    }

    fetchWithAuth(`https://localhost:7233/User/Update?userId=` + userData.id + "&username=" + userData.username + "&password=" + userData.password + "&branchId=" + userData.branch + "&roleId=" + userData.role + "&firstName=" + userData.firstName + "&lastName=" + userData.lastName + "&phone=" + userData.phone + "&email=" + userData.email + "&status=" + userData.activeStatus + "&balence=" + userData.balance + "&accessFail=" + userData.accessFail + "&actorId=" + tokenUserId, {
      method: "PUT",
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(userData)
    }).then(response => response.json())
      .then((res) => {
        toast.success(res.msg);
      })
      .catch((error) => {
        console.error('Error updating user:', error);
      });
    setLoading(true);
    setTimeout(() => {
      setLoading(false);
      setOpen(false);
      setFormState(initialState); // Reset form state to initial values
    }, 1000);
  };

  const handleCancel = () => {
    setOpen(false);
    setFormState(initialState); // Reset form state to initial values
  };

  const isValidate = () => {
    let isProceed = true;

    const email = formState.email;
    const phone = formState.phone;
    const password = formState.password;

    if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[A-Za-z]{2,}$/.test(email)) {
      isProceed = false;
      toast.warning('Please enter a valid email');
    }

    if (!/^\d{10}$/.test(phone)) {
      isProceed = false;
      toast.warning('Please enter a valid phone number');
    }

    if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_\-+=<>?])[A-Za-z\d!@#$%^&*()_\-+=<>?]{12,}$/.test(password)) {
      isProceed = false;
      toast.warning('Please enter a secure password. It should be at least 12 characters long and include uppercase, lowercase, digit, and special character.');
    }

    return isProceed;
  };

  const handleAddOk = () => {
    //isValidate();
    if (!isValidate()) {
      return;
    }

    // Create a temporary role variable
    let role = formState.role;

    if (tokenRole !== 'admin') {
      role = 'R003';
    }

    // Construct the data for the new user
    const newUser = {
      username: formState.username,
      password: formState.password,
      branch: formState.branch,
      firstName: formState.firstName,
      lastName: formState.lastName,
      email: formState.email,
      phone: formState.phone,
      role: role
    };

    // Send a POST request to the API endpoint to add the new user
    fetchWithAuth(`https://localhost:7233/User/Add?UserName=` + newUser.username + "&Password=" + newUser.password + "&FirstName=" + newUser.firstName + "&LastName=" + newUser.lastName + "&Branch=" + newUser.branch + "&RoleId=" + newUser.role + "&Email=" + newUser.email + "&Phone=" + newUser.phone, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(newUser)
    }).then(response => response.json())
      .then((res) => {
        toast(res.msg);
      })
      .catch((error) => {
        toast.warning('Error adding user:', error);
        // Handle errors, such as displaying an error message to the user
      });

    setLoading(true);
    setTimeout(() => {
      setLoading(false);
      setAddOpen(false);
      setFormState(initialState); // Reset form state to initial values
    }, 1000);
  };

  const handleAddCancel = () => {
    setAddOpen(false);
    setFormState(initialState); // Reset form state to initial values
  };

  const addUser = () => {
    setAddOpen(true);
  };

  useEffect(() => {
    if (!token) {
      console.error('Token not found. Please log in.');
      return;
    }

    const fetchData = async () => {
      try {
        const [userDetailsRes, rolesRes, usersRes, branchesRes] = await Promise.all([
          fetchWithAuth(`https://localhost:7233/UserDetail/GetAll`, {
            method: "GET",
            headers: {
              'Authorization': `Bearer ${token}`,
              'Content-Type': 'application/json'
            }
          }),
          fetchWithAuth(`https://localhost:7233/Role/GetAll`, {
            method: "GET",
            headers: {
              'Authorization': `Bearer ${token}`,
              'Content-Type': 'application/json'
            }
          }),
          fetchWithAuth(`https://localhost:7233/User/GetAll`, {
            method: "GET",
            headers: {
              'Authorization': `Bearer ${token}`,
              'Content-Type': 'application/json'
            }
          }),
          fetchWithAuth(`https://localhost:7233/Branch/GetAll`, {
            method: "GET",
            headers: {
              'Authorization': `Bearer ${token}`,
              'Content-Type': 'application/json'
            }
          })
        ]);

        if (!userDetailsRes.ok || !rolesRes.ok || !usersRes.ok || !branchesRes.ok) {
          throw new Error('Failed to fetch data');
        }

        const [userDetails, roles, users, branches] = await Promise.all([
          userDetailsRes.json(),
          rolesRes.json(),
          usersRes.json(),
          branchesRes.json()
        ]);

        roles.forEach(role => {
          if (!role.roleId || !role.roleName) {
            throw new Error(`Role data is missing roleId or roleName: ${JSON.stringify(role)}`);
          }
        });

        setRoles(roles); // Store roles in state

        setBranches(branches); // Store branches in state

        const mergedData1 = userDetails.map(userDetail => {
          const user = users.find(u => u.userId === userDetail.userId);
          if (user) {
            return { ...userDetail, ...user };
          }
          return userDetail;
        });

        const mergedData2 = mergedData1.map(userDetail => {
          const branch = branches.find(b => b.branchId === userDetail.branchId);
          if (branch) {
            return { ...userDetail, branchName: branch.branchName };
          }
          return userDetail;
        });

        const formattedData = mergedData2.map((row, index) => {
          const role = roles.find(r => r.roleId === row.roleId);
          return { id: index + 1, ...row, role: role ? role.roleName : 'Unknown' };
        });

        setRows(formattedData);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();

    const intervalId = setInterval(fetchData, 1000);

    return () => clearInterval(intervalId);
  }, [token]);

  const handleDelete = (id) => {
    fetchWithAuth(`https://localhost:7233/User/Delete?id=${id}`, {
      method: "DELETE",
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      }
    })
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        // Kiểm tra nếu có nội dung phản hồi
        return response.text(); // Sử dụng text() thay vì json()
      })
      .then(text => {
        if (text) {
          const data = JSON.parse(text);
          toast.success('User banned successfully.');
          setRows(prevRows => prevRows.filter(row => row.id !== id));
        } else {
          // Không có nội dung phản hồi
          toast.success('User banned successfully.');
          setRows(prevRows => prevRows.filter(row => row.id !== id));
        }
      })
      .catch(error => {
        console.error('Error banned user:', error);
        toast.error('Error banned user.');
      });
  };

  const columns = [
    { field: "userId", headerName: "UserID", align: "center", headerAlign: "center" },
    { field: "firstName", headerName: "First Name", flex: 1, align: "center", headerAlign: "center" },
    { field: "lastName", headerName: "Last Name", flex: 1, align: "center", headerAlign: "center" },
    { field: "email", headerName: "Email", flex: 1, align: "center", headerAlign: "center" },
    { field: "phone", headerName: "Phone", flex: 1, align: "center", headerAlign: "center" },
    { field: "role", headerName: "Role", flex: 1, align: "center", headerAlign: "center" },
    {
      field: "activeStatus", headerName: "Active Status", flex: 1, align: "center", headerAlign: "center", renderCell: (params) => (
        <Box color={params.value ? 'green' : 'red'}>
          {params.value ? 'Active' : 'Banned'}
        </Box>
      )
    },
    {
      field: "actions",
      headerName: "Actions",
      sortable: false,
      flex: 1,
      align: "center",
      headerAlign: "center",
      renderCell: (params) => (
        <Box>
          <Button type="primary" onClick={() => showModal(params.row)}
            variant="contained"
            color="primary"
            size="small"
          >
            Edit Info
          </Button>
          <Button
            variant="contained"
            size="small"
            onClick={() => handleDelete(params.row.userId)}
            style={{ backgroundColor: '#b22222', color: 'white', marginLeft: 8 }}
          >
            Ban
          </Button>
        </Box>
      )
    }
  ];

  return (
    <ConfigProvider theme={{
      token: {
        colorPrimary: theme.palette.primary.main,
        colorSuccess: theme.palette.success.main,
        colorWarning: theme.palette.warning.main,
        colorError: theme.palette.error.main,
        colorInfo: theme.palette.info.main,
      },
    }}>
      <Box m="20px">
        <Head title="User" subtitle="Managing the User Accounts" />
        <Box>
          <button className="button-adduser" type="primary" onClick={addUser} variant="contained" color="primary" size="small">
            Add User
          </button>
          <Modal
            width={1000}
            open={open}
            title="User Information"
            onOk={handleOk}
            onCancel={handleCancel}
            className="custom-modal"
            footer={[
              <Button key="back" onClick={handleCancel} className="button-hover-black">
                Return
              </Button>,
              <Button key="submit" type="primary" loading={loading || undefined} onClick={handleOk} className="button-hover-black">
                Submit
              </Button>
            ]}
            centered
          >
            <form action="">
              <div className="user-modal">
                <div className="user-modal-left">
                  <div className="user-modal-item">
                    <div className="user-modal-item-text1">
                      <p>Username:</p>
                      <p>First Name:</p>
                      <p>Email:</p>
                      {tokenRole === 'Admin' && (
                        <>
                          <p>Role:</p>
                        </>
                      )}
                      <p>Active Status:</p>
                    </div>
                    <div className="user-modal-item-value">
                      <input
                        value={formState.username}
                        placeholder={selectedRow ? selectedRow.userName : ''}
                        onChange={e => setFormState({ ...formState, username: e.target.value })}
                        className="input-box-modal"
                        type="text"
                      />
                      <input
                        value={formState.firstName}
                        placeholder={selectedRow ? selectedRow.firstName : ''}
                        onChange={e => setFormState({ ...formState, firstName: e.target.value })}
                        className="input-box-modal"
                        type="text"
                      />
                      <input
                        value={formState.email}
                        placeholder={selectedRow ? selectedRow.email : ''}
                        onChange={e => setFormState({ ...formState, email: e.target.value })}
                        className="input-box-modal"
                        type="text"
                      />
                      {tokenRole === 'Admin' && (
                        <>
                          <select
                            value={formState.role}
                            onChange={(e) => setFormState({ ...formState, role: e.target.value })}
                            className="input-box-modal"
                          >
                            <option value="" disabled hidden>{selectedRow ? selectedRow.role : 'Select role'}</option>
                            {roles.map(role => (
                              <option key={role.roleId} value={role.roleId}>{role.roleName}</option>
                            ))}
                          </select>
                        </>
                      )}
                      <select
                        value={formState.activeStatus}
                        onChange={e => setFormState({ ...formState, activeStatus: e.target.value })}
                        className="input-box-modal"
                        type="text"
                      >
                        <option value="" disabled hidden>{selectedRow ? selectedRow.activeStatus.toString() : 'Select status'}</option>
                        <option value="true">Active</option>
                        <option value="false">Banned</option>
                      </select>
                    </div>
                  </div>
                </div>
                <div className="user-modal-right">
                  <div className="user-modal-item">
                    <div className="user-modal-item-text2">
                      <p>Password:</p>
                      <p>Last Name:</p>
                      {tokenRole === 'Admin' && (
                        <>
                          <p>Branch:</p>
                        </>
                      )}
                      <p>Phone:</p>
                      <p>Balance:</p>
                    </div>
                    <div className="user-modal-item-value">
                      <input
                        value={formState.password}
                        placeholder={selectedRow ? selectedRow.password : ''}
                        onChange={e => setFormState({ ...formState, password: e.target.value })}
                        className="input-box-modal"
                        type="password"
                      />
                      <input
                        value={formState.lastName}
                        placeholder={selectedRow ? selectedRow.lastName : ''}
                        onChange={e => setFormState({ ...formState, lastName: e.target.value })}
                        className="input-box-modal"
                        type="text"
                      />
                      {tokenRole === 'Admin' && (
                        <>
                          <select
                            value={formState.branch}
                            onChange={(e) => setFormState({ ...formState, branch: e.target.value })}
                            className="input-box-modal"
                          >
                            <option value="" disabled hidden>{selectedRow ? selectedRow.branchName : 'Select branch'}</option>
                            {branches.map(branch => (
                              <option key={branch.branchId} value={branch.branchId}>{branch.branchName}</option>
                            ))}
                          </select>
                        </>
                      )}
                      <input
                        value={formState.phone}
                        placeholder={selectedRow ? selectedRow.phone : ''}
                        onChange={e => setFormState({ ...formState, phone: e.target.value })}
                        className="input-box-modal"
                        type="text"
                      />
                      <input
                        value={formState.balance}
                        placeholder={selectedRow ? selectedRow.balance : ''}
                        onChange={e => setFormState({ ...formState, balance: e.target.value })}
                        className="input-box-modal"
                        type="number"
                        min="0"
                      />
                    </div>
                  </div>
                </div>
              </div>
            </form>
          </Modal>
          <Modal
            width={1000}
            open={addOpen}
            title="Register New User"
            onOk={handleAddOk}
            onCancel={handleAddCancel}
            className="custom-modal"
            footer={[
              <Button key="back" onClick={handleAddCancel} className="button-hover-black">
                Return
              </Button>,
              <Button key="submit" type="primary" loading={loading || undefined} onClick={handleAddOk} className="button-hover-black">
                Submit
              </Button>
            ]}
            centered
          >
            <form>
              <div className="user-modal">
                <div className="user-modal-left">
                  <div className="user-modal-item">
                    <div className="user-modal-item-text1">
                      <p>Username:</p>
                      <p>Password:</p>
                      <p>First Name:</p>
                      <p>Last Name:</p>
                      {tokenRole === 'Admin' && (
                        <>
                          <p>Role:</p>
                          <p>Branch:</p>
                        </>
                      )}
                      <p>Email:</p>
                      <p>Phone:</p>
                    </div>
                    <div className="user-modal-item-value">
                      <input value={formState.username} onChange={(e) => setFormState({ ...formState, username: e.target.value })} className="input-box-modal" type="text" required />
                      <input value={formState.password} onChange={(e) => setFormState({ ...formState, password: e.target.value })} className="input-box-modal" type="password" required />
                      <input value={formState.firstName} onChange={(e) => setFormState({ ...formState, firstName: e.target.value })} className="input-box-modal" type="text" required />
                      <input value={formState.lastName} onChange={(e) => setFormState({ ...formState, lastName: e.target.value })} className="input-box-modal" type="text" required />
                      {tokenRole === 'Admin' ? (
                        <>
                          <select
                            value={formState.role}
                            onChange={(e) => setFormState({ ...formState, role: e.target.value })}
                            className="input-box-modal"
                            required
                          >
                            <option value="" hidden>Select role</option>
                            {roles.map(role => (
                              <option key={role.roleId} value={role.roleId}>{role.roleName}</option>
                            ))}
                          </select>
                          <select
                            value={formState.branch}
                            onChange={(e) => setFormState({ ...formState, branch: e.target.value })}
                            className="input-box-modal"
                          >
                            <option disabled selected hidden value="">Please select branch</option>
                            {branches.map(branch => (
                              <option key={branch.branchId} value={branch.branchId}>{branch.branchName}</option>
                            ))}
                          </select>
                        </>
                      ) : (
                        <input type="hidden" value="R001" name="role" />
                      )}
                      <input value={formState.email} onChange={(e) => setFormState({ ...formState, email: e.target.value })} className="input-box-modal" type="email" />
                      <input value={formState.phone} onChange={(e) => setFormState({ ...formState, phone: e.target.value })} className="input-box-modal" type="text" />
                    </div>
                  </div>
                </div>
              </div>
            </form>
          </Modal>

        </Box>
        <Box
          m="40px 0 0 0"
          height="75vh"
          sx={{
            "& .MuiDataGrid-root": {
              border: "none",
            },
            "& .MuiDataGrid-cell": {
              borderBottom: "none",
            },
            "& .name-column--cell": {
              color: colors.greenAccent[300],
            },
            "& .MuiDataGrid-columnHeader": {
              backgroundColor: colors.blueAccent[700],
              borderBottom: "none",
            },
            "& .MuiDataGrid-virtualScroller": {
              backgroundColor: colors.primary[400],
            },
            "& .MuiDataGrid-footerContainer": {
              borderTop: "none",
              backgroundColor: colors.blueAccent[700],
            },
            "& .MuiCheckbox-root": {
              color: `${colors.greenAccent[200]} !important`,
            },
            "& .MuiDataGrid-toolbarContainer .MuiButton-text": {
              color: `${colors.grey[100]} !important`,
            },
          }}
        >
          <DataGrid
            rows={rows}
            columns={columns}
            getRowId={(row) => row.userId}
          />
        </Box>
      </Box>
      <ToastContainer theme='colored' />
    </ConfigProvider>
  );
};

export default User;
