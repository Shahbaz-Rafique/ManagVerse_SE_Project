const express = require("express");
const router = express.Router();
const { bookModel } = require("../models/book_schema");
router.get("/", async (req, res) => {
	try {
		let book = await bookModel.find({ active: true });
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
router.put("/", (req, res) => {});
router.delete("/", (req, res) => {});
module.exports = router;
