export default function Footer () {
  return (
     <footer className="bg-gray-100 dark:bg-gray-900 text-gray-700 dark:text-gray-300 py-6 mt-10">
       <div className="container mx-auto flex flex-col md:flex-row justify-between items-center">
         {/* Links */}
         <div className="flex space-x-6 mb-4 md:mb-0">
           <a href="/about">About</a>
           <a href="/contact">Contact</a>
           <a href="/privacy">Privacy Policy</a>
           <a href="/terms">Terms of Service</a>
         </div>
         
         {/* Social Icons */}
         <div className="flex space-x-4">
           <a href="#" className="text-blue-600">Facebook</a>
           <a href="#" className="text-sky-500">Twitter</a>
           <a href="#" className="text-pink-500">Instagram</a>
           <a href="#" className="text-blue-700">LinkedIn</a>
         </div>
         
         {/* Contact Info */}
         <div className="mt-4 md:mt-0">
           <p>Email: support@motohive.com</p>
           <p>Phone: +91-9876543210</p>
         </div>
       </div>
     </footer>
  );
}