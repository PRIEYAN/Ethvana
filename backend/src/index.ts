import express, { Request, Response } from 'express';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 8000;

app.use(express.json());

app.get('/health', (_req: Request, res: Response) => {
  res.status(200).json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.get('/', (_req: Request, res: Response) => {
  res.json({ message: 'Ethvana Backend API' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
