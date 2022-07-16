using System;
using System.Collections.Generic;

namespace MonNgonMoiNgay.Models.Entities
{
    public partial class BaiDang
    {
        public BaiDang()
        {
            BaiDangDuocLuus = new HashSet<BaiDangDuocLuu>();
            DayBaiDangs = new HashSet<DayBaiDang>();
            HinhAnhs = new HashSet<HinhAnh>();
            YeuThichBaiDangs = new HashSet<YeuThichBaiDang>();
        }

        public string MaBd { get; set; } = null!;
        public string MaLoai { get; set; } = null!;
        public string MaNd { get; set; } = null!;
        public DateTime ThoiGian { get; set; }
        public string TenMon { get; set; } = null!;
        public string? MoTa { get; set; }
        public int GiaTien { get; set; }
        public string? MaXp { get; set; }
        public string? DiaChi { get; set; }
        public int TrangThai { get; set; }

        public virtual LoaiMonAn MaLoaiNavigation { get; set; } = null!;
        public virtual NguoiDung MaNdNavigation { get; set; } = null!;
        public virtual XaPhuong? MaXpNavigation { get; set; }
        public virtual ICollection<BaiDangDuocLuu> BaiDangDuocLuus { get; set; }
        public virtual ICollection<DayBaiDang> DayBaiDangs { get; set; }
        public virtual ICollection<HinhAnh> HinhAnhs { get; set; }
        public virtual ICollection<YeuThichBaiDang> YeuThichBaiDangs { get; set; }

        MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();
        public string setMa(string maND)
        {
            var last = (from b in db.BaiDangs
                        where b.MaNd == maND
                        orderby b.MaBd descending
                        select b).FirstOrDefault();
            if (last == null)
            {
                return maND + "-001";
            }
            int temp = int.Parse(Convert.ToString(last.MaBd).Substring(8));
            string ma = maND + "-" + Convert.ToString(1000 + temp + 1).Substring(1);
            return ma;
        }
        public string getOneImage()
        {
            var img = db.HinhAnhs.FirstOrDefault(x => x.MaBd == this.MaBd);
            return "/Content/FilesPost/" + img.UrlImage;
        }

        public List<HinhAnh> getListImages()
        {
            return db.HinhAnhs.Where(x => x.MaBd == this.MaBd).ToList();
        }

        public int getSLLuu()
        {
            return db.BaiDangDuocLuus.Where(x => x.MaBd == this.MaBd).Count();
        }

        public int getSLYeuThich()
        {
            return db.YeuThichBaiDangs.Where(x => x.MaBd == this.MaBd).Count();
        }

        public bool isSave(string maNd)
        {
            var saved = db.BaiDangDuocLuus.FirstOrDefault(x => x.MaBd == this.MaBd && x.MaNd == maNd);
            if (saved != null) return true;
            return false;
        }

        public bool isLike(string maNd)
        {
            var liked = db.YeuThichBaiDangs.FirstOrDefault(x => x.MaBd == this.MaBd && x.MaNd == maNd);
            if (liked != null) return true;
            return false;
        }

        public bool isHide()
        {
            var hide = db.BaiDangs.FirstOrDefault(x => x.MaBd == this.MaBd);
            return hide.TrangThai == 0 ? true : false;
        }

        public string getTenLoai()
        {
            var loai = db.LoaiMonAns.FirstOrDefault(x => x.MaLoai == this.MaLoai);
            return loai.TenLoai;
        }

        public string getFullAddress()
        {
            var xp = db.XaPhuongs.FirstOrDefault(x => x.MaXp == this.MaXp);
            var qh = db.QuanHuyens.FirstOrDefault(x => x.MaQh == xp.MaQh);
            var tp = db.TinhTps.FirstOrDefault(x => x.MaTp == qh.MaTp);

            return xp.TenXp + " - " + qh.TenQh + " - " + tp.TenTp;
        }
    }
}
