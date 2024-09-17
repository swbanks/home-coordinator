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

export async function updateChores(chores) {
  try{
    const response = await axios.patch(`/api/chore_calendar`, chores);
  } catch(error) {
      console.log(`Error in function updateChores, ${error}`);
  }
}

export async function createChoreMonth() {
  try{
    const response = await axios.post(`/api/chore_calendar/create_month`, {});
  } catch(error) {
      console.log(`Error in function createChoreMonth, ${error}`);
  }
}

export async function deleteOldChoreCalendarRecords(date) {
  try{
    const response = await axios.post(`/api/chore_calendar/delete_old`, {date: date});
  } catch(error) {
      console.log(`Error in function deleteOldChoreCalendarRecords, ${error}`);
  }
}

export async function createAdHocChore(choreId, userId, date) {
  try{
    const response = await axios.post(`/api/chore_calendar`, {chore_id: choreId, user_id: userId, date: date});
  } catch(error) {
      console.log(`Error in function createAdHocChore, ${error}`);
  }
}