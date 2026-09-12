// src/components/FilterSidebar.jsx
import { useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import axios from "axios";

async function fetchBrands(vehicleType) {
  const res = await axios.get(`/api/brands?vehicleType=${vehicleType}`);
  return res.data;
}

async function fetchModels(vehicleType, brand) {
  const res = await axios.get(`/api/models?vehicleType=${vehicleType}&brand=${brand}`);
  return res.data;
}

export default function FilterSidebar({ vehicleType }) {
  const navigate = useNavigate();
  const location = useLocation();
  
  const [brand, setBrand] = useState("");
  const [model, setModel] = useState("");
  const [price, setPrice] = useState(1000000);
  
  const { data: brands = [] } = useQuery(["brands", vehicleType], () => fetchBrands(vehicleType));
  const { data: models = [] } = useQuery(
     ["models", vehicleType, brand],
     () => fetchModels(vehicleType, brand),
     { enabled: !!brand }
  );
  
  const handleFilter = () => {
    navigate(`${location.pathname}?brand=${brand}&model=${model}&price=${price}`);
  };
  
  return (
     <div className="bg-gray-100 dark:bg-gray-800 p-4 rounded shadow-md mb-6">
       <h2 className="text-lg font-bold mb-4">Filters</h2>
       <div className="flex flex-col space-y-4">
         <select value={brand} onChange={(e) => setBrand(e.target.value)} className="p-2 rounded">
           <option value="">Select Brand</option>
           {brands.map((b) => <option key={b} value={b}>{b}</option>)}
         </select>
         
         <select value={model} onChange={(e) => setModel(e.target.value)} className="p-2 rounded" disabled={!brand}>
           <option value="">Select Model</option>
           {models.map((m) => <option key={m} value={m}>{m}</option>)}
         </select>
         
         <div>
           <input
              type="range"
              min="0"
              max="1000000"
              step="50000"
              value={price}
              onChange={(e) => setPrice(e.target.value)}
              className="w-full"
           />
           <span>₹0 - ₹{price}</span>
         </div>
         
         <button onClick={handleFilter} className="px-4 py-2 bg-blue-600 text-white rounded">
           Apply Filters
         </button>
       </div>
     </div>
  );
}