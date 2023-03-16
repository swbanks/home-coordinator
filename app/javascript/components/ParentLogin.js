import React, { useState } from 'react';
import {useNavigate} from 'react-router-dom';

const ParentLogin = () => {
  const navigate = useNavigate();
  const [password, setPassword] = useState("");
  const [incorrectPassword, setIncorrectPassword] = useState(false);
  

  const handleSubmit = (e) => {
    if (password === "yo mama") {
      setIncorrectPassword(false);
      navigate('/parent_checker');
    } else {
      setIncorrectPassword(true);
      e.preventDefault();
    };
  };
  
  return (
    <>
      {!incorrectPassword &&
        <h2 className="form-field pb-10">Hello Parent! Please enter your password to login:</h2>
      }
      {
        incorrectPassword && 
          <h2 className="form-field pb-10">You have entered an incorrect password. Please try again:</h2>
      }
      {<form onSubmit={handleSubmit}>
        {<label className="form-field pb-10">Password:
          <input
            type="text"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </label>}
        <input type="submit" value="Submit" />
      </form>}
    </>
  );
};

export default ParentLogin;