import React, { useEffect, useState } from "react";
import axios from 'axios';
import { Box } from "@mui/material";
import Head from "../../Components/Head";
import LineChart from "../../Components/LineChart";
import { fetchWithAuth } from "../../Components/fetchWithAuth/fetchWithAuth";

const Line = () => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const currentYear = new Date().getFullYear();

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const token = sessionStorage.getItem('token');
        const response = await fetchWithAuth(`https://localhost:7233/Payment/Statistic?Year=${currentYear}&Type=1&StartMonth=1&MonthNum=1&Week=1`, {
          method: 'GET',
          headers: { 'Authorization': `Bearer ${token}` }
        });
        const result = await response.json();
        setData(result);
      } catch (error) {
        console.error("Error fetching data", error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [currentYear]);

  return (
    <Box m="20px">
      <Head title="Line Chart" subtitle="Simple Line Chart" />
      <Box height="75vh">
        {loading ? (
          <p>Loading data...</p>
        ) : (
          <LineChart data={data} />
        )}
      </Box>
    </Box>
  );
};

export default Line;
