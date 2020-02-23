package beans;

import java.util.Date;

public class Event {
	private Long id;
	private Long userId;
	private int numberNeeded;
	private int numberCommitted;
	private String title;
	private String lat;
	private String lon;
	private String city;
	private String state;
	private String descrip;
	private int userCommitted;
	private String time;
	private Date now;
	private int type;

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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLon() {
		return lon;
	}

	public void setLon(String lon) {
		this.lon = lon;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getDescrip() {
		return descrip;
	}

	public void setDescrip(String descrip) {
		this.descrip = descrip;
	}

	public int getUserCommited() {
		return userCommitted;
	}

	public void setUserCommited(int userCommited) {
		this.userCommitted = userCommited;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public Date getNow() {
		return now;
	}

	public void setNow(Date now) {
		this.now = now;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}
