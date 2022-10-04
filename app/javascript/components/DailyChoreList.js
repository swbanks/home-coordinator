import React, { useState, useEffect } from 'react';
import {useLocation} from 'react-router-dom';
import { getDailyChoreCalendarForUser, updateChores } from '../services/ChoreCalendarService';
import { isEmpty } from 'lodash';
import { format } from 'date-fns';

const DailyChoreList = () => {
  const { state } = useLocation();
  const { name } = state;
  const [chores, setChores] = useState(null);
  const [isFetched, setIsFetched] = useState(false);
  const [isSaved, setIsSaved] = useState(false);

  useEffect(() => {
    if (!state) return;
    getDailyChoreCalendarForUser(state.name, "2022-08-12")
      .then(response => {
        setChores(response);
        setIsFetched(true);
      });
  }, []);

  const handleChoreCheckChanged = (index) => {
    newChores = [...chores];
    newChores[index].user_completed = !newChores[index].user_completed;
    setChores(newChores);
  };

  const startOver = () => {
    setIsFetched(false);
  };

  const save = () => {
    updateChores(chores)
      .then(_ => {
        setIsSaved(true);
        setTimeout(() => setIsSaved(false), 7000);
    });
  };

  return (
    <>
      <div className={isSaved ? "message-bar" : "empty-message-bar"}>Chore status has been saved.</div>

      {isFetched && isEmpty(chores) &&
        <>
          <h1>Sorry {name}, we could not find you in our system.</h1>
          <button onClick={() => startOver()}>Start Over</button>
        </>
      }
      {!isEmpty(chores) && <>
        <h2 className="header">Hello, {name}!</h2>
        <h2 className="header">Today is {format(new Date(), "eeee MMMM do yyyy")} and here are your chores for today:</h2>
      </>
      }
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