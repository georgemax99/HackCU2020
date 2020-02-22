package beans;

public class Event {
	private Long id;
	private Long userId;
	private int numberNeeded;
	private int numberCommitted;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public int getNumberNeeded() {
		return numberNeeded;
	}

	public void setNumberNeeded(int numberNeeded) {
		this.numberNeeded = numberNeeded;
	}

	public int getNumberCommitted() {
		return numberCommitted;
	}

	public void setNumberCommitted(int numberCommitted) {
		this.numberCommitted = numberCommitted;
	}
}
