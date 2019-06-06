$(document).ready(function() {
    $('#Staten').height($('.background').height());
});


function sendId() {
    var id = document.getElementById('OrderIdInput').value;
    
    var idObject = {
        BestellId: id
    }

    $.ajax({
        url: "../php/api/status.php",
        type: "POST",
        contentType: "application/json",
        dataType: "JSON",
        data: JSON.stringify(idObject),
        success: function(res) {
            var Bestellverfolgung = {
                BestellId: res[0]["BestellId"],
                StatusId: res[0]["StatusId"],
                Bezeichnung: res[0]["Bezeichnung"]
            }
            console.log(Bestellverfolgung);

            showProgress(Bestellverfolgung);
        }
    });

}

function showProgress(status) {
    $('.foreground').css('height', parseInt(status.StatusId) * 150 + "px");
}