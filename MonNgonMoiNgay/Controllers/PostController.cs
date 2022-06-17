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
            return View();
        }

        [HttpPost]
        [Authorize]
        public async Task<IActionResult> getCreateNew(string loai, string ten, string mota, string vitri, IList<IFormFile> images)
        {
            //Tạo mới bài đăng và thêm các thuộc tính cần thiết
            BaiDang newPost = new BaiDang();
            newPost.MaBd = newPost.setMa(User.Claims.ToList()[0].Value);
            newPost.MaLoai = loai;
            newPost.MaNd = User.Claims.ToList()[0].Value;
            newPost.ThoiGian = DateTime.Now;
            newPost.TenMon = ten;
            newPost.MoTa = mota;
            //newPost.DiaChi = vitri;
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

        [HttpPost]
        [Authorize]
        public async Task<IActionResult> setTrangThai(string mabd)
        {
            var bd = await db.BaiDangs.FirstOrDefaultAsync(x => x.MaNd == User.Claims.ToList()[0].Value && x.MaBd == mabd);
            bd.TrangThai = 0;
            db.SaveChanges();

            return Json(new { tt = true });
        }
    }
}
