package vn.edu.fit.mssv24162042.entity;

import java.io.Serializable;
import java.util.Date;

public class Share_24162042 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer shareId;
    private String emails;
    private Date sharedDate;
    private String username;
    private String videoId;

    public Share_24162042() {
    }

    public Share_24162042(Integer shareId, String emails, Date sharedDate, String username, String videoId) {
        this.shareId = shareId;
        this.emails = emails;
        this.sharedDate = sharedDate;
        this.username = username;
        this.videoId = videoId;
    }

    public Integer getShareId() {
        return shareId;
    }

    public void setShareId(Integer shareId) {
        this.shareId = shareId;
    }

    public String getEmails() {
        return emails;
    }

    public void setEmails(String emails) {
        this.emails = emails;
    }

    public Date getSharedDate() {
        return sharedDate;
    }

    public void setSharedDate(Date sharedDate) {
        this.sharedDate = sharedDate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }
}
