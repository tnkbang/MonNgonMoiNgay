using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MonNgonMoiNgay.Areas.Admin.Models;
using MonNgonMoiNgay.Models.Entities;

namespace MonNgonMoiNgay.Areas.Admin.Controllers
{
    public class UserController : Controller
    {
        MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult fList()
        {
            return View();
        }
        public async Task<IActionResult> List(string? q, int? P)
        {

            if (q != null)
            {
                P = 1;
            }
            else
            {
                q = null;
            }

            var nd = from u in db.NguoiDungs select u;
            if (!String.IsNullOrEmpty(q))
            {
                nd = nd.Where(s => s.HoLot.Contains(q) || s.Ten.Contains(q));
            }

            int pageSize = 1;

            return View(await PaginatedList<NguoiDung>.CreateAsync(nd.AsNoTracking(), P ?? 1, pageSize));
        }
    }
}
