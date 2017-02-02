package sist.com;

import java.util.List;

public interface IBbsDao {
	List<BbsDto> getBbsList();
	boolean writeBbs(BbsDto dto);
	BbsDto getBbs(int seq);
	void readCount(int seq);
	boolean answer(int seq, BbsDto dto);
}
