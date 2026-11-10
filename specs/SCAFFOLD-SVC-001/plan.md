# Implementation Plan: SCAFFOLD-SVC-001

## Technical Context

**Primary stack (frontend shell):**
- Next.js 14+ (App Router), React 18, TypeScript
- Tailwind CSS / CSS Modules
- Shared Design System Component Library (internal React package)
- SWR / React Query (server-state management)
- React Context (lightweight client state for cart and consent)
- Webpack / Turbopack
- Next.js Bundle Analyzer (CI enforcement)
- OpenTelemetry (client-side RUM instrumentation)
- Vercel / AWS (hosting origin)

**Backend/infrastructure constraints also declared in the implementation specification:**
- Node.js (TypeScript) or Java (Spring Boot / Kotlin)
- PostgreSQL (primary transactional store, AES-256 encryption at rest, outbox table, event log)
- Redis 7+ Cluster (slot holds with 10-min TTL, SETNX distributed locks, idempotency key store)
- Apache Kafka (domain event publication via Outbox Relay)
- PgBouncer (connection pooling)
- OpenTelemetry (distributed tracing)
- AWS KMS / HashiCorp Vault (encryption key management)

**Platform**: backend (as declared in implementation constraints).

---

## Scaffold Setup Steps

1. Set up the project skeleton for this stack: dependency manifest, entrypoint, and linting/formatting config.
2. Add environment-based configuration loading (no hardcoded secrets or endpoints).
3. Add a health-check endpoint so the service can be verified as running locally.
4. Add a database connection helper for the stack's datastore, configured via environment variables.

---

## Contract Changes

No material API, event, or data contract change is evidenced in the source artifacts.

---

## Security and Quality

- **Security**: Validate credential and personal-data handling against the story's acceptance criteria.
- **Quality / Accessibility**: Verify the changed user flow against the stated accessibility criteria.

---

## Verification Plan

- **AC-1**: Scaffold the Next.js Frontend Shell (business) per its approved architecture. Technology stack: Next.js 14+ (App Router), React 18, TypeScript, Tailwind CSS / CSS Modules, Shared Design System Component Library (internal React package), SWR / React Query (server-state management), React Context (lightweight client state for cart and consent), Webpack / Turbopack, Next.js Bundle Analyzer (CI enforcement), OpenTelemetry (client-side RUM instrumentation), Vercel / AWS (hosting origin). Responsibilities: Render all public-facing pages using the appropriate rendering strategy (SSG, ISR, SSR) per route type; Host and compose all domain-specific UI feature areas: marketing site, product catalogue, support centre, resource centre, account hub, dealer locator, e-commerce, and search; Enforce shared design system and accessible navigation structure (WCAG 2.1 AA disclosure-pattern mega-menus) across all pages; Enforce JS bundle performance budget (≤170 KB gzipped per route) via code splitting and lazy loading; Lazy-load images with responsive srcsets and preload subsetted fonts for Core Web Vitals optimisation; Integrate CMP SDK to read consent state and conditionally load Tag Manager and analytics scripts; Implement client-side progressive profiling cookie/localStorage reads (consent-gated); Render A/B test variants assigned at CDN edge via feature flags without client-side flicker; Initiate OIDC/OAuth2 PKCE authentication flows against CIAM provider for customer login and registration; Implement gated content download flow: submit lead form, receive BFF-issued token, trigger download; Render dealer locator map UI with radius-based results from BFF; Render structured data markup (JSON-LD), canonical tags, noindex flags, and XML sitemap links for SEO; Implement on-demand ISR revalidation triggered by CMS publish webhooks for immediate content freshness; Render account hub: order history, reorder, saved addresses, support ticket list and detail; Implement global search bar with debounced autocomplete and faceted search results page; Implement driver/firmware finder with browser OS auto-detection for support centre; Push conversion events (lead submissions, purchases, downloads) to Tag Manager data layer. Ground the generated spec in this service's own C3/C4 diagrams and API spec already on file in Architecture, not just this summary.

**Expected evidence**: test result for AC-1

---

## Provenance

- **Policy version**: `ace-spec-format/v1`
- **Repository baseline commit**: `cf9d1cf0462ea370be834930260db4a1df5c0af1`
- **Accepted impact hash**: *(none — no impact revision accepted)*
