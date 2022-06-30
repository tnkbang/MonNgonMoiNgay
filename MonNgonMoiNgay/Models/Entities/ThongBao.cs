using System;
using System.Collections.Generic;

namespace MonNgonMoiNgay.Models.Entities
{
    public partial class ThongBao
    {
        public string MaTb { get; set; } = null!;
        public string MaNd { get; set; } = null!;
        public string TieuDe { get; set; } = null!;
        public string? NoiDung { get; set; }
        public DateTime ThoiGian { get; set; }
        public bool TrangThai { get; set; }
        public string? LienKet { get; set; }

        public virtual NguoiDung MaNdNavigation { get; set; } = null!;

        MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();
        public string setMa(string maND)
        {
            var tb = db.ThongBaos.Where(x => x.MaNd == maND);
            if (tb.Count() == 0) return maND + "-001";

            string ma = Convert.ToString(1000 + tb.Count() + 1).Substring(1);
            return maND + "-" + ma;
        }
        public List<ThongBao> getAllThongBao(string maND)
        {
            var tb = db.ThongBaos.Where(x => x.MaNd == maND).OrderByDescending(x => x.ThoiGian).ToList();
            return tb;
        }
        public List<ThongBao> getThongBaoChuaXem(string maND)
        {
            var tb = db.ThongBaos.Where(x => x.MaNd == maND && x.TrangThai == false).OrderByDescending(x => x.ThoiGian).ToList();
            return tb;
        }
    }
}
