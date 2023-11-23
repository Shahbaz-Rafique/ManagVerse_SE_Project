const express = require("express");
const { chapterModel } = require("../models/chapter_schema");
const { bookModel } = require("../models/book_schema");
const router = express.Router();

router.post("/", async (req, res) => {
	try {
		const { bookId } = req.body;
		console.log(req.body);
		let chp = await chapterModel.create(req.body);
		let book = await bookModel.findByIdAndUpdate(
			bookId,
			{ $push: { chapters: chp.id } },
			{ new: true }
		);

		res.status(201).send({ data: chp, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
});
router.get("/:id", async (req, res) => {
	try {
		const { active } = req.query;
		const { id } = req.params;
		console.log(id);
		let query = {};
		if (active !== undefined) {
			query.active = active === "true";
		}
		var bookArray = [];
		let book = await bookModel.findById(id);
		// Use Promise.all to wait for all promises to resolve
		await Promise.all(
			book.chapters.map(async (e) => {
				var chp = await chapterModel.findById(e);
				bookArray.push(chp);
			})
		);
		console.log(bookArray);
		res
			.status(200)
			.send({ data: bookArray, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
});
router.put("/", (req, res) => {});
router.delete("/", (req, res) => {});
module.exports = router;
