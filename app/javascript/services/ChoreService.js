const axios = require('axios');

export async function createChore(choreName) {
  try{
    const response = await axios.post(`/api/chores`, {name: choreName});
    return response.data;
  } catch(error) {
      console.log(`Error in function createChore, ${error}`);
      return [];
  }
}

export async function getChores() {
  try{
    const response = await axios.get(`/api/chores`);
    return response.data;
  } catch(error) {
      console.log(`Error in function getChores, ${error}`);
      return [];
  }
}

export async function deleteChore(choreId) {
  try{
    const response = await axios.delete(`/api/chores/${choreId}`);
    return response.data;
  } catch(error) {
      console.log(`Error in function deleteChore, ${error}`);
      return [];
  }
}