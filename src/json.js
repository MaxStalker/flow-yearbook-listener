import fs from "fs";

export const readJSON = (filePath) => {
	let rawdata = fs.readFileSync(filePath);
	return JSON.parse(rawdata);
};

export const writeJSON = (filePath, data) => {
	let raw = JSON.stringify(data, null, 2);
	fs.writeFileSync(filePath, raw);
	console.log(`${filePath} is updated with new data`);
};
