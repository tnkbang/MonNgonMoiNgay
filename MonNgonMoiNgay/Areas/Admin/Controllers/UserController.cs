﻿using Microsoft.AspNetCore.Mvc;

namespace MonNgonMoiNgay.Areas.Admin.Controllers
{
    public class UserController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
