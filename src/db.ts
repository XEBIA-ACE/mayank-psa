import { Pool } from 'pg';
import type { Config } from './config';

/**
 * Creates a PostgreSQL pool configured from environment-derived config.
 * PgBouncer compatibility: keep the client pool small, avoid session state
 * (no named prepared statements, no session-level SET), and use short idle timeouts.
 */
export function createPool(config: Config): Pool {
  return new Pool({
    connectionString: config.DATABASE_URL,
    max: config.DB_POOL_MAX,
    idleTimeoutMillis: config.DB_POOL_IDLE_TIMEOUT_MS,
    connectionTimeoutMillis: config.DB_POOL_CONNECTION_TIMEOUT_MS,
  });
}

export async function checkDb(pool: Pick<Pool, 'query'>): Promise<boolean> {
  try {
    await pool.query('SELECT 1');
    return true;
  } catch {
    return false;
  }
}
