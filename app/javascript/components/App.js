import React from 'react';
import {BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import Login from './Login';
import ParentLogin from './ParentLogin';
import DailyChoreList from './DailyChoreList';
import ParentChoreChecker from './ParentChoreChecker';
import './App.css';

const App = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/parent" element={<ParentLogin />} />
        <Route path="/parent_checker" element={<ParentChoreChecker />} />
        <Route path="/chores" element={<DailyChoreList />} />
      </Routes>
    </Router>
  );
};

export default App;