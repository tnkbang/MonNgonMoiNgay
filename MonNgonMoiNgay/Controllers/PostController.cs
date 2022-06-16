using Microsoft.AspNetCore.Mvc;

namespace MonNgonMoiNgay.Controllers
{
    public class PostController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
