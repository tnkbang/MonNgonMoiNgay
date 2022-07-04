(function ($) {
 "use strict";

	/*----------------------------
	 jQuery MeanMenu
	------------------------------ */
	jQuery('nav#dropdown').meanmenu();	
	/*----------------------------
	 jQuery myTab
	------------------------------ */
	$('#myTab a').on('click', function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		});
		$('#myTab3 a').on('click', function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		});
		$('#myTab4 a').on('click', function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		});
		$('#myTabedu1 a').on('click', function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		});

	  $('#single-product-tab a').on('click', function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		});
	
	$('[data-toggle="tooltip"]').tooltip(); 
	
	$('#sidebarCollapse').on('click', function () {
		 $('#sidebar').toggleClass('active');
	 });
	// Collapse ibox function
	$('#sidebar ul li').on('click', function () {
		var button = $(this).find('i.fa.indicator-mn');
		button.toggleClass('fa-plus').toggleClass('fa-minus');
		
	});
	/*-----------------------------
		Menu Stick
	---------------------------------*/
	$(".sicker-menu").sticky({topSpacing:0});
		
	$('#sidebarCollapse').on('click', function () {
		$("body").toggleClass("mini-navbar");
		SmoothlyMenu();
	});
	$(document).on('click', '.header-right-menu .dropdown-menu', function (e) {
		  e.stopPropagation();
	});
	/*----------------------------
	 wow js active
	------------------------------ */
	 new WOW().init();
	/*----------------------------
	 owl active
	------------------------------ */  
	$("#owl-demo").owlCarousel({
      autoPlay: false, 
	  slideSpeed:2000,
	  pagination:false,
	  navigation:true,	  
      items : 4,
	  /* transitionStyle : "fade", */    /* [This code for animation ] */
	  navigationText:["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"],
      itemsDesktop : [1199,4],
	  itemsDesktopSmall : [980,3],
	  itemsTablet: [768,2],
	  itemsMobile : [479,1],
	});
	/*----------------------------
	 price-slider active
	------------------------------ */  
	  $( "#slider-range" ).slider({
	   range: true,
	   min: 40,
	   max: 600,
	   values: [ 60, 570 ],
	   slide: function( event, ui ) {
		$( "#amount" ).val( "£" + ui.values[ 0 ] + " - £" + ui.values[ 1 ] );
	   }
	  });
	  $( "#amount" ).val( "£" + $( "#slider-range" ).slider( "values", 0 ) +
	   " - £" + $( "#slider-range" ).slider( "values", 1 ) );
	/*--------------------------
	 scrollUp
	---------------------------- */	
	$.scrollUp({
        scrollText: '<i class="fa fa-angle-up"></i>',
        easingType: 'linear',
        scrollSpeed: 900,
        animation: 'fade'
	});
 
})(jQuery); 

//Xử lý tìm kiếm người dùng và chọn loại người dùng
$('#search-user').on('submit', function () {
	event.preventDefault();
	window.location.href = '/Admin/User/List?q=' + $('#inp-search-user').val();
})
$('#btn-search-user').on('click', function () {
	event.preventDefault();
	window.location.href = '/Admin/User/List?q=' + $('#inp-search-user').val();
})
$('#select-loai-user').on('change', function () {
	event.preventDefault();
	window.location.href = '/Admin/User/List?l=' + $('#select-loai-user').val();
})

//Xử lý khóa người dùng
var thisUserLock, btnUserLock;
function setUserLock(maUser, elm) {
	thisUserLock = maUser;
	btnUserLock = elm;

	var title = document.getElementById('modal-lock-user-title');
	var content = document.getElementById('modal-lock-user-content');
	var btn = document.getElementById('confirm-lock-user');
	if ($(btnUserLock).hasClass('fa-lock')) {
		title.innerHTML = 'Bạn thật sự muốn khóa?'
		content.innerHTML = 'Khi khóa người dùng, tài khoản này sẽ không thể đăng nhập vào hệ thống và thực hiện các chức năng. Bạn thật sự chắc chắn về hành động này ?'
		btn.innerHTML = 'Khóa'
	}
	else {
		title.innerHTML = 'Bạn thật sự muốn mở khóa?'
		content.innerHTML = 'Khi mở khóa người dùng, tài khoản này sẽ khôi phục hoạt động và có thể thao tác với các chức năng trong hệ thống. Bạn thật sự chắc chắn về hành động này ?'
		btn.innerHTML = 'Mở khóa'
    }
}
$('#cancel-lock-user').on('click', function () {
	thisUserLock = btnUserLock = null;
})
$('#confirm-lock-user').on('click', function () {
	$.ajax({
		url: '/Admin/User/LockUser',
		type: 'POST',
		data: { ma: thisUserLock },
		success: function (data) {
			if (data.tt) {
				$(btnUserLock).removeClass('fa-unlock').addClass('fa-lock')
				$($(btnUserLock).parent()[0]).attr("data-original-title", "Khóa")
				$($(btnUserLock).parent().parent().parent().children()[5]).html('Hoạt động')
				getThongBao('success', 'Thành công', 'Mở khóa người dùng thành công !')
				thisUserLock = btnUserLock = null;
			}
			else {
				$(btnUserLock).removeClass('fa-lock').addClass('fa-unlock')
				$($(btnUserLock).parent()[0]).attr("data-original-title", "Mở khóa")
				$($(btnUserLock).parent().parent().parent().children()[5]).html('Bị khóa')
				getThongBao('success', 'Thành công', 'Khóa người dùng thành công !')
				thisUserLock = btnUserLock = null;
			}
		},
		error: function () {
			getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
		}
	})
})


//My Custom

//Hàm xử lý đẩy bài đăng
function setDayBaiDang(mabd, elm) {

	event.preventDefault();

	$.ajax({
		url: 'DayBaiDang',
		type: 'POST',
		data: { id: mabd },
		success: function (data) {
			if (data.tt) {
				$(elm).addClass('disabled')
				getThongBao('success', 'Thành công', 'đã đẩy thành công')
			}
			else {
				getThongBao('warning', 'Thông báo', 'Bạn đã đẩy bài đăng này rồi!')
			}
		},
		error: function () {
			getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về server')
		}
	})
}
//Hàm xử lý ẩn bài đăng
function setAnBaiDang(mabd, elm) {

	event.preventDefault();

	$.ajax({
		url: 'AnBaiDang',
		type: 'POST',
		data: { id: mabd },
		success: function (data) {
			if (data.tt) {
				$(elm).toggle('slow');
				getThongBao('success', 'Thành công', 'Bạn có thể xem lại trong mục bài đăng của tôi')
			}
			else {
				getThongBao('warning', 'Thông báo', 'Bạn đã ẩn bài đăng này rồi!')
			}
		},
		error: function () {
			getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về server')
		}
	})
}

//Hàm xử lý hủy ẩn bài đăng
function setBoAnBaiDang(mabd, elm) {

	event.preventDefault();

	$.ajax({
		url: 'BoAnBaiDang',
		type: 'POST',
		data: { id: mabd },
		success: function (data) {
			if (data.tt) {
				$($(elm).parents()[2]).hide('slow')
				getThongBao('success', 'Thành công', 'Bài đăng của bạn đã công khai với mọi người.')
			}
		},
		error: function () {
			getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về server')
		}
	})
}

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

//Xử lý tìm kiếm phản hồi
$('#search-phanhoi').on('submit', function () {
	event.preventDefault();
	window.location.href = '/Admin/User/ViewPhanHoi?q=' + $('#inp-search-phanhoi').val();
})
$('#btn-search-phanhoi').on('click', function () {
	event.preventDefault();
	window.location.href = '/Admin/User/ViewPhanHoi?q=' + $('#inp-search-phanhoi').val();
})

//Hàm xử lý bỏ lưu bài đăng
function setBoLuuBaiDang(mabd, elm) {
	event.preventDefault();

	$.ajax({
		url: '/Admin/User/setBoLuuBaiDang',
		type: 'POST',
		data: { id: mabd },
		success: function (data) {
			if (data.tt) {
				$($(elm).parents()[2]).hide('slow')
				getThongBao('success', 'Thành công', 'Bỏ lưu bài đăng thành công !')
			}
			else {
				getThongBao('error', 'Lỗi', 'Mã lệnh đã bị thay đổi !')
			}
		},
		error: function () {
			getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về server')
		}
	})
}

//Hàm xử lý bỏ thích bài đăng
function setBoThichBaiDang(mabd, elm) {
	event.preventDefault();

	$.ajax({
		url: '/Admin/Home/setBoThichBaiDang',
		type: 'POST',
		data: { id: mabd },
		success: function (data) {
			if (data.tt) {
				$($(elm).parents()[2]).hide('slow')
				getThongBao('success', 'Thành công', 'Bỏ thích bài đăng thành công !')
			}
			else {
				getThongBao('error', 'Lỗi', 'Mã lệnh đã bị thay đổi !')
			}
		},
		error: function () {
			getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về server')
		}
	})
}

//Xử lý cập nhật giỏ hàng
$(".updatecartitem").click(function (event) {
	event.preventDefault();
	var Mabd = $(this).attr("data-productid");
	var quantity = $("#quantity-" + Mabd).val();
	$.ajax({
		type: "POST",
		url: "/Post/UpdateCart",
		data: {
			id: Mabd,
			quantity: quantity
		},
		success: function (result) {
			window.location.reload();
		}
	});
});

//Chỉnh sửa bài đăng
var maPostEdit = "";

//Hiển popup chỉnh sửa bài đăng
function setEditPost(ma) {
	maPostEdit = ma;
	var loaiMon = document.getElementById('pst-edit-loai');
	var tenMon = document.getElementById('pst-edit-ten');
	var giaTien = document.getElementById('pst-edit-giatien');
	var moTa = document.getElementById('pst-edit-mota');

	$.ajax({
		type: "POST",
		url: "/Post/getInfoPost",
		data: { ma: ma },
		success: function (data) {
			loaiMon.value = data.info.maLoai;
			tenMon.value = data.info.tenMon;
			giaTien.value = data.info.giaTien;
			moTa.value = data.info.moTa

			$('#pst-edit-giatien').number(true, 0, ',', '.');
			$('#modal-edit-post').modal('show')
		}
	});
}

//Định dạng số tiền
$('#pst-edit-giatien').number(true, 0, ',', '.');

//Xử lý chỉnh sửa bài đăng.
$('#confirm-edit-post').on('click', function () {
	var loaiMon = document.getElementById('pst-edit-loai');
	var tenMon = document.getElementById('pst-edit-ten');
	var moTa = document.getElementById('pst-edit-mota');

	//Kiểm tra loại món đã được chọn
	if (loaiMon.value == "0") {
		getThongBao('error', 'Lỗi', 'Vui lòng chọn loại món!')
		return;
	}

	var form_data = new FormData();
	form_data.append('ma', maPostEdit);
	form_data.append('loai', loaiMon.value);
	form_data.append('ten', tenMon.value);
	form_data.append('gia', $('#pst-edit-giatien').val());
	form_data.append('mota', moTa.value);

	//Gọi ajax xử lý tạo post
	$.ajax({
		url: '/Post/getEditPost',
		type: 'POST',
		data: form_data,
		contentType: false,
		processData: false,
		success: function (data) {
			if (data.tt) {
				$('#modal-edit-post').modal('hide')
				maPostEdit = "";
				window.location.href = "/Post/Detail?id=" + maPostEdit;
				//window.location.reload();
			}
			else {
				getThongBao('error', 'Lỗi', 'Mã nguồn đã bị thay đổi !')
            }
		},
		error: function () {
			getThongBao('error', 'Lỗi', 'Không thể gửi yêu cầu về máy chủ !')
		}
	})
})