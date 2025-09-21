CREATE DATABASE insta_influencer;
USE insta_influencer;
-- 1. Create Table
CREATE TABLE influencers (
    rank_value INT,
    channel_info VARCHAR(255),
    influence_score INT,
    posts BIGINT,
    followers BIGINT,
    avg_likes BIGINT,
    engagement_rate FLOAT,
    new_post_avg_like BIGINT,
    total_likes BIGINT,
    country VARCHAR(100)
);

-- 2. Load Data 
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\top_insta_influencers_data_cleaned.csv'
INTO TABLE influencers
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- Q1: Top 10 Influencers by Followers
SELECT channel_info, followers, influence_score, country
FROM influencers
ORDER BY followers DESC
LIMIT 10;

-- Q2: Average Followers per Country
SELECT country, AVG(followers) AS avg_followers
FROM influencers
GROUP BY country
ORDER BY avg_followers DESC;

-- Q3: Micro-Influencers (followers < 1M, engagement > 3%)
SELECT channel_info, followers, engagement_rate, country
FROM influencers
WHERE followers < 1000000
  AND engagement_rate > 3
ORDER BY engagement_rate DESC;

-- Q4: Top Countries with Highest Avg Influence Score
SELECT country, AVG(influence_score) AS avg_influence
FROM influencers
GROUP BY country
ORDER BY avg_influence DESC
LIMIT 10;

-- Q5: Influencers whose New Post Avg Likes > Old Avg Likes
SELECT channel_info, avg_likes, new_post_avg_like, country
FROM influencers
WHERE new_post_avg_like > avg_likes
ORDER BY (new_post_avg_like - avg_likes) DESC;


