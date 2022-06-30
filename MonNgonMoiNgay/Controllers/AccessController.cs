using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MonNgonMoiNgay.Controllers
{
    public class AccessController : Controller
    {
        //Trang không có quyền truy cập
        public IActionResult Denied()
        {
            Response.StatusCode = 403;
            return View();
        }

        //Không tìm thấy nội dung
        [Route("error/404")]
        public IActionResult PageNotFound()
        {
            Response.StatusCode = 404;
            return View();
        }
    }
}
