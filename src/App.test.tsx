import { render, screen } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { describe, expect, it } from 'vitest';
import { App, routes } from './App';
import { loadConfig } from './config';

describe('AC-1 route shell', () => {
  it.each(routes)('renders $name at $path', ({ path, name }) => {
    render(
      <MemoryRouter initialEntries={[path.replace('/*', '/x')]}>
        <App />
      </MemoryRouter>,
    );
    expect(screen.getByRole('heading').textContent).toBe(name);
  });

  it('reads config from env only', () => {
    const c = loadConfig({ VITE_API_BASE_URL: 'u', VITE_FEATURE_FLAGS: 'a, b' });
    expect(c.apiBaseUrl).toBe('u');
    expect(c.featureFlags).toEqual({ a: true, b: true });
  });
});
