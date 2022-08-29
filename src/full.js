import { getAccount, processCSV, setNetwork, checkQuest } from "./utils";

(async () => {
  // This will import ./data.csv file and export to accounts.json file
  processCSV();
  checkQuest();
})();
