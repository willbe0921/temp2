package sist.com;

public interface IMemDao {
	
	public boolean addMember (MemberDto dto);
	public MemberDto login(MemberDto dto);
	//그냥 클래스에서 사용해도 되지만 이런 방식 많이씀
	boolean selectId(String id);
	//아이디 확인. db에 자기가 쓸려는 아이디가 중복 되는지.

}
