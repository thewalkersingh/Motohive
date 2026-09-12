import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import NavBar from "./components/NavBar";
import Footer from "./components/Footer";
import HomePage from "./pages/HomePage";
import CarsListingPage from "./pages/CarsListingPage";
import BikesListingPage from "./pages/BikesListingPage";
import EVListingPage from "./pages/EVListingPage";
import VehicleDetailPage from "./pages/VehicleDetailPage";
import AddVehiclePage from "./pages/AddVehiclePage";
import ProfilePage from "./pages/ProfilePage";
import SettingsPage from "./pages/SettingsPage";

export default function App () {
  const isAdmin = true; // placeholder until login is wired
  
  return (
     <Router>
       <div className="flex flex-col min-h-screen">
         <NavBar isAdmin={isAdmin}/>
         <main className="flex-grow">
           <Routes>
             <Route path="/" element={<HomePage/>}/>
             <Route path="/listings/cars" element={<CarsListingPage/>}/>
             <Route path="/listings/bikes" element={<BikesListingPage/>}/>
             <Route path="/listings/evs" element={<EVListingPage/>}/>
             <Route path="/listings/:id" element={<VehicleDetailPage/>}/>
             {isAdmin && <Route path="/add-vehicle" element={<AddVehiclePage/>}/>}
             <Route path="/profile" element={<ProfilePage/>}/>
             {isAdmin && <Route path="/settings" element={<SettingsPage/>}/>}
           </Routes>
         </main>
         <Footer/>
       </div>
     </Router>
  );
  
}