var p1Total = 0;
var p2Total = 0;
var p3Total = 0;

var p1Display = document.querySelector("#player1Display")
var p2Display = document.querySelector("#player2Display")
var p3Display = document.querySelector("#player3Display")

p1Display.textContent = p1Total;
p2Display.textContent = p2Total;
p3Display.textContent = p3Total;

var p1NameAll = document.querySelectorAll(".player1Name")
var p2NameAll = document.querySelectorAll(".player2Name")
var p3NameAll = document.querySelectorAll(".player3Name")

//=================================================================

document.querySelector("#nameSet").addEventListener("change", function(){
    for(var i = 0; i < p1NameAll.length; i++) {
        p1NameAll[i].textContent = document.querySelector("#player1NameSet").value
    }
    for(var i = 0; i < p2NameAll.length; i++) {
        p2NameAll[i].textContent = document.querySelector("#player2NameSet").value
    }
    for(var i = 0; i < p3NameAll.length; i++) {
        p3NameAll[i].textContent = document.querySelector("#player3NameSet").value
    }
});

//=================================================================

difen = 1

document.querySelector("#difen").addEventListener("change", function(){
    difen = Number(document.querySelector("#difen").value)
    benjuUpdate()
});

//=================================================================

var beishu = 1;

document.querySelector("#erbei").addEventListener("click", function(){
    beishu *= 2
    document.querySelector("#beishu").textContent = beishu;
    benjuUpdate()
});

document.querySelector("#sanbei").addEventListener("click", function(){
    beishu *= 3
    document.querySelector("#beishu").textContent = beishu;
    benjuUpdate()
});

document.querySelector("#sibei").addEventListener("click", function(){
    beishu *= 4
    document.querySelector("#beishu").textContent = beishu;
    benjuUpdate()
});

//=================================================================

var benju = 1

function benjuUpdate() {
    benju = beishu*difen
    document.querySelector("#benju").textContent = benju
}

document.querySelector("#benju").textContent = benju

//=================================================================

var dizhu = "dizhuplayer1"

/* document.querySelector("#benjudizhu").addEventListener("change", function(){
    dizhu = document.querySelector("select").value;
}); */

document.querySelector("#dizhu1").addEventListener("click", function(){
    dizhu = "dizhuplayer1"
    document.querySelector("#dizhu2").classList.add("disabled")
    document.querySelector("#dizhu3").classList.add("disabled")
});

document.querySelector("#dizhu2").addEventListener("click", function(){
    dizhu = "dizhuplayer2"
    document.querySelector("#dizhu1").classList.add("disabled")
    document.querySelector("#dizhu3").classList.add("disabled")
});

document.querySelector("#dizhu3").addEventListener("click", function(){
    dizhu = "dizhuplayer3"
    document.querySelector("#dizhu1").classList.add("disabled")
    document.querySelector("#dizhu2").classList.add("disabled")
});


//=================================================================

function displayTotalAndReset() {
    p1Display.textContent = p1Total;
    p2Display.textContent = p2Total;
    p3Display.textContent = p3Total;
    beishu = 1;
    document.querySelector("#beishu").textContent = beishu;
    benjuUpdate();
    document.querySelector("#dizhu1").classList.remove("disabled");
    document.querySelector("#dizhu2").classList.remove("disabled");
    document.querySelector("#dizhu3").classList.remove("disabled");
}

document.querySelector("#player1Wins").addEventListener("click", function(){
    if(dizhu === "dizhuplayer1"){
        p1Total += benju*2;
        p2Total -= benju;
        p3Total -= benju;
        displayTotalAndReset()
    } else if(dizhu === "dizhuplayer2"){
        p1Total += benju;
        p2Total -= benju*2;
        p3Total += benju;
        displayTotalAndReset()
    } else {
        p1Total += benju;
        p2Total += benju;
        p3Total -= benju*2;
        displayTotalAndReset()
    }
});

document.querySelector("#player2Wins").addEventListener("click", function(){
    if(dizhu === "dizhuplayer2"){
        p1Total -= benju;
        p2Total += benju*2;
        p3Total -= benju;
        displayTotalAndReset()
    } else if(dizhu === "dizhuplayer1"){
        p1Total -= benju*2;
        p2Total += benju;
        p3Total += benju;
        displayTotalAndReset()
    } else {
        p1Total += benju;
        p2Total += benju;
        p3Total -= benju*2;
        displayTotalAndReset()
    };
});

document.querySelector("#player3Wins").addEventListener("click", function(){
    if(dizhu === "dizhuplayer3"){
        p1Total -= benju;
        p2Total -= benju;
        p3Total += benju*2;
        displayTotalAndReset()
    } else if(dizhu === "dizhuplayer1"){
        p1Total -= benju*2;
        p2Total += benju;
        p3Total += benju;
        displayTotalAndReset()
    } else {
    p1Total += benju;
    p2Total -= benju*2;
    p3Total += benju;
    displayTotalAndReset()
    };
});



document.querySelector("#chongzhi").addEventListener("click", function(){
    document.querySelector("#beishu").textContent = beishu
    for(var i = 0; i < p1NameAll.length; i++) {
        p1NameAll[i].textContent = "玩家1"
    };
    for(var i = 0; i < p2NameAll.length; i++) {
        p2NameAll[i].textContent = "玩家2"
    };
    for(var i = 0; i < p3NameAll.length; i++) {
        p3NameAll[i].textContent = "玩家3"
    };
    p1Total = 0;
    p2Total = 0;
    p3Total = 0;
    displayTotalAndReset();
});

