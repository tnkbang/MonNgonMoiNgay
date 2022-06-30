using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MonNgonMoiNgay.Models.Entities;

namespace MonNgonMoiNgay.Controllers
{
    [Authorize]
    public class NotificationController : Controller
    {
        MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();

        //Tạo thông báo mới
        public void setThongBao(string maND, string tieude, string noidung, string lienket)
        {
            ThongBao newTB = new ThongBao();
            newTB.MaTb = newTB.setMa(maND);
            newTB.MaNd = maND;
            newTB.TieuDe = tieude;
            newTB.NoiDung = noidung;
            newTB.ThoiGian = DateTime.Now;
            newTB.TrangThai = false;
            newTB.LienKet = lienket;

            db.ThongBaos.Add(newTB);
            db.SaveChanges();
        }

        //Lấy tất cả tin chưa xem
        [HttpPost]
        public IActionResult getThongBaoChuaXem()
        {
            ThongBao tb = new ThongBao();
            List<dynamic> list = new List<dynamic>();
            foreach (var m in tb.getThongBaoChuaXem(User.Claims.First().Value))
            {
                var temp = new
                {
                    link = m.LienKet,
                    time = customDateTime(m.ThoiGian),
                    tieude = m.TieuDe,
                    noidung = m.NoiDung
                };
                list.Add(temp);
            }
            return Json(new { thongBao = list, sl = list.Count() });
        }

        //Đã xem tất cả thông báo
        [HttpPost]
        public IActionResult setXemTatCaThongBao()
        {
            var tb = db.ThongBaos.Where(x => x.MaNd == User.Claims.First().Value && x.TrangThai == false);
            if (tb == null) Json(new { tt = false });

            foreach (var t in tb)
            {
                t.TrangThai = true;
            }
            db.SaveChanges();

            return Json(new { tt = true });
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
            if (delta < 12 * month)
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
