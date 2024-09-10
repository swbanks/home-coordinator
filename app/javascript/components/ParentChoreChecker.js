/*
What will we do here? This will be the root component as we test initially.
A login screen will eventually take over which distinguishes between children and parents (maybe based on user type?)

This page can allow a parent to choose which child they want to check via dropdown.
It will display the chores for that day for that child and allow the parent to check off completion.
Allow user to go back to child select.

Eventually maybe we can cycle between days?
*/

import React, { useState, useRef } from "react";
import {
  getDailyChoreCalendarForUser,
  updateChores,
  createChoreMonth,
} from "../services/ChoreCalendarService";
import {
  createChore,
  deleteChore,
  getChores,
} from "../services/ChoreService";
import { isEmpty } from "lodash";

// I need a user dropdown, chore dropdown, and a date picker textbox (or calendar)
// I also need sections for picking either chores to check or assigning an ad-hoc chore
const ParentChoreChecker = () => {
  const currentDate = new Date().toJSON().slice(0, 10);

  const names = ["Nathanael", "Joshua", "Caleb", "Annalise"];
  const [choreUserName, setChoreUserName] = useState("");
  const [deleteChoreList, setDeleteChoreList] = useState([]);
  const [chores, setChores] = useState(null);
  const [isSaved, setIsSaved] = useState(false);
  const [displaySections, setDisplaySections] = React.useState({
    intro: true,
    chores: false,
    addChore: false,
  });

  const createChoreRef = useRef(null);
  const deleteChoreRef = useRef(null);

  const handleChoreCheckChanged = (index) => {
    let newChores = [...chores];
    newChores[index].checked = !newChores[index].checked;
    setChores(newChores);
  };

  const save = () => {
    updateChores(chores).then((_) => {
      setIsSaved(true);
      setTimeout(() => setIsSaved(false), 7000);
    });
  };

  const selectChoreUserChange = (event) => {
    const value = event.target.value;
    if (value == "Select" || value == choreUserName) return;

    setChoreUserName(value);
    getDailyChoreCalendarForUser(value, currentDate).then((response) => {
      setChores(response);
    });
  };

  const changeSectionDisplay = (event) => {
    const value = event.target.value;
    if (value == "chores") {
      console.log("chores");
      setDisplaySections({ intro: false, addChore: false, chores: true });
    } else if (value == "addChore") {
      getDeleteChoreList();
      setDisplaySections({ intro: false, addChore: true, chores: false });
    }
  };

  const getDeleteChoreList = () => {
    getChores().then((response) => {
      console.log(response);
      setDeleteChoreList(response);
    });
  }
  const addChore = () => {
    console.log("add chore");
    const choreName = createChoreRef.current?.value;
    createChore(choreName).then((response) => {
      console.log(response);
    });
  };

  const removeChore = () => {
    const choreId = deleteChoreRef.current?.value;
    console.log("delete chore, choreId = ", choreId);
    deleteChore(choreId).then((response) => {
      console.log(response);
    });
  };

  const createMonth = () => {
    createChoreMonth().then((response) => {
      console.log(response);
      alert("Chore month created"); //show something on the screen saying this worked
    });
  };

  return (
    <div>
      <div
        className={displaySections["intro"] ? "show-section" : "hide-section"}
      >
        <h2>Welcome parent! Please select an option below:</h2>
        <select onChange={changeSectionDisplay}>
          <option value="n/a">Select</option>
          <option value="addChore">Add Chore</option>
          <option value="chores">Check Chores</option>
        </select>
      </div>
      <div className={displaySections["addChore"] ? "show-section" : "hide-section"}>
        <div>
          <h2>Please enter a chore to add:</h2>
          <input type="text" ref={createChoreRef}></input>
          <button onClick={addChore}>Add</button>
        </div>
        <div>
          <h2>Please select a chore to delete:</h2>
          <select ref={deleteChoreRef}>
            <option>Select</option>
            {deleteChoreList.map((chore) => {
              return <option value={chore.id}>{chore.name}</option>;
            })}
        </select>
          <button onClick={removeChore}>Delete</button>
        </div>
        <div>
          <button onClick={createMonth}>Create Month</button>
        </div>
      </div>
      <div
        className={displaySections["chores"] ? "show-section" : "hide-section"}
      >
        <div className={isSaved ? "message-bar" : "empty-message-bar"}>
          Chore status has been saved.
        </div>

        <h2>Please select which child's chores to check:</h2>
        <select onChange={selectChoreUserChange}>
          <option>Select</option>
          {names.map((name) => {
            return <option value={name}>{name}</option>;
          })}
        </select>

        <div className="grid-parent-header"></div>
        {!isEmpty(chores) && (
          <div className="grid-parent-checker">
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
                  ></input>
                  <input
                    type="checkbox"
                    checked={chore.checked}
                    onChange={() => handleChoreCheckChanged(index)}
                    key={chore.id + "parent"}
                  ></input>
                </>
              );
            })}
            <button className="save" onClick={() => save()}>
              Save
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default ParentChoreChecker;
