using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MonNgonMoiNgay.Models.Entities;

namespace MonNgonMoiNgay.Areas.Admin.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();
        [HttpGet]
        public IActionResult TrangCaNhan()
        {
            var bd = db.BaiDangs.Where(x => x.MaNd == User.Claims.ToList()[0].Value).ToList();
            return View(bd);
        }

        public IActionResult BaiDangYeuThich()
        {
            var bdyt = db.YeuThichBaiDangs
                .Include(x => x.MaBdNavigation)
                .Where(x => x.MaNd == User.Claims.ToList()[0].Value).ToList();
            return View(bdyt);
        }

        public IActionResult BaiDangDeCu()
        {
            var bddc = db.DayBaiDangs
                .Include(x => x.MaBdNavigation)
                .Where(x => x.MaNd == User.Claims.ToList()[0].Value).ToList();
            return View(bddc);
        }
    }
}
