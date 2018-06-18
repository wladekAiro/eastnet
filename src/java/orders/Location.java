/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package orders;

/**
 *
 * @author wladekairo
 */
public class Location {
    private int id;
    private String name;
    private Double cost;
    
    public Location(){}
    
    public Location(int id , String name, Double cost){
        this.id = id;
        this.name = name;
        this.cost = cost;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Double getCost() {
        return cost;
    }
}
