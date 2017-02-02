package sist.com;

import java.util.List;

public interface IPdsDao {
	
	boolean writePds(PdsDto pds);
	
	List<PdsDto> getPdss();

}
