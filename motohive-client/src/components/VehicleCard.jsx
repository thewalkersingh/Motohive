// src/components/VehicleCard.jsx
export default function VehicleCard ({ vehicle }) {
  return (
     <div className="border rounded shadow p-4">
       <img
          src={vehicle.imageUrl || "https://via.placeholder.com/300"}
          alt={`${vehicle.brand} ${vehicle.model}`}
          className="mb-2 rounded"
       />
       <h3 className="font-bold">{vehicle.brand} {vehicle.model}</h3>
       <p>₹{vehicle.price} • {vehicle.city}</p>
       <p>Fuel: {vehicle.fuelType} • Year: {vehicle.year}</p>
     </div>
  );
}