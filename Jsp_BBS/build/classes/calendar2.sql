
SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE
from
(
	SELECT ROW_NUMBER() OVER(PARTITION BY SUBSTR(RDATE, 1, 8) 
		ORDER BY RDATE ASC) RN, 
		SEQ, ID, TITLE, CONTENT, RDATE, WDATE
	FROM CALENDAR
	WHERE ID=? AND SUBSTR(RDATE, 1, 6)=?
)
WHERE RN BETWEEN 1 AND 5;

SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE
from
(
	SELECT ROW_NUMBER() OVER(PARTITION BY SUBSTR(RDATE, 1, 8) 
		ORDER BY RDATE ASC) RN, 
		SEQ, ID, TITLE, CONTENT, RDATE, WDATE
	FROM CALENDAR
	WHERE ID='cc' AND SUBSTR(RDATE, 1, 6)='201701'
)
WHERE RN BETWEEN 1 AND 5;



산출된 테이블. PARTITION BY (String yyyyMM) 달별로 묶어준다. (RDATE, 1, 6) yyyyMM 6자리