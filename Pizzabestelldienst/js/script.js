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
    return "<div class='card my-5 mx-2' style='width: 18rem;'><img src='../images/" + name +".jpg' class='card-img-top'><div class='card-body'><h4 class='card-title pb-2'>" + name +"</h4><h6 class='card-text'>Zutaten:</h6></div><ul class='list-group list-group-flush'><li class='list-group-item'>" + zutaten + "</li></ul><div class='card-body'><form><div class='d-flex flex-column flex-wrap form-group'><div class='d-flex justify-content-around'><div class='form-group'><select class='form-control' id='Select" + name + "'><option>28cm - "+ preisK + "</option><option>32cm - "+ preisG + "</option></select></div></div></div></form><button onclick='addToOrder(this)' class='btn btn-primary mt-2'>Bestellen!</button></div></div>"
}

function addToOrder(sender) {
    var name = sender.parentNode.parentNode.children[1].children[0].innerHTML;
    var selection = document.getElementById('Select' + name).options[document.getElementById('Select' + name).selectedIndex].value;

    document.getElementById('OrderList').innerHTML += "<div class='form-group'><input type='text' class='form-control' value='" + name + " - " + selection + "' ></div>";
}