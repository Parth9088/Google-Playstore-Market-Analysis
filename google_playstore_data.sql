-- SQL Business Analysis Questions

-- Query 1: Which categories generate the highest estimated revenue?

SELECT
    "Category",
    ROUND(SUM("Revenue Estimate")::numeric, 2) AS total_revenue
FROM google_data
GROUP BY "Category"
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 2: Which categories have the highest average ratings?

SELECT
    "Category",
    ROUND(AVG("Rating")::numeric, 2) AS average_rating,
    COUNT(*) AS total_apps
FROM google_data
GROUP BY "Category"
HAVING COUNT(*) >= 5
ORDER BY average_rating DESC
LIMIT 10;

-- Query 3: Build a category performance summary (Apps, Rating, Installs, Reviews, Revenue)

SELECT
    "Category",
    COUNT(*) AS total_apps,
    ROUND(AVG("Rating")::numeric, 2) AS average_rating,
    SUM("Installs") AS total_installs,
    SUM("Reviews") AS total_reviews,
    ROUND(SUM("Revenue Estimate")::numeric, 2) AS total_revenue
FROM google_data
GROUP BY "Category"
ORDER BY total_revenue DESC;

-- Query 4: Compare Free vs Paid apps in terms of ratings and reviews.

SELECT
    "Type",
    COUNT(*) AS total_apps,
    ROUND(AVG("Rating")::numeric, 2) AS average_rating,
    ROUND(AVG("Reviews")::numeric, 0) AS average_reviews,
    SUM("Installs") AS total_installs
FROM google_data
GROUP BY "Type";

-- Query 5: Which install group generates the highest estimated revenue?

SELECT
    "Install Group",
    COUNT(*) AS total_apps,
    ROUND(AVG("Revenue Estimate")::numeric, 2) AS average_revenue,
    ROUND(SUM("Revenue Estimate")::numeric, 2) AS total_revenue
FROM google_data
GROUP BY "Install Group"
ORDER BY total_revenue DESC;

-- Query 6: Which categories receive the highest review engagement?

SELECT
    "Category",
    ROUND(AVG("Review Engagement")::numeric, 4) AS average_engagement
FROM google_data
GROUP BY "Category"
ORDER BY average_engagement DESC
LIMIT 10;

--Query 7: Which categories have the highest installs?

SELECT
    "Category",
    SUM("Installs") AS total_installs
FROM google_data
GROUP BY "Category"
ORDER BY total_installs DESC
LIMIT 10;

-- Query 8: Which paid apps have the highest ratings with more than 1,000 reviews?

SELECT
    "App",
    "Category",
    "Price",
    "Rating",
    "Reviews"
FROM google_data
WHERE "Type" = 'Paid'
  AND "Reviews" > 1000
ORDER BY "Rating" DESC,
         "Reviews" DESC
LIMIT 10;

-- Query 9: Find the Top 10 most reviewed applications.

SELECT
    "App",
    "Category",
    "Reviews",
    "Rating",
    "Installs"
FROM google_data
ORDER BY "Reviews" DESC
LIMIT 10;

-- Query 10: Analyze the distribution of apps across Rating Classes.

SELECT
    "Rating Class",
    COUNT(*) AS total_apps,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM google_data),
        2
    ) AS percentage
FROM google_data
GROUP BY "Rating Class"
ORDER BY total_apps DESC;

-- Query 11: Find the Top 10 Categories by average rating.

SELECT
    "Category",
    ROUND(AVG("Rating")::numeric, 2) AS average_rating
FROM google_data
GROUP BY "Category"
ORDER BY average_rating DESC
LIMIT 10;

-- Query 12: Find the Top 10 most downloaded applications.

SELECT
    "App",
    "Category",
    "Installs",
    "Rating",
    "Reviews"
FROM google_data
ORDER BY "Installs" DESC
LIMIT 10;

-- Query 13: Create a performance score to rank applications.

SELECT
    "App",
    "Category",
    "Rating",
    "Reviews",
    "Installs",
    ROUND(
        (
            ("Rating" * 0.5) +
            (LOG("Reviews" + 1) * 0.3) +
            (LOG("Installs" + 1) * 0.2)
        )::numeric,
        2
    ) AS performance_score
FROM google_data
ORDER BY performance_score DESC
LIMIT 10;