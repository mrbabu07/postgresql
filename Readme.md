
## 1. Database Schema Design & Data Integrity (DDL)

* User Access Control (Users Table): Created a structural account log that secures system access. It includes a strict string validation rule (CHECK constraint) restricting system roles exclusively to 'Football Fan' or 'Ticket Manager', and enforces email uniqueness to prevent duplicate registrations.
* Fixture Management (Matches Table): Set up a match catalog protected by absolute numerical boundary constraints. It prevents database entry errors by blocking negative ticket prices (>= 0) and limits match statuses strictly to 'available', 'selling fast', or 'sold out'.
* Relational Ticketing Core (Bookings Table): Implemented a central transaction ledger that bridges users and matches using relational Foreign Keys. It restricts payment states strictly to 'confirmed' or 'pending' while guarding the total billing column from negative calculations.

## 2. Debugging & Data Seeding Corrections

* Data Typo Resolution: Diagnosed and corrected structural inline syntax errors, such as misaligned query parenthesis and text field misspellings (payment_staus).
* Case-Sensitivity Conflict Fix: Resolved a major runtime conflict where sample dataset insertions were being entirely rejected by the database. The initial insert statements used capitalized states (e.g., 'Available'), which violated the strict lowercase rules (e.g., 'available'). All insert entries were synchronized to lowercase to pass validation smoothly.

## 3. Advanced Assignment Query Implementations

* Conditional Data Extraction: Isolated precise records by filtering ongoing 'Champions League' matches that remain explicitly listed as available for general purchase.
* Case-Insensitive Wildcard Search: Designed a flexible text search utilizing string manipulation helpers (LOWER and LIKE) to locate system accounts starting with 'Tanvir' or containing 'Haque', regardless of user capitalization habits.
* Handling Missing Values (NULL Processing): Used conditional scanning functions (COALESCE) to automatically trap blank or unpaid payment fields and mask them under an actionable system string label: 'Action Required'.
* Comprehensive User Activity Audits (LEFT JOIN): Crafted a join lookup that preserves data visibility for inactive buyers. This ensures that sports fans who have never ordered a single ticket remain listed in global user audits rather than being omitted.
* Dynamic Average Filtering (Subqueries): Constructed a multi-layered query that dynamically calculates the global average seat price behind the scenes, then dynamically extracts premium ticket profiles priced strictly above that baseline.
* Pagination and Sorting Logic (LIMIT & OFFSET): Configured a sorting queue that ranks fixtures descending from highest to lowest price, bypassing the single absolute most expensive entry (the tier-one match) to systematically target the next two highest matching records.



