$(window).ready(function() {
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
})