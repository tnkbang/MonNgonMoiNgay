const changeForm = async (form) => {
    switch (form) {
        case 'login': {
            document.querySelector('.sign-up').style.display = 'none'
            document.getElementById('loading-text').style.display = 'block'
            document.getElementById('loading-text').innerHTML = ''

            new TypeIt('#loading-text', {
                speed: 50,
                waitUntilVisible: true
            }).type('Vui lòng chờ....', { delay: 500 })
                .go()

            $('#tieude-login').html("Đăng nhập - Món Ngon Mỗi Ngày")

            setTimeout(async () => {
                document.querySelector('.box').style.display = 'block'
                document.getElementById('loading-text').style.display = 'none'
            }, 2000)
            break
        }

        case 'register': {
            document.querySelector('.box').style.display = 'none'
            document.getElementById('loading-text').style.display = 'block'
            document.getElementById('loading-text').innerHTML = ''

            new TypeIt('#loading-text', {
                speed: 50,
                waitUntilVisible: true
            }).type('Vui lòng chờ....', { delay: 500 })
                .go()

            $('#tieude-login').html("Đăng ký tài khoản - Món Ngon Mỗi Ngày")

            setTimeout(async () => {
                document.querySelector('.sign-up').style.display = 'block'
                document.getElementById('loading-text').style.display = 'none'
            }, 2000)
            break
        }
    }
}

//Hàm đăng ký
function dangky() {
    $.getJSON('/Account/createAccount' + '?email=' + $('#registerEmail').val() + '&pass=' + $('#registerPass').val(), function (data) {
        if (data.tt) {
            window.location.href = "/Home/Index";
        }
        else {
            if (data.erro == "email") {
                document.getElementById('registerEmail').style.borderColor = 'red';
                document.getElementById('erroRegister').innerHTML = data.mess;
                $('#erroRegister').show('slow');
                $('#erroRegister').delay(5000).hide('slow');
                $('#erroRegister').focus();
            }
            else {
                document.getElementById('erroRegister').innerHTML = data.mess;
                $('#erroRegister').show('slow');
                $('#erroRegister').delay(5000).hide('slow');
            }
        }
    })
}

//Hàm đăng nhập
function dangnhap() {
    var remember = document.getElementById('loginRemember');
    $.getJSON('/Account/getLogin' + '?email=' + $('#loginEmail').val() + '&pass=' + $('#loginPass').val() + '&re=' + remember.checked, function (data) {
        if (data.tt) {
            window.location.href = $('#loginUrlReturn').val();
        }
        else {
            document.getElementById('erroLogin').innerHTML = data.mess;
            $('#erroLogin').show('slow');
            $('#erroLogin').delay(5000).hide('slow');
        }
    })
}

//Hàm đăng xuất
function dangxuat() {
    $.getJSON('/Account/Logout', function (data) {
        location.replace('/Account/Login');
    })
}

//Bắt sự kiện khi nhấn đăng nhập
$('#formLogin').on('submit', function () {
    event.preventDefault();
    dangnhap()
})

//Bắt sự kiện khi nhấn đăng ký
$('#formRegister').on('submit', function () {
    event.preventDefault();

    if (!passValidate('registerPass', 'registerRePass', 'erroRegister')) {
        return;
    }
    dangky()
})

//Kiểm tra nhập lại mật khẩu
function passValidate(id_pass, re_pass, kt_pass) {
    var pass = document.getElementById(id_pass);
    var pass_re = document.getElementById(re_pass);
    var tb = document.getElementById(kt_pass);
    if (pass.value == pass_re.value) {
        pass_re.style.borderColor = 'green';
        pass.style.borderColor = 'green';
        tb.style.display = 'none';
        return true;
    }
    else {
        pass_re.style.borderColor = 'red';
        pass.style.borderColor = 'red';
        tb.innerHTML = 'Xác nhận mật khẩu sai !';
        tb.style.display = 'block';
        $('#' + kt_pass).delay(5000).hide(1);
        return false;
    }
}

//Gọi API google để đăng nhập

var OAUTHURL = 'https://accounts.google.com/o/oauth2/auth?';
var VALIDURL = 'https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=';
var SCOPE = 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email';
var CLIENTID = '157130659490-m66pse93mn73j3lf1ndjql21hi2nprh2.apps.googleusercontent.com';
var REDIRECT = 'https://localhost:9090';
var TYPE = 'token';
var _url = OAUTHURL + 'scope=' + SCOPE + '&client_id=' + CLIENTID + '&redirect_uri=' + REDIRECT + '&response_type=' + TYPE;
var acToken;
var tokenType;
var expiresIn;
var user;

function loginWithGoogle() {
    var win = window.open(_url, "windowname1", 'width=500, height=500');
    var pollTimer = window.setInterval(function () {
        try {
            if (win.document.URL.indexOf(REDIRECT) != -1) {
                window.clearInterval(pollTimer);
                var url = win.document.URL;
                acToken = gup(url, 'access_token');
                tokenType = gup(url, 'token_type');
                expiresIn = gup(url, 'expires_in');

                win.close();
                validateToken(acToken);
            }
        }
        catch (e) {
        }
    }, 500);
}

function loginWithFacebook() {
    getThongBao('warning', 'Đang phát triển', 'Chức năng này đang trong quá trình phát triển, hiện tại không thể sử dụng !')
}

function gup(url, name) {
    namename = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regexS = "[\\#&]" + name + "=([^&#]*)";
    var regex = new RegExp(regexS);
    var results = regex.exec(url);
    if (results == null)
        return "";
    else
        return results[1];
}

function validateToken(token) {
    $.ajax(
        {
            url: VALIDURL + token,
            data: null,
            success: function (responseText) {
                getUserInfo();
            },
            error: function () {
                getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu đến Google !')
            }
        });
}

function getUserInfo() {
    $.ajax({
        url: 'https://www.googleapis.com/oauth2/v1/userinfo?access_token=' + acToken,
        data: null,
        async: false,
        success: function (resp) {
            user = resp;
            var form_data = new FormData();

            form_data.append('hoten', user.given_name);
            form_data.append('email', user.email);

            //Lấy url ảnh chuyển thành file
            fetch(user.picture).then(async response => {
                const contentType = response.headers.get('content-type')
                const blob = await response.blob()
                const file = new File([blob], user.given_name + ".jpg", { contentType })

                //Chuyển file ảnh vào form data gửi về server
                form_data.append('img_avt', file);

                //Gọi ajax về server
                $.ajax({
                    url: '/Account/loginWithGoogle',
                    type: 'POST',
                    data: form_data,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        if (data.tt) {
                            window.location.href = $('#loginUrlReturn').val();
                        }
                        else {
                            document.getElementById('erroLogin').innerHTML = data.mess;
                            $('#erroLogin').show('slow');
                            $('#erroLogin').delay(5000).hide('slow');
                        }
                    },
                    error: function () {
                        getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
                    }
                });
            })
        },
        error: function () {
            getThongBao('error', 'Lỗi', 'Không thể lấy thông tin người dùng từ Google !')
        }
    });
}

//Cập nhật thông tin người dùng
$('#user-update-info').on('submit', function () {
    event.preventDefault();
    var inp = document.getElementsByClassName('user-change-inp');

    var form_data = new FormData();
    form_data.append('holot', inp[0].value);
    form_data.append('ten', inp[1].value);
    form_data.append('ngaysinh', inp[2].value);
    form_data.append('gioitinh', inp[3].value);
    form_data.append('sdt', inp[4].value);
    form_data.append('diachi', inp[5].value);
    form_data.append('imgavt', $('#user-change-img').prop('files')[0]);

    $.ajax({
        url: '/Account/updateProfile',
        type: 'POST',
        data: form_data,
        contentType: false,
        processData: false,
        success: function (data) {
            if (data.tt) {
                history.back();
            }
        },
        error: function () {
            getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
        }
    });
})

//Bắt sự kiện hiện ảnh xem trước
$('#user-change-img').on('change', function () {
    if ($('#user-change-img').prop('files').length != 0) {
        $('div.preview-images').html('');
        $('.fake-btn').html($('#user-change-img').prop('files')[0].name);
        imagesPreview(this, 'div.preview-images');
    }
    else {
        $('div.preview-images').html('');
        $('.fake-btn').html('Kéo thả hoặc chọn ảnh để tải lên');
    }
})

//Xử lý gán ảnh được thêm từ input vào div hiển thị xem trước
var imagesPreview = function (input, placeImagePreview) {
    if (input.files) {
        for (i = 0; i < input.files.length; i++) {
            var reader = new FileReader();

            reader.onload = function (event) {
                $($.parseHTML('<img>')).attr('src', event.target.result).attr('class', 'img-preview').appendTo(placeImagePreview);
            }
            reader.readAsDataURL(input.files[i]);
        }
    }
};

//Trạng thái có thể đổi mật khẩu
var isChangePassOld = false;
var isChangePassNew = false;
var isChangePassRe = false;

//Kiểm tra mật khẩu nhập vào
$('#passOld').on('change', function () {
    $.ajax({
        url: '/Account/checkPass',
        type: 'POST',
        data: { pass: $('#passOld').val() },
        success: function (data) {
            if (!data.tt) {
                document.getElementById('passOld').style.borderColor = '#e74c3c';
                $('#lbl-passOld').addClass('text-danger').removeClass('text-success');
                $('#lbl-passOld').html('Mật khẩu không chính xác !');
                isChangePassOld = false;
            }
            else {
                document.getElementById('passOld').style.borderColor = '#3c763d';
                $('#lbl-passOld').removeClass('text-danger').addClass('text-success');
                $('#lbl-passOld').html('Mật khẩu');
                isChangePassOld = true;
            }
        },
        error: function () {
            getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
        }
    });
})

$('#passNew').on('change', function () {
    if ($('#passNew').val() != "") {
        document.getElementById('passNew').style.borderColor = '#3c763d';
        $('#lbl-passNew').removeClass('text-danger').addClass('text-success');
        $('#lbl-passNew').html('Mật khẩu mới');
        isChangePassNew = true;
    }
    else {
        document.getElementById('passNew').style.borderColor = '#e74c3c';
        $('#lbl-passNew').addClass('text-danger').removeClass('text-success');
        $('#lbl-passNew').html('Mật khẩu mới không được để trống !');
        isChangePassNew = false;
    }
})

//Kiểm tra trùng khớp mật khẩu
$('#passRe').on('change', function () {
    if ($('#passRe').val() != $('#passNew').val()) {
        document.getElementById('passRe').style.borderColor = '#e74c3c';
        $('#lbl-passRe').addClass('text-danger').removeClass('text-success');
        $('#lbl-passRe').html('Nhập lại không chính xác !');
        isChangePassRe = false;
    }
    else {
        document.getElementById('passRe').style.borderColor = '#3c763d';
        $('#lbl-passRe').removeClass('text-danger').addClass('text-success');
        $('#lbl-passRe').html('Nhập lại mật khẩu mới');
        isChangePassRe = true;
    }
})

//Xử lý thay đổi mật khẩu
$('#confirm-change-pass').on('click', function () {
    var passRe = document.getElementById('passRe');
    var passOld = document.getElementById('passOld');
    if (isChangePassOld && isChangePassNew && isChangePassRe) {
        $.ajax({
            url: '/Account/updatePass',
            type: 'POST',
            data: { pass: $('#passNew').val() },
            success: function (data) {
                if (data.tt) {
                    getThongBao('success', 'Thành công', 'Đổi mật khẩu thành công !')
                    setTimeout(function () {
                        window.location.reload();
                    }, 1000);
                }
            },
            error: function () {
                getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
            }
        });
    }
    else {
        getThongBao('warning', 'Thông báo', 'Có tham số chưa hợp lệ !')
    }
})