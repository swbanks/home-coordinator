/*
What will we do here? This will be the root component as we test initially.
A login screen will eventually take over which distinguishes between children and parents (maybe based on user type?)

This page can allow a parent to choose which child they want to check via dropdown.
It will display the chores for that day for that child and allow the parent to check off completion.
Allow user to go back to child select.

Eventually maybe we can cycle between days?
*/

import React, { useState } from 'react';
import { getDailyChoreCalendarForUser, updateChores } from '../services/ChoreCalendarService';
import { isEmpty } from 'lodash';

const ParentChoreChecker = () => {
  const names = ["Nathanael", "Joshua", "Caleb", "Annalise"];
  const [choreUserName, setChoreUserName] = useState("");
  const [chores, setChores] = useState(null);

  const handleChoreCheckChanged = (index) => {
    newChores = [...chores];
    newChores[index].checked = !newChores[index].checked;
    setChores(newChores);
  };

  const save = () => {
    updateChores(chores);
  };

  const selectChoreUserChange = (event) => {
    const value = event.target.value;
    if (value == "Select" || value == choreUserName) return;

    setChoreUserName(value);
    getDailyChoreCalendarForUser(value, "2022-08-12")
      .then(response => {
        setChores(response);
      });
  };

  return (
    <>
      <h1>Welcome parent! Please select which child's chores to check:</h1>
      <select onChange={selectChoreUserChange}>
        <option>Select</option>
        {names.map((name) => {
          return (
            <option value={name}>{name}</option>
          );

      })}
      </select>

      <div className="grid-parent-header">

      </div>
      {!isEmpty(chores) && <div className="grid-parent-checker">
        <div>Chore</div>
        <div>✅ by child</div>
        <div>✅ by parent</div>
        {chores.map((chore, index) => {
          return (
            <>
              <div className="item">{chore.chore.name}</div>
              <input 
                type="checkbox"
                checked={chore.user_completed}
                key={chore.id + "user"}
              >
              </input>
              <input 
                type="checkbox"
                checked={chore.checked}
                onChange={() => handleChoreCheckChanged(index)}
                key={chore.id + "parent"}
              >
              </input>
            </>
          );
        })}
        <button className="save" onClick={() => save()}>Save</button>
      </div>}
    </>
  );
};

export default ParentChoreChecker;