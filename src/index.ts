import { createApp } from './app';
import { loadConfig } from './config';
import { createPool } from './db';

const config = loadConfig();
const pool = createPool(config);
const server = createApp().listen(config.PORT, () => {
  console.log(`booking-service listening on port ${config.PORT}`);
});

function shutdown(): void {
  server.close(() => {
    void pool.end().finally(() => process.exit(0));
  });
}
process.on('SIGTERM', shutdown);
process.on('SIGINT', shutdown);
