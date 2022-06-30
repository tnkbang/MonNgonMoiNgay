using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MonNgonMoiNgay.Models.Entities;

namespace MonNgonMoiNgay.Controllers
{
    [Authorize]
    public class ChatController : Controller
    {
        MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();
        public IActionResult Index()
        {
            return View();
        }

        //Lấy tin nhắn từ 1 người dùng đến người dùng đang đăng nhập
        [HttpPost]
        public IActionResult getTinNhanTuUser(string maNG)
        {
            TinNhan tn = new TinNhan();
            NguoiDung Usend = tn.getUser(maNG);
            NguoiDung Ureceived = tn.getUser(User.Claims.First().Value);
            var usersend = new
            {
                MaNd = Usend.MaNd,
                MaLoai = Usend.MaLoai,
                HoLot = Usend.HoLot,
                Ten = Usend.Ten,
                ImgAvt = Usend.getImage()
            };
            var userreceived = new
            {
                MaNd = Ureceived.MaNd,
                MaLoai = Ureceived.MaLoai,
                HoLot = Ureceived.HoLot,
                Ten = Ureceived.Ten,
                ImgAvt = Ureceived.getImage()
            };
            List<dynamic> list = new List<dynamic>();
            foreach (var m in tn.getAllTinNhan(maNG, User.Claims.First().Value))
            {
                var temp = new
                {
                    Id = m.Id,
                    NguoiGui = m.NguoiGui,
                    NguoiNhan = m.NguoiNhan,
                    ThoiGian = customDateTime(m.ThoiGian),
                    NoiDung = m.NoiDung,
                    TrangThai = m.TrangThai
                };
                list.Add(temp);
            }
            setXemTatCaTinNhan(User.Claims.First().Value);
            return Json(new { tt = true, USend = usersend, UReceived = userreceived, soluong = list.Count(), TinNhan = list });
        }

        //Gửi tin nhắn cho người dùng khác
        [HttpPost]
        public IActionResult sendNewTinNhan(string maNN, string noidung)
        {
            if (maNN == "" || noidung == "") return Json(new { tt = false });

            TinNhan tn = new TinNhan();
            tn.Id = tn.setID();
            tn.NguoiGui = User.Claims.First().Value;
            tn.NguoiNhan = maNN;
            tn.ThoiGian = DateTime.Now;
            tn.NoiDung = noidung;
            tn.TrangThai = false;

            db.TinNhans.Add(tn);
            db.SaveChanges();

            return Json(new { tt = true, ImgAvt = User.Claims.FirstOrDefault(x=>x.Type.Equals("ImgAvt")).Value, NoiDung = tn.NoiDung, ThoiGian = customDateTime(tn.ThoiGian) });
        }

        //Đã xem tất cả tin nhắn
        [HttpPost]
        public IActionResult setXemTatCaTinNhan(string maND)
        {
            var tn = db.TinNhans.Where(x => x.NguoiNhan == maND && x.TrangThai == false);
            if (tn == null) Json(new { tt = false });

            foreach (var t in tn)
            {
                t.TrangThai = true;
            }
            db.SaveChanges();

            return Json(new { tt = true });
        }

        //Lấy tất cả tin chưa xem
        [HttpPost]
        public IActionResult getTinNhanChuaXem()
        {
            TinNhan tn = new TinNhan();
            List<dynamic> list = new List<dynamic>();
            foreach (var m in tn.getTinNhanChuaXem(User.Claims.First().Value).OrderByDescending(x => x.ThoiGian))
            {
                var temp = new
                {
                    maNG = m.NguoiGui,
                    image = m.getUser(m.NguoiGui).getImage(),
                    hoten = m.getUser(m.NguoiGui).getTenHienThi(),
                    thoigian = customDateTime(m.ThoiGian),
                    noidung = m.NoiDung
                };
                list.Add(temp);
            }
            return Json(new { TinNhan = list, sl = list.Count() });
        }

        //Custom datetime
        private string customDateTime(DateTime date)
        {
            int second = 1;
            int minute = 60 * second;
            int hour = 60 * minute;
            int day = 24 * hour;
            int month = 30 * day;

            var time = new TimeSpan(DateTime.Now.Ticks - date.Ticks);
            double delta = Math.Abs(time.TotalSeconds);

            if (delta < 1 * minute) return "Vừa xong";
            if (delta < 24 * hour) return date.ToString("HH:mm");
            if (delta < 48 * hour) return "Hôm qua";
            if (delta < 30 * day) return time.Days + " ngày";
            if(delta < 12 * month)
            {
                int months = Convert.ToInt32(Math.Floor((double)time.Days / 30));
                return months <= 1 ? "Một tháng" : months + " tháng";
            }
            else
            {
                int years = Convert.ToInt32(Math.Floor((double)time.Days / 365));
                return years <= 1 ? "Một năm" : years + " năm";
            }
        }
    }
}
