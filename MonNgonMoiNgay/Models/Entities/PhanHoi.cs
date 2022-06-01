using System;
using System.Collections.Generic;

namespace MonNgonMoiNgay.Models.Entities
{
    public partial class PhanHoi
    {
        public string MaPh { get; set; } = null!;
        public string MaNd { get; set; } = null!;
        public string ChiMuc { get; set; } = null!;
        public string? NoiDung { get; set; }
        public DateTime ThoiGian { get; set; }

        public virtual NguoiDung MaNdNavigation { get; set; } = null!;
    }
}
