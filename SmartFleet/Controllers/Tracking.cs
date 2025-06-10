using Microsoft.AspNetCore.Mvc;

namespace SmartFleet.Controllers
{
    public class Tracking : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
