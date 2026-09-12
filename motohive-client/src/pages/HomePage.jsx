import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import axios from "axios";

async function fetchFeaturedListings () {
  const res = await axios.get("/api/listings?isPrimary=true&status=ACTIVE&page=0&size=6");
  if (res.data.content.length === 0) {
    return axios.get("/api/listings?status=ACTIVE&sort=listedAt,desc&page=0&size=6")
       .then(r => r.data.content);
  }
  return res.data.content;
}

async function fetchBrands (vehicleType) {
  const res = await axios.get(`/api/brands?vehicleType=${vehicleType}`);
  return res.data;
}

async function fetchModels (vehicleType, brand) {
  const res = await axios.get(`/api/models?vehicleType=${vehicleType}&brand=${brand}`);
  return res.data;
}

export default function HomePage () {
  const navigate = useNavigate();
  const [vehicleType, setVehicleType] = useState("cars");
  const [brand, setBrand] = useState("");
  const [model, setModel] = useState("");
  const [price, setPrice] = useState(1000000);
  
  const { data: listings = [], isLoading } = useQuery(["featuredListings"], fetchFeaturedListings);
  const { data: brands = [] } = useQuery(["brands", vehicleType], () => fetchBrands(vehicleType));
  const { data: models = [] } = useQuery(["models", vehicleType, brand], () => fetchModels(vehicleType, brand), {
    enabled: !!brand,
  });
  
  const handleSearch = () => {
    navigate(`/listings/${vehicleType}?brand=${brand}&model=${model}&price=${price}`);
  };
  
  return (
     <div className="p-6">
       {/* Tabs */}
       <div className="flex space-x-6 mb-6">
         <button onClick={() => setVehicleType("cars")} className="text-blue-600 font-semibold">Cars</button>
         <button onClick={() => setVehicleType("bikes")} className="text-blue-600 font-semibold">Bikes</button>
         <button onClick={() => setVehicleType("evs")} className="text-blue-600 font-semibold">EVs</button>
       </div>
       
       {/* Search Bar */}
       <div className="bg-gray-100 dark:bg-gray-800 p-4 rounded shadow-md mb-6">
         <h2 className="text-lg font-bold mb-4">Search Vehicles</h2>
         <div className="flex space-x-4 items-center">
           <select value={brand} onChange={(e) => setBrand(e.target.value)} className="p-2 rounded">
             <option value="">Select Brand</option>
             {brands.map((b) => <option key={b} value={b}>{b}</option>)}
           </select>
           
           <select value={model}
                   onChange={(e) => setModel(e.target.value)}
                   className="p-2 rounded"
                   disabled={!brand}>
             <option value="">Select Model</option>
             {models.map((m) => <option key={m} value={m}>{m}</option>)}
           </select>
           
           <input
              type="range"
              min="0"
              max="1000000"
              step="50000"
              value={price}
              onChange={(e) => setPrice(e.target.value)}
              className="w-1/3"
           />
           <span>₹0 - ₹{price}</span>
           
           <button onClick={handleSearch} className="px-4 py-2 bg-blue-600 text-white rounded">
             Search
           </button>
         </div>
       </div>
       
       {/* Featured Listings */}
       <div>
         <h2 className="text-xl font-bold mb-4">Featured Listings</h2>
         {isLoading ? (
            <p>Loading...</p>
         ) : (
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {listings.map((vehicle) => (
                 <div key={vehicle.id} className="border rounded shadow p-4">
                   <img src={vehicle.imageUrl || "https://via.placeholder.com/300"}
                        alt="Vehicle"
                        className="mb-2 rounded"/>
                   <h3 className="font-bold">{vehicle.brand} {vehicle.model}</h3>
                   <p>₹{vehicle.price} • {vehicle.city}</p>
                   <p>Fuel: {vehicle.fuelType} • Year: {vehicle.year}</p>
                 </div>
              ))}
            </div>
         )}
       </div>
     </div>
  );
}