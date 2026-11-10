import type { ReactNode } from 'react';

// Shell-level wiring point for @brand/design-system, @brand/analytics-client,
// @brand/i18n and @brand/event-bus. These packages are not resolvable from the
// repository baseline, so providers are intentionally not wired yet.
export function ShellProviders({ children }: { children: ReactNode }) {
  return <>{children}</>;
}
