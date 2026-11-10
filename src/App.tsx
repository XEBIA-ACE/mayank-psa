import { Route, Routes } from 'react-router-dom';
import { Placeholder } from './pages/Placeholder';
import { ShellProviders } from './shell';

export const routes = [
  { path: '/book/*', name: 'booking-flow-web' },
  { path: '/stylist/*', name: 'stylist-app-web' },
  { path: '/manager/*', name: 'store-manager-web' },
  { path: '/ops/*', name: 'ops-reporting-web' },
];

export function App() {
  return (
    <ShellProviders>
      <Routes>
        {routes.map((r) => (
          <Route key={r.path} path={r.path} element={<Placeholder name={r.name} />} />
        ))}
        <Route path="*" element={<Placeholder name="frontend-app" />} />
      </Routes>
    </ShellProviders>
  );
}
