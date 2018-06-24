/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.io.Serializable;

/**
 *
 * @author wladekairo
 */
public class KopoKopoResponseDTO implements Serializable{
   private String status;
   private String description; 
   private String subscriber_message; 

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSubscriber_message() {
        return subscriber_message;
    }

    public void setSubscriber_message(String subscriber_message) {
        this.subscriber_message = subscriber_message;
    }
}
