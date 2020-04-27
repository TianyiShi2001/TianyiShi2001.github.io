var express = require("express"),
	app = express(),
	mongoose = require("mongoose"),
	bodyParser = require("body-parser");

express.urlencoded({extended: true});

mongoose.connect("mongodb://localhost/blog");

var catSchema = new mongoose.Schema({
	name: String,
	age: Number
});

/* var Cat = mongoose.model("Cat", catSchema);

var alan = new Cat({
	name: "Alan",
	age: 10
});

alan.save(function(err, cat) {
	if (err) {
		console.log("wrong");
	} else {
		console.log(cat);
	}
}); */

Cat.create(
	{
		name: "Alan",
		age: 10
	},
	function(err, cat) {
		if (err) {
			console.log("wrong");
		} else {
			console.log(cat);
		}
	}
);



app.use(express.static("public"));
app.set("view engine", "ejs");

app.get("/", function(req, res) {
	res.render("home");
});

app.listen(3000, function() {
	console.log("started!");
});
