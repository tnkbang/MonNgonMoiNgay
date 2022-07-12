//Số lượng tin
var INDEX = 0;

//Xử lý gửi tin nhắn
$("#chat-submit").click(function (e) {
    e.preventDefault();
    var msg = $("#chat-input").val();
    if (msg.trim() == '') {
        return false;
    }

    $.ajax({
        url: '/Chat/sendNewTinNhan',
        type: 'POST',
        data: { maNN: messUserReceived, noidung: msg },
        success: function (data) {
            if (INDEX == 0) {
                $(".chat-logs").html("");
            }
            generate_message('self', data.imgAvt, data.noiDung, data.thoiGian);
            $(".chat-logs").stop().animate({ scrollTop: $(".chat-logs")[0].scrollHeight }, 1000);
            $("#chat-input").val('');
        },
        error: function () {
            getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
        }
    })
})

//Ghi nội dung tin nhắn vào popup tin nhắn
function generate_message(type, img, msg, time) {
    INDEX++;
    var str = "";
    str += "<div class=\"chat-msg " + type + "\">";
    str += "    <span class=\"msg-avatar\">";
    str += '        <img src="' + img + '">';
    str += "    <\/span>";
    str += "    <div class=\"cm-msg-text\">";
    str += msg;
    str += '        <div class="cm-msg-time">' + time + '</div>';
    str += "    <\/div>";
    str += "<\/div>";

    $(".chat-logs").append(str);
    //$("#cm-msg-" + INDEX).hide().fadeIn(300);
    //$(".chat-logs").stop().animate({ scrollTop: $(".chat-logs")[0].scrollHeight }, 1000);
}

//Xử lý nút đóng popup tin nhắn
$(".chat-box-toggle").click(function () {
    $(".chat-box").toggle('scale');
    clearInterval(myReloadChat);
    setInterval(myReloadPingChat, 1000);
})

//Mã người nhận tin nhắn
var messUserReceived;
var myReloadChat;

//Hàm mở chat
function openchat(ma) {
    INDEX = 0;
    clearInterval(myReloadPingChat);
    $(".chat-logs").html("");
    messUserReceived = ma;

    myReloadChat = setInterval(function () {
        $.ajax({
            url: '/Chat/getTinNhanTuUser',
            type: 'POST',
            data: { maNG: ma },
            success: function (data) {
                document.getElementById('chat-header').innerHTML = data.uSend.hoLot + " " + data.uSend.ten;

                if (data.soluong > 0 && data.soluong > INDEX) {

                    for (var i = INDEX; i < data.soluong; i++) {
                        var value = data.tinNhan[i];
                        if (value.nguoiGui == ma) generate_message('user', data.uSend.imgAvt, value.noiDung, value.thoiGian);
                        else generate_message('self', data.uReceived.imgAvt, value.noiDung, value.thoiGian);
                    }

                    $(".chat-logs").stop().animate({ scrollTop: $(".chat-logs")[0].scrollHeight }, 1000);
                }
                if (data.soluong == 0) {
                    $(".chat-logs").html('<p class="text-center">Chưa có tin nhắn nào</p>');
                }
            },
            error: function () {
                getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
            }
        })
    }, 1000);

    $(".chat-box").toggle('scale');
}

//Hàm ghi nội dung thông báo của tin nhắn
function generate_ping_mess(ma, img, time, hoten, noidung) {
    var str = "";
    str += '<li style="width: 100%">';
    str += '    <a href="#" onclick="openchat(\'' + ma + '\')">';
    str += '        <div class="message-img">';
    str += '            <img src="' + img + '" alt="">';
    str += '        </div>';
    str += '        <div class="message-content">';
    str += '            <span class="message-date">' + time + '</span>';
    str += '            <h2>' + hoten + '</h2>';
    str += '            <p class="ping-text">' + noidung + '</p>';
    str += '        </div>';
    str += '    </a>';
    str += '</li>';

    $("#mCSB_2_container").append(str);
}

//Tự động nhận tin nhắn mới
function myReloadPingChat() {
    $.ajax({
        url: '/Chat/getTinNhanChuaXem',
        type: 'POST',
        success: function (data) {
            $("#mCSB_2_container").html("");
            if (data.sl > 0) {
                $.each(data.tinNhan, function (index, value) {
                    generate_ping_mess(value.maNG, value.image, value.thoigian, value.hoten, value.noidung);
                })
                $('#icon-mess-ping').addClass('indicator-ms');
            }
            else {
                $("#mCSB_2_container").html('<p class="text-center" style="padding-top: 10px;">Không có tin nhắn mới nào.</p>');
                $('#icon-mess-ping').removeClass('indicator-ms');
            }
        },
        error: function () {
            //getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
        }
    })
}

//Hàm ghi nội dung của thông báo
function generate_ping(link, time, tieude, noidung) {
    var str = "";
    str += '<li style="width: 100%">';
    str += '    <a href="' + link + '" >';
    str += '        <div class="notification-icon">';
    str += '            <i class="fa fa-bell" aria-hidden="true"></i>';
    str += '        </div>';
    str += '        <div class="notification-content">';
    str += '            <span class="notification-date">' + time + '</span>';
    str += '            <h2>' + tieude + '</h2>';
    str += '            <p class="ping-text">' + noidung + '</p>';
    str += '        </div>';
    str += '    </a>';
    str += '</li>';

    $("#mCSB_3_container").append(str);
}

//Tự động nhận thông báo mới
function myReloadPing() {
    $.ajax({
        url: '/Notification/getThongBaoChuaXem',
        type: 'POST',
        success: function (data) {
            $("#mCSB_3_container").html("");
            if (data.sl > 0) {
                $.each(data.thongBao, function (index, value) {
                    generate_ping(value.link, value.time, value.tieude, value.noidung);
                })
                $('#icon-noti-ping').addClass('indicator-nt');
            }
            else {
                $("#mCSB_3_container").html('<p class="text-center" style="padding-top: 10px;">Không có thông báo mới nào.</p>');
                $('#icon-noti-ping').removeClass('indicator-nt');
            }
        },
        error: function () {
            //getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
        }
    })
}

//Set đã xem tất cả thông báo
$('#view-all-noti').on('click', function () {
    $.ajax({
        url: '/Notification/setXemTatCaThongBao',
        type: 'POST',
        success: function (data) {
            $("#mCSB_3_container").html("");
            if (data.tt) {
                getThongBao('success', 'Thành công', 'Đã xem tất cả thông báo !');
                $('#icon-noti-ping').removeClass('indicator-nt');
            }
            else {
                getThongBao('warning', 'Thông báo', 'Không có thông báo mới nào !');
            }
        },
        error: function () {
            getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
        }
    })
})