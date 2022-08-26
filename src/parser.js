import { readFileSync } from "fs";

const noSpaces = line => line.replace(/\s/g, "");
const commaSplit = line => noSpaces(line).split(',');

export const parseFile = (file) => {
  try {
    const fileContent = readFileSync(file, "utf8");
    const [,...data] = fileContent.split("\n");
    const final = data.reduce((acc, line)=>{
      const [testnet, mainnet, email] = commaSplit(line);
      acc[testnet]= {
        testnet,
        mainnet,
        email
      }
      return acc
    },{})
    return [final, null];
  } catch (e) {
    return [null, e];
  }
};

export const loadCadenceFile = (file) => {
  try {
    const fileContent = readFileSync(`./cadence/${file}.cdc`, "utf8");
    return [fileContent, null]
  } catch (e) {
    return [null, e]
  }
  }