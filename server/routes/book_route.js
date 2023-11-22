const express = require("express");
const router = express.Router();
const { bookModel } = require("../models/book_schema");
router.get("/", async (req, res) => {
	try {
		const { active } = req.query;
		let query = {};

		if (active !== undefined) {
			query.active = active === "true";
		}

		let book = await bookModel.find(query);
		res.status(200).send({ data: book, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
});
router.post("/", async (req, res) => {
	try {
		console.log(req.body);
		let addBook = await bookModel.create(req.body);
		res
			.status(201)
			.send({ data: addBook, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
});
router.put("/:id", async (req, res) => {
	try {
		const { id } = req.params;
		console.log(req.body);
		let addBook = await bookModel.findByIdAndUpdate(id, req.body);
		res.status(200).send({ data: null, message: "Successful", status: "ok" });
	} catch (e) {
		console.log(e);
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
});
router.put("/active/:id", async (req, res) => {
	try {
		const { id } = req.params;
		console.log(req.body);
		let addBook = await bookModel.findByIdAndUpdate(id, req.body);
		res.status(200).send({ data: null, message: "Successful", status: "ok" });
	} catch (e) {
		console.log(e);
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
});
router.put("/continue/:id", async (req, res) => {
	try {
		const { id } = req.params;
		console.log(req.body);
		let addBook = await bookModel.findByIdAndUpdate(id, req.body);
		res.status(200).send({ data: null, message: "Successful", status: "ok" });
	} catch (e) {
		console.log(e);
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
});
router.delete("/", (req, res) => {});
module.exports = router;
