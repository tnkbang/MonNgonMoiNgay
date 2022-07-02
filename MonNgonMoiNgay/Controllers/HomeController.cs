using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MonNgonMoiNgay.Areas.Admin.Models;
using MonNgonMoiNgay.Models;
using MonNgonMoiNgay.Models.Entities;
using System.Diagnostics;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace MonNgonMoiNgay.Controllers
{
    public class HomeController : Controller
    {
        MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();

        //Struct đếm sl yêu thích
        struct DemYT
        {
            public int sl;
            public string MaBd;
        };

        [AllowAnonymous]
        public IActionResult Index()
        {
            //Tạo ViewData cho bài đăng mới đăng (trong vòng 7 ngày) và bài đăng được đề cử bởi Admin hoặc nhân viên
            ViewData["PostNew"] = db.BaiDangs.Where(x => x.ThoiGian.AddDays(7) >= DateTime.Now && x.TrangThai == 1).OrderByDescending(x => x.ThoiGian).ToList();
            ViewData["PostVote"] = (from bd in db.BaiDangs
                                    join dbd in db.DayBaiDangs on bd.MaBd equals dbd.MaBd
                                    join nd in db.NguoiDungs on dbd.MaNd equals nd.MaNd
                                    where nd.MaLoai == "01" && nd.MaLoai == "03"
                                    orderby dbd.ThoiGian descending
                                    select bd).ToList();

            //Xử lý hiển thị top 10 bài đăng được yêu thích nhất
            var list = (from bd in db.BaiDangs
                        join yt in db.YeuThichBaiDangs on bd.MaBd equals yt.MaBd
                        select bd).ToList();

            List<BaiDang> result = new List<BaiDang>();
            List<DemYT> slyt = new List<DemYT>();
            
            //Chạy lặp gán mã bài đăng và số lượt yt vào danh sách slyt
            foreach (var bd in list)
            {
                var temp = db.YeuThichBaiDangs.Where(x => x.MaBd == bd.MaBd).ToList().Count();
                slyt.Add(new DemYT { MaBd = bd.MaBd, sl = temp });
            }

            //Sắp xếp lượt yêu thích từ cao đến thấp
            slyt.OrderByDescending(x => x.sl);

            //Chạy lặp gán bài đăng vào result
            foreach(var yt in slyt)
            {
                var temp = db.BaiDangs.FirstOrDefault(x => x.MaBd == yt.MaBd);
                result.Add(temp);
            }

            //Gán result vào ViewData để trả về View
            ViewData["PostLike"] = result.Take(10).ToList();

            return View();
        }

        [AllowAnonymous]
        public async Task<IActionResult> Search(string? d, int? p)
        {
            var lb = from c in db.BaiDangs select c;
            if (!String.IsNullOrEmpty(d))
            {
                lb = lb.Where(s => s.TenMon.Contains(d));
            }
            int pageSize = 5;

            ViewBag.Search = d;

            return View(await PaginatedList<BaiDang>.CreateAsync(lb.AsNoTracking(), p ?? 1, pageSize));
        }
    }
}