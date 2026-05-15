

# 🏠 Real Estate Analytics Pipeline

An end-to-end analytics engineering project built with **dbt Core**, **Snowflake**, and **GitHub Actions** — transforming raw real estate data into clean, tested, production-ready insights across a four-layer architecture.

---

## 📌 Project Overview

This project implements a modern ELT analytics pipeline for real estate data. Raw data is loaded into Snowflake and transformed through four progressive dbt model layers, each with a single clear responsibility — from raw source access all the way to stakeholder-ready analytics tables.

The pipeline is fully deployed and runs automatically via GitHub Actions on every push to `main`, with data quality tests enforced at every stage.

---

## 🛠️ Tech Stack

| Tool | Role |
|---|---|
| **dbt Core 1.9.0** | Data transformation framework |
| **dbt-snowflake 1.9.0** | Snowflake adapter for dbt |
| **Snowflake** | Cloud data warehouse |
| **GitHub Actions** | CI/CD and pipeline orchestration |
| **dbt_utils >=1.3.0** | dbt utility macros package |

---

## 🏗️ Architecture — Four-Layer Model

The project follows a layered dbt architecture where each layer has a single responsibility. Data flows in one direction: `Base → Prep → Dimensional → Presents`.

```
Raw Source Data (Snowflake seeds)
        │
        ▼
┌───────────────┐
│   BASE LAYER  │  ← Views | Direct source references, no transformations
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   PREP LAYER  │  ← Tables | Cleaning, renaming, casting, filtering
└───────┬───────┘
        │
        ▼
┌─────────────────────┐
│  DIMENSIONAL LAYER  │  ← Tables | Dim tables + Fact tables
└──────────┬──────────┘
           │
           ▼
┌──────────────────┐
│  PRESENTS LAYER  │  ← Tables | Aggregated, analytics-ready outputs
└──────────────────┘
```

### Layer Details

#### 🔵 Base Layer — `materialized: view`
The entry point of the pipeline. Base models reference raw source data directly from Snowflake seeds and do one thing: make it queryable. No business logic, no transformations — just a clean, stable foundation to build on.

#### 🟡 Prep Layer — `materialized: table`
Where data quality begins. Columns are renamed for consistency, data types are cast correctly, and irrelevant noise is filtered out. YAML files with `not_null`, `unique`, and foreign key tests are applied here to enforce data integrity from the very first transformation layer.

#### 🟠 Dimensional Layer — `materialized: table`
Where the data starts telling a story. Following dbt modelling best practices, prep data is split into two types of tables:

- **Dimension tables** — descriptive, relatively static attributes (the *who*, *what*, and *where*). Examples: properties, agents, locations.
- **Fact tables** — measurable, time-stamped business events (the *what happened*). Examples: transactions, listings, price changes.

Separating concerns this way makes downstream querying faster, cleaner, and easier to reason about.

#### 🟢 Presents Layer — `materialized: table`
The final layer. Clean, aggregated, analytics-ready tables purpose-built for real estate insights. This is what stakeholders actually consume:

- **Property Performance** — how individual properties are tracking over time
- **Pricing Trends** — market-level price movement analysis
- **Sales Overview** — high-level transactional summaries

---

## 📂 Project Structure

```
dbt_real_estate/
├── .github/
│   └── workflows/           # GitHub Actions CI/CD pipeline
├── models/
│   ├── base/                # Base layer models
│   ├── prep/                # Prep layer models + YAML tests
│   ├── dimensional/         # Dim and Fact models
│   └── presents/            # Analytics-ready output models
├── seeds/                   # Raw real estate source data (loaded to Snowflake raw schema)
├── profiles/                # dbt connection profiles
├── dbt_project.yml          # Project configuration and materialization settings
├── packages.yml             # dbt packages (dbt_utils)
└── requirements.txt         # Python dependencies
```

---

## ⚙️ Configuration

### Materialization Strategy (`dbt_project.yml`)

```yaml
models:
  real_estate:
    base:
      +materialized: view
    prep:
      +materialized: table
    dimensional:
      +materialized: table
    presents:
      +materialized: table
```

### Seeds Schema

Raw data seeds are loaded into a dedicated `_raw` schema in Snowflake to keep source data isolated from transformed models:

```yaml
seeds:
  real_estate:
    +schema: raw
```

---

## 🧪 Data Quality & Testing

Tests are defined in YAML files across the Base and Prep layers and include:

- `not_null` — ensures critical columns always have values
- `unique` — enforces primary key integrity
- **Foreign key relationships** — referential integrity back to source tables

Tests run automatically on every pipeline execution. If any test fails, the pipeline stops — nothing broken ever reaches Snowflake.

---

## 🚀 Deployment — GitHub Actions

The pipeline is deployed to production using **GitHub Actions**. A workflow in `.github/workflows/` triggers automatically on every push to the `main` branch.

### What the workflow does:

1. Checks out the repository
2. Sets up Python and installs dbt Core + dbt-snowflake from `requirements.txt`
3. Installs dbt packages (`dbt deps`)
4. Authenticates to Snowflake using **GitHub Secrets** (no credentials are hardcoded or exposed)
5. Runs `dbt build` — executes all models and tests in dependency order
6. dbt resolves the DAG automatically: `Base → Prep → Dimensional → Presents`

### GitHub Secrets required:

| Secret | Description |
|---|---|
| `SNOWFLAKE_ACCOUNT` | Your Snowflake account identifier |
| `SNOWFLAKE_USER` | Snowflake username |
| `SNOWFLAKE_PASSWORD` | Snowflake password |
| `SNOWFLAKE_ROLE` | Snowflake role |
| `SNOWFLAKE_WAREHOUSE` | Snowflake virtual warehouse |
| `SNOWFLAKE_DATABASE` | Target database |
| `SNOWFLAKE_SCHEMA` | Target schema |

---

## 🏃 Running Locally

### Prerequisites

- Python 3.9+
- A Snowflake account
- Git

### Setup

```bash
# Clone the repository
git clone https://github.com/Ayomideolayiwola/dbt_real_estate.git
cd dbt_real_estate

# Install dependencies
pip install -r requirements.txt

# Install dbt packages
dbt deps

# Configure your Snowflake connection in profiles/profiles.yml
# then test the connection
dbt debug
```

### Run the pipeline

```bash
# Load seed data
dbt seed

# Run all models
dbt run

# Run tests
dbt test

# Or do everything at once
dbt build
```

---

## 📦 Dependencies

```yaml
# packages.yml
packages:
  - package: dbt-labs/dbt_utils
    version: ">=1.3.0"
```

```
# requirements.txt
dbt-core==1.9.0
dbt-snowflake==1.9.0
```

---

## 🙏 Acknowledgements

Built under the supervision and mentorship of **Damilare A.**, whose guidance shaped the architecture and best practices applied throughout this project.

---

## 📄 License

This project is open source and available for learning and reference purposes.

