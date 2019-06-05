var fullOrder = {
    Name: "",
    Strasse: "",
    OrtId: "",
    Telefon: "",
    Bestelloptionen: []
}

var cities = [];
var pizzas = [];
var rawOrders = [];

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
        type: "GET",
        dataType: "JSON",
        success: function(res) {
            
            for(var i = 0; i < res.length;  i++)
            {
                var id = res[i]["Id"];
                var name = res[i]["Pizza"];
                var zutaten = res[i]["Rezept"];
                var preisK = res[i]["28cm"];
                var preisG = res[i]["32cm"];

                var pizzaObject = {
                    id: id,
                    name: name,
                    preisK: preisK,
                    preisG: preisG
                }

                pizzas.push(pizzaObject);

                document.getElementById('PizzaContainer').innerHTML += createCard(name, zutaten, preisK, preisG);
            }
        }
    });

    $.ajax({
        url: "../php/api/locations.php",
        type: "GET",
        dataType: "JSON",
        success: function(res) {
            
            for(var i = 0; i < res.length;  i++)
            {
                var id = res[i]["Id"];
                var plz = res[i]["PLZ"];
                var cityname = res[i]["Ortsname"];
                
                var city = {
                    id: id,
                    plz: plz,
                    city: cityname 
                }

                cities.push(city);

                document.getElementById('SelectOrt').innerHTML += "<option>" + cityname + "</option>";
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

    var orderString = "" + name + " - " + selection;

    rawOrders.push(orderString);

    document.getElementById('OrderList').innerHTML += "<div class='form-group'><input type='text' class='form-control mt-2' value='" + name + " - " + selection + "' ></div>";
}

function getCityIdByName(name) {
    var id = 0;

    for(i = 0; i < cities.length; i++)
    {
        if(cities[i].city == name)
        {
            id = cities[i].id;
        }
    }

    return id;
}

function getPizzaIdByName(name) {
    var id = 0;
    
    for(i = 0; i < pizzas.length; i++)
    {
        if(pizzas[i].name == name)
        {
            id = pizzas[i].id;
        }
    }

    return id;
}


function splitOrderObject(order) {
    var splittedOrderObject = order.split(" - ");
    var splitSize = splittedOrderObject[1].split("cm");

    var orderObject = {
        PizzaId: getPizzaIdByName(splittedOrderObject[0]),
        Groesse: splitSize[0]
    }

    fullOrder.Bestelloptionen.push(orderObject);
}

function packOrder() {
    fullOrder.Name = document.getElementById('Name').value;
    fullOrder.Strasse = document.getElementById('Strasse').value;
    fullOrder.Telefon = document.getElementById('Telefon').value;
    fullOrder.OrtId = getCityIdByName(document.getElementById('SelectOrt').options[document.getElementById('SelectOrt').selectedIndex].innerHTML);
    
    for(var i = 0; i < rawOrders.length; i++)
    {
        splitOrderObject(rawOrders[i]);
    }

    console.log(fullOrder);
}
