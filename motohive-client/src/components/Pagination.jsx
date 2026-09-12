// src/components/Pagination.jsx
import { useNavigate, useLocation, useSearchParams } from "react-router-dom";

export default function Pagination ({ page, totalPages }) {
  const navigate = useNavigate();
  const location = useLocation();
  const [searchParams] = useSearchParams();
  
  const goToPage = (newPage) => {
    searchParams.set("page", newPage);
    navigate(`${location.pathname}?${searchParams.toString()}`);
  };
  
  return (
     <div className="flex justify-center mt-6 space-x-4">
       <button
          onClick={() => goToPage(page - 1)}
          disabled={page <= 0}
          className="px-3 py-1 bg-gray-200 dark:bg-gray-700 rounded"
       >
         Prev
       </button>
       <span>Page {page + 1} of {totalPages}</span>
       <button
          onClick={() => goToPage(page + 1)}
          disabled={page >= totalPages - 1}
          className="px-3 py-1 bg-gray-200 dark:bg-gray-700 rounded"
       >
         Next
       </button>
     </div>
  );
}