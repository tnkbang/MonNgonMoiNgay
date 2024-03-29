﻿using Microsoft.AspNetCore.Authentication;
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
            //Tất cả bài đăng
            ViewData["PostAll"] = db.BaiDangs.Where(x => x.TrangThai == 1).OrderByDescending(x => x.ThoiGian).ToList();

            //Tạo ViewData cho bài đăng mới đăng (trong vòng 7 ngày)
            List<BaiDang> lstNew = db.BaiDangs.Where(x => x.ThoiGian.AddDays(7) >= DateTime.Now && x.TrangThai == 1).OrderByDescending(x => x.ThoiGian).ToList();
            List<BaiDang> lstDay = (from bd in db.BaiDangs
                                    join day in db.DayBaiDangs on bd.MaBd equals day.MaBd
                                    where day.ThoiGian.AddDays(7) >= DateTime.Now && bd.TrangThai == 1
                                    orderby bd.ThoiGian descending
                                    select bd).ToList();
            lstNew.AddRange(lstDay);
            ViewData["PostNew"] = lstNew.DistinctBy(x => x.MaBd).OrderByDescending(x => x.ThoiGian).ToList();


            //Bài đăng được đề xuất
            ViewData["PostVote"] = (from bd in db.BaiDangs
                                    join dbd in db.DayBaiDangs on bd.MaBd equals dbd.MaBd
                                    join nd in db.NguoiDungs on dbd.MaNd equals nd.MaNd
                                    where nd.MaLoai == "01" || nd.MaLoai == "03"
                                    orderby dbd.ThoiGian descending
                                    select bd).Where(x => x.TrangThai == 1).ToList();

            //Xử lý hiển thị top 20 bài đăng được yêu thích nhất
            var list = (from bd in db.BaiDangs
                        join yt in db.YeuThichBaiDangs on bd.MaBd equals yt.MaBd
                        where bd.TrangThai == 1
                        select bd).ToList();

            List<BaiDang> result = new List<BaiDang>();
            List<DemYT> slyt = new List<DemYT>();
            
            //Chạy lặp gán mã bài đăng và số lượt yt vào danh sách slyt
            foreach (var bd in list)
            {
                var temp = db.YeuThichBaiDangs.Where(x => x.MaBd == bd.MaBd).ToList().Count();
                slyt.Add(new DemYT { MaBd = bd.MaBd, sl = temp });
            }

            //Sắp xếp lượt yêu thích từ cao đến thấp và loại bỏ giá trị trùng và chỉ lấy 20 giá trị
            slyt = slyt.DistinctBy(x => x.MaBd).OrderByDescending(x => x.sl).Take(20).ToList();

            //Chạy lặp gán bài đăng vào result
            foreach (var yt in slyt)
            {
                var temp = db.BaiDangs.FirstOrDefault(x => x.MaBd == yt.MaBd);
                result.Add(temp);
            }

            //Gán result vào ViewData để trả về View
            ViewData["PostLike"] = result.ToList();


            //Xử lý ảnh dưới trang chỉ lấy 20 ảnh ngẫu nhiên
            List<HinhAnh> viewImg = (from ha in db.HinhAnhs
                                     join bd in db.BaiDangs on ha.MaBd equals bd.MaBd
                                     where bd.TrangThai == 1
                                     select ha).ToList();
            var rnd = new Random();
            ViewData["FooterImg"] = viewImg.OrderBy(x => rnd.Next()).Take(20).ToList();

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

        [AllowAnonymous]
        public IActionResult LienHe()
        {
            return View();
        }
    }
}