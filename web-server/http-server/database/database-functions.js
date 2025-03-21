import fs from "fs";
export function save(object) {
  const data = `export const product = ${JSON.stringify(object, null, 2)};`;

  fs.writeFile("./database/product.js", data, (err) => {
    if (err) {
      console.error("products save error:", err);
      return;
    }
    console.log("Products saved.");
  });
}
