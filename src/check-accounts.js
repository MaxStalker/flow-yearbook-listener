import { parseFile } from "./parser";
import { writeJSON } from "./json";

const [data, err] = parseFile("./data.csv");
if (data) {
  const keys = Object.keys(data);
  for (const key of keys) {
    const { testnet, mainnet, email } = data[key];
    data[key] = {
      email,
      mainnet: {
        address: mainnet,
        floatInitialized: false,
        floatDistributed: false,
      },
      testnet: {
        address: testnet,
        yearbookCreated: false,
        yearbookSigned: false,
      },
    };
  }
  writeJSON("./accounts.json", data);
} else {
  console.error(e);
}
