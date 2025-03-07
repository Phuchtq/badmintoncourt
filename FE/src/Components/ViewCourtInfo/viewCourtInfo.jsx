import React, { useEffect, useState } from 'react';
import Header from "../Header/header";
import Navbar from "../Navbar/Navbar";
import './viewCourtInfo.css';
import Footer from "../Footer/Footer";
import { FaArrowLeft, FaArrowRight } from 'react-icons/fa';
import { format, addDays, subDays, startOfWeek } from 'date-fns';
import { useNavigate, useLocation } from 'react-router-dom';

const ViewCourtInfo = () => {
    const [mainCourt, setMainCourt] = useState(null);
    const [recommendedCourts, setRecommendedCourts] = useState([]);
    const [branch, setBranch] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [selectedDate, setSelectedDate] = useState(new Date());
    const [currentWeekStart, setCurrentWeekStart] = useState(startOfWeek(new Date()));
    const [currentHourIndex, setCurrentHourIndex] = useState(0);
    const [slots, setSlots] = useState([]);
    const [currentImageIndex, setCurrentImageIndex] = useState(0);
    const maxVisibleHours = 5;
    const [timeBound, setTimeBound] = useState([]); // 0:00 to 23:00

    const navigate = useNavigate();
    const location = useLocation();

    useEffect(() => {
        const fetchData = async () => {
            const branchUrl = 'https://localhost:7233/Branch/GetAll';
            const courtUrl = 'https://localhost:7233/Court/GetAll';
            const slotUrl = 'https://localhost:7233/Slot/GetAll';

            try {
                setLoading(true);
                const [branchResponse, courtResponse, slotResponse] = await Promise.all([
                    fetch(branchUrl),
                    fetch(courtUrl),
                    fetch(slotUrl),
                ]);

                if (!branchResponse.ok) {
                    throw new Error(`Failed to fetch branch data: ${branchResponse.statusText}`);
                }
                if (!courtResponse.ok) {
                    throw new Error(`Failed to fetch court data: ${courtResponse.statusText}`);
                }
                if (!slotResponse.ok) {
                    throw new Error(`Failed to fetch slot data: ${slotResponse.statusText}`);
                }

                const branchData = await branchResponse.json();
                const courtData = await courtResponse.json();
                const slotData = await slotResponse.json();

                const params = new URLSearchParams(location.search);
                const courtId = params.get('courtId');

                const mainCourtData = courtData.find(court => court.courtId === courtId) || courtData[0];
                const mainBranchData = branchData.find(branch => branch.branchId === mainCourtData.branchId);
                const recommendedCourtsData = courtData.filter(court => court.branchId === mainCourtData.branchId && court.courtId !== mainCourtData.courtId).slice(0, 2);

                setBranch(mainBranchData);
                setMainCourt(mainCourtData);
                setRecommendedCourts(recommendedCourtsData);
                setSlots(slotData);
            } catch (error) {
                setError(error.message);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
        loadTimeFrame();
    }, [location.search]);

    const handleBookCourt = (courtId) => {
        navigate(`/viewCourtInfo?courtId=${courtId}`);
    };

    const handleBookCourtOption = (courtId) => {
        navigate(`/bookCourt?courtId=${courtId}`);
    };

    const handleDateClick = (date) => {
        setSelectedDate(date);
        setCurrentHourIndex(0);
    };

    const handlePrevWeek = () => {
        setCurrentWeekStart(subDays(currentWeekStart, 7));
    };

    const handleNextWeek = () => {
        setCurrentWeekStart(addDays(currentWeekStart, 7));
    };

    const handlePrevHour = () => {
        setCurrentHourIndex((prev) => Math.max(prev - 1, 0));
    };

    const handleNextHour = () => {
        setCurrentHourIndex((prev) => Math.min(prev + 1, timeBound.length - maxVisibleHours));
    };

    const handlePrevImage = () => {
        setCurrentImageIndex((prev) => Math.max(prev - 1, 0));
    };

    const handleNextImage = () => {
        if (mainCourt?.courtImg?.length > 0) {
            setCurrentImageIndex((prev) => Math.min(prev + 1, images.length - 1));
        }
    };

    const generateWeekDates = (startOfWeek) => {
        const dates = [];
        for (let i = 0; i < 7; i++) {
            const date = addDays(startOfWeek, i);
            dates.push({
                day: format(date, 'EEE'),
                date: format(date, 'dd'),
                month: format(date, 'MMM'),
                fullDate: date,
            });
        }
        return dates;
    };

    const generateHourTimeline = (startHourIndex, date) => {
        const hours = [];
        const availableHours = timeBound.slice(startHourIndex, startHourIndex + maxVisibleHours);

        availableHours.forEach((hour, index) => {
            const hourStart = hour;
            const hourEnd = (hour + 1) % 24;
            
            const isBooked = slots.some(slot => 
                slot.courtId === mainCourt?.courtId &&
                new Date(slot.date).toDateString() === new Date(date).toDateString() &&
                hourStart >= slot.start &&
                hourStart < slot.end
            );

            const status = !mainCourt?.courtStatus ? 'maintenance' : isBooked ? 'booked' : 'available';

            hours.push({
                start: hourStart.toString().padStart(2, '0') + ':00',
                end: hourEnd.toString().padStart(2, '0') + ':00',
                status
            });
        });

        return hours;
    };

    const loadTimeFrame = async () => {
        const fetchTime = async () => {
            const res = await fetch(`https://localhost:7233/Slot/GetAll`)
            const data = await res.json()
            return data
        }

        try {
            const data = await fetchTime()
            setTimeBound([])
            const primitive = data.find(d => d['bookedSlotId'] === 'S1')
            const start = primitive.start
            const end = primitive.end
            for (let i = start; i <= end; i++) {
                setTimeBound(t => [...t, i])
            }
        } catch (err) {
            // handle error
        }
    }

    const weekDates = generateWeekDates(currentWeekStart);
    const hours = generateHourTimeline(currentHourIndex, selectedDate);

    // Function to extract image URLs from the courtImg string
    const extractImageUrls = (courtImg) => {
        if (!courtImg) return [];
        const regex = /([^|]+)/g;
        let matches;
        const urls = [];
        while ((matches = regex.exec(courtImg)) !== null) {
            urls.push(matches[0]);
        }
        return urls;
    }

    const images = mainCourt ? extractImageUrls(mainCourt.courtImg) : [];

    // Function to format the price
    const formatPrice = (n) => {
        function formatTo3Digits(n, stop) {
            let rs = ''
            if (!stop)
                for (let i = 1; i <= 3; i++) {
                    rs = (n % 10) + rs
                    n = Math.floor(n / 10)
                }
            else rs = n + rs
            return rs
        }
        if (Object.is(n, NaN)) return 0
        n = Math.floor(n)
        let rs = ''
        do {
            rs = formatTo3Digits(n % 1000, Math.floor(n / 1000) === 0) + rs
            n = Math.floor(n / 1000)
            if (n > 0) rs = ',' + rs
        } while (n > 0)
        return rs
    };
    const token = sessionStorage.getItem("token");
    return (
        <div className="viewcourtinfo">
            {token != null && (
                <div className="findCourtHeader">
                    <Header />
                </div>
            )}
            {token == null && (
                <Navbar />
            )}
            <div className="viewCourtInfo-wrapper">
                <div className="background">
                    <div className="viewcourtinfo-body">
                        <div className="viewcourtinfo-body-content">
                            <div className="viewcourtinfo-body-pic">
                                {images.length > 0 && (
                                    <div className="viewcourtinfo-slider">
                                        <button className="arrow-left" onClick={handlePrevImage}>
                                            <FaArrowLeft />
                                        </button>
                                        <img className="viewcourtinfo-img" src={images[currentImageIndex]?.trim() || ''} alt={`Court ${currentImageIndex}`} />
                                        <button className="arrow-right" onClick={handleNextImage}>
                                            <FaArrowRight />
                                        </button>
                                    </div>
                                )}
                                <div className="indicator-wrapper">
                                    {images.map((_, index) => (
                                        <span
                                            key={index}
                                            className={`indicator ${currentImageIndex === index ? 'active' : ''}`}
                                        ></span>
                                    ))}
                                </div>
                                <div className="viewcourtinfo-info-status">
                                    <div className="viewcourtinfo-info">
                                        <p className='viewcourt-title'>Address: {branch?.location}</p>
                                        <p className='viewcourt-title'>Branch: {branch?.branchName}</p>
                                        <p className='viewcourt-title'>Price: {mainCourt ? formatPrice(mainCourt.price) : 'N/A'} VND</p>
                                    </div>
                                </div>
                            </div>
                            <div className="viewcourtinfo-body-details">
                                <div className="viewcourtinfo-body-courtId">
                                    <h1>Court Name: {mainCourt?.courtName}</h1>
                                </div>
                                <div className="viewcourtinfo-body-des">
                                    <h1 className='viewcourtinfo-des-h1'>Description:</h1>
                                    <p className='viewcourtinfo-des-p'>{mainCourt?.description}</p>
                                </div>
                                <div className='chooseTimeLine'>
                                    <div className="chooseDate">CHOOSE DATE</div>
                                    <div className="date-slider-wrapper">
                                        <button className="arrow-left" onClick={handlePrevWeek}>
                                            <FaArrowLeft />
                                        </button>
                                        <div className="date-slider">
                                            {weekDates.map((date, index) => (
                                                <div
                                                    key={index}
                                                    className={`date-item ${selectedDate && selectedDate.toDateString() === date.fullDate.toDateString() ? 'selected' : ''}`}
                                                    onClick={() => handleDateClick(date.fullDate)}
                                                >
                                                    <div>{date.day}</div>
                                                    <div className="line-separator"></div>
                                                    <div className="viewcourt-date">{date.date}</div>
                                                    <div className="viewcourt-month">{date.month}</div>
                                                </div>
                                            ))}
                                        </div>
                                        <button className="arrow-right" onClick={handleNextWeek}>
                                            <FaArrowRight />
                                        </button>
                                    </div>
                                    <div className="chooseTime">CHOOSE TIME</div>
                                    <div className="schedule-legend-wrapper">
                                        <div className="schedule">
                                            <div className="court">
                                                <button className="arrow-left-timeline" onClick={handlePrevHour}>
                                                    <FaArrowLeft />
                                                </button>
                                                <div className="court-timeline">
                                                    {hours.map((hour, index) => (
                                                        <div
                                                            key={index}
                                                            className={`time-slot ${hour.status}`}
                                                        >
                                                            {hour.start} - {hour.end}
                                                        </div>
                                                    ))}
                                                </div>
                                                <button className="arrow-right-timeline" onClick={handleNextHour}>
                                                    <FaArrowRight />
                                                </button>
                                            </div>
                                        </div>
                                        <div className="legend">
                                            <div className="legend-item">
                                                <div className="legend-color booked"></div>
                                                <div className="legend-text">Booked</div>
                                            </div>
                                            <div className="legend-item">
                                                <div className="legend-color available"></div>
                                                <div className="legend-text">Available</div>
                                            </div>
                                            <div className="legend-item">
                                                <div className="legend-color maintenance"></div>
                                                <div className="legend-text">Maintenance</div>
                                            </div>
                                        </div>
                                        <button
                                            className='timeline-viewCourt'
                                            onClick={() => handleBookCourtOption(mainCourt?.courtId)}
                                            disabled={!mainCourt?.courtStatus}
                                        >
                                            Book
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="viewcourtinfo-othercourts">
                        <h1 className='viewcourtinfo-othercourts-h1'>OTHER COURTS</h1>
                        <div className="viewcourtinfo-othercourts-content">
                            {recommendedCourts.map((court, index) => (
                                <div key={index} className="viewcourtinfo-other-pic">
                                    <img className="viewcourtinfo-other-img" src={extractImageUrls(court.courtImg)[0]?.trim() || ''} alt="" />
                                    <div className="viewcourtinfo-other-info">
                                        <h2>Court Name: {court.courtName}</h2>
                                        <p>Address: {branch?.location}</p>
                                        <p>Branch: {branch?.branchName}</p>
                                        <p>Price: {formatPrice(court.price)} VND</p>
                                        <div className="viewcourtinfo-other-des">
                                            <h1 className='viewcourtinfo-other-des-h1'>Description:</h1>
                                            <p className='viewcourtinfo-other-des-p'>{court.description}</p>
                                        </div>
                                        <div className="other-court-button">
                                            <button
                                                className='viewCourt'
                                                onClick={() => handleBookCourt(court.courtId)}
                                                disabled={!court.courtStatus}
                                            >
                                                Book
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
            </div>
            <Footer />
        </div>
    );
}

export default ViewCourtInfo;
