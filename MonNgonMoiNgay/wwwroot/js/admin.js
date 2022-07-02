//My Custom

//Hàm xử lý đề cử bài đăng
function setDeCuBaiDang(mabd, elm) {

    event.preventDefault();

    $.ajax({
        url: '/Post/DeCuBaiDang',
        type: 'POST',
        data: { id: mabd },
        success: function (data) {
            if (data.tt) {
                $(elm).addClass('disabled')
                getThongBao('success', 'Thành công', 'Bạn có thể xem lại trong phần bài đăng đã đề cử !');
            }
            else {
                getThongBao('warning', 'Thông báo', 'Bạn đã đề cử bài đăng này rồi !')
            }
        },
        error: function () {
            getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
        }
    })
}