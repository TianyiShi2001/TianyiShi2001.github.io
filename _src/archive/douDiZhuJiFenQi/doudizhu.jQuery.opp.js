var p1Total = 0;
var p2Total = 0;
var p3Total = 0;

var p1Display = $("#player1Display");
var p2Display = $("#player2Display");
var p3Display = $("#player3Display");

p1Display.textContent = p1Total;
p2Display.textContent = p2Total;
p3Display.textContent = p3Total;

var p1NameAll = $(".player1Name");
var p2NameAll = $(".player2Name");
var p3NameAll = $(".player3Name");

//=================================================================

$("#nameSet").on("change", function() {
	$(".player1Name").text($("#player1NameSet").val());
	$(".player2Name").text($("#player2NameSet").val());
	$(".player3Name").text($("#player3NameSet").val());
});

//=================================================================

difen = 1;

$("#difen").on("change", function() {
	difen = Number($("#difen").val());
	benjuUpdate();
});

function difenreset() {
	difen = 1;
	$("#difen").val(1);
}

//=================================================================

var beishu = 1;

$("#erbei").on("click", function() {
	beishu *= 2;
	$("#beishu").text(beishu);
	benjuUpdate();
});

$("#sanbei").on("click", function() {
	beishu *= 3;
	$("#beishu").text(beishu);
	benjuUpdate();
});

$("#sibei").on("click", function() {
	beishu *= 4;
	$("#beishu").text(beishu);
	benjuUpdate();
});

//=================================================================

var benju = 1;

function benjuUpdate() {
	benju = beishu * difen;
	$("#benju").text(benju);
}

$("#benju").text(benju);

//=================================================================

var dizhu = "none";

nodizhu = dizhu === "none";

$("#dizhu1").on("click", function() {
	dizhu = "dizhuplayer1";
	nodizhu = dizhu === "none";
	$("#dizhu2").addClass("disabled");
	$("#dizhu3").addClass("disabled");
});

$("#dizhu2").on("click", function() {
	dizhu = "dizhuplayer2";
	nodizhu = dizhu === "none";
	$("#dizhu1").addClass("disabled");
	$("#dizhu3").addClass("disabled");
});

$("#dizhu3").on("click", function() {
	dizhu = "dizhuplayer3";
	nodizhu = dizhu === "none";
	$("#dizhu1").addClass("disabled");
	$("#dizhu2").addClass("disabled");
});

//=================================================================

function displayTotalAndReset() {
	p1Display.text(p1Total);
	p2Display.text(p2Total);
	p3Display.text(p3Total);
	beishu = 1;
	$("#beishu").text(beishu);
	benjuUpdate();
	$("#dizhu1").removeClass("disabled");
	$("#dizhu2").removeClass("disabled");
	$("#dizhu3").removeClass("disabled");
	dizhu = "none";
	nodizhu = dizhu === "none";
}

$("#player1Wins").on("click", function() {
	if (nodizhu) {
		alert("请设置地主");
	} else {
		if (dizhu === "dizhuplayer1") {
			p1Total += benju * 2;
			p2Total -= benju;
			p3Total -= benju;
			displayTotalAndReset();
		} else if (dizhu === "dizhuplayer2") {
			p1Total += benju;
			p2Total -= benju * 2;
			p3Total += benju;
			displayTotalAndReset();
		} else {
			p1Total += benju;
			p2Total += benju;
			p3Total -= benju * 2;
			displayTotalAndReset();
		}
	}
});

$("#player2Wins").on("click", function() {
	if (nodizhu) {
		alert("请设置地主");
	} else {
		if (dizhu === "dizhuplayer2") {
			p1Total -= benju;
			p2Total += benju * 2;
			p3Total -= benju;
			displayTotalAndReset();
		} else if (dizhu === "dizhuplayer1") {
			p1Total -= benju * 2;
			p2Total += benju;
			p3Total += benju;
			displayTotalAndReset();
		} else {
			p1Total += benju;
			p2Total += benju;
			p3Total -= benju * 2;
			displayTotalAndReset();
		}
	}
});

$("#player3Wins").on("click", function() {
	if (nodizhu) {
		alert("请设置地主");
	} else {
		if (dizhu === "dizhuplayer3") {
			p1Total -= benju;
			p2Total -= benju;
			p3Total += benju * 2;
			displayTotalAndReset();
		} else if (dizhu === "dizhuplayer1") {
			p1Total -= benju * 2;
			p2Total += benju;
			p3Total += benju;
			displayTotalAndReset();
		} else {
			p1Total += benju;
			p2Total -= benju * 2;
			p3Total += benju;
			displayTotalAndReset();
		}
	}
});

//=================================================================

$("#chongzhi").on("click", function() {
	$(".player1Name").text("玩家1");
	$(".player2Name").text("玩家2");
	$(".player3Name").text("玩家3");
	p1Total = 0;
	p2Total = 0;
	p3Total = 0;
	difen = 1;
	displayTotalAndReset();
	difenreset();
	nameClear();
});

function nameClear() {
	$("#player1NameSet").val("");
	$("#player2NameSet").val("");
	$("#player3NameSet").val("");
}
