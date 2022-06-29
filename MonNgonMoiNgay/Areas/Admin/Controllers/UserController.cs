using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MonNgonMoiNgay.Areas.Admin.Models;
using MonNgonMoiNgay.Models.Entities;

namespace MonNgonMoiNgay.Areas.Admin.Controllers
{
    [Authorize(Roles = "01")]
    public class UserController : Controller
    {
        MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();
        public IActionResult Index()
        {
            return View();
        }
        public async Task<IActionResult> List(string? q, int? p, string? l)
        {
            ViewBag.Loai = l;
            ViewData["LoaiNd"] = db.LoaiNds.ToList();
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
            return View(await PaginatedList<NguoiDung>.CreateAsync(nd.AsNoTracking(), p ?? 1, pageSize));
        }

        //Khóa hoặc mở khóa người dùng
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
    }
}
