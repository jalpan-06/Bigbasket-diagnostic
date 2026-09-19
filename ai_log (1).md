# AI-Assisted Prompting Log

## Prompt 1 (Part 1 — SQL)

**Role:** You are an experienced SQL analyst who specializes in SQLite and retail analytics.
**Context:** I'm building a BigBasket-style category revenue diagnostic in SQLite. My `orders` table has `status` values `Delivered`, `Cancelled`, `Pending`, and I need category-level revenue compared against fixed monthly targets stored in a `category_targets` table.
**Task:** Help me write a query that joins delivered-order revenue per category to `category_targets` and computes both an absolute variance and a percentage variance from target.
**Constraints:** Only count `Delivered` orders in revenue. `total_revenue` and `target_revenue_inr` are both INTEGER columns in SQLite, so the percentage formula must not truncate to integer division. Tag each row `'Above Target'`, `'Below Target - Watch'` (within 15% shortfall), or `'Below Target - Critical'`.
**Format:** Return one runnable SQLite query using a CTE, with column names `category, total_revenue, target_revenue_inr, variance, percentage_variance, status_tag`.

**Verification performed:** I ran the AI-suggested query against `bigbasket_capstone.db` and manually recomputed the percentage variance by hand for two categories (Household Essentials: (21715-17000)*100/17000 = 27.7%, and Fruits & Vegetables: (9790-12000)*100/12000 = -18.4%) using a calculator, confirming both matched the query's output to one decimal place before keeping the query.

## Prompt 2 (Part 4 — Pandas)

**Role:** You are a data cleaning specialist experienced with Pandas.
**Context:** I have a raw orders CSV with duplicate `order_id` rows, mixed-case `city`/`category` values, some missing `amount_inr` values, and a handful of inflated `amount_inr` outliers, and I need to detect and cap (not drop) the outliers.
**Task:** Show me how to compute IQR-based outlier bounds on the `Delivered`, non-null `amount_inr` values and cap values above the upper fence.
**Constraints:** Use `.quantile()` for Q1/Q3, do not drop any rows, use `.clip(upper=...)`, and don't touch rows that are already excluded for missing `amount_inr`.
**Format:** A short code snippet using `.quantile()`, `.clip()`, and a print statement showing Q1, Q3, IQR, and the upper fence.

**Verification performed:** After running the AI-suggested `.clip()` line, I manually checked 3 rows that were originally flagged as outliers and confirmed their `amount_inr` value after clipping was exactly equal to the printed upper fence value, not some other number, before accepting the code into the notebook.
