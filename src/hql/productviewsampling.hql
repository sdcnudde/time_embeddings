--SAMPLING
SET SAMPLING='0.02’;
SET EARLIESTDATEPART1="2015-02-24";
SET LATESTDATEPART1="2016-02-24";
set hive.execution.engine=tez;
set hive.merge.tezfiles=true;
set hive.merge.smallfiles.avgsize=1000000000000;
set hive.exec.reducers.max=1;


--PRODUCT VIEWS desktop views part1 
DROP TABLE productviews;
CREATE EXTERNAL TABLE productviews(customerId int, productId int, variantId int, divisionId int, sourceId int, itemQty int, signalDate string, origin string, price float, discountType string, useForRecs int, dateModified string, viewonly int, changeThumbnail int, imageZoom int, watchVideo int, view360 int, sizeGuide int, device string, userTime string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE LOCATION 'wasb://signals@asosrecssignals.blob.core.windows.net/productviews/adobe/productviews/';
CREATE EXTERNAL TABLE productviewsS(customerId int, productId int, variantId int, divisionId int, sourceId int, itemQty int, signalDate string, origin string, price float, discountType string, useForRecs int, dateModified string, viewonly int, changeThumbnail int, imageZoom int, watchVideo int, view360 int, sizeGuide int, device string, userTime string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'STORED AS TEXTFILE LOCATION 'wasb://sdcsparkrd01@asoscustprofdevelopment.blob.core.windows.net/sample1outof100singlefile/desktop_productviews';
INSERT OVERWRITE TABLE productviewsS
SELECT * FROM productviews where (customerId % (1/${hiveconf:SAMPLING}))=0 and signalDate>=${hiveconf:EARLIESTDATEPART1} and signalDate<${hiveconf:LATESTDATEPART1};

--PRODUCT VIEWS app views part1 
DROP TABLE productviews;
CREATE EXTERNAL TABLE productviews(customerId int, productId int, variantId int, divisionId int, sourceId int, itemQty int, signalDate string, origin string, price float, discountType string, useForRecs int, dateModified string, viewonly int, changeThumbnail int, imageZoom int, watchVideo int, view360 int, sizeGuide int, device string, userTime string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'STORED AS TEXTFILE LOCATION 'wasb://signals@asosrecssignals.blob.core.windows.net/productviews/adobeapps/productviews/';
DROP TABLE productviewsS;
CREATE EXTERNAL TABLE productviewsS(customerId int, productId int, variantId int, divisionId int, sourceId int, itemQty int, signalDate string, origin string, price float, discountType string, useForRecs int, dateModified string, viewonly int, changeThumbnail int, imageZoom int, watchVideo int, view360 int, sizeGuide int, device string, userTime string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'STORED AS TEXTFILE LOCATION 'wasb://sdcsparkrd01@asoscustprofdevelopment.blob.core.windows.net/sample1outof100singlefile/app_productviews';
INSERT OVERWRITE TABLE productviewsS
SELECT * FROM productviews where (customerId % (1/${hiveconf:SAMPLING}))=0 and signalDate>=${hiveconf:EARLIESTDATEPART1} and signalDate<${hiveconf:LATESTDATEPART1};
