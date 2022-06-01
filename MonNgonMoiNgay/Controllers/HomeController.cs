using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MonNgonMoiNgay.Models;
using MonNgonMoiNgay.Models.Entities;
using System.Diagnostics;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace MonNgonMoiNgay.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        [AllowAnonymous]
        public IActionResult Login(string ReturnUrl)
        {

            LoginModel objLoginModel = new LoginModel();
            objLoginModel.ReturnUrl = string.IsNullOrEmpty(ReturnUrl) ? "/" : ReturnUrl;
            return View(objLoginModel);
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> Login(LoginModel objLoginModel)
        {
            MonNgonMoiNgayContext db = new MonNgonMoiNgayContext();

            if (ModelState.IsValid)
            {
                var user = db.NguoiDungs.Where(x => x.Email == objLoginModel.Email && x.MatKhau == mahoaMatKhau(objLoginModel.Password)).FirstOrDefault();
                if (user != null)
                {
                    //A claim is a statement about a subject by an issuer and    
                    //represent attributes of the subject that are useful in the context of authentication and authorization operations.
                    var claims = new List<Claim>() {
                        new Claim(ClaimTypes.Sid, user.MaNd),
                        new Claim(ClaimTypes.Role, user.MaLoai == "01" ? "Admin" : user.MaLoai == "02" ? "User" : user.MaLoai == "03" ? "GiaoVien" : "HocSinh"),
                        new Claim(ClaimTypes.Name, user.HoLot + " " + user.Ten),
                        new Claim(ClaimTypes.Uri, user.ImgAvt == null ? "" : user.ImgAvt)
                    };

                    //Initialize a new instance of the ClaimsIdentity with the claims and authentication scheme    
                    var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                    //Initialize a new instance of the ClaimsPrincipal with ClaimsIdentity    
                    var principal = new ClaimsPrincipal(identity);
                    //SignInAsync is a Extension method for Sign in a principal for the specified scheme.    
                    await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal, new AuthenticationProperties()
                    {
                        IsPersistent = objLoginModel.RememberLogin
                    });
                    return objLoginModel.ReturnUrl == null ? LocalRedirect("/Home/Index") : LocalRedirect(objLoginModel.ReturnUrl);
                }
                else
                {
                    ViewBag.Message = "Invalid Credential";
                    return View(user);
                }
            }
            return View(objLoginModel);
        }

        public async Task<IActionResult> LogOut()
        {
            //SignOutAsync is Extension method for SignOut    
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            //Redirect to home page    
            return LocalRedirect("/Home/Index");
        }
        [Authorize]
        public IActionResult Index()
        {
            return View();
        }
        public string mahoaMatKhau(string pass)
        {
            MD5 mh = MD5.Create();
            byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(pass);
            byte[] hash = mh.ComputeHash(inputBytes);
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString();
        }
    }
}