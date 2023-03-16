import React, { useState } from 'react';
import {useNavigate} from 'react-router-dom';

//Need to add router and better formatting
const Login = () => {
  const navigate = useNavigate();

  const names = ["Nathanael", "Joshua", "Caleb", "Annalise"];
  const [userName, setUserName] = useState("");
  

  const selectUserChange = (event) => {
    const value = event.target.value;
    if (value == "Select" || value == userName) return;

    setUserName(value);
  };

  const handleSubmit = () => {
    if (userName !== "") navigate('/chores', { state: { name: userName } });
  };
  
  return (
    <>
      <h2 className="form-field pb-10">Hello There! Please select your username to login:</h2>

      {<form onSubmit={handleSubmit}>
        {<label className="form-field pb-10">Username:
          <select onChange={selectUserChange}>
            <option>Select</option>
            {names.map((name) => {
              return (
                <option value={name}>{name}</option>
              );

          })}
          </select>
        </label>}
        <input type="submit" value="Submit" />
      </form>}
    </>
  );
};

export default Login;