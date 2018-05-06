/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  wladekairo
 * Created: May 1, 2018
 */
ALTER TABLE `products` add category_id int(255) NOT NULL DEFAULT 0;
ALTER TABLE `products` ADD CONSTRAINT fk_catgery_id FOREIGN KEY (category_id) REFERENCES category(category_id);

ALTER TABLE `sub-category` modify category_id int(255) NOT NULL DEFAULT 0;
ALTER TABLE `sub-category` ADD CONSTRAINT fk_catgery_id FOREIGN KEY (category_id) REFERENCES category(category_id);
