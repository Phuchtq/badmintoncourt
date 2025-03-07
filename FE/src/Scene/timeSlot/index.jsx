import { Box, Button } from "@mui/material";
import { DataGrid } from "@mui/x-data-grid";
import React, { useState, useEffect } from "react";
import Head from "../../Components/Head";
import { Modal } from 'antd';
import './managetimeslot.css'; // Import the custom CSS
import { toast, ToastContainer } from "react-toastify";
import { ConfigProvider } from 'antd';
import { useTheme } from "@mui/material";
import { tokens } from "../../theme";
import dayjs from 'dayjs';
import { fetchWithAuth } from "../../Components/fetchWithAuth/fetchWithAuth";
import { jwtDecode } from 'jwt-decode';

const TimeSlotManagement = () => {
  const [rows, setRows] = useState([]);
  const token = sessionStorage.getItem('token');
  const [loading, setLoading] = useState(false);
  const [open, setOpen] = useState(false);
  const [branches, setBranches] = useState([]);
  const [courts, setCourts] = useState([]);
  const [filteredCourts, setFilteredCourts] = useState([]);
  const [slots, setSlots] = useState([]);
  const [bookings, setBookings] = useState([]);
  const [timeBound, setTimeBound] = useState([]);
  const [tokenRole, setTokenRole] = useState([]);

  const [addFormState, setAddFormState] = useState({
    branchId: '',
    courtId: '',
    date: '',
    start: '',
    startValue: '',
    end: '',
    endValue: '',
    userId: '',
    phone: ''
  });
  const [addOpen, setAddOpen] = useState(false);
  const [updateOpen, setUpdateOpen] = useState(false);
  const [updateFormState, setUpdateFormState] = useState({
    branchId: '',
    courtId: '',
    date: '',
    start: '',
    startValue: '',
    end: '',
    endValue: '',
    price: '',
    slotId: '',
    bookedSlotId: ''
  });

  const loadTimeFrame = async () => {
    const fetchTime = async () => {
      var res = await fetchWithAuth(`https://localhost:7233/Slot/GetAll`);
      var data = await res.json();
      return data;
    };

    try {
      var data = await fetchTime();
      setTimeBound([]);
      var primitive = data.find(d => d.bookedSlotId === 'S1');
      var start = primitive.start;
      var end = primitive.end;
      for (let i = start; i <= end; i++) {
        setTimeBound(t => [...t, i]);
      }
    }
    catch (err) {
      toast.error('Server error');
    }
  };

  const convertToMDY = (date) => {
    //assume date is in dd-mm-yyyy
    var t = date.split('-');
    return `${t[1]}-${t[0]}-${t[2]}`;
  };

  const openUpdateModal = (row) => {
    //row.date is treated as mm-dd instead of dd-mm, so this must be done
    var normalize = convertToMDY(row.date);
    setUpdateFormState({
      branchId: row.branchId,
      courtId: row.courtId,
      date: dayjs(normalize).format('YYYY-MM-DD'), // Ensure date is in correct format
      start: row.start,
      startValue: row.start,
      end: row.end,
      endValue: row.end,
      price: row.price,
      slotId: row.slotId,
      bookedSlotId: row.bookedSlotId // Add this line to include bookedSlotId
    });
    setUpdateOpen(true);
  };

  const handleCancelUpdate = () => {
    setUpdateFormState({
      branchId: '',
      courtId: '',
      date: '',
      start: '',
      startValue: '',
      end: '',
      endValue: '',
      price: '',
      slotId: '',
      bookedSlotId: ''
    });
    setUpdateOpen(false);
  };

  const theme = useTheme();
  const colors = tokens(theme.palette.mode);

  const initialState = {
    branchId: '',
    courtId: '',
    date: '',
    start: '',
    end: '',
    bookingId: '',
    firstName: '',
    lastName: '',
    phone: '',
    email: '',
    img: ''
  };

  const [formState, setFormState] = useState(initialState);

  const showModal = async (row) => {
    try {
      const bookingsRes = await fetchWithAuth(`https://localhost:7233/Booking/GetAll`, {
        method: "GET",
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      });

      if (!bookingsRes.ok) {
        throw new Error('Failed to fetch bookings');
      }

      const bookingsData = await bookingsRes.json();
      const booking = bookingsData.find(booking => booking.bookingId === row.bookingId);

      const userRes = await fetchWithAuth(`https://localhost:7233/User/GetById?id=${booking.userId}`, {
        method: "GET",
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      });

      if (!userRes.ok) {
        throw new Error('Failed to fetch user details');
      }

      const userData = await userRes.json();

      const userDetailsRes = await fetchWithAuth(`https://localhost:7233/UserDetail/GetAll`, {
        method: "GET",
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      });

      if (!userDetailsRes.ok) {
        throw new Error('Failed to fetch user details');
      }

      const userDetailsData = await userDetailsRes.json();
      const userDetail = userDetailsData.find(detail => detail.userId === userData.userId);
      setFormState({
        firstName: userDetail.firstName || '',
        lastName: userDetail.lastName || '',
        phone: userDetail?.phone || '',
        email: userDetail?.email || '',
        img: userDetail?.img || '',
        bookingId: booking ? booking.bookingId : 'N/A',
      });
      setOpen(true);
    } catch (error) {
      toast.error('Failed to fetch booking or user data');
      console.log(error);
    }
  };

  const handleCancel = () => {
    setOpen(false);
    setFormState(initialState);
  };

  const handleAddOk = () => {
    const slotData = {
      ...addFormState,
      start: addFormState.startValue,
      end: addFormState.endValue,
    };
    console.log(addFormState);
    console.log(slotData);
    fetchWithAuth(`https://localhost:7233/Slot/BookingByBalance?date=${slotData.date}&start=${slotData.start}&end=${slotData.end}&userId=${slotData.userId}&courtId=${slotData.courtId}`, {
      method: "POST",
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(slotData)
    })
      .then(response => response.json())
      .then(data => {
        toast.info(data.msg);
        fetchData();
        setAddOpen(false);
      })
      .catch(error => {
        toast.error('User not exist');
        setAddOpen(false);
      });
    setLoading(true);
    setTimeout(() => {
      setLoading(false);
    }, 1000);
  };

  const handleAddCancel = () => {
    setAddOpen(false);
    setAddFormState({
      courtId: '',
      date: '',
      start: '',
      end: '',
      userId: ''
    });
  };

  const addSlot = () => {
    setAddFormState({
      courtId: addFormState.courtId || '',
      date: addFormState.date || '',
      start: addFormState.start || '',
      end: addFormState.end || '',
      phone: addFormState.phone || '',
      userId: addFormState.userId || ''
    });
    setAddOpen(true);
  };

  const fetchData = async () => {
    let decodedToken = jwtDecode(token);
    setTokenRole(decodedToken.Role);
    try {
      const [branchesRes, courtsRes, slotsRes, bookingsRes, userRes] = await Promise.all([
        fetchWithAuth(`https://localhost:7233/Branch/GetAll`, {
          method: "GET",
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        }),
        fetchWithAuth(`https://localhost:7233/Court/GetAll`, {
          method: "GET",
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        }),
        fetchWithAuth(`https://localhost:7233/Slot/GetAll`, {
          method: "GET",
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        }),
        fetchWithAuth(`https://localhost:7233/Booking/GetAll`, {
          method: "GET",
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        }),
        fetchWithAuth(`https://localhost:7233/User/GetById?id=${decodedToken.UserId}`, {
          method: "GET",
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
      ]);

      if (!branchesRes.ok || !courtsRes.ok || !slotsRes.ok || !bookingsRes.ok || !userRes.ok) {
        throw new Error('Failed to fetch data');
      }

      const [branchesData, courtsData, slotsData, bookingsData, userData] = await Promise.all([
        branchesRes.json(),
        courtsRes.json(),
        slotsRes.json(),
        bookingsRes.json(),
        userRes.json(),
      ]);

      setBranches(branchesData);
      setCourts(courtsData);
      setFilteredCourts(courtsData);
      setSlots(slotsData);
      setBookings(bookingsData);
      console.log(userData.branchId)
      const formattedData = slotsData
      .filter(slot => {
        if (decodedToken.Role !== 'Admin') {
          const court = courtsData.find(court => court.courtId === slot.courtId);
          return court && court.branchId === userData.branchId; // Chỉ lấy các slot từ chi nhánh của nhân viên nếu không phải admin
        }
        return true; // Nếu là admin thì không lọc
      })
        .map((row, index) => {
          const court = courtsData.find(court => court.courtId === row.courtId);
          const branch = branchesData.find(branch => branch.branchId === court.branchId);
          const booking = bookingsData.find(booking => booking.bookingId === row.bookingId);
          return {
            id: index + 1,
            ...row,
            branchName: branch ? branch.branchName : 'Unknown',
            courtName: court ? court.courtName : 'Unknown',
            date: dayjs(row.date).format('DD-MM-YYYY'),
            timeRange: `${row.start}:00 - ${row.end}:00`,
            totalPrice: booking ? booking.amount : 'N/A',
            bookingId: booking ? booking.bookingId : 'N/A',
          };
        });

      setRows(formattedData);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  const [userDetails, setUserDetails] = useState([]);

  const fetchUserDetails = async () => {
    try {
      const response = await fetchWithAuth(`https://localhost:7233/UserDetail/GetAll`, {
        method: "GET",
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      });

      if (!response.ok) {
        throw new Error('Failed to fetch user details');
      }

      const data = await response.json();
      setUserDetails(data);
    } catch (error) {
      console.error('Error fetching user details:', error);
      toast.error('Failed to fetch user details');
    }
  };

  useEffect(() => {
    if (!token) {
      console.error('Token not found. Please log in.');
      return;
    }

    loadTimeFrame();
    fetchData();
    fetchUserDetails();
  }, [token]);

  const handleBranchChange = (value) => {
    setFormState((prevState) => ({
      ...prevState,
      branchId: value,
      courtId: ''
    }));

    if (value === "all") {
      setFilteredCourts(courts);

      const formattedData = slots.map((row, index) => {
        const court = courts.find(court => court.courtId === row.courtId);
        const branch = court ? branches.find(branch => branch.branchId === court.branchId) : null;
        const booking = bookings.find(booking => booking.bookingId === row.bookingId);

        return {
          id: index + 1,
          ...row,
          branchName: branch ? branch.branchName : 'Unknown',
          courtName: court ? court.courtName : 'Unknown',
          date: dayjs(row.date).format('DD-MM-YYYY'),
          timeRange: `${row.start}:00 - ${row.end}:00`,
          totalPrice: booking ? booking.amount : 'N/A',
          bookingId: booking ? booking.bookingId : 'N/A',
        };
      });
      setRows(formattedData);
    } else {
      const filteredCourts = courts.filter(court => court.branchId === value);
      setFilteredCourts(filteredCourts);

      const filteredSlots = slots.filter(slot => {
        const court = filteredCourts.find(court => court.courtId === slot.courtId);
        return court && court.branchId === value;
      });

      const selectedBranch = branches.find(branch => branch.branchId === value);

      const formattedData = filteredSlots.map((row, index) => {
        const court = filteredCourts.find(court => court.courtId === row.courtId);
        const booking = bookings.find(booking => booking.bookingId === row.bookingId);

        return {
          id: index + 1,
          ...row,
          branchName: selectedBranch ? selectedBranch.branchName : 'Unknown',
          courtName: court ? court.courtName : 'Unknown',
          date: dayjs(row.date).format('DD-MM-YYYY'),
          timeRange: `${row.start}:00 - ${row.end}:00`,
          totalPrice: booking ? booking.amount : 'N/A',
          bookingId: booking ? booking.bookingId : 'N/A',
        };
      });

      setRows(formattedData);
    }
  };

  const handleCourtChange = (value) => {
    setFormState((prevState) => ({
      ...prevState,
      courtId: value
    }));

    if (value === "all") {
      const filteredSlots = formState.branchId === "all"
        ? slots
        : slots.filter(slot => {
          const court = filteredCourts.find(court => court.courtId === slot.courtId);
          return court && court.branchId === formState.branchId;
        });

      const formattedData = filteredSlots.map((row, index) => {
        const court = filteredCourts.find(court => court.courtId === row.courtId);
        const branch = branches.find(branch => branch.branchId === court.branchId);
        const booking = bookings.find(booking => booking.bookingId === row.bookingId);

        return {
          id: index + 1,
          ...row,
          branchName: branch ? branch.branchName : 'Unknown',
          courtName: court ? court.courtName : 'Unknown',
          date: dayjs(row.date).format('DD-MM-YYYY'),
          timeRange: `${row.start}:00 - ${row.end}:00`,
          totalPrice: booking ? booking.amount : 'N/A',
          bookingId: booking ? booking.bookingId : 'N/A',
        };
      });

      setRows(formattedData);
    } else {
      const filteredSlots = slots.filter(slot => slot.courtId === value);

      const formattedData = filteredSlots.map((row, index) => {
        const court = filteredCourts.find(court => court.courtId === row.courtId);
        const branch = branches.find(branch => branch.branchId === court.branchId);
        const booking = bookings.find(booking => booking.bookingId === row.bookingId);
        return {
          id: index + 1,
          ...row,
          branchName: branch ? branch.branchName : 'Unknown',
          courtName: court ? court.courtName : 'Unknown',
          date: dayjs(row.date).format('DD-MM-YYYY'),
          timeRange: `${row.start}:00 - ${row.end}:00`,
          totalPrice: booking ? booking.amount : 'N/A',
          bookingId: booking ? booking.bookingId : 'N/A',
        };
      });

      setRows(formattedData);
    }
  };

  const handleDateChange = async (dateValue) => {
    setFormState({ ...formState, date: dateValue });

    try {
      const [branchesRes, courtsRes, slotsRes, bookingsRes] = await Promise.all([
        fetchWithAuth(`https://localhost:7233/Branch/GetAll`, {
          method: "GET",
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        }),
        fetchWithAuth(`https://localhost:7233/Court/GetAll`, {
          method: "GET",
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        }),
        fetchWithAuth(`https://localhost:7233/Slot/GetAll`, {
          method: "GET",
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        }),
        fetchWithAuth(`https://localhost:7233/Booking/GetAll`, {
          method: "GET",
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
      ]);

      if (!branchesRes.ok || !courtsRes.ok || !slotsRes.ok || !bookingsRes.ok) {
        throw new Error('Failed to fetch data');
      }

      const [branchesData, courtsData, slotsData, bookingsData] = await Promise.all([
        branchesRes.json(),
        courtsRes.json(),
        slotsRes.json(),
        bookingsRes.json()
      ]);

      setBranches(branchesData);
      setCourts(courtsData);
      setSlots(slotsData);

      const selectedBranchId = formState.branchId;
      const selectedCourtId = formState.courtId;

      let filteredSlots = slotsData.filter(slot => dayjs(slot.date).format('YYYY-MM-DD') === dateValue);

      if (selectedBranchId && selectedBranchId !== "all") {
        const filteredCourts = courtsData.filter(court => court.branchId === selectedBranchId);
        setFilteredCourts(filteredCourts);

        if (selectedCourtId && selectedCourtId !== "all") {
          filteredSlots = filteredSlots.filter(slot => slot.courtId === selectedCourtId);
        } else {
          filteredSlots = filteredSlots.filter(slot => {
            const court = filteredCourts.find(court => court.courtId === slot.courtId);
            return court;
          });
        }
      }

      const formattedData = filteredSlots.map((row, index) => {
        const court = courtsData.find(court => court.courtId === row.courtId);
        const branch = branchesData.find(branch => branch.branchId === court.branchId);
        const booking = bookingsData.find(booking => booking.bookingId === row.bookingId);

        return {
          id: index + 1,
          ...row,
          branchName: branch ? branch.branchName : 'Unknown',
          courtName: court ? court.courtName : 'Unknown',
          date: dayjs(row.date).format('DD-MM-YYYY'),
          timeRange: `${row.start}:00 - ${row.end}:00`,
          totalPrice: booking ? booking.amount : 'N/A',
          bookingId: booking ? booking.bookingId : 'N/A',
        };
      });

      setRows(formattedData);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  const handlePhoneChange = (e) => {
    const phone = e.target.value;
    const userDetail = userDetails.find(user => user.phone === phone);
    const userId = userDetail ? userDetail.userId : '';

    setAddFormState(prevState => ({
      ...prevState,
      phone: phone,
      userId: userId
    }));
  };

  const handleUpdateOk = () => {
    if (updateFormState.date === 'Invalid Date') {
      toast.error('Date is not in correct format');
      return;
    }
    if (Date.parse(updateFormState.date) < Date.parse(new Date())) {
      toast.error('Can\'t change to a date in the past');
      return;
    }
    if (!updateFormState.courtId || !updateFormState.date || !updateFormState.start || !updateFormState.end || !updateFormState.bookedSlotId) {
      toast.error('All fields are required.');
      return;
    }
    var bookingId = slots.find(s => s.bookedSlotId === updateFormState.bookedSlotId).bookingId;
    const updatedSlot = {
      slotId: updateFormState.bookedSlotId,
      courtId: updateFormState.courtId,
      date: updateFormState.date,
      start: updateFormState.startValue,
      end: updateFormState.endValue,
      bookingId: bookingId
    };

    fetchWithAuth(`https://localhost:7233/Slot/UpdateByStaff?date=${updatedSlot.date}&start=${updatedSlot.start}&end=${updatedSlot.end}&slotId=${updatedSlot.slotId}&courtId=${updatedSlot.courtId}&bookingId=${updatedSlot.bookingId}`, {
      method: 'PUT',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(updatedSlot)
    })
      .then(response => response.json())
      .then(data => {
        toast.info(data.msg);
        fetchData();
        setUpdateOpen(false);
        setUpdateFormState({
          branchId: '',
          courtId: '',
          date: '',
          start: '',
          end: '',
          price: '',
          slotId: '',
          bookedSlotId: ''
        });
      })
      .catch(error => {
        toast.error("Update fail");
        setUpdateOpen(false);
      });

    setLoading(true);
    setTimeout(() => {
      setLoading(false);
    }, 1000);
  };

  const columns = [
    { field: "bookingId", headerName: "ID", align: "center", headerAlign: "center" },
    { field: "branchName", headerName: "Branch", flex: 1, align: "center", headerAlign: "center" },
    { field: "courtName", headerName: "Court", flex: 1, align: "center", headerAlign: "center" },
    { field: "date", headerName: "Date", flex: 1, align: "center", headerAlign: "center" },
    { field: "timeRange", headerName: "Time Range", flex: 1, align: "center", headerAlign: "center" },
    {
      field: "totalPrice", headerName: "Total Price", flex: 1, align: "center", headerAlign: "center"
    },
    {
      field: "actions",
      headerName: "Actions",
      sortable: false,
      flex: 1,
      align: "center",
      headerAlign: "center",
      renderCell: (params) => (
        <Box
          style={{ marginRight: 20 }}>
          <Button
            type="primary"
            onClick={() => showModal(params.row)}
            variant="contained"
            color="primary"
            size="small"
            className="managetimeslot-action-button"
          >
            User Info
          </Button>
          <Button
            variant="contained"
            size="small"
            onClick={() => openUpdateModal(params.row)} // Open update modal
            style={{ backgroundColor: '#b22222', color: 'white', marginLeft: 8 }}
          >
            Update
          </Button>
        </Box>
      )
    }
  ];

  const handleStartChange = (e) => {
    console.log(addFormState);
    const startValue = e.target.value;
    const startDisplay = startValue.padStart(2, '0') + ':00';
    setAddFormState(a => ({
      ...a,
      start: startDisplay,
      startValue: parseInt(startValue)
    }));
  };

  const handleEndChange = (e) => {
    console.log(addFormState);
    const endValue = e.target.value;
    const endDisplay = endValue.padStart(2, '0') + ':00';
    setAddFormState({
      ...addFormState,
      end: endDisplay,
      endValue: parseInt(endValue)
    });
  };

  const handleUpdateStartChange = (e) => {
    const startValue = e.target.value;
    const startDisplay = startValue.padStart(2, '0') + ':00';
    setUpdateFormState(prevState => ({
      ...prevState,
      start: startDisplay,
      startValue: parseInt(startValue)
    }));
  };

  const handleUpdateEndChange = (e) => {
    const endValue = e.target.value;
    const endDisplay = endValue.padStart(2, '0') + ':00';
    setUpdateFormState(prevState => ({
      ...prevState,
      end: endDisplay,
      endValue: parseInt(endValue)
    }));
  };

  const handleUpdateBranchChange = (e) => {
    const branchId = e.target.value;
    const filteredCourts = courts.filter(court => court.branchId === branchId);
    setUpdateFormState(prevState => ({
      ...prevState,
      branchId,
      courtId: '',
    }));
    setFilteredCourts(filteredCourts);
  };

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
        <Head title="Booking" subtitle="Court Booking Time Slots" />
        <div className="timeslotmanage-filter">
        {tokenRole == 'Admin' && (
      <>
        <label htmlFor="" className="timeslotmanage-filter-branch">
          Branch:
        </label>
        <select
          value={formState.branchId}
          onChange={(e) => handleBranchChange(e.target.value)}
          className="timeslotmanage-filter-branch-input-box-modal"
        >
          <option value="all">All</option>
          {branches.map((branch) => (
            <option key={branch.branchId} value={branch.branchId}>
              {branch.branchName}
            </option>
          ))}
        </select>

        <label htmlFor="" className="timeslotmanage-filter-court">
          Court:
        </label>
        <select
          value={formState.courtId}
          onChange={(e) => handleCourtChange(e.target.value)}
          className="timeslotmanage-filter-court-input-box-modal"
        >
          <option value="all">All</option>
          {filteredCourts.map((court) => (
            <option key={court.courtId} value={court.courtId}>
              {court.courtName}
            </option>
          ))}
        </select>
        <label htmlFor="" className="timeslotmanage-filter-date">
          Date:
        </label>
        <input
          type="date"
          value={formState.date}
          onChange={(e) => handleDateChange(e.target.value)}
          className="timeslotmanage-filter-date-input"
        />
       </>
    )}
          <button
            className="timeslotbutton-flex"
            type="primary"
            onClick={addSlot}
            variant="contained"
            color="primary"
            size="small"
          >
            Add Time Slot
          </button>
          <Modal
            width={700}
            open={open}
            title="User Information"
            onCancel={handleCancel}
            className="managetimeslot-custom-modal"
            footer={[
              <button key="back" onClick={handleCancel} className="managetimeslot-button-hover-black">
                Close
              </button>
            ]}
            centered
          >
            <div className="managetimeslot-timeslot-modal">
              <div className="managetimeslot-user-info">
                <img
                  src={formState.img}
                  alt={`${formState.firstName} ${formState.lastName}`}
                  className="managetimeslot-user-info-image"
                />
                <div className="managetimeslot-user-info-details">
                  <p className="managetimeslot-user-info-text">First Name: {formState.firstName}</p>
                  <p className="managetimeslot-user-info-text">Last Name: {formState.lastName}</p>
                  <p className="managetimeslot-user-info-text">Phone: {formState.phone}</p>
                  <p className="managetimeslot-user-info-text">Email: {formState.email}</p>
                </div>
              </div>
            </div>
          </Modal>

          <Modal
            width={700}
            open={addOpen}
            title="Add Time Slot"
            onOk={handleAddOk}
            onCancel={handleAddCancel}
            className="managetimeslot-custom-modal"
            footer={[
              <button key="back" onClick={handleAddCancel} className="managetimeslot-button-hover-black-addslot">
                Cancel
              </button>,
              <button key="submit" onClick={handleAddOk} className="managetimeslot-button-hover-black-addslot">
                Add
              </button>
            ]}
            centered
          >
            <div className="managetimeslot-add-slot-modal">
              <div className="managetimeslot-add-slot-fields">
                <div className="managetimeslot-add-slot-label-time-row">
                  <div className="time-input">
                    <label htmlFor="branchId" className="managetimeslot-add-slot-label">Branch:</label>
                    <select
                      id="branchId"
                      value={addFormState.branchId}
                      onChange={(e) => {
                        const selectedBranchId = e.target.value;
                        setAddFormState({ ...addFormState, branchId: selectedBranchId, courtId: '' });
                        const filteredCourts = courts.filter(court => court.branchId === selectedBranchId);
                        setFilteredCourts(filteredCourts);
                      }}
                      className="managetimeslot-add-slot-input"
                      required
                    >
                      <option disabled selected hidden value="">Select branch</option>
                      {branches.map((branch) => (
                        <option key={branch.branchId} value={branch.branchId}>
                          {branch.branchName}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="time-input">
                    <label htmlFor="courtId" className="managetimeslot-add-slot-label">Court:</label>
                    <select
                      id="courtId"
                      value={addFormState.courtId}
                      onChange={(e) => setAddFormState({ ...addFormState, courtId: e.target.value })}
                      className="managetimeslot-add-slot-input"
                      required
                      disabled={!addFormState.branchId}
                    >
                      <option disabled selected hidden value="">Select court</option>
                      {filteredCourts.map((court) => ( // Use filtered courts here as well
                        <option key={court.courtId} value={court.courtId}>
                          {court.courtName}
                        </option>
                      ))}
                    </select>
                  </div>
                </div>
                <div className="managetimeslot-add-slot-label-time-row">
                  <div className="time-input">
                    <label htmlFor="date" className="managetimeslot-add-slot-label">Date:</label>
                    <input
                      type="date"
                      id="date"
                      value={addFormState.date}
                      onChange={(e) => setAddFormState({ ...addFormState, date: e.target.value })}
                      className="managetimeslot-add-slot-input"
                      required
                    />
                  </div>
                  <div className="time-input">
                    <label htmlFor="start" className="managetimeslot-add-slot-label">Start Time:</label>
                    <select
                      id="start"
                      value={addFormState.startValue}
                      onChange={handleStartChange}
                      className="managetimeslot-add-slot-input time-select"
                      required
                    >
                      <option disabled selected hidden value="">Select start time</option>
                      {timeBound.map(t => (
                        <option key={t} value={t}>{t}:00</option>
                      ))}
                    </select>
                  </div>
                  <div className="time-input">
                    <label htmlFor="end" className="managetimeslot-add-slot-label">End Time:</label>
                    <select
                      id="end"
                      value={addFormState.endValue}
                      onChange={handleEndChange}
                      className="managetimeslot-add-slot-input time-select"
                      required
                    >
                      <option disabled selected hidden value="">Select end time</option>
                      {timeBound.map(t => (
                        <option key={t} value={t}>{t}:00</option>
                      ))}
                    </select>
                  </div>
                </div>
                <div className="managetimeslot-add-slot-label-time-row">
                  <div className="time-input">
                    <label htmlFor="phone" className="managetimeslot-add-slot-label">Phone Number:</label>
                    <input
                      type="text"
                      id="phone"
                      value={addFormState.phone}
                      onChange={handlePhoneChange}
                      className="managetimeslot-add-slot-input"
                      required
                    />
                  </div>
                </div>
              </div>
            </div>
          </Modal>

          <Modal
            width={700}
            open={updateOpen}
            title="Update Time Slot"
            onOk={handleUpdateOk}
            onCancel={handleCancelUpdate}
            className="managetimeslot-custom-modal"
            footer={[null]}
            centered
          >
            <div className="managetimeslot-update-slot-modal">
              <div className="managetimeslot-update-slot-fields">
                <div className="managetimeslot-update-slot-label-time-row">
                  <div className="time-input">
                    <label htmlFor="updateBranchId" className="managetimeslot-update-slot-label">Branch:</label>
                    <select
                      id="updateBranchId"
                      value={updateFormState.branchId}
                      onChange={handleUpdateBranchChange}
                      className="managetimeslot-update-slot-input"
                      required
                    >
                      <option disabled selected hidden value="">Select branch</option>
                      {branches.map((branch) => (
                        <option key={branch.branchId} value={branch.branchId}>
                          {branch.branchName}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="time-input">
                    <label htmlFor="updateCourtId" className="managetimeslot-update-slot-label">Court:</label>
                    <select
                      id="updateCourtId"
                      value={updateFormState.courtId}
                      onChange={(e) => setUpdateFormState({ ...updateFormState, courtId: e.target.value })}
                      className="managetimeslot-update-slot-input"
                      required
                    >
                      <option disabled selected hidden value="">Select court</option>
                      {filteredCourts.map((court) => (
                        <option key={court.courtId} value={court.courtId}>
                          {court.courtName}
                        </option>
                      ))}
                    </select>
                  </div>
                </div>
                <div className="managetimeslot-update-slot-label-time-row">
                  <div className="time-input">
                    <label htmlFor="updateDate" className="managetimeslot-update-slot-label">Date:</label>
                    <input
                      type="date"
                      id="updateDate"
                      value={updateFormState.date}
                      onChange={(e) => {
                        setUpdateFormState({ ...updateFormState, date: e.target.value });
                        console.log(e.target.value);
                      }}
                      className="managetimeslot-update-slot-input"
                      required
                    />
                  </div>
                  <div className="time-input-flexing">
                    <div className="time-input">
                      <label htmlFor="updateStart" className="managetimeslot-update-slot-label">Start Time:</label>
                      <select
                        id="updateStart"
                        value={updateFormState.startValue}
                        onChange={handleUpdateStartChange}
                        className="managetimeslot-update-slot-input time-select"
                        required
                      >
                        <option disabled selected hidden value="">Select start time</option>
                        {timeBound.map(t => (
                          <option key={t} value={t}>{t}:00</option>
                        ))}
                      </select>
                    </div>
                    <div className="time-input">
                      <label htmlFor="updateEnd" className="managetimeslot-update-slot-label">End Time:</label>
                      <select
                        id="updateEnd"
                        value={updateFormState.endValue}
                        onChange={handleUpdateEndChange}
                        className="managetimeslot-update-slot-input time-select"
                        required
                      >
                        <option disabled selected hidden value="">Select end time</option>
                        {timeBound.map(t => (
                          <option key={t} value={t}>{t}:00</option>
                        ))}
                      </select>
                    </div>
                  </div>
                  <div className="updatetimeslot-footer-flex">
                    <button key="back" onClick={() => setUpdateOpen(false)} className="managetimeslot-button-hover-black">
                      Cancel
                    </button>
                    <button key="submit" onClick={handleUpdateOk} className="managetimeslot-button-hover-black">
                      Update
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </Modal>
        </div>

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
          <DataGrid rows={rows} columns={columns} getRowId={(row) => row.id} />
        </Box>
      </Box>
      <ToastContainer theme='colored' />
    </ConfigProvider>
  );
};

export default TimeSlotManagement;
