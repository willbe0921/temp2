package sist.com;

import java.io.Serializable;

public class BbsDto implements Serializable {
	
	/*drop table bbs
	cascade constraint;

	create table bbs(

		seq number(8) primary key,
		id varchar2(50) not null,
		ref number(8) not null,
		step number(8) not null,
		depth number(8) not null,
		title varchar2(200) not null,
		content varchar2(4000) not null,
		wdate date not null,
		parent number(8) not null,
		del number(1) not null,
		readcount number(8) not null
	);

	create sequence seq_bbs
	start with 1 increment by 1;

	alter table bbs 
	add constraint fk_bbs_id foreign key(id)
	references member(id);*/
	
	private static final long serialVersionUID = -7166730180843777295L;
	
	private int seq;	//글의 중복 을 막고, 검색을 빠르게 하기 위해.
	private String id;	//글쓴 사람
	
	private int ref;	//그룹번호.  덧글 달았을 때 그 덧글들에 대한 그룹.
	private int step;	//밑으로 
	private int depth;	//옆으로. 덧글에 따라 옆으로 밀리는거.
	
	private String title;
	private String content;
	private String wdate;	//기입일
	private int parent;	//부모글
	
	private int del;	//삭제된 글이냐 아니냐. db에는 남아있음.
	private int readcount;	//몇번 읽었는지
	
	public BbsDto() {}

	public BbsDto(int seq, String id, int ref, int step, int depth, String title, String content, String wdate,
			int parent, int del, int readcount) {
		super();
		this.seq = seq;
		this.id = id;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.parent = parent;
		this.del = del;
		this.readcount = readcount;
	}
	
	public BbsDto(String id, String title, String content ) {
		this.id = id;
		this.title = title;
		this.content = content;
	
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	@Override
	public String toString() {
		return "BbsDto [seq=" + seq + ", id=" + id + ", ref=" + ref + ", step=" + step + ", depth=" + depth + ", title="
				+ title + ", content=" + content + ", wdate=" + wdate + ", parent=" + parent + ", del=" + del
				+ ", readcount=" + readcount + "]";
	}
	
	
	
	
	
	
}












