$('.ruiping, .zhongsheng').addClass('alert alert-warning');
$('.kuaixun').addClass('alert alert-secondary');
$('.kuaixun h4:first-of-type').before('<h3 class="heading">其他</h3>');

$('.zswz').click(function(){
    $('.zhongsheng, .kuaixun, .ruiping').removeClass('hide')
    $('.ruiping, .kuaixun').addClass('hide')
});

$('.gjrp').click(function(){
    $('.zhongsheng, .kuaixun, .ruiping').removeClass('hide')
    $('.zhongsheng, .kuaixun').addClass('hide')
});

$('.qb').click(function(){
    $('.zhongsheng, .kuaixun, .ruiping').removeClass('hide')
});

