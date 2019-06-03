$(document).ready(function() {
    $(window).scroll(function() {
        var wScroll = $(window).scrollTop();
        var wHeight = $(window).height();
        if(wScroll + 100 > wHeight)
        {
            $('#navigation').addClass('scrolled');
        }
        else
            $('#navigation').removeClass('scrolled');
    })

    $.ajax({
        url: "../php/api/menu.php",
        type: "POST",
        dataType: "JSON",
        success: function(res) {
            
            for(var i = 0; i < res.length;  i++)
            {
                var name = res[i]["Pizza"];
                var zutaten = res[i]["Rezept"];
                var preisK = res[i]["28cm"];
                var preisG = res[i]["32cm"];

                document.getElementById('PizzaContainer').innerHTML += createCard(name, zutaten, preisK, preisG);
            }
        }
    });
});

function createCard(name, zutaten, preisK, preisG) {  
    return "<div class='card my-5 mx-2' style='width: 18rem;'><img src='../images/" + name +".jpg' class='card-img-top'><div class='card-body'><h4 class='card-title pb-2'>" + name +"</h4><h6 class='card-text'>Zutaten:</h6></div><ul class='list-group list-group-flush'><li class='list-group-item'>" + zutaten + "</li></ul><div class='card-body'><form><div class='d-flex flex-column flex-wrap form-group'><div class='d-flex justify-content-around'><div class='custom-control custom-radio'><input type='radio' id='Radio" + name +  "28cm' name='Radio" + name +"28cm' class='custom-control-input'><label class='custom-control-label' for='Radio" + name + "28cm'>28 cm</label></div><div class='custom-control custom-radio'><input type='radio' id='Radio" + name +"32cm' name='Radio" + name +"32cm' class='custom-control-input'></input><label class='custom-control-label' for='Radio" + name +"32cm'>32 cm</label></div></div><button class='btn btn-primary mt-2'>Bestellen!</button></div></form></div></div>"
}
