/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rest;

/**
 *
 * @author wladekairo
 */
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;
import user.User;

@Path("/kopo-kopo-webservice")
public class PaymentService {

    @GET
    @Path("/users/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUserById(@PathParam("id") int id) {
        User user = new User();
        user.userId = id;
        user.address = "test adress";
        user.gender = "male";
        user.userEmail = "test@mail.com";
        user.username = "testuser";
        Response.ResponseBuilder rb = Response.ok(user);
        return rb.build();
    }

    @POST
    @Path("/users")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateUserById(User user) {
        //Update the User resource
//        UserDatabase.updateUser(id);
        Response.ResponseBuilder rb = Response.ok(user);
        return rb.status(201).build();
    }
}
