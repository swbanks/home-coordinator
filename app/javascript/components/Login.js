import React, { useState } from 'react';

//Need to add router and better formatting
const Login = () => {
  const [requirePassword, setRequirePassword] = useState(false);
  const [userName, setUserName] = useState("");
  const [password, setPassword] = useState("");
  
  const onUserTypeChange = (event) => {
    console.log(event.target.value);
    setRequirePassword(event.target.value == 'Parent');
  };

  const handleSubmit = () => {
    return true;
  };
  
  return (
    <>
      <label>What user type are you?</label>
      <div className="pt-10 pb-10" onChange={onUserTypeChange}>
        <input type="radio" value="Parent" name="user-type" /> Parent
        <input type="radio" value="Child" name="user-type" /> Child
      </div>

      {<form onSubmit={handleSubmit}>
        <label className="form-field pb-10">Username:
          <input
            type="text"
            value={userName}
            onChange={(e) => setUserName(e.target.value)}
          />
        </label>
        {requirePassword && <label className="form-field pb-10">Password:
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

export default Login;