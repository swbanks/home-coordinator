const axios = require('axios');

export async function getDailyChoreCalendarForUser(userName, date) {
  try{
    const response = await axios.get(`/api/chore_calendar?user=${userName}&date=${date}`);
    return response.data;
  } catch(error) {
      console.log(`Error in function getDailyChoreCalendarForUser, ${error}`);
      return [];
  }
}