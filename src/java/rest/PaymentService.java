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
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;
import user.User;

@Path("/kopo-kopo-webservice")
public class PaymentService {

    @PermitAll
    @GET
    @Path("/users/{id}")
    @Produces("application/json")
    public Response getUserById(@PathParam("id") int id, @Context Request req) {
        User user = new User();
        user.userId = id;
        user.address = "test adress";
        user.gender = "male";
        user.userEmail = "test@mail.com";
        user.username = "testuser";
        Response.ResponseBuilder rb = Response.ok(user);
        return rb.build();
    }

    @RolesAllowed("ADMIN")
    @PUT
    @Path("/users/{id}")
    @Consumes("application/json")
    @Produces("application/json")
    public Response updateUserById(@PathParam("id") int id) {
        //Update the User resource
//        UserDatabase.updateUser(id);
        return Response.status(200).build();
    }
}
