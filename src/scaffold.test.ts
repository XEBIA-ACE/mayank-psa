import request from 'supertest';
import { describe, expect, it } from 'vitest';
import { createApp } from './app';
import { loadConfig } from './config';
import { checkDb } from './db';

describe('scaffold', () => {
  it('GET /health returns 200', async () => {
    const res = await request(createApp()).get('/health');
    expect(res.status).toBe(200);
    expect(res.body).toEqual({ status: 'ok' });
  });

  it('loadConfig reads from env and applies defaults', () => {
    const cfg = loadConfig({ DATABASE_URL: 'postgres://u:p@pgbouncer:6432/db' });
    expect(cfg.PORT).toBe(3000);
    expect(cfg.DB_POOL_MAX).toBe(10);
  });

  it('loadConfig rejects missing DATABASE_URL', () => {
    expect(() => loadConfig({})).toThrow(/DATABASE_URL/);
  });

  it('checkDb reflects query outcome', async () => {
    expect(await checkDb({ query: async () => ({}) as never })).toBe(true);
    expect(
      await checkDb({
        query: async () => {
          throw new Error('down');
        },
      }),
    ).toBe(false);
  });
});
