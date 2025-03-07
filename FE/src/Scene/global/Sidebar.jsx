import { useState, useEffect } from 'react';
import { ProSidebar, Menu, MenuItem } from "react-pro-sidebar";
import 'react-pro-sidebar/dist/css/styles.css';
import { Box, IconButton, Typography, useTheme } from '@mui/material';
import { Link } from 'react-router-dom';
import { tokens } from "../../theme";
import HomeOutlinedIcon from "@mui/icons-material/HomeOutlined";
import PeopleOutlinedIcon from "@mui/icons-material/PeopleOutlined";
import ContactsOutlinedIcon from "@mui/icons-material/ContactsOutlined";
import ReceiptOutlinedIcon from "@mui/icons-material/ReceiptOutlined";
import AccessAlarmIcon from '@mui/icons-material/AccessAlarm';
import CalendarTodayOutlinedIcon from "@mui/icons-material/CalendarTodayOutlined";
import PaymentIcon from '@mui/icons-material/Payment';
import BarChartOutlinedIcon from "@mui/icons-material/BarChartOutlined";
import TimelineOutlinedIcon from "@mui/icons-material/TimelineOutlined";
import MenuOutlinedIcon from "@mui/icons-material/MenuOutlined";
import FeedbackOutlinedIcon from '@mui/icons-material/FeedbackOutlined';
import PieChartOutlineIcon from '@mui/icons-material/PieChartOutline';
import './sidebar.css';
import { MdSportsTennis } from "react-icons/md";
import { useNavigate } from "react-router-dom";
import { jwtDecode } from 'jwt-decode';  // Fixed import statement
import DiscountIcon from '@mui/icons-material/Discount';
import { toast, ToastContainer } from 'react-toastify';

const Item = ({ title, to, icon, selected, setSelected }) => {
    const theme = useTheme();
    const colors = tokens(theme.palette.mode);
    return (
        <MenuItem
            active={selected === title}
            style={{
                color: colors.grey[100],
            }}
            onClick={() => setSelected(title)}
            icon={icon}>
            <Typography>{title}</Typography>
            <Link to={to} />
        </MenuItem>
    );
};

const Sidebar = () => {
    const theme = useTheme();
    const colors = tokens(theme.palette.mode);
    const [isCollapsed, setIsCollapsed] = useState(false);
    const [selected, setSelected] = useState('Dashboard');
    const navigate = useNavigate(); // Ensure useNavigate is called inside the component
    const [role, setRole] = useState();

    useEffect(() => {
        let token = sessionStorage.getItem('token');
        if (!token) {
            navigate('/'); // Redirect to home if token is not present
            return;
        }

        let decodedToken;
        try {
            decodedToken = jwtDecode(token); // Decode the JWT token to get user information
        } catch (error) {
            console.error('Invalid token:', error);
            sessionStorage.clear();
            navigate('/'); // Redirect to home if token is invalid
            return;
        }

        const { Role: role } = decodedToken;
        setRole(role);

        if (!role) {
            navigate('/signin'); // Redirect to sign-in if role is missing
            return;
        }

        if (role !== "Admin" && role !== "Staff") {
            sessionStorage.clear();
            navigate('/'); // Redirect to home if the role is not 'Admin' or 'Staff'
            return;
        }
    }, [navigate]);

    const handleLogout = () => {
            navigate('/');
            toast.success('Logout successfully!');
            sessionStorage.clear();
        
         // Redirect to home on logout  
    };

    return (
        <Box className="sidebar-wrapper"
            sx={{
                "& .pro-sidebar-inner": {
                    background: `${colors.primary[400]} !important`
                },
                "& .pro-icon-wrapper": {
                    backgroundColor: "transparent !important",
                },
                "& .pro-inner-item": {
                    padding: "10px 35px 10px 20px !important",
                },
                "& .pro-inner-item:hover": {
                    color: "#868dfb !important",
                },
                "& .pro-menu-item.active": {
                    color: "#6870fa !important",
                },
            }}>
            <ProSidebar collapsed={isCollapsed}>
                <Menu iconShape="square">
                    {/* LOGO AND MENU ICON */}
                    <MenuItem
                        onClick={() => setIsCollapsed(!isCollapsed)}
                        icon={isCollapsed ? <MenuOutlinedIcon /> : undefined}
                        style={{
                            margin: "10px 0 20px 0",
                            color: colors.grey[400],
                        }}>
                        {!isCollapsed && (
                            <Box
                                display="flex"
                                justifyContent="space-between"
                                alignItems="center"
                                ml="15px"
                            >
                                <Link className="logo" to="/">
                                    <MdSportsTennis className="iconSidebar"/>
                                </Link>
                                <Typography className="webNameAdmin" variant="h4" color={colors.grey[100]}>
                                    BMTC
                                </Typography>
                                <IconButton onClick={() => setIsCollapsed(!isCollapsed)}>
                                    <MenuOutlinedIcon />
                                </IconButton>
                            </Box>
                        )}
                    </MenuItem>

                    {/* USER */}
                    {!isCollapsed && (
                        <Box mb="25px" mr="50px" ml="50px">
                            <Box textAlign="center">
                                <button onClick={handleLogout} className="admin-button-logout">Logout</button>
                                <Typography
                                    className="adminName"
                                    variant="h2"
                                    color={colors.grey[100]}
                                    fontWeight="bold"
                                    sx={{ m: "10px 0 0 0" }}
                                >
                                    {role}
                                </Typography>
                                <Typography className="role" variant="h5" color={colors.greenAccent[500]}>
                                    VP Fancy {role}
                                </Typography>
                            </Box>
                        </Box>
                    )}

                    {/* MENU ITEMS */}
                    <Box paddingLeft={isCollapsed ? undefined : "10%"}>
                        <Item className="menu-item"
                            title="Dashboard"
                            to="/admin"
                            icon={<HomeOutlinedIcon />}
                            selected={selected}
                            setSelected={setSelected}
                            color={colors.grey[400]}
                        />

                        <Typography
                            className='sidebar-section-title'
                            color={colors.grey[300]}
                            sx={{ m: "15px 0 5px 20px" }}
                        >
                            Manage
                        </Typography>
                        <Item className="menu-item"
                            title="User"
                            to="user"
                            icon={<PeopleOutlinedIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />
                        {role === 'Admin' && (
                        <Item className="menu-item"
                            title="Court Branch"
                            to="branch"
                            icon={<ContactsOutlinedIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />
                        )}
                        <Item className="menu-item"
                            title="Court"
                            to="court"
                            icon={<ReceiptOutlinedIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />

                        <Typography
                            className='sidebar-section-title2'
                            color={colors.grey[300]}
                            sx={{ m: "15px 0 5px 20px" }}
                        >
                            Pages
                        </Typography>
                        {role === 'Admin' && (
                        <Item className="menu-item"
                            title="Discount"
                            to="discount"
                            icon={<DiscountIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />
                        )}
                        <Item className="menu-item"
                            title="Time Slot"
                            to="timeSlot"
                            icon={<AccessAlarmIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />
                        {role === 'Admin' && (
                            <Item className="menu-item"
                                title="Time Manage"
                                to="timeManage"
                                icon={<CalendarTodayOutlinedIcon />}
                                selected={selected}
                                setSelected={setSelected}
                            />
                        )}
                        <Item className="menu-item"
                            title="Payment"
                            to="payment"
                            icon={<PaymentIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />

                        {role === 'Admin' && (
                        <Item className="menu-item"
                            title="Feedback"
                            to="feedback"
                            icon={<FeedbackOutlinedIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />
                        )}

                        {role === 'Staff' && (
                        <Item className="menu-item"
                            title="Feedback"
                            to="staffFeedback"
                            icon={<FeedbackOutlinedIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />
                        )}

                        <Typography
                            className='sidebar-section-title3'
                            color={colors.grey[300]}
                            sx={{ m: "15px 0 5px 20px" }}
                        >
                            Charts
                        </Typography>

                        <Item className="menu-item"
                            title="Bar Chart"
                            to="bar"
                            icon={<BarChartOutlinedIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />
                        <Item className="menu-item"
                            title="Line Chart"
                            to="line"
                            icon={<TimelineOutlinedIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />
                        <Item className="menu-item"
                            title="Pie Chart"
                            to="pie"
                            icon={<PieChartOutlineIcon />}
                            selected={selected}
                            setSelected={setSelected}
                        />
                    </Box>
                </Menu>
            </ProSidebar>
            <ToastContainer theme='colored'/>
        </Box>
    );
};

export default Sidebar;
