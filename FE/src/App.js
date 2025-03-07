import React, { useState, useEffect } from 'react';
import './App.css';
import Navbar from './Components/Navbar/Navbar';
import Home from './Components/Home/Home';
import Footer from './Components/Footer/Footer';
import Popular from './Components/Popular/Popular';
import { Route, Routes, Navigate } from 'react-router-dom';
import SignInSignUp from './Components/SigninSignUp/signinsignup';
import ViewCourtInfo from './Components/ViewCourtInfo/viewCourtInfo';
import ViewInfo from './Components/ViewInfo/ViewInfo';
import EditInfo from './Components/EditInfo/EditInfo';
import FindCourt from './Components/findCourt/findCourt';
import Header from './Components/Header/header';
import 'react-toastify/dist/ReactToastify.css';
import { ToastContainer } from 'react-toastify';
import ForgetPassword from './Components/ForgetPassword/forgetPassword';
import { ColorModeContext, useMode } from './theme';
import { CssBaseline, ThemeProvider } from '@mui/material';
import User from "./Scene/user";
import Branch from "./Scene/courtBranch";
import Court from "./Scene/court";
import SlotManagement from "./Scene/timeSlot";
import BadmintonCourtHours from "./Scene/calendar";
import Payment from "./Scene/payment";
import Bar from "./Scene/bar";
import Line from "./Scene/line";
import Dashboard from './Scene/dashboard';
import BookCourt from './Components/bookCourt/bookCourt';
import AdminLayout from './Components/AdminLayout';
import BuyTime from './Components/BuyTime/BuyTime';
import BookingHistory from './Components/ViewHistory/ViewHistory';
import PaySuccess from './Components/PaySuccess/PaySuccess';
import BuyFail from './Components/BuyFail/BuyFail';
import GoogleMap from './Components/googleMap/googleMap';
import VerifyAccount from './Components/verifyAccount/verifyAccount';
import CreateFeedbackModal from './Components/CreateFeedbackModal/CreateFeedbackModal'; 
import PaymentHistory from './Components/ViewPayment/ViewPayment';
import { jwtDecode } from 'jwt-decode';
import Discount from './Scene/discount/discount';
import Feedback from './Scene/feedback/feedback';
import StaffFeedback from './Scene/feedback/staffFeedback';
import Pie from './Scene/pie'
import AnimatedIcons from './Components/AnimatedIcons/animatedIcons';

const App = () => {
  const [theme, colorMode] = useMode();
  const [isSidebar, setIsSidebar] = useState(true);
  const [searchCriteria, setSearchCriteria] = useState({ branch: '', location: '' });

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (token) {
        try {
            const decoded = jwtDecode.decode(token);
            if (decoded.exp * 1000 < Date.now()) {
                logout();
            }
        } catch (err) {
            logout();
        }
    }
}, []);

const logout = () => {
    localStorage.removeItem('token');
    window.location.href = '/signin'; 
};

  return (
    <ColorModeContext.Provider value={colorMode}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <Routes>
          <Route path="/" element={<div><Navbar /><Home setSearchCriteria={setSearchCriteria} /><Popular searchCriteria={searchCriteria} /><AnimatedIcons/><Footer /></div>} />
          <Route path="/home" element={<div><Header /><Home setSearchCriteria={setSearchCriteria} /><Popular searchCriteria={searchCriteria} /><AnimatedIcons/><Footer /></div>} />
          <Route path="/signin" element={<SignInSignUp defaultLoginVisible={true} />} />
          <Route path="/signup" element={<SignInSignUp defaultLoginVisible={false} />} />
          <Route path="/viewCourtInfo" element={<><ViewCourtInfo /><AnimatedIcons/></>} />
          <Route path="/editInfo" element={<><EditInfo /><AnimatedIcons/></>} />
          <Route path="/viewInfo" element={<><ViewInfo /><AnimatedIcons/></>} />
          <Route path="/findCourt" element={<><FindCourt /><AnimatedIcons/></>} />
          <Route path="/ResetPassword" element={<><ForgetPassword /></>} />
          <Route path="/verifyAccount" element={<><VerifyAccount /></>} />
          <Route path="/bookCourt" element={<div><Header /><BookCourt /><AnimatedIcons/></div>} />
          <Route path="/buyTime" element={<div><Header /><BuyTime /><Footer /><AnimatedIcons/></div>} />
          <Route path="/paySuccess" element={<div><Header /><PaySuccess /><Footer /></div>} />
          <Route path="/payFail" element={<div><Header /><BuyFail /><Footer /></div>} />
          <Route path="/bookingHistory" element={<><BookingHistory /><AnimatedIcons/></>} />
          <Route path="/paymentHistory" element={<><PaymentHistory/><AnimatedIcons/></>} /> 
          <Route path="/googleMap" element={<div><Header /><GoogleMap /><Footer /><AnimatedIcons/></div>} />
          <Route path="/contacts" element={<div><Navbar /><GoogleMap /><Footer /><AnimatedIcons/></div>} />

          <Route path="/admin/*" element={<AdminLayout isSidebar={isSidebar} setIsSidebar={setIsSidebar} />}>
            <Route path="" element={<Navigate to="dashboard" />} /> {/* Default to Dashboard */}
            <Route path="dashboard" element={<Dashboard />} />
            <Route path="user" element={<User />} />
            <Route path="branch" element={<Branch />} />
            <Route path="court" element={<Court />} />
            <Route path="discount" element={<Discount />} />
            <Route path="timeSlot" element={<SlotManagement />} />
            <Route path="timeManage" element={<BadmintonCourtHours />} />
            <Route path="payment" element={<Payment />} />
            <Route path="bar" element={<Bar />} />
            <Route path="line" element={<Line />} />
            <Route path="feedback" element={<Feedback />} />
            <Route path="pie" element={<Pie />} />

          </Route>

          <Route path="/staff/*" element={<AdminLayout isSidebar={isSidebar} setIsSidebar={setIsSidebar} />}>
            <Route path="" element={<Navigate to="dashboard" />} /> {/* Default to Dashboard */}
            <Route path="dashboard" element={<Dashboard />} />
            <Route path="user" element={<User />} />
            <Route path="court" element={<Court />} />
            <Route path="timeSlot" element={<SlotManagement />} />
            <Route path="payment" element={<Payment />} />
            <Route path="bar" element={<Bar />} />
            <Route path="line" element={<Line />} />
            <Route path="staffFeedback" element={<StaffFeedback />} />
            <Route path="pie" element={<Pie />} />
          </Route>
            <Route path="/createFeedbackModal" element={<CreateFeedbackModal />} />
        </Routes>
        
      </ThemeProvider>
      <ToastContainer theme='colored' />
    </ColorModeContext.Provider>
  );
};

export default App;
