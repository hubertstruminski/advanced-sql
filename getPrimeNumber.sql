CREATE FUNCTION getprimenumber(n integer) RETURNS integer[] AS $$
DECLARE
	countDivider integer := 0;
	primes integer[];
BEGIN
	<< outside >>
	FOR i IN 1..n LOOP
		countDivider := 0;
		<< inside >>
		FOR j IN 1..i LOOP
			IF i % j = 0 THEN
				countDivider := countDivider + 1;
			END IF;
		END LOOP inside;
		IF countDivider = 2 THEN
			primes := array_append(primes, i);
		END IF;
	END LOOP outside;
	
	RETURN primes;
END;
$$
LANGUAGE plpgsql;