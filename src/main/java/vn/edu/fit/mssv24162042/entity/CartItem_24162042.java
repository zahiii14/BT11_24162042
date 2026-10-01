package vn.edu.fit.mssv24162042.entity;

import java.io.Serializable;

public class CartItem_24162042 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Video_24162042 video;
    private int quantity;

    public CartItem_24162042() {
    }

    public CartItem_24162042(Video_24162042 video, int quantity) {
        this.video = video;
        this.quantity = quantity;
    }

    public Video_24162042 getVideo() {
        return video;
    }

    public void setVideo(Video_24162042 video) {
        this.video = video;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        // Enforce quantity limits (1 - 99)
        if (quantity < 1) {
            this.quantity = 1;
        } else if (quantity > 99) {
            this.quantity = 99;
        } else {
            this.quantity = quantity;
        }
    }

    public double getAmount() {
        if (video != null && video.getPrice() != null) {
            return video.getPrice() * quantity;
        }
        return 0.0;
    }
}
