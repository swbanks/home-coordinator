/*
What will we do here? This will be the root component as we test initially.
A login screen will eventually take over which distinguishes between children and parents (maybe based on user type?)

This page can allow a parent to choose which child they want to check via dropdown.
It will display the chores for that day for that child and allow the parent to check off completion.
Allow user to go back to child select.

Eventually maybe we can cycle between days?
*/

import React, { useState, useRef, useEffect } from "react";
import {
  getDailyChoreCalendarForUser,
  updateChores,
  createChoreMonth,
  deleteOldChoreCalendarRecords,
  createAdHocChore,
} from "../services/ChoreCalendarService";
import {
  createChore,
  deleteChore,
  getChores,
  updateFamilyVerse,
} from "../services/ChoreService";
import { getUsers } from "../services/UserService";
import { isEmpty } from "lodash";

const ParentChoreChecker = () => {
  const currentDate = new Date().toLocaleDateString();

  const names = ["Nathanael", "Joshua", "Caleb", "Annalise"];
  const [choreUserName, setChoreUserName] = useState("");
  const [users, setUsers] = useState([]);
  const [choreList, setChoreList] = useState([]);
  const [userChores, setUserChores] = useState(null);
  const [isSaved, setIsSaved] = useState(false);
  const [displaySections, setDisplaySections] = React.useState({
    intro: true,
    chores: false,
    utilities: false,
  });

  const createChoreRef = useRef(null);
  const deleteChoreRef = useRef(null);
  const deleteOldChoresRef = useRef(null);
  const updateVerseRef = useRef(null);
  const adHocChoreUserRef = useRef(null);
  const adHocChoreChoreRef = useRef(null);
  const adHocChoreDateRef = useRef(null);

  const handleChoreCheckChanged = (index) => {
    let newChores = [...userChores];
    newChores[index].checked = !newChores[index].checked;
    setUserChores(newChores);
  };

  const save = () => {
    updateChores(userChores).then((_) => {
      setIsSaved(true);
      setTimeout(() => setIsSaved(false), 7000);
    });
  };

  const selectChoreUserChange = (event) => {
    const value = event.target.value;
    if (value == "Select" || value == choreUserName) return;

    setChoreUserName(value);
    getDailyChoreCalendarForUser(value, currentDate).then((response) => {
      setUserChores(response);
    });
  };

  const changeSectionDisplay = (event) => {
    const value = event.target.value;
    if (value == "chores") {
      setDisplaySections({ intro: false, utilities: false, chores: true });
    } else if (value == "utilities") {
      getDeleteChoreList();
      setDisplaySections({ intro: false, utilities: true, chores: false });
    }
  };

  const getDeleteChoreList = () => {
    getChores().then((response) => {
      console.log(response);
      setChoreList(response);
    });
  };

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
      alert("Chore month already created"); //show something on the screen saying this worked
    });
  };

  const deleteOldChores = () => {
    const date = deleteOldChoresRef.current?.value;
    deleteOldChoreCalendarRecords(date).then((response) => {
      console.log(response);
      alert("Old chores deleted");
    });
  };

  const updateVerse = () => {
    const verse = updateVerseRef.current?.value;
    updateFamilyVerse(verse).then((response) => {
      console.log(response);
      alert("Family verse updated");
    });
  };

  const AddAdHocChore = () => {
    const date = adHocChoreDateRef.current?.value;
    const userId = adHocChoreUserRef.current?.value;
    const choreId = adHocChoreChoreRef.current?.value;
    createAdHocChore(choreId, userId, date).then((response) => {
      console.log(response);
      alert("Ad-hoc chore created");
    });
  };

  useEffect(() => {
    getUsers().then((response) => {
      setUsers(response);
    });
  }, []);
  

  return (
    <div>
      <div
        className={displaySections["intro"] ? "show-section" : "hide-section"}
      >
        <h2>Welcome parent! Please select an option below:</h2>
        <select onChange={changeSectionDisplay}>
          <option value="n/a">Select</option>
          <option value="utilities">Utilities</option>
          <option value="chores">Check Chores</option>
        </select>
      </div>
      <div
        className={
          displaySections["utilities"] ? "show-section" : "hide-section"
        }
      >
        <div>
          <h2>Please enter a chore to add:</h2>
          <input type="text" ref={createChoreRef}></input>
          <button onClick={addChore}>Add</button>
        </div>
        <div>
          <h2>Please select a chore to delete:</h2>
          <select ref={deleteChoreRef}>
            <option>Select</option>
            {choreList.map((chore) => {
              return <option value={chore.id}>{chore.name}</option>;
            })}
          </select>
          <button onClick={removeChore}>Delete</button>
        </div>
        <div>
          <h2>Create an ad-hoc chore:</h2>
          <select ref={adHocChoreChoreRef}>
            <option>Select</option>
            {choreList.map((chore) => {
              return <option value={chore.id}>{chore.name}</option>;
            })}
          </select>
          <select ref={adHocChoreUserRef}>
            <option>Select</option>
            {users.map((user) => {
              return <option value={user.id}>{user.name}</option>;
            })}
          </select>
          <input type="text" ref={adHocChoreDateRef}></input>
          <button onClick={AddAdHocChore}>Create Ad-Hoc Chore</button>
        </div>
        <div>
          <button onClick={createMonth}>Create Month</button>
        </div>
        <div>
          <input type="text" ref={deleteOldChoresRef}></input>
          <button onClick={deleteOldChores}>Delete old chores</button>
        </div>
        <div>
          <input type="text" ref={updateVerseRef}></input>
          <button onClick={updateVerse}>Update family verse</button>
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
        {!isEmpty(userChores) && (
          <div className="grid-parent-checker">
            <div>Chore</div>
            <div>✅ by child</div>
            <div>✅ by parent</div>
            {userChores.map((chore, index) => {
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
