using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MonNgonMoiNgay.Models;
using MonNgonMoiNgay.Models.Entities;
using Newtonsoft.Json;

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
            ViewBag.DangBai = "active";
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

                //Nếu file không tồn tại thì thêm file vào server và cập nhật vào csdl
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

            return Json(new { ma = newPost.MaBd });
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

        //Hiển thị trang detail bài đăng
        [AllowAnonymous]
        public IActionResult Detail(string id)
        {
            var baidang = db.BaiDangs.FirstOrDefault(x => x.MaBd == id);

            if (baidang == null)
            {
                return NotFound();
            }

            ViewData["PostSimilar"] = db.BaiDangs.Where(x => x.MaLoai == baidang.MaLoai && x.TrangThai == 1 && x.MaBd != id).OrderByDescending(x => x.ThoiGian).ToList();
            return View(baidang);
        }

        //Chức năng lưu lại bài đăng của người dùng
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> LuuBaiDang(string id)
        {
            var baidang = await db.BaiDangs.FirstOrDefaultAsync(x => x.MaBd == id);
            var saved = await db.BaiDangDuocLuus.FirstOrDefaultAsync(x => x.MaBd == id && x.MaNd == User.Claims.ToList()[0].Value);

            if (baidang != null && saved == null)
            {
                BaiDangDuocLuu save = new BaiDangDuocLuu();
                save.MaBd = baidang.MaBd;
                save.MaNd = User.Claims.ToList()[0].Value;
                save.ThoiGian = DateTime.Now;

                NotificationController notification = new NotificationController();
                var temp = db.BaiDangDuocLuus.Where(x => x.MaBd == save.MaBd).Count();
                notification.setThongBao(baidang.MaNd, "Lượt lưu mới", "Bài đăng " + baidang.TenMon + " nhận được lượt lưu thứ " + temp + ".", "/Post/Detail?id=" + save.MaBd);

                db.BaiDangDuocLuus.Add(save);
                db.SaveChanges();

                return Json(new { tt = true });
            }
            return Json(new { tt = false });
        }

        //Chức năng yêu thích bài đăng của người dùng
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> YeuThichBaiDang(string id)
        {
            var baidang = await db.BaiDangs.FirstOrDefaultAsync(x => x.MaBd == id);
            var yt = await db.YeuThichBaiDangs.FirstOrDefaultAsync(x => x.MaBd == id && x.MaNd == User.Claims.ToList()[0].Value);

            if (baidang != null && yt == null)
            {
                YeuThichBaiDang newYT = new YeuThichBaiDang();
                newYT.MaBd = baidang.MaBd;
                newYT.MaNd = User.Claims.ToList()[0].Value;
                newYT.ThoiGian = DateTime.Now;

                db.YeuThichBaiDangs.Add(newYT);
                db.SaveChanges();

                NotificationController notification = new NotificationController();
                var temp = db.YeuThichBaiDangs.Where(x => x.MaBd == newYT.MaBd).Count();
                notification.setThongBao(baidang.MaNd, "Lượt thích mới", "Bài đăng " + baidang.TenMon + " nhận được lượt thích thứ " + temp + ".", "/Post/Detail?id=" + newYT.MaBd);

                return Json(new { tt = true });
            }
            return Json(new { tt = false });
        }

        //Chức năng phản hồi của người dùng
        [Authorize]
        public IActionResult CreatePhanHoi()
        {
            ViewBag.PhanHoi = "active";
            return View();
        }

        [HttpPost]
        [Authorize]
        public IActionResult setPhanHoi(string td, string nd)
        {
            try
            {
                PhanHoi phhoi = new PhanHoi();
                phhoi.MaPh = phhoi.setMaPh(User.Claims.ToList()[0].Value);
                phhoi.MaNd = User.Claims.ToList()[0].Value;
                phhoi.ChiMuc = td;
                phhoi.NoiDung = nd;
                phhoi.ThoiGian = DateTime.Now;

                db.PhanHois.Add(phhoi);
                db.SaveChanges();

                return Json(new { tt = true });
            }
            catch (Exception)
            {
                return Json(new { tt = false });
            }

        }

        //Trang bài đăng
        [Authorize]
        public IActionResult BaiDang()
        {
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
            foreach (var yt in slyt)
            {
                var temp = db.BaiDangs.FirstOrDefault(x => x.MaBd == yt.MaBd);
                result.Add(temp);
            }

            //Gán result vào ViewData để trả về View
            ViewData["PostLike"] = result.Take(10).ToList();
            return View();
        }

        struct DemYT
        {
            public int sl;
            public string MaBd;
        };

        [Authorize]
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var m = await db.BaiDangs.FindAsync(id);
            if (m == null)
            {
                return NotFound();
            }
            ViewData["LoaiMonAn"] = db.LoaiMonAns.ToList();
            ViewData["TinhTP"] = db.TinhTps.ToList();
            return View(m);
        }

        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("MaBd,MaLoai,MaNd,ThoiGian,TenMon,MoTa,GiaTien,MaXP,DiaChi,TrangThai")] BaiDang bd)
        {
            if (id != bd.MaBd)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    db.Update(bd);
                    await db.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!BaiDangExists(bd.MaBd))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["LoaiMonAn"] = db.LoaiMonAns.ToList();
            ViewData["TinhTP"] = db.TinhTps.ToList();
            return View(bd);
        }

        private bool BaiDangExists(string id)
        {
            return db.BaiDangs.Any(e => e.MaBd == id);
        }

        //Chức năng đề cử bài đăng của người dùng
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> DeCuBaiDang(string id)
        {
            ViewBag.DeCu = "active-focus";
            var baidang = await db.BaiDangs.FirstOrDefaultAsync(x => x.MaBd == id);
            var decubaidang = await db.DayBaiDangs.FirstOrDefaultAsync(x => x.MaBd == id && x.MaNd == User.Claims.ToList()[0].Value);

            if (baidang != null && decubaidang == null)
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

        public IActionResult listdecu()
        {
            List<DayBaiDang> decubai = db.DayBaiDangs.ToList();
            return View(decubai);
        }

        // Key lưu chuỗi json của Cart
        public const string CARTKEY = "cart";

        // Lấy cart từ Session (danh sách CartItem)
        List<CartItem> GetCartItems()
        {

            var session = HttpContext.Session;
            string jsoncart = session.GetString(CARTKEY);
            if (jsoncart != null)
            {
                return JsonConvert.DeserializeObject<List<CartItem>>(jsoncart);
            }
            return new List<CartItem>();
        }

        // Xóa cart khỏi session
        void ClearCart()
        {
            var session = HttpContext.Session;
            session.Remove(CARTKEY);
        }

        // Lưu Cart (Danh sách CartItem) vào session
        void SaveCartSession(List<CartItem> ls)
        {
            var session = HttpContext.Session;
            string jsoncart = JsonConvert.SerializeObject(ls);
            session.SetString(CARTKEY, jsoncart);
        }

        [Authorize]
        /// Thêm sản phẩm vào cart
        [HttpPost]
        public IActionResult AddToCart(string id)
        {

            var product = db.BaiDangs.FirstOrDefault(p => p.MaBd == id);
            if (product == null)
                return NotFound("Không có sản phẩm");


            // Xử lý đưa vào Cart ...
            var cart = GetCartItems();
            var cartitem = cart.Find(p => p.baidang.MaBd == id);
            if (cartitem != null)
            {
                // Đã tồn tại, tăng thêm 1
                cartitem.quantity++;
            }
            else
            {
                //  Thêm mới
                cart.Add(new CartItem() { quantity = 1, baidang = product });
            }
            // Lưu cart vào Session
            SaveCartSession(cart);
            // Chuyển đến trang hiện thị Cart
            //return RedirectToAction(nameof(Cart));
            return Json(new { tt = true });
        }

        /// xóa item trong cart

        public IActionResult RemoveCart(string id)
        {

            // Xử lý xóa một mục của Cart ...
            var cart = GetCartItems();
            var cartitem = cart.Find(p => p.baidang.MaBd == id);
            if (cartitem != null)
            {
                // Đã tồn tại, tăng thêm 1
                cart.Remove(cartitem);
            }

            SaveCartSession(cart);
            return RedirectToAction(nameof(Cart));
        }

        /// Cập nhật

        [HttpPost]
        public IActionResult UpdateCart(string id, int quantity)
        {
            // Cập nhật Cart thay đổi số lượng quantity ...
            var cart = GetCartItems();
            var cartitem = cart.Find(p => p.baidang.MaBd == id);
            if (cartitem != null)
            {
                // Đã tồn tại, tăng thêm 1
                cartitem.quantity = quantity;
            }
            SaveCartSession(cart);
            // Trả về mã thành công (không có nội dung gì - chỉ để Ajax gọi)

            return RedirectToAction(nameof(Cart));
        }

        // Hiện thị giỏ hàng
        public IActionResult Cart()
        {
            return View(GetCartItems());
        }


        public IActionResult CheckOut()
        {
            // Xử lý khi đặt hàng
            return View();
        }
    }
}
