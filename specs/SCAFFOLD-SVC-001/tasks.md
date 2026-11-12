# Tasks: SCAFFOLD-SVC-001

> All tasks below are independently reviewable. Complete T001–T004 (scaffold setup) before T005–T021 (feature implementation). T022 is the final verification gate.

---

## Scaffold Setup

- [ ] **T001** Set up the project skeleton for this stack: dependency manifest, entrypoint, and linting/formatting config.
- [ ] **T002** Add environment-based configuration loading (no hardcoded secrets or endpoints).
- [ ] **T003** Add a health-check endpoint so the service can be verified as running locally.
- [ ] **T004** Add a database connection helper for the stack's datastore, configured via environment variables.

---

## Feature Implementation (AC-1)

- [ ] **T005** Configure Next.js 14+ App Router with TypeScript; establish rendering strategy (SSG / ISR / SSR) per route type.
- [ ] **T006** Integrate Shared Design System Component Library (internal React package) and configure Tailwind CSS / CSS Modules.
- [ ] **T007** Implement accessible navigation structure: WCAG 2.1 AA disclosure-pattern mega-menus across all pages.
- [ ] **T008** Enforce JS bundle performance budget (≤170 KB gzipped per route) via code splitting, lazy loading, and Next.js Bundle Analyzer in CI.
- [ ] **T009** Implement lazy-loaded images with responsive srcsets; preload subsetted fonts for Core Web Vitals optimisation.
- [ ] **T010** Integrate CMP SDK: read consent state and conditionally load Tag Manager and analytics scripts.
- [ ] **T011** Implement client-side progressive profiling cookie/localStorage reads (consent-gated).
- [ ] **T012** Render A/B test variants assigned at CDN edge via feature flags without client-side flicker.
- [ ] **T013** Initiate OIDC/OAuth2 PKCE authentication flows against CIAM provider for customer login and registration.
- [ ] **T014** Implement gated content download flow: submit lead form → receive BFF-issued token → trigger download.
- [ ] **T015** Render dealer locator map UI with radius-based results from BFF.
- [ ] **T016** Render structured data markup (JSON-LD), canonical tags, noindex flags, and XML sitemap links for SEO.
- [ ] **T017** Implement on-demand ISR revalidation triggered by CMS publish webhooks for immediate content freshness.
- [ ] **T018** Render account hub: order history, reorder, saved addresses, support ticket list and detail.
- [ ] **T019** Implement global search bar with debounced autocomplete and faceted search results page.
- [ ] **T020** Implement driver/firmware finder with browser OS auto-detection for support centre.
- [ ] **T021** Push conversion events (lead submissions, purchases, downloads) to Tag Manager data layer.

---

## Security & Quality Gates

- [ ] **T022-SEC** Validate credential and personal-data handling against AC-1 acceptance criteria.
- [ ] **T022-A11Y** Verify the changed user flow against the stated accessibility criteria (WCAG 2.1 AA).

---

## Verification

- [ ] **T023** Verify AC-1 end-to-end: confirm all responsibilities listed in AC-1 are demonstrably met. Produce test result evidence for AC-1.

  > **AC-1 full text**: Scaffold the Next.js Frontend Shell (business) per its approved architecture. Technology stack: Next.js 14+ (App Router), React 18, TypeScript, Tailwind CSS / CSS Modules, Shared Design System Component Library (internal React package), SWR / React Query (server-state management), React Context (lightweight client state for cart and consent), Webpack / Turbopack, Next.js Bundle Analyzer (CI enforcement), OpenTelemetry (client-side RUM instrumentation), Vercel / AWS (hosting origin). Responsibilities: Render all public-facing pages using the appropriate rendering strategy (SSG, ISR, SSR) per route type; Host and compose all domain-specific UI feature areas: marketing site, product catalogue, support centre, resource centre, account hub, dealer locator, e-commerce, and search; Enforce shared design system and accessible navigation structure (WCAG 2.1 AA disclosure-pattern mega-menus) across all pages; Enforce JS bundle performance budget (≤170 KB gzipped per route) via code splitting and lazy loading; Lazy-load images with responsive srcsets and preload subsetted fonts for Core Web Vitals optimisation; Integrate CMP SDK to read consent state and conditionally load Tag Manager and analytics scripts; Implement client-side progressive profiling cookie/localStorage reads (consent-gated); Render A/B test variants assigned at CDN edge via feature flags without client-side flicker; Initiate OIDC/OAuth2 PKCE authentication flows against CIAM provider for customer login and registration; Implement gated content download flow: submit lead form, receive BFF-issued token, trigger download; Render dealer locator map UI with radius-based results from BFF; Render structured data markup (JSON-LD), canonical tags, noindex flags, and XML sitemap links for SEO; Implement on-demand ISR revalidation triggered by CMS publish webhooks for immediate content freshness; Render account hub: order history, reorder, saved addresses, support ticket list and detail; Implement global search bar with debounced autocomplete and faceted search results page; Implement driver/firmware finder with browser OS auto-detection for support centre; Push conversion events (lead submissions, purchases, downloads) to Tag Manager data layer. Ground the generated spec in this service's own C3/C4 diagrams and API spec already on file in Architecture, not just this summary.

---

## Provenance

- **Policy version**: `ace-spec-format/v1`
- **Repository baseline commit**: `cf9d1cf0462ea370be834930260db4a1df5c0af1`
- **Accepted impact hash**: *(none — no impact revision accepted)*
