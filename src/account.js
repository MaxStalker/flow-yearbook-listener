import { readJSON } from "./json";

export const getAccount = (name) => {
  const content = readJSON(`./keys/${name}.private.json`);
  return content.accounts[name];
};
