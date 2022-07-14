const cds = require("@sap/cds");
const bodyParser = require("body-parser");

cds.on("bootstrap", app => {

	app.use("/rest", bodyParser.urlencoded({
		extended: true
	}));
	app.use("/rest", bodyParser.json());

	app.post("/rest/callback", (request, response) => {
		console.log(request.body);
		response.status(200).send({ stats: "Success!" });
	});
});

module.exports = cds.server;