drop table candidate;
drop table contribution;
drop table contributor;
-- -----------------------------------------------------
-- Table `campaign`.`candidate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campaign`.`candidate` (
  `cand_id` VARCHAR(12),
  `cand_nm` VARCHAR(50),
  PRIMARY KEY (`cand_id`));


-- -----------------------------------------------------
-- Table `campaign`.`contributor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campaign`.`contributor` (
  `contrbr_id` INT AUTO_INCREMENT,
  `contbr_nm` VARCHAR(50),
  `contbr_city` VARCHAR(40),
  `contbr_st` VARCHAR(40),
  `contbr_zip` VARCHAR(20),
  `contbr_employer` VARCHAR(60),
  `contbr_occupation` VARCHAR(40),
  PRIMARY KEY (`contrbr_id`));



-- -----------------------------------------------------
-- Table `campaign`.`contribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campaign`.`contribution` (
  `contbr_id` INT AUTO_INCREMENT,
  `contrbr_id` INT,
  `cand_id` VARCHAR(12),
  `contb_receipt_amt` DECIMAL(8,2),
  `contb_receipt_dt` VARCHAR(20),
  PRIMARY KEY (`contbr_id`));


create index contributor_nm on contributor(contbr_nm);

select COUNT(cand_id) from candidate; -- delete
select count(contbr_nm) from contributor; -- delete
select count(contbr_id) from contribution; -- delete 


-- creating canidate row 
INSERT INTO candidate
SELECT DISTINCT campaign.cand_id, campaign.cand_nm
FROM campaign;


-- create contributor
INSERT INTO contributor 
SELECT DISTINCT 0, campaign.contbr_nm, campaign.contbr_city, campaign.contbr_st, campaign.contbr_zip, campaign.contbr_employer, campaign.contbr_occupation 
FROM campaign; 


-- create contribution 
INSERT INTO contribution
SELECT 0, contributor.contrbr_id, campaign.cand_id, campaign.contb_receipt_amt, campaign.contb_receipt_dt
FROM campaign, contributor
WHERE campaign.contbr_nm = contributor.contbr_nm AND campaign.contbr_city = contributor.contbr_city AND campaign.contbr_st = contributor.contbr_st AND campaign.contbr_zip = contributor.contbr_zip AND campaign.contbr_employer = contributor.contbr_employer AND campaign.contbr_occupation = contributor.contbr_occupation;



-- adding foreign key 
ALTER TABLE contribution
ADD CONSTRAINT FK_contrbr_id FOREIGN KEY (contrbr_id) REFERENCES contributor(contrbr_id),
ADD CONSTRAINT FK_cand_id FOREIGN KEY (cand_id) REFERENCES candidate(cand_id);

select * from contribution;
drop table vcampaign;
select * from vcampaign;

CREATE VIEW view_campaign AS 
SELECT candidate.cand_id, candidate.cand_nm, contbr_nm, contbr_city, contbr_st, contbr_zip, contbr_employer, contbr_occupation, contb_receipt_amt, contb_receipt_dt
FROM candidate JOIN contribution ON candidate.cand_id = contribution.cand_id
JOIN contributor ON contributor.contrbr_id = contribution.contrbr_id;