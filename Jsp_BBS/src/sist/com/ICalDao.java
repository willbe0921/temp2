package sist.com;

import java.util.List;

/*import java.util.Calendar;*/

public interface ICalDao {
	
	boolean addCalendar(CalDto cal);
	List<CalDto> CalList(String id, String yyyyMM);
	CalDto getdetail(int seq);
	
	List<CalDto> getDayList(String id, String yyyymmdd);
	boolean deletelist(int seq);
	

}
