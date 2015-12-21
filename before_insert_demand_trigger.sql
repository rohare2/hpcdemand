# $Id: $
# $Date: $

DELIMITER //

DROP TRIGGER IF EXISTS hpcdemand.before_insert_demand;

CREATE TRIGGER hpcdemand.before_insert_demand BEFORE INSERT ON demand
	FOR EACH ROW
	SET new.user = SUBSTRING_INDEX(USER(),'@',1);

