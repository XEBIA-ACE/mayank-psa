export interface AppConfig {
  apiBaseUrl: string;
  analyticsEndpoint: string;
  defaultLocale: string;
  featureFlags: Record<string, boolean>;
}

type Env = Record<string, string | undefined>;

export function loadConfig(env: Env = import.meta.env): AppConfig {
  const flags = (env.VITE_FEATURE_FLAGS ?? '')
    .split(',')
    .map((f) => f.trim())
    .filter(Boolean);
  return {
    apiBaseUrl: env.VITE_API_BASE_URL ?? '',
    analyticsEndpoint: env.VITE_ANALYTICS_ENDPOINT ?? '',
    defaultLocale: env.VITE_DEFAULT_LOCALE ?? '',
    featureFlags: Object.fromEntries(flags.map((f) => [f, true])),
  };
}

export const config = loadConfig();
