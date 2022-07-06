using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MonNgonMoiNgay.Areas.Admin.Models;
using MonNgonMoiNgay.Models.Entities;

namespace MonNgonMoiNgay.Areas.Admin.Controllers
{
    [Authorize]
    public class UserController : Controller
    {
        MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();
        [Authorize(Roles = "01")]
        public async Task<IActionResult> List(string? q, int? p, string? l)
        {
            ViewBag.Loai = l;
            ViewData["LoaiNd"] = db.LoaiNds.ToList();
            ViewBag.QLUser = "active-focus";
            var nd = from u in db.NguoiDungs select u;

            //Lọc người dùng theo họ tên
            if (!String.IsNullOrEmpty(q))
            {
                nd = nd.Where(s => string.Concat(s.HoLot, " ", s.Ten).Contains(q) || s.MaNd.Contains(q) || s.Email.Contains(q) || s.DiaChi.Contains(q));
            }

            //Select trả về khác rỗng và khác 01 (01 là trường hợp admin không hiển thị, thay vào đó là hiển thị tất cả)
            if (!String.IsNullOrEmpty(l) && l != "01")
            {
                nd = nd.Where(s => s.MaLoai == l);
            }

            //Số lượng người dùng được trả về trên một trang
            int pageSize = 10;

            //Chờ đợi xử lý phân trang rồi mới trả về view
            //Các tham số của phân trang như sau:
            //      nd.AsNoTracking() là danh sách người dùng chỉ xem
            //      p là trang muốn hiển thị, ở đây nếu không nhập thì ngầm hiểu trang hiển thị là 1 tức là trang đầu
            //      pageSize là số số lượng người hiển thị trên trang
            return View(await PaginatedList<NguoiDung>.CreateAsync(nd.OrderByDescending(x => x.NgayTao).AsNoTracking(), p ?? 1, pageSize));
        }

        //Khóa hoặc mở khóa người dùng
        [Authorize(Roles = "01")]
        [HttpPost]
        public async Task<IActionResult> LockUser(string ma)
        {
            var user = await db.NguoiDungs.FirstOrDefaultAsync(x => x.MaNd == ma);
            if(user.TrangThai) {
                user.TrangThai = false;
            }
            else user.TrangThai= true;
            db.SaveChanges();

            return Json(new { tt = user.TrangThai });
        }

        //Trang thông tin đầy đủ người dùng
        public IActionResult Profile(string id)
        {
            var user = db.NguoiDungs.FirstOrDefault(x => x.MaNd == id);
            return user != null ? View(user) : NotFound();
        }

        public IActionResult Index(string? q)
        {
            ViewData["LoaiMonAn"] = db.LoaiMonAns.ToList();
            ViewData["TinhTP"] = db.TinhTps.ToList();
            ViewBag.QLPost = "active-focus";

            List<BaiDang> bai = db.BaiDangs.Where(s => s.MaNd == User.Claims.ToList()[0].Value).ToList();

            //Lọc bài đăng
            if (!String.IsNullOrEmpty(q))
            {
                bai = bai.Where(s => s.TenMon.Contains(q) || s.MoTa.Contains(q) || s.MaNd.Contains(q) || s.getTenLoai().Contains(q) || s.getFullAddress().Contains(q)).ToList();
            }

            bai.OrderByDescending(x => x.ThoiGian).ToList();

            return View(bai);
        }

        //Chức năng đẩy bài đăng của người dùng
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> DayBaiDang(string id)
        {
            var baidang = await db.BaiDangs.FirstOrDefaultAsync(x => x.MaBd == id);
            var daybaidang = await db.DayBaiDangs.FirstOrDefaultAsync(x => x.MaBd == id && x.MaNd == User.Claims.ToList()[0].Value);

            if (baidang != null && daybaidang == null)
            {
                DayBaiDang day = new DayBaiDang();
                day.MaBd = baidang.MaBd;
                day.MaNd = User.Claims.ToList()[0].Value;
                day.ThoiGian = DateTime.Now;

                db.DayBaiDangs.Add(day);
                db.SaveChanges();

                return Json(new { tt = true });
            }
            return Json(new { tt = false });
        }

        //Bài đăng đã đẩy
        [Authorize]
        [HttpGet]
        public IActionResult ListDay(string? q)
        {
            ViewBag.Day = "active-focus";
            var baidang = (from bd in db.BaiDangs
                                join dbd in db.DayBaiDangs on bd.MaBd equals dbd.MaBd
                                where dbd.MaNd == User.Claims.First().Value
                                orderby dbd.ThoiGian descending
                                select bd).ToList();

            //Lọc bài đăng
            if (!String.IsNullOrEmpty(q))
            {
                baidang = baidang.Where(s => s.TenMon.Contains(q) || s.MoTa.Contains(q) || s.MaNd.Contains(q) || s.getTenLoai().Contains(q) || s.getFullAddress().Contains(q)).ToList();
            }

            return View(baidang);
        }

        //Bài đăng đã ẩn
        [Authorize]
        [HttpGet]
        public IActionResult ListAn(string? q)
        {
            ViewBag.An = "active-focus";
            List<BaiDang> anbaidang = db.BaiDangs.Where(x => x.TrangThai == 0 && x.MaNd == User.Claims.First().Value).ToList();

            //Lọc bài đăng
            if (!String.IsNullOrEmpty(q))
            {
                anbaidang = anbaidang.Where(s => s.TenMon.Contains(q) || s.MoTa.Contains(q) || s.MaNd.Contains(q) || s.getTenLoai().Contains(q) || s.getFullAddress().Contains(q)).ToList();
            }

            anbaidang.OrderByDescending(x => x.ThoiGian).ToList();

            return View(anbaidang);
        }

        //Chức năng ẩn bài đăng của người dùng
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> AnBaiDang(string id)
        {
            var baidang = await db.BaiDangs.FirstOrDefaultAsync(x => x.MaBd == id && x.MaNd == User.Claims.First().Value);

            if (baidang != null && baidang.TrangThai != 0)
            {
                baidang.TrangThai = 0;

                db.SaveChanges();

                return Json(new { tt = true });
            }
            return Json(new { tt = false });
        }

        //Chức năng bỏ ẩn bài đăng của người dùng
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> BoAnBaiDang(string id)
        {
            var baidang = await db.BaiDangs.FirstOrDefaultAsync(x => x.MaBd == id && x.MaNd == User.Claims.First().Value);

            if (baidang != null && baidang.TrangThai == 0)
            {
                baidang.TrangThai = 1;

                db.SaveChanges();

                return Json(new { tt = true });
            }
            return Json(new { tt = false });
        }

        //Bài đăng đã lưu
        [Authorize]
        public IActionResult ListSave(string? q)
        {
            ViewBag.Save = "active-focus";
            var luu = (from bd in db.BaiDangs
                                join l in db.BaiDangDuocLuus on bd.MaBd equals l.MaBd
                                where l.MaNd == User.Claims.First().Value
                                orderby l.ThoiGian descending
                                select bd).ToList();

            //Lọc bài đăng
            if (!String.IsNullOrEmpty(q))
            {
                luu = luu.Where(s => s.TenMon.Contains(q) || s.MoTa.Contains(q) || s.MaNd.Contains(q) || s.getTenLoai().Contains(q) || s.getFullAddress().Contains(q)).ToList();
            }

            luu.OrderByDescending(x => x.ThoiGian).ToList();

            return View(luu);
        }

        //Chức năng bỏ lưu bài đăng của người dùng
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> setBoLuuBaiDang(string id)
        {
            var baidang = await db.BaiDangDuocLuus.FirstOrDefaultAsync(x => x.MaBd == id && x.MaNd == User.Claims.First().Value);

            if (baidang != null)
            {
                db.BaiDangDuocLuus.Remove(baidang);
                db.SaveChanges();

                return Json(new { tt = true });
            }

            return Json(new { tt = false });
        }

        //Chức năng xem phản hồi
        [Authorize(Roles = "01, 03")]
        public async Task<IActionResult> ViewPhanHoi(string? q, int? p)
        {
            ViewBag.PhanHoi = "active-focus";
            var ph = from temp in db.PhanHois select temp;

            //Lọc phản hồi
            if (!String.IsNullOrEmpty(q))
            {
                ph = ph.Where(s => s.ChiMuc.Contains(q) || s.NoiDung.Contains(q) || s.MaNd.Contains(q) || s.MaPh.Contains(q));
            }

            //Số lượng phản hồi được trả về trên một trang
            int pageSize = 10;

            return View(await PaginatedList<PhanHoi>.CreateAsync(ph.AsNoTracking(), p ?? 1, pageSize));
        }
    }
}
