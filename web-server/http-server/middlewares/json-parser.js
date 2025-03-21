/**
  Dentro do http.createServer() o body.json() não funciona, pois
  o Node.js não processa automaticamente o corpo das requisições. 
  Logo foi necessário criar esse método 
  para garantir os valores da
  requisição como json ao invés de string 
**/

export const parseJsonBody = (req, callback) => {
  let body = "";

  req.on("data", (chunk) => {
    body += chunk.toString();
  });

  req.on("end", () => {
    try {
      const data = JSON.parse(body);
      callback(null, data);
    } catch (error) {
      callback(error, null);
    }
  });
};
