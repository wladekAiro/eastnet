/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rest;

import org.glassfish.jersey.filter.LoggingFilter;
import org.glassfish.jersey.server.ResourceConfig;

/**
 *
 * @author wladekairo
 */
public class RestApplication extends ResourceConfig {
    public RestApplication(){
		packages("rest");
		register(LoggingFilter.class);
		//Register Auth Filter here
		register(AuthenticationFilter.class);
	}
}
