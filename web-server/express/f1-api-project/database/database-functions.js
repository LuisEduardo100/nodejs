import fs from "fs";
export function save(list) {
  const data = `export const driversInRandomOrder = ${JSON.stringify(
    list,
    null,
    2
  )}
  \n\n
  export const driversOrdered = driversInRandomOrder.sort((a, b) => b.points - a.points)
  
  export const teams = driversInRandomOrder
    .reduce((acc, object) => {
      const { team, points } = object;
      const teamObject = acc.find((t) => t.team === object.team);
      teamObject
        ? (teamObject.points += object.points)
        : acc.push({ team, points });
      return acc;
    }, [])
    .sort((a, b) => b.points - a.points);
  `;

  fs.writeFile("./database/script.js", data, (err) => {
    if (err) {
      console.log(`Error to save data: ${err}`);
      return;
    }

    console.log("Data saved.");
  });
}
