# API Express - Estrutura RESTful

Esta pasta contém códigos que utilizam o Express.js, seguindo os princípios do REST (Representational State Transfer) para a gestão de dados.

## Princípios REST

### Flexibilidade
A API é projetada para ser flexível, permitindo que novos recursos sejam adicionados facilmente sem comprometer a estrutura atual.

### Organização
A estrutura do código segue as melhores práticas de separação de responsabilidades, garantindo que cada módulo ou rota tenha uma responsabilidade clara e fácil manutenção.

### Latência/Eficiência
A API foi desenvolvida para ser eficiente, minimizando a latência nas requisições.

### Escalabilidade
A arquitetura da API permite escalabilidade horizontal, facilitando o crescimento do sistema sem comprometer o desempenho.

### Stateless
Toda requisição deve conter toda a informação necessária para o seu atendimento. Não há estado armazenado entre as requisições.

## Métodos HTTP (Create-Read-Update-Delete)

```javascript
  const users = [
    { id: 1, name: 'John Doe', email: 'john@example.com' },
    { id: 2, name: 'Jane Doe', email: 'jane@example.com' }
  ];
```

### **GET**: Recupera informações
#### Exemplo de uso com Express.js:

- **Requisição**: `GET /users`
- **Descrição**: Recupera todos os usuários cadastrados.
- **Código**:
  ```javascript
  app.get('/users', (req, res) => {
    res.status(200).json(users);
  });

#### Exemplo sem Express.js: 

- **Código**:
  ```javascript
  const server = http.createServer((req, res) => {
    const { method, url: requestUrl } = req;
    
    if (method === 'GET' && requestUrl === '/users') {
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify(users));
    } else {
      res.writeHead(404);
      res.end('Not Found');
    }
  });
- **POST**: Cria novas informações. Exemplo de uso:
#### Exemplo de uso com Express.js:

- **Requisição**: POST /users
- **Descrição**: Cria um novo usuário.
- **Código**:
  ```javascript
  app.post('/users', (req, res) => {
    const { name, email } = req.body;
    const newUser = { id: users.length + 1, name, email };
    users.push(newUser);
    res.status(201).json(newUser);
  });

#### Exemplo de uso sem Express.js: 
- **Código**:
  ```javascript
  const server = http.createServer((req, res) => {
  if (req.method === 'POST' && req.url === '/users') {
    let body = '';

    req.on('data', chunk => {
      body += chunk;
    });

    req.on('end', () => {
      const { name, email } = JSON.parse(body);
      const newUser = { id: users.length + 1, name, email };
      users.push(newUser);

      res.writeHead(201, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify(newUser));
    });
  } else {
    res.writeHead(404);
    res.end('Not Found');
  }
});
  
- **PUT**: Atualiza um item existente com novas informações. Exemplo de uso:
#### Exemplo de uso com Express.js:
- **Requisição**: PUT /users/:id
- **Descrição**: Atualiza as informações de um usuário.
- **Código**:
  ```javascript
  app.put('/users/:id', (req, res) => {
  const user = users.find(u => u.id === parseInt(req.params.id));
  if (!user) return res.status(404).send('Usuário não encontrado');

  const { name, email } = req.body;
  if (name) user.name = name;
  if (email) user.email = email;

  res.status(200).json(user);
});

#### Exemplo de uso sem Express.js:
- **Código**:
  ```javascript:
  const server = http.createServer((req, res) => {
  if (req.method === 'PUT' && req.url.startsWith('/users/')) {
    const userId = parseInt(req.url.split('/')[2]);
    const user = users.find(u => u.id === userId);

    if (!user) {
      res.writeHead(404);
      res.end('Usuário não encontrado');
      return;
    }

    let body = '';
    req.on('data', chunk => {
      body += chunk;
    });

    req.on('end', () => {
      const { name, email } = JSON.parse(body);
      if (name) user.name = name;
      if (email) user.email = email;

      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify(user));
    });
  } else {
    res.writeHead(404);
    res.end('Not Found');
  }
});

- **DELETE**: Deleta informações. Exemplo de uso:
#### Exemplo de uso com Express.js:
- **Requisição**: DELETE /users/:id
- **Descrição**: Deleta um usuário específico.
- **Código**:
  ```javascript
  app.delete('/users/:id', (req, res) => {
  const userIndex = users.findIndex(u => u.id === parseInt(req.params.id));
  if (userIndex === -1) return res.status(404).send('Usuário não encontrado');
  
  users.splice(userIndex, 1);
  res.status(204).send();
});

#### Exemplo de uso sen Express.js:
- **Código**:
  ```javascript
  const server = http.createServer((req, res) => {
  if (req.method === 'DELETE' && req.url.startsWith('/users/')) {
    const userId = parseInt(req.url.split('/')[2]);
    const userIndex = users.findIndex(u => u.id === userId);

    if (userIndex === -1) {
      res.writeHead(404);
      res.end('Usuário não encontrado');
      return;
    }

    users.splice(userIndex, 1);
    res.writeHead(204);
    res.end();
  } else {
    res.writeHead(404);
    res.end('Not Found');
  }
});

## Códigos de Resposta

- **2xx** - Sucesso: Indica que a requisição foi bem-sucedida.
- 200 OK
- 201 Created
- **3xx** - Redirecionamento: A requisição precisa de mais ações para ser completada.
- 301 Moved Permanently
- **4xx** - Erro na Requisição: Ocorre quando o cliente envia uma requisição inválida.
- 400 Bad Request
- 404 Not Found
- **5xx** - Erro no Servidor: Ocorre quando há falha no servidor.
- 500 Internal Server Error
