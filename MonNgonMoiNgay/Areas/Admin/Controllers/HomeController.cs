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

        public IActionResult BaiDangYeuThich(string? q)
        {
            ViewBag.YeuThich = "active-focus";
            var bd = (from baidang in db.BaiDangs
                      join yeuthich in db.YeuThichBaiDangs on baidang.MaBd equals yeuthich.MaBd
                      where yeuthich.MaNd == User.Claims.First().Value
                      select baidang).ToList();

            //Lọc yêu thích
            if (!String.IsNullOrEmpty(q))
            {
                bd = bd.Where(s => s.TenMon.Contains(q) || s.MoTa.Contains(q) || s.MaNd.Contains(q) || s.getTenLoai().Contains(q) || s.getFullAddress().Contains(q)).ToList();
            }

            bd = bd.OrderByDescending(x => x.ThoiGian).ToList();

            return View(bd);
        }

        //Chức năng bỏ thích bài đăng của người dùng
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> setBoThichBaiDang(string id)
        {
            var yt = await db.YeuThichBaiDangs.FirstOrDefaultAsync(x => x.MaBd == id && x.MaNd == User.Claims.First().Value);

            if (yt != null)
            {
                db.YeuThichBaiDangs.Remove(yt);
                db.SaveChanges();

                return Json(new { tt = true });
            }

            return Json(new { tt = false });
        }

        public IActionResult BaiDangDeCu(string? q)
        {
            ViewBag.DeCu = "active-focus";
            var bd = db.BaiDangs.Where(x => x.TrangThai == 1).ToList();

            //Lọc đề cử
            if (!String.IsNullOrEmpty(q))
            {
                bd = bd.Where(s => s.TenMon.Contains(q) || s.MoTa.Contains(q) || s.MaNd.Contains(q) || s.getTenLoai().Contains(q) || s.getFullAddress().Contains(q)).ToList();
            }

            bd = bd.OrderByDescending(x => x.ThoiGian).ToList();

            return View(bd);
        }
    }
}
