//var mymap;
//var pstDiaChi;

//function initMap(lat, lng) {
//    if (lat) {
//        mymap = L.map('map').setView([lat, lng], 14);
//        var marker = L.marker([lat, lng]).addTo(mymap);

//        marker.bindPopup('<p><i><img src="/Content/Images/" class="img-thumbnail"/><br>' +
//            '<h5>' + "aaa" + '</h5>' +
//            '<strong>Thông tin:</strong><ul>' +
//            '<li>Cách bạn: ' + "ddd" + '&nbsp;km</li>' +
//            '<li>Giá vé: ' + "aa" + '</li>' +
//            "</p>", { maxWidth: 200, minWidth: 200 });
//    }
//    else {
//        mymap = L.map('map').setView([10.032106481012109, 105.76840075044362], 14);
//    }

//    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
//        minZoom: 1,
//        maxZoom: 19
//    }).addTo(mymap);

//    mymap.zoomControl.setPosition('bottomright');

//    L.control.locate({
//        position: 'bottomright',
//        strings: {
//            title: "Di chuyển đến vị trí hiện tại của tôi",
//            popup: "Đây là vị trí của bạn",
//        }
//    }).addTo(mymap);
//};

//$('.btn-diachi').on('click', function () {
//    $('#map').show();
//    initMap();

//    mymap.on('click', function (e) {
//        pstDiaChi = e.latlng.lat + '-' + e.latlng.lng;
//        mymap.remove();
//        $('#map').hide();
//    });
//})

//$('.close-map').on('click', function () {
//    mymap.remove();
//    $('#map').hide();
//})