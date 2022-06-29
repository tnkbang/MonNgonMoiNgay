var INDEX = 0;
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
            generate_message('self', data.imgAvt, data.noiDung, data.thoiGian);
            $(".chat-logs").stop().animate({ scrollTop: $(".chat-logs")[0].scrollHeight }, 1000);
            $("#chat-input").val('');
        },
        error: function () {
            getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
        }
    })
})

function generate_message(type, img, msg, time) {
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

$(".chat-box-toggle").click(function () {
    $(".chat-box").toggle('scale');
    clearInterval(myReloadChat);
})

//Mã người nhận tin nhắn
var messUserReceived;
var myReloadChat;

function openchat(ma) {
    INDEX = 0;
    messUserReceived = ma;

    myReloadChat = setInterval(function () {
        $.ajax({
            url: '/Chat/getTinNhanTuUser',
            type: 'POST',
            data: { maNG: ma },
            success: function (data) {
                document.getElementById('chat-header').innerHTML = data.uSend.hoLot + " " + data.uSend.ten;
                $(".chat-logs").html("");

                var countMess = 0;
                $.each(data.tinNhan, function (index, value) {
                    countMess++;
                    if (value.nguoiGui == ma) generate_message('user', data.uSend.imgAvt, value.noiDung, value.thoiGian);
                    else generate_message('self', data.uReceived.imgAvt, value.noiDung, value.thoiGian);
                })

                if (countMess > INDEX) {
                    $(".chat-logs").stop().animate({ scrollTop: $(".chat-logs")[0].scrollHeight }, 1000);
                    INDEX = countMess;
                }
            },
            error: function () {
                getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
            }
        })
    }, 1000);

    $(".chat-box").toggle('scale');
}