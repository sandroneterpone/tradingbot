# Institutional Trading System Scaffold

This repository is a **production-oriented scaffold** for an institutional-style automated trading platform.
It is **not** a finished institutional trading system and it is **not** safe to use with real capital without:
- venue-specific adapter hardening
- full reconciliation against real broker/exchange statements
- secrets management and HSM/MPC integration
- production security review
- incident drills
- realistic backtesting, shadow deployment, and paper-trading validation
- legal/compliance review for the jurisdictions and venues you will use

What is included:
- FastAPI application with modular domain boundaries
- SQLAlchemy persistence layer
- market data ingestion
- simple feature engineering
- strategy intent generation
- portfolio suggestion
- pre-trade risk engine
- OMS state machine
- mock execution adapter
- treasury request / approval / execution workflow
- reconciliation endpoint
- audit trail persistence
- admin controls including kill switch
- sample config, Docker compose, Makefile, tests

## Quick start

```bash
python -m venv .venv
source .venv/bin/activate
pip install -e .[dev]
cp .env.example .env
uvicorn app.main:app --reload
```

Docs:
- `config/system.example.yaml`
- `docs/architecture.md`
- `docs/operating_assumptions.md`

## API overview

- `GET /api/v1/health`
- `POST /api/v1/instruments`
- `POST /api/v1/market/ticks`
- `POST /api/v1/strategy/evaluate`
- `POST /api/v1/risk/pretrade`
- `POST /api/v1/orders`
- `GET /api/v1/orders/{order_id}`
- `POST /api/v1/treasury/transfers`
- `POST /api/v1/treasury/transfers/{transfer_id}/approve`
- `POST /api/v1/treasury/transfers/{transfer_id}/execute`
- `POST /api/v1/reconciliation/run`
- `POST /api/v1/admin/kill-switch`
- `POST /api/v1/admin/safe-mode`

## Suggested build order beyond this scaffold

1. Replace `MockExchangeAdapter` with real venue adapters.
2. Split the app into independently deployable services:
   - market-data
   - strategy
   - risk
   - OMS
   - execution
   - treasury
   - reconciliation
3. Add Kafka or Redpanda for eventing.
4. Move secrets to Vault and signer actions to HSM/MPC.
5. Add statement-based reconciliation.
6. Add real market calendars, corp actions, borrow/funding feeds.
7. Add feature store, model registry, shadow deployment, calibration monitoring.
