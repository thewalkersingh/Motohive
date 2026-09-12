// src/pages/VehicleDetailPage.jsx
import { useParams } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import axios from "axios";

async function fetchVehicle(id) {
  const res = await axios.get(`/api/listings/${id}`);
  return res.data;
}

export default function VehicleDetailPage() {
  const { id } = useParams();
  const { data: vehicle, isLoading } = useQuery(["vehicleDetail", id], () => fetchVehicle(id));
  
  if (isLoading) return <p>Loading...</p>;
  
  return (
     <div className="p-6 grid grid-cols-1 md:grid-cols-3 gap-6">
       {/* Image Carousel */}
       <div className="md:col-span-2">
         <div className="flex overflow-x-scroll space-x-4">
           {vehicle.images.map((img, idx) => (
              <img key={idx} src={img} alt="Vehicle" className="rounded w-80 h-60 object-cover" />
           ))}
         </div>
       </div>
       
       {/* Vehicle Info */}
       <div className="md:col-span-1 bg-gray-100 dark:bg-gray-800 p-4 rounded shadow">
         <h2 className="text-xl font-bold mb-2">{vehicle.brand} {vehicle.model}</h2>
         <p>₹{vehicle.price} • {vehicle.city}</p>
         <p>Fuel: {vehicle.fuelType} • Year: {vehicle.year}</p>
         
         {/* Seller Info */}
         <div className="mt-4">
           <h3 className="font-bold">Seller Info</h3>
           <p>{vehicle.seller.name}</p>
           <p>{vehicle.seller.contact}</p>
         </div>
         
         {/* Enquiry Form */}
         <div className="mt-4">
           <h3 className="font-bold">Send Enquiry</h3>
           <textarea className="w-full p-2 rounded border" placeholder="Write your message..." />
           <button className="mt-2 px-4 py-2 bg-blue-600 text-white rounded">Send</button>
         </div>
         
         {/* Appointment Widget */}
         <div className="mt-4">
           <h3 className="font-bold">Book Appointment</h3>
           <input type="date" className="p-2 rounded border w-full mb-2" />
           <input type="time" className="p-2 rounded border w-full mb-2" />
           <button className="px-4 py-2 bg-green-600 text-white rounded">Book</button>
         </div>
       </div>
     </div>
  );
}