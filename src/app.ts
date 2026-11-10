import express from 'express';

export function createApp(): express.Express {
  const app = express();
  app.disable('x-powered-by');

  // Liveness: returns 200 whenever the process is serving requests.
  app.get('/health', (_req, res) => {
    res.status(200).json({ status: 'ok' });
  });

  return app;
}
