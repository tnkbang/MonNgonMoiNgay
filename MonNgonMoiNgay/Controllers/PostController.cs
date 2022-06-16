using Microsoft.AspNetCore.Mvc;

namespace MonNgonMoiNgay.Controllers
{
    public class PostController : Controller
    {
        public IActionResult CreateNew()
        {
            return View();
        }
    }
}
