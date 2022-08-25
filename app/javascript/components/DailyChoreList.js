import React, { useState, useEffect } from 'react';
import { getDailyChoreCalendarForUser } from '../services/ChoreCalendarService';

const DailyChoreList = ({ name }) => {
  const [chores, setChores] = useState([]);

  useEffect(() => {
    getDailyChoreCalendarForUser("Joshua", "2022-08-12")
      .then(response => {
        setChores(response);
      });
  }, []);

  const handleChoreCheckChanged = (index) => {
    newChores = [...chores];
    console.log(`hello mate! ${index}, checked = ${newChores[index].checked}`);
    newChores[index].checked = !newChores[index].checked;
    setChores(newChores);
  };

  return (
    <>
      <h1>Hello, {name}!</h1>

      <div className="grid">
        {chores.map((chore, index) => {
          return (
            <>
              <div className="item">{chore.chore.name}</div>
              <input 
                type="checkbox"
                checked={chore.checked}
                onChange={() => handleChoreCheckChanged(index)}
                key={chore.id}
              >
              </input>
            </>
          );
        })}
      </div>
    </>
  );
};

export default DailyChoreList;