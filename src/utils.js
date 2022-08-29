import { config } from "@onflow/fcl";
import { readJSON, writeJSON } from "./json";
import { parseFile } from "./parser";

export const setNetwork = (network = "testnet") => {
  const invalidName = network !== "testnet" && network !== "mainnet";
  const net = invalidName ? "testnet" : network;
  config({ "accessNode.api": `https://rest-${net}.onflow.org` });
};

export const getAccount = (name) => {
  const content = readJSON(`./keys/${name}.private.json`);
  return content.accounts[name];
};

export const processCSV = (
  input = "./data.csv",
  output = "./accounts.json"
) => {
  const [data, err] = parseFile(input);
  if (data) {
    const keys = Object.keys(data);
    for (const key of keys) {
      const { testnet, mainnet, email } = data[key];
      data[key] = {
        email,
        mainnet: {
          address: mainnet,
          checked: false,
          floatInitialized: false,
          floatDistributed: false,
        },
        testnet: {
          address: testnet,
          checked: false,
          yearbookCreated: false,
          yearbookSigned: false,
        },
      };
    }
    writeJSON(output, data);
  } else {
    console.error(e);
  }
};

export const checkQuest = (filename = "./accounts.json") => {
  const json = readJSON(filename);
  for (const key in json) {
    const { testnet } = json[key];
    const { checked, address } = testnet;
    if(!checked){
      console.log(`Check ${address} for Yearbook`)
    }
  }
};
