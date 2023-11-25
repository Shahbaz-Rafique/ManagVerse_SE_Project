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
// router.get("/done", async (req, res) => {
// 	try {
// 		for (let i = 1; i <= 30; i++) {
// 			const dummyBook = {
// 				name: `Book ${i}`,
// 				publisher: `Publisher ${(i % 5) + 1}`,
// 				author: `Author ${(i % 7) + 1}`,
// 				category: i % 2 === 0 ? "novel" : "comics",
// 				isContinue: i % 2 === 0,
// 				active: i % 3 === 0,
// 				Reader: [`Reader${(i % 3) + 1}`, `Reader${(i % 3) + 2}`],
// 				Downloader: [`Downloader${(i % 3) + 1}`, `Downloader${(i % 3) + 2}`],
// 				chapters: [`Chapter${(i % 5) + 1}`, `Chapter${(i % 5) + 2}`],
// 				summery: `Summary ${i}`,
// 				images: [`https://picsum.photos/200/300?random=${i + 1}`, `https://picsum.photos/200/300?random=${i + 10}`],
// 				novel_rating: [
// 					Math.floor(Math.random() * 5) + 1,
// 					Math.floor(Math.random() * 5) + 1,
// 				],
// 				availability: i % 4 === 0,
// 				iSBN: `ISBN-${(i % 3) + 1}-${(i % 4) + 1}`,
// 				language: i % 2 === 0 ? "English" : "Spanish",
// 				genre: i % 3 === 0 ? "Fiction" : "Non-Fiction",
// 			};
// 			await bookModel.create(dummyBook);
// 			console.log(i);
// 		}
// 		res.status(200).send({ data: [], message: "Successful", status: "ok" });
// 	} catch (e) {
// 		res.status(505).send({ data: null, message: e.message, status: "error" });
// 	}
// });
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
		let addBook = await bookModel.findByIdAndUpdate(id, req.body);
		res
			.status(200)
			.send({ data: addBook, message: "Successful", status: "ok" });
	} catch (e) {
		console.log(e);
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
});
router.put("/continue/:id", async (req, res) => {
	try {
		const { id } = req.params;
		let addBook = await bookModel.findByIdAndUpdate(id, req.body);
		res.status(200).send({ data: null, message: "Successful", status: "ok" });
	} catch (e) {
		console.log(e);
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
});
router.delete("/", (req, res) => {});
module.exports = router;
