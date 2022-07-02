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
            ViewBag.YeuThich = "active-focus";
            var bd = (from baidang in db.BaiDangs
                      join yeuthich in db.YeuThichBaiDangs on baidang.MaBd equals yeuthich.MaBd
                      where yeuthich.MaNd == User.Claims.First().Value
                      orderby yeuthich.ThoiGian descending
                      select baidang).ToList();
            return View(bd);
        }

        public IActionResult BaiDangDeCu()
        {
            ViewBag.DeCu = "active-focus";
            var bd = db.BaiDangs.OrderByDescending(x => x.ThoiGian).ToList();
            return View(bd);
        }
    }
}
