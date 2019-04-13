CREATE FUNCTION checkpesel(pesel bigint) RETURNS boolean AS
$$
DECLARE
	peselString text := pesel::text;
	digits integer[];
	answer integer;
	result integer := 0;
	lastDigitResult integer;
	resultText text;
	isCorrect boolean;
BEGIN

	SELECT a INTO digits::integer[] FROM (SELECT regexp_split_to_array(peselString,'')) AS x(a);
	result := 1 * digits[1]  + 3 * digits[2] + 7 * digits[3] + 9 * digits[4] + 1 * digits[5] + 3 * digits[6] + 7 * digits[7] + 9 * digits[8] + 1 * digits[9] + 3 * digits[10];
	
	resultText := result::text;
	SELECT b[3] INTO lastDigitResult::integer FROM (SELECT regexp_split_to_array(resultText,'')) AS y(b);

	answer := abs(lastDigitResult - 10);
																		   
	IF answer = digits[11] THEN
		isCorrect := true;
	ELSE
		isCorrect := false;
	END IF;
	RETURN isCorrect;
END
$$
LANGUAGE plpgsql;