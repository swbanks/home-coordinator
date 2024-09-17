const axios = require("axios");

export async function getUsers() {
  try {
    const response = await axios.get(`/api/users`);
    return response.data;
  } catch (error) {
    console.log(`Error in function getUsers, ${error}`);
    return [];
  }
}
