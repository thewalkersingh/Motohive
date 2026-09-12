import { useState } from "react";
import logo from "../assets/hero.png";

export default function NavBar ({ isAdmin }) {
  const [isDark, setIsDark] = useState(false);
  const [showLogin, setShowLogin] = useState(false);
  
  const toggleDarkMode = () => {
    setIsDark(!isDark);
    document.documentElement.classList.toggle("dark");
  };
  
  return (
     <nav className="bg-white dark:bg-gray-900 shadow-md px-6 py-3 flex justify-between items-center">
       {/* Logo */}
       <div className="flex items-center space-x-2">
         <img src={logo} alt="MotoHive Logo" className="h-8 w-8"/>
         <span className="text-xl font-bold text-gray-800 dark:text-white">MotoHive</span>
       </div>
       
       {/* Links */}
       <div className="flex space-x-6 text-gray-700 dark:text-gray-200">
         <a href="/">Home</a>
         <a href="/listings">Listings</a>
         {isAdmin && <a href="/add-vehicle">Add Vehicle</a>}
         <a href="/profile">Profile</a>
         {isAdmin && <a href="/settings">Settings</a>}
       </div>
       
       {/* Actions */}
       <div className="flex space-x-4">
         <button onClick={toggleDarkMode} className="px-3 py-1 rounded bg-gray-200 dark:bg-gray-700">
           {isDark ? "Light" : "Dark"}
         </button>
         <button onClick={() => setShowLogin(true)} className="px-3 py-1 rounded bg-blue-600 text-white">
           Login
         </button>
       </div>
       
       {/* Login Modal */}
       {showLogin && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
            <div className="bg-white dark:bg-gray-800 p-6 rounded shadow-lg">
              <h2 className="text-lg font-bold mb-4">Login Coming Soon</h2>
              <button onClick={() => setShowLogin(false)} className="px-4 py-2 bg-red-500 text-white rounded">
                Close
              </button>
            </div>
          </div>
       )}
     </nav>
  );
}