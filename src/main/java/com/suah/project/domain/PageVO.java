package com.suah.project.domain;

public class PageVO {

	// 시작 페이지 
	private int startPage;

	//현재 페이지
	private int currPage;

	//마지막 페이지
	private int endPage;
	
	//최대 페이지
	private int maxPage;
	
	//페이지 당 게시글 수
	private int limit;

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}
	
	
	
}
