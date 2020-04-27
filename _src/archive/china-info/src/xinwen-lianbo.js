$('.ruiping, .zhongsheng').addClass('alert alert-warning');
$('.kuaixun').addClass('alert alert-secondary');
$('.kuaixun h4:first-of-type').before('<h3 class="heading">其他</h3>');

$('.zswz').click(function(){
    $('.zhongsheng, .kuaixun, .ruiping').removeClass('hide')
    $('.ruiping, .kuaixun').addClass('hide')
    $('.zswz, .gjrp, .qb').removeClass('active')
    $('.zswz').addClass('active')
});

$('.gjrp').click(function(){
    $('.zhongsheng, .kuaixun, .ruiping').removeClass('hide')
    $('.zhongsheng, .kuaixun').addClass('hide')
    $('.zswz, .gjrp, .qb').removeClass('active')
    $('.gjrp').addClass('active')
});

$('.qb').click(function(){
    $('.zhongsheng, .kuaixun, .ruiping').removeClass('hide')
    $('.zswz, .gjrp, .qb').removeClass('active')
    $('.qb').addClass('active')
});

