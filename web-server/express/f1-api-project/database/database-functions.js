import fs from "fs";
export function save(list) {
  const data = `export const driversInRandomOrder = ${JSON.stringify(
    list,
    null,
    2
  )}\nexport const driversOrdered = driversInRandomOrder.sort((a, b) => b.points - a.points)`;

  fs.writeFile("./database/script.js", data, (err) => {
    if (err) {
      console.log(`Error to save data: ${err}`);
      return;
    }

    console.log("Data saved.");
  });
}
