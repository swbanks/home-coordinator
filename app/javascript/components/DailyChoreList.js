import React from 'react';
import { useState } from 'react';

const DailyChoreList = ({ name }) => {
  const choreList = [{id: 1, name: "Dishes", checked: false}, {id: 2, name: "Laundry", checked: true}];
  const [chores, setChores] = useState(choreList);

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
              <div className="item">{chore.name}</div>
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