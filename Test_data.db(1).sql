-- Task 1.1: Calculate the average number of questions asked per conversation for each day
SELECT date, AVG(num_que_asked) AS avg_questions_per_conversation
FROM test
GROUP BY date;

-- Task 1.2: Find out all the queries where the bot was not able to understand the query and assigned them to the agent
SELECT *
FROM test
WHERE is_bot = 'No' AND is_llm = 'No';

-- Task 1.3: Calculate the average number of users talking to the agent for each day
SELECT date, COUNT(DISTINCT "user_id (new)") AS avg_users_talking_to_agent
FROM test
WHERE is_bot = 'No'
GROUP BY date;

-- Task 1.4: Calculate the average time of conversation with the chat bot when the required information is provided by the chat bot
SELECT AVG(strftime('%s', time_end) - strftime('%s', time_start)) AS avg_time_when_info_provided
FROM (
    SELECT session_id, 
           MAX(time) AS time_end,
           MIN(time) AS time_start
    FROM test
    WHERE info_collection_end = 1
    GROUP BY session_id
);

-- Task 1.5: Calculate the average time of conversation with the chat bot when the required information is not provided by the chat bot and the user had to communicate with the agent
SELECT AVG(strftime('%s', time_end) - strftime('%s', time_start)) AS avg_time_when_info_not_provided
FROM (
    SELECT session_id, 
           MAX(time) AS time_end,
           MIN(time) AS time_start
    FROM test
    WHERE info_collection_end = 0
    GROUP BY session_id
);
