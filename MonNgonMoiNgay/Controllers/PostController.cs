using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MonNgonMoiNgay.Models.Entities;

namespace MonNgonMoiNgay.Controllers
{
    public class PostController : Controller
    {
        MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();

        [Authorize]
        public IActionResult CreateNew()
        {
            ViewData["LoaiMonAn"] = db.LoaiMonAns.ToList();
            ViewData["TinhTP"] = db.TinhTps.ToList();
            return View();
        }

        //Thêm mới bài đăng
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> getCreateNew(string loai, string ten, int gia, string mota, string xp, string diachi, IList<IFormFile> images)
        {
            //Tạo mới bài đăng và thêm các thuộc tính cần thiết
            BaiDang newPost = new BaiDang();
            newPost.MaBd = newPost.setMa(User.Claims.ToList()[0].Value);
            newPost.MaLoai = loai;
            newPost.MaNd = User.Claims.ToList()[0].Value;
            newPost.ThoiGian = DateTime.Now;
            newPost.TenMon = ten;
            newPost.GiaTien = gia;
            newPost.MoTa = mota;
            newPost.MaXp = xp;
            newPost.DiaChi = diachi;
            newPost.TrangThai = 1;
            db.BaiDangs.Add(newPost);

            foreach (IFormFile img in images)
            {
                //Khai báo đường dẫn lưu file
                var basePath = Path.Combine(Directory.GetCurrentDirectory() + "\\wwwroot\\Content\\FilesPost\\");
                bool basePathExists = Directory.Exists(basePath);

                //Nếu thư mục không có thì tạo mới
                if (!basePathExists) Directory.CreateDirectory(basePath);

                var fileName = newPost.MaBd + "-" + img.FileName;
                var filePath = Path.Combine(basePath, fileName);

                //Nếu file tồn tại thì thêm file vào server và cập nhật vaod csdl
                if (!System.IO.File.Exists(filePath))
                {
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await img.CopyToAsync(stream);
                    }

                    HinhAnh newHA = new HinhAnh();
                    newHA.MaBd = newPost.MaBd;
                    newHA.UrlImage = fileName;
                    db.HinhAnhs.Add(newHA);
                }
            }

            db.SaveChanges();

            return Json(new { tt = true });
        }

        //Xử lý trả về quận huyện theo mã tỉnh
        [HttpPost]
        [Authorize]
        public IActionResult getQuanHuyen(string ma)
        {
            var qh = db.QuanHuyens.Where(x => x.MaTp == ma).ToList();

            return qh.Count() != 0 ? Json(new { tt = true, qh }) : Json(new { tt = false });
        }

        //Xử lý trả về xã phường theo mã quận huyện
        [HttpPost]
        [Authorize]
        public IActionResult getXaPhuong(string ma)
        {
            var xp = db.XaPhuongs.Where(x => x.MaQh == ma).ToList();

            return xp.Count() != 0 ? Json(new { tt = true, xp }) : Json(new { tt = false });
        }
    }
}
