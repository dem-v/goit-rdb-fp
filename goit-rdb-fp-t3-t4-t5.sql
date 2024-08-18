USE pandemia;

-- Task 3
SELECT Entity_id, MIN(Number_rabies), MAX(Number_rabies), AVG(Number_rabies), SUM(Number_rabies)
FROM infectious_cases c
WHERE Number_rabies IS NOT NULL
GROUP BY Entity_id
ORDER BY AVG(Number_rabies)
LIMIT 10
;

-- Task 4
ALTER TABLE infectious_cases
ADD COLUMN (
DateOfSource date,
CurrentDate date,
YearsDiff FLOAT
);

UPDATE infectious_cases
SET DateOfSource = MAKEDATE(Year, 1),
	CurrentDate = CURDATE(),
    YearsDiff = DATEDIFF(CurrentDate, DateOfSource)/365.25
WHERE Id >= 0;

SELECT * FROM infectious_cases LIMIT 10;

-- Task 5
DROP FUNCTION IF EXISTS GetYearDistance;
DELIMITER //
CREATE FUNCTION GetYearDistance(y year)
RETURNS FLOAT
DETERMINISTIC 
NO SQL
BEGIN
    DECLARE result FLOAT;
    SET result =  DATEDIFF(CURDATE(), MAKEDATE(y, 1))/365.25;
    RETURN result;
END //
DELIMITER ;

SELECT *, GetYearDistance(Year) FROM infectious_cases LIMIT 20;