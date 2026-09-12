// src/pages/CarsListingPage.jsx
import { useSearchParams } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import axios from "axios";
import VehicleCard from "../components/VehicleCard";
import FilterSidebar from "../components/FilterSidebar";
import Pagination from "../components/Pagination.jsx";

async function fetchCarsListings (params) {
  const res = await axios.get(`/api/listings/cars`, { params });
  return res.data;
}

export default function CarsListingPage () {
  const [searchParams] = useSearchParams();
  const brand = searchParams.get("brand") || "";
  const model = searchParams.get("model") || "";
  const price = searchParams.get("price") || "";
  const page = parseInt(searchParams.get("page") || "0", 10);
  const size = parseInt(searchParams.get("size") || "10", 10);
  
  const { data, isLoading } = useQuery(
     ["carsListings", brand, model, price, page, size],
     () => fetchCarsListings({ brand, model, price, page, size })
  );
  
  // For now, mock brands/models until backend endpoints are ready
  const brands = ["Honda", "Toyota", "Maruti"];
  const models = brand === "Honda" ? ["City", "Amaze"] : brand === "Toyota" ? ["Corolla", "Innova"] : [];
  
  return (
     <div className="p-6 grid grid-cols-1 md:grid-cols-4 gap-6">
       {/* Sidebar */}
       <div className="md:col-span-1">
         <FilterSidebar vehicleType="cars" brands={brands} models={models}/>
       </div>
       
       {/* Listings */}
       <div className="md:col-span-3">
         <h1 className="text-2xl font-bold mb-4">Cars Listings</h1>
         {isLoading ? (
            <p>Loading...</p>
         ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {data.content.map((vehicle) => (
                 <VehicleCard key={vehicle.id} vehicle={vehicle}/>
              ))}
            </div>
         )}
         
         {/* Pagination */}
         {data && (
            <Pagination page={page} totalPages={data.totalPages}/>
         )}
       </div>
     </div>
  );
}