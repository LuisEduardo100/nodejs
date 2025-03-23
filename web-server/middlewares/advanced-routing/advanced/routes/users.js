import express from 'express';
import { users } from '../data.js';

const router = express.Router();

router
  .route('/')
  .get((req, res) => {
    //todo um processamento antes de entregar a resposta
    res.status(200).send(users);
  })
  .post((req, res) => {
    res.status(200).send('novo usuário criado');
  })
  .put((req, res) => {
    res.status(200).send('usuário editado');
  })
  .delete((req, res) => {
    res.status(200).send('usuário apagado');
  });

export default router;
