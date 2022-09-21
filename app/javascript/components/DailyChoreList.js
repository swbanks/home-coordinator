import React, { useState } from 'react';
import { getDailyChoreCalendarForUser, updateChores } from '../services/ChoreCalendarService';
import { isEmpty } from 'lodash';

const DailyChoreList = () => {
  const [chores, setChores] = useState(null);
  const [name, setName] = useState("");
  const [isFetched, setIsFetched] = useState(false);

  const handleChoreCheckChanged = (index) => {
    newChores = [...chores];
    newChores[index].user_completed = !newChores[index].user_completed;
    setChores(newChores);
  };

  const startOver = () => {
    setIsFetched(false);
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    getDailyChoreCalendarForUser(name, "2022-08-12")
      .then(response => {
        setIsFetched(true);
        setChores(response);
      });
  };

  const save = () => {
    updateChores(chores);
  };

  return (
    <>
      {!isFetched && <form onSubmit={handleSubmit}>
        <label>
          Please enter your name:
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
        </label>
        <input type="submit" value="Submit" />
      </form>}

      {isFetched && isEmpty(chores) &&
        <>
          <h1>Sorry {name}, we could not find you in our system.</h1>
          <button onClick={() => startOver()}>Start Over</button>
        </>
      }
      {!isEmpty(chores) && <h1>Hello, {name}! Here are your chores for today:</h1>}
      {!isEmpty(chores) && <div className="grid">
        {chores.map((chore, index) => {
          return (
            <>
              <div className="item">{chore.chore.name}</div>
              <input 
                type="checkbox"
                checked={chore.user_completed}
                onChange={() => handleChoreCheckChanged(index)}
                key={chore.id}
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

export default DailyChoreList;