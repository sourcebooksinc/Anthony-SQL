SELECT ChildRecords.`ISBN13`, Contributors.`FullNameInPrint`, ContributorISBNRelation.`OnixFullName`, ContributorISBNRelation.`AuthorLastName`, Contributors.`CompanyName`, 
Contributors.`OnixBio`, Contributors.`OnixFirstNameInPrint`, Contributors.`OnixLastNameInPrint`, ContributorRoles.Value, Contributors.`WebsiteURL`, CountryList.`CountryCode` 
FROM OnixTitles
LEFT JOIN ContributorISBNRelation ON OnixTitles.`isbn13` = ContributorISBNRelation.`ISBN13` 
LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
LEFT JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.`ISBN13` AND `ChildRecords`.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d')
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 5 AND (Contributors.`OnixLastNameInPrint` <> "" OR Contributors.`CompanyName` <> "") 
AND (Contributors.`OnixLastNameInPrint` IS NOT NULL OR Contributors.`CompanyName` IS NOT NULL ) 
AND (`ChildRecords`.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixTitles.`OnixLogFlag` = 'X')
ORDER BY ChildRecords.`ISBN13`, ContributorISBNRelation.`ID`;


9781402215360  ;


SELECT *
FROM (
        SELECT *
        FROM (
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN13`,
                    Contributors.`FullNameInPrint`,
                    ContributorISBNRelation.`OnixFullName`,
                    ContributorISBNRelation.`AuthorLastName`,
                    Contributors.`CompanyName`,
                    Contributors.`OnixBio`,
                    Contributors.`OnixFirstNameInPrint`,
                    Contributors.`OnixLastNameInPrint`,
                    ContributorRoles.Value,
                    Contributors.`WebsiteURL`,
                    CountryList.`CountryCode`
                FROM`OnixTitles`
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN ContributorISBNRelation ON ChildRecords.`ParentISBN13` = ContributorISBNRelation.`ISBN13`
                    LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
                    LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
                    LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
                WHERE (
                        Contributors.`OnixLastNameInPrint` <> ""
                        OR Contributors.`CompanyName` <> ""
                    )
                    AND (
                        Contributors.`OnixLastNameInPrint` IS NOT NULL
                        OR Contributors.`CompanyName` IS NOT NULL
                    )
                    AND (OnixTitles.`OnixLogFlag` = 'X'
--                    OR OnixEditProductCatalogs.`ModifyDate` >= CURRENT_DATE()
                    )
                    AND OnixTitles.`isbn13` NOT IN (
                        SELECT
                            ISBN13
                        FROM
                            ProductPlaceholderData
                        WHERE
                            CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    ) 
                UNION
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN13`,
                    Contributors.`FullNameInPrint`,
                    ContributorISBNRelation.`OnixFullName`,
                    ContributorISBNRelation.`AuthorLastName`,
                    Contributors.`CompanyName`,
                    Contributors.`OnixBio`,
                    Contributors.`OnixFirstNameInPrint`,
                    Contributors.`OnixLastNameInPrint`,
                    ContributorRoles.Value,
                    Contributors.`WebsiteURL`,
                    CountryList.`CountryCode`
                FROM
                    `OnixTitles`
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN ContributorISBNRelation ON ChildRecords.`ParentISBN13` = ContributorISBNRelation.`ISBN13`
                    LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
                    LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
                    LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
                WHERE (
                        Contributors.`OnixLastNameInPrint` <> ""
                        OR Contributors.`CompanyName` <> ""
                    )
                    AND (
                        Contributors.`OnixLastNameInPrint` IS NOT NULL
                        OR Contributors.`CompanyName` IS NOT NULL
                    )
                    AND ChildRecords.`ModifyDate` >= DATE_FORMAT( (CURDATE() - INTERVAL 1 DAY),
                        '%Y-%m-%d'
                    )
                    AND OnixTitles.`isbn13` NOT IN (
                        SELECT
                            ISBN13
                        FROM
                            ProductPlaceholderData
                        WHERE
                            CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    )
                UNION
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN13`,
                    Contributors.`FullNameInPrint`,
                    ContributorISBNRelation.`OnixFullName`,
                    ContributorISBNRelation.`AuthorLastName`,
                    Contributors.`CompanyName`,
                    Contributors.`OnixBio`,
                    Contributors.`OnixFirstNameInPrint`,
                    Contributors.`OnixLastNameInPrint`,
                    ContributorRoles.Value,
                    Contributors.`WebsiteURL`,
                    CountryList.`CountryCode`
                FROM
                    `OnixTitles`
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN ContributorISBNRelation ON ChildRecords.`ParentISBN13` = ContributorISBNRelation.`ISBN13`
                    LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
                    LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
                    LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
                WHERE (
                        Contributors.`OnixLastNameInPrint` <> ""
                        -- OR Contributors.`CompanyName` <> ""
                    )
                    AND (
                        Contributors.`OnixLastNameInPrint` IS NOT NULL
                        -- OR Contributors.`CompanyName` IS NOT NULL
                    )
                    AND OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d')
                    AND OnixTitles.`isbn13` NOT IN (
                        SELECT
                            ISBN13
                        FROM
                            ProductPlaceholderData
                        WHERE
                            CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    
                    )
            ) ChildContributors 
        UNION
        SELECT *
        FROM (
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN13`,
                    ContributorPlaceHolderData.`FullName` AS `FullNameInPrint`,
                    ContributorPlaceHolderData.`FullName` AS `OnixFullName`,
                    ContributorPlaceHolderData.`ContributorLastName`,
                    ContributorPlaceHolderData.`Company`,
                    ContributorPlaceHolderData.`Bio`,
                    ContributorPlaceHolderData.`ContributorFirstName`,
                    ContributorPlaceHolderData.`ContributorLastName` AS `OnixLastNameInPrint`,
                    ContributorPlaceHolderData.`Role`,
                    ContributorPlaceHolderData.`Website`,
                    CountryList.`CountryCode`
                FROM
                    ProductPlaceholderData
                    JOIN OnixTitles ON OnixTitles.isbn13 = ProductPlaceholderData.`ISBN13`
                    AND CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN ContributorISBNRelation ON ChildRecords.`ParentISBN13` = ContributorISBNRelation.`ISBN13`
                    LEFT JOIN `ContributorPlaceHolderData` ON ContributorISBNRelation.`AuthorID` = `ContributorPlaceHolderData`.`ContributorID`
                    LEFT JOIN `CountryList` ON ContributorPlaceHolderData.`Country` = `CountryList`.`Country`
                WHERE (
                        ContributorPlaceHolderData.`ContributorLastName` <> ""
                        OR ContributorPlaceHolderData.`Company` <> ""
                    )
                    AND (
                        ContributorPlaceHolderData.`ContributorLastName` IS NOT NULL
                        OR ContributorPlaceHolderData.`Company` IS NOT NULL
                    )
                    AND OnixTitles.`OnixLogFlag` = 'X'
                UNION
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN13`,
                    ContributorPlaceHolderData.`FullName` AS `FullNameInPrint`,
                    ContributorPlaceHolderData.`FullName` AS `OnixFullName`,
                    ContributorPlaceHolderData.`ContributorLastName`,
                    ContributorPlaceHolderData.`Company`,
                    ContributorPlaceHolderData.`Bio`,
                    ContributorPlaceHolderData.`ContributorFirstName`,
                    ContributorPlaceHolderData.`ContributorLastName` AS `OnixLastNameInPrint`,
                    ContributorPlaceHolderData.`Role`,
                    ContributorPlaceHolderData.`Website`,
                    CountryList.`CountryCode`
                FROM
                    ProductPlaceholderData
                    JOIN OnixTitles ON OnixTitles.isbn13 = ProductPlaceholderData.`ISBN13`
                    AND CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN ContributorISBNRelation ON ChildRecords.`ParentISBN13` = ContributorISBNRelation.`ISBN13`
                    LEFT JOIN `ContributorPlaceHolderData` ON ContributorISBNRelation.`AuthorID` = `ContributorPlaceHolderData`.`ContributorID`
                    LEFT JOIN `CountryList` ON ContributorPlaceHolderData.`Country` = `CountryList`.`Country`
                WHERE (
                        ContributorPlaceHolderData.`ContributorLastName` <> ""
                        OR ContributorPlaceHolderData.`Company` <> ""
                    )
                    AND (
                        ContributorPlaceHolderData.`ContributorLastName` IS NOT NULL
                        OR ContributorPlaceHolderData.`Company` IS NOT NULL
                    )
                    AND ChildRecords.`ModifyDate` >= DATE_FORMAT( (CURDATE() - INTERVAL 1 DAY),
                        '%Y-%m-%d'
                    )
                UNION
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN13`,
                    ContributorPlaceHolderData.`FullName` AS `FullNameInPrint`,
                    ContributorPlaceHolderData.`FullName` AS `OnixFullName`,
                    ContributorPlaceHolderData.`ContributorLastName`,
                    ContributorPlaceHolderData.`Company`,
                    ContributorPlaceHolderData.`Bio`,
                    ContributorPlaceHolderData.`ContributorFirstName`,
                    ContributorPlaceHolderData.`ContributorLastName` AS `OnixLastNameInPrint`,
                    ContributorPlaceHolderData.`Role`,
                    ContributorPlaceHolderData.`Website`,
                    CountryList.`CountryCode`
                FROM
                    ProductPlaceholderData
                    JOIN OnixTitles ON OnixTitles.isbn13 = ProductPlaceholderData.`ISBN13`
                    AND CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN ContributorISBNRelation ON ChildRecords.`ParentISBN13` = ContributorISBNRelation.`ISBN13`
                    LEFT JOIN `ContributorPlaceHolderData` ON ContributorISBNRelation.`AuthorID` = `ContributorPlaceHolderData`.`ContributorID`
                    LEFT JOIN `CountryList` ON ContributorPlaceHolderData.`Country` = `CountryList`.`Country`
                WHERE (
                        ContributorPlaceHolderData.`ContributorLastName` <> ""
                        OR ContributorPlaceHolderData.`Company` <> ""
                    )
                    AND (
                        ContributorPlaceHolderData.`ContributorLastName` IS NOT NULL
                        OR ContributorPlaceHolderData.`Company` IS NOT NULL
                    )
                    AND OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d')
                    
            ) ChildContributors
    ) ChildContributors;
    
    
    SELECT *
FROM (
        SELECT *
        FROM (
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN`,
                    OnixTitles.`isbn10`,
                    OnixTitles.`upc`,
                    OnixTitles.`title_prefix`,
                    ChildRecords.`Title` AS title_clean,
                    OnixTitles.`subtitle`,
                    OnixTitles.`series`,
                    OnixTitles.`series_number`,
                    OnixTitles.`pages`,
                    OnixTitles.`imprint`,
                    OnixTitles.`text_language`,
                    OnixTitles.`imprint_symbol`,
                    OnixTitles.`weight`,
                    OnixTitles.`PhysicalThickness`,
                    OnixTitles.`PhysicalLength`,
                    OnixTitles.`PhysicalWidth`,
                    OnixTitles.`length`,
                    OnixTitles.`width`,
                    COALESCE(
                        ChildRecords.`Description`,
                        OnixTitles.`description`
                    ) AS Description,
                    OnixTitles.`table_of_contents`,
                    COALESCE(
                        ChildRecords.`PubDate`,
                        OnixTitles.`pub_date`
                    ) AS pub_date,
                    OnixTitles.`audience_code`,
                    OnixTitles.`author_bio`,
                    Bindings.`ProductFormEBookThree` AS ProductForm,
                    Bindings.`ProductFormEbookThreeDetail` AS ProductFormDetail,
                    PublishingStatus.`StatusValue`,
                    OnixTitles.`age_low`,
                    OnixTitles.`age_high`,
                    OnixTitles.`grade_low`,
                    OnixTitles.`grade_high`,
                    ProductTitles.`Edition`,
                    OnixTitles.`onixkeywords`,
                    OnixTitles.`lexile_code`,
                    EditionTypes.`Code`,
                    Bindings.`ProductFormDetailTwo`,
                    CAST(
                        PublishingStatus.StatusValue AS NCHAR
                    ) AS STRStatusValue,
                    OnixTitles.`SubscriptionRightsFlag`
                FROM
                    OnixTitles
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN Bindings ON Bindings.`Binding` = ChildRecords.`Binding`
                    LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
                    LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
                    LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
                WHERE
                    OnixTitles.`OnixLogFlag` = 'X'
                    AND OnixTitles.`isbn13` NOT IN (
                        SELECT
                            ISBN13
                        FROM
                            ProductPlaceholderData
                        WHERE
                            CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    )
                UNION
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN`,
                    OnixTitles.`isbn10`,
                    OnixTitles.`upc`,
                    OnixTitles.`title_prefix`,
                    ChildRecords.`Title` AS title_clean,
                    OnixTitles.`subtitle`,
                    OnixTitles.`series`,
                    OnixTitles.`series_number`,
                    OnixTitles.`pages`,
                    OnixTitles.`imprint`,
                    OnixTitles.`text_language`,
                    OnixTitles.`imprint_symbol`,
                    OnixTitles.`weight`,
                    OnixTitles.`PhysicalThickness`,
                    OnixTitles.`PhysicalLength`,
                    OnixTitles.`PhysicalWidth`,
                    OnixTitles.`length`,
                    OnixTitles.`width`,
                    COALESCE(
                        ChildRecords.`Description`,
                        OnixTitles.`description`
                    ) AS Description,
                    OnixTitles.`table_of_contents`,
                    COALESCE(
                        ChildRecords.`PubDate`,
                        OnixTitles.`pub_date`
                    ) AS pub_date,
                    OnixTitles.`audience_code`,
                    OnixTitles.`author_bio`,
                    Bindings.`ProductFormEBookThree` AS ProductForm,
                    Bindings.`ProductFormEbookThreeDetail` AS ProductFormDetail,
                    PublishingStatus.`StatusValue`,
                    OnixTitles.`age_low`,
                    OnixTitles.`age_high`,
                    OnixTitles.`grade_low`,
                    OnixTitles.`grade_high`,
                    ProductTitles.`Edition`,
                    OnixTitles.`onixkeywords`,
                    OnixTitles.`lexile_code`,
                    EditionTypes.`Code`,
                    Bindings.`ProductFormDetailTwo`,
                    CAST(
                        PublishingStatus.StatusValue AS NCHAR
                    ) AS STRStatusValue,
                    OnixTitles.`SubscriptionRightsFlag`
                FROM
                    OnixTitles
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN Bindings ON Bindings.`Binding` = ChildRecords.`Binding`
                    LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
                    LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
                    LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
                WHERE
                    ChildRecords.`ModifyDate` >= DATE_FORMAT( (CURDATE() - INTERVAL 1 DAY),
                        '%Y-%m-%d'
                    )
                    AND OnixTitles.`isbn13` NOT IN (
                        SELECT
                            ISBN13
                        FROM
                            ProductPlaceholderData
                        WHERE
                            CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    )
                    UNION
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN`,
                    OnixTitles.`isbn10`,
                    OnixTitles.`upc`,
                    OnixTitles.`title_prefix`,
                    ChildRecords.`Title` AS title_clean,
                    OnixTitles.`subtitle`,
                    OnixTitles.`series`,
                    OnixTitles.`series_number`,
                    OnixTitles.`pages`,
                    OnixTitles.`imprint`,
                    OnixTitles.`text_language`,
                    OnixTitles.`imprint_symbol`,
                    OnixTitles.`weight`,
                    OnixTitles.`PhysicalThickness`,
                    OnixTitles.`PhysicalLength`,
                    OnixTitles.`PhysicalWidth`,
                    OnixTitles.`length`,
                    OnixTitles.`width`,
                    COALESCE(
                        ChildRecords.`Description`,
                        OnixTitles.`description`
                    ) AS Description,
                    OnixTitles.`table_of_contents`,
                    COALESCE(
                        ChildRecords.`PubDate`,
                        OnixTitles.`pub_date`
                    ) AS pub_date,
                    OnixTitles.`audience_code`,
                    OnixTitles.`author_bio`,
                    Bindings.`ProductFormEBookThree` AS ProductForm,
                    Bindings.`ProductFormEbookThreeDetail` AS ProductFormDetail,
                    PublishingStatus.`StatusValue`,
                    OnixTitles.`age_low`,
                    OnixTitles.`age_high`,
                    OnixTitles.`grade_low`,
                    OnixTitles.`grade_high`,
                    ProductTitles.`Edition`,
                    OnixTitles.`onixkeywords`,
                    OnixTitles.`lexile_code`,
                    EditionTypes.`Code`,
                    Bindings.`ProductFormDetailTwo`,
                    CAST(
                        PublishingStatus.StatusValue AS NCHAR
                    ) AS STRStatusValue,
                    OnixTitles.`SubscriptionRightsFlag`
                FROM
                    OnixTitles
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN Bindings ON Bindings.`Binding` = ChildRecords.`Binding`
                    LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
                    LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
                    LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
                WHERE
                    
                    OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') 
                    AND OnixTitles.`isbn13` NOT IN (
                        SELECT
                            ISBN13
                        FROM
                            ProductPlaceholderData
                        WHERE
                            CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    )
            ) ChildMain
        UNION
        SELECT *
        FROM (
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN`,
                    OnixTitles.`isbn10`,
                    OnixTitles.`upc`,
                    OnixTitles.`title_prefix`,
                    ProductPlaceholderData.`Title` AS title_clean,
                    "" AS `Subtitle`,
                    ProductPlaceholderData.`Series`,
                    OnixTitles.`series_number`,
                    OnixTitles.`pages`,
                    OnixTitles.`imprint`,
                    OnixTitles.`text_language`,
                    OnixTitles.`imprint_symbol`,
                    OnixTitles.`weight`,
                    OnixTitles.`PhysicalThickness`,
                    OnixTitles.`PhysicalLength`,
                    OnixTitles.`PhysicalWidth`,
                    OnixTitles.`length`,
                    OnixTitles.`width`,
                    ProductPlaceholderData.`DescriptiveCopy` AS Description,
                    "" AS `Table of Contents`,
                    COALESCE(
                        ChildRecords.`PubDate`,
                        OnixTitles.`pub_date`
                    ) AS pub_date,
                    OnixTitles.`audience_code`,
                    "" AS `Author Bio`,
                    Bindings.`ProductFormEBookThree` AS ProductForm,
                    Bindings.`ProductFormEbookThreeDetail` AS ProductFormDetail,
                    PublishingStatus.`StatusValue`,
                    OnixTitles.`age_low`,
                    OnixTitles.`age_high`,
                    OnixTitles.`grade_low`,
                    OnixTitles.`grade_high`,
                    ProductTitles.`Edition`,
                    OnixTitles.`onixkeywords`,
                    OnixTitles.`lexile_code`,
                    EditionTypes.`Code`,
                    Bindings.`ProductFormDetailTwo`,
                    CAST(
                        PublishingStatus.StatusValue AS NCHAR
                    ) AS STRStatusValue,
                    OnixTitles.`SubscriptionRightsFlag`
                FROM
                    ProductPlaceholderData
                    JOIN OnixTitles ON OnixTitles.isbn13 = ProductPlaceholderData.`ISBN13`
                    AND CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN Bindings ON Bindings.`Binding` = ChildRecords.`Binding`
                    LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
                    LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
                    LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
                WHERE
                    OnixTitles.`OnixLogFlag` = 'X'
                UNION
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN`,
                    OnixTitles.`isbn10`,
                    OnixTitles.`upc`,
                    OnixTitles.`title_prefix`,
                    ProductPlaceholderData.`Title` AS title_clean,
                    "" AS `Subtitle`,
                    ProductPlaceholderData.`Series`,
                    OnixTitles.`series_number`,
                    OnixTitles.`pages`,
                    OnixTitles.`imprint`,
                    OnixTitles.`text_language`,
                    OnixTitles.`imprint_symbol`,
                    OnixTitles.`weight`,
                    OnixTitles.`PhysicalThickness`,
                    OnixTitles.`PhysicalLength`,
                    OnixTitles.`PhysicalWidth`,
                    OnixTitles.`length`,
                    OnixTitles.`width`,
                    ProductPlaceholderData.`DescriptiveCopy` AS Description,
                    "" AS `Table of Contents`,
                    COALESCE(
                        ChildRecords.`PubDate`,
                        OnixTitles.`pub_date`
                    ) AS pub_date,
                    OnixTitles.`audience_code`,
                    "" AS `Author Bio`,
                    Bindings.`ProductFormEBookThree` AS ProductForm,
                    Bindings.`ProductFormEbookThreeDetail` AS ProductFormDetail,
                    PublishingStatus.`StatusValue`,
                    OnixTitles.`age_low`,
                    OnixTitles.`age_high`,
                    OnixTitles.`grade_low`,
                    OnixTitles.`grade_high`,
                    ProductTitles.`Edition`,
                    OnixTitles.`onixkeywords`,
                    OnixTitles.`lexile_code`,
                    EditionTypes.`Code`,
                    Bindings.`ProductFormDetailTwo`,
                    CAST(
                        PublishingStatus.StatusValue AS NCHAR
                    ) AS STRStatusValue,
                    OnixTitles.`SubscriptionRightsFlag`
                FROM
                    ProductPlaceholderData
                    JOIN OnixTitles ON OnixTitles.isbn13 = ProductPlaceholderData.`ISBN13`
                    AND CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN Bindings ON Bindings.`Binding` = ChildRecords.`Binding`
                    LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
                    LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
                    LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
                WHERE
                    ChildRecords.`ModifyDate` >= DATE_FORMAT( (CURDATE() - INTERVAL 1 DAY),
                        '%Y-%m-%d'
                    )
                    UNION
                SELECT
                    ChildRecords.`ISBN13` AS `ChildISBN`,
                    OnixTitles.`isbn10`,
                    OnixTitles.`upc`,
                    OnixTitles.`title_prefix`,
                    ProductPlaceholderData.`Title` AS title_clean,
                    "" AS `Subtitle`,
                    ProductPlaceholderData.`Series`,
                    OnixTitles.`series_number`,
                    OnixTitles.`pages`,
                    OnixTitles.`imprint`,
                    OnixTitles.`text_language`,
                    OnixTitles.`imprint_symbol`,
                    OnixTitles.`weight`,
                    OnixTitles.`PhysicalThickness`,
                    OnixTitles.`PhysicalLength`,
                    OnixTitles.`PhysicalWidth`,
                    OnixTitles.`length`,
                    OnixTitles.`width`,
                    ProductPlaceholderData.`DescriptiveCopy` AS Description,
                    "" AS `Table of Contents`,
                    COALESCE(
                        ChildRecords.`PubDate`,
                        OnixTitles.`pub_date`
                    ) AS pub_date,
                    OnixTitles.`audience_code`,
                    "" AS `Author Bio`,
                    Bindings.`ProductFormEBookThree` AS ProductForm,
                    Bindings.`ProductFormEbookThreeDetail` AS ProductFormDetail,
                    PublishingStatus.`StatusValue`,
                    OnixTitles.`age_low`,
                    OnixTitles.`age_high`,
                    OnixTitles.`grade_low`,
                    OnixTitles.`grade_high`,
                    ProductTitles.`Edition`,
                    OnixTitles.`onixkeywords`,
                    OnixTitles.`lexile_code`,
                    EditionTypes.`Code`,
                    Bindings.`ProductFormDetailTwo`,
                    CAST(
                        PublishingStatus.StatusValue AS NCHAR
                    ) AS STRStatusValue,
                    OnixTitles.`SubscriptionRightsFlag`
                FROM
                    ProductPlaceholderData
                    JOIN OnixTitles ON OnixTitles.isbn13 = ProductPlaceholderData.`ISBN13`
                    AND CURRENT_DATE() < ProductPlaceholderData.`DataReleaseDate`
                    JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.isbn13
                    LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`ISBN13`
                    AND OnixEditProductCatalogs.`CatalogID`= 5
                    LEFT JOIN Bindings ON Bindings.`Binding` = ChildRecords.`Binding`
                    LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
                    LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
                    LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
                WHERE
                   
                    OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d')  
            ) ChildMain
    ) ChildPlaceHolder
GROUP BY
    ChildPlaceHolder.ChildISBN;
    
    
SELECT
        *
FROM
        (SELECT
                OnixTitles.`isbn13`,
                OnixTitles.`isbn10`,
                OnixTitles.`upc`,
                OnixTitles.`title_prefix`,
                OnixTitles.`title_clean`,
                OnixTitles.`subtitle`,
                OnixTitles.`series`,
                OnixTitles.`series_number`,
                OnixTitles.`pages`,
                OnixTitles.`imprint`,
                OnixTitles.`text_language`,
                OnixTitles.`imprint_symbol`,
                OnixTitles.`weight`,
                OnixTitles.`PhysicalThickness`,
                OnixTitles.`PhysicalLength`,
                OnixTitles.`PhysicalWidth`,
                OnixTitles.`length`,
                OnixTitles.`width`,
                OnixTitles.`description`,
                OnixTitles.`table_of_contents`,
                OnixTitles.`pub_date`,
                OnixTitles.`audience_code`,
                OnixTitles.`author_bio`,
                Bindings.`ProductForm`,
                Bindings.`ProductFormDetail`,
                PublishingStatus.`StatusValue`,
                OnixTitles.`age_low`,
                OnixTitles.`age_high`,
                OnixTitles.`grade_low`,
                OnixTitles.`grade_high`,
                ProductTitles.`Edition`,
                OnixTitles.`onixkeywords`,
                OnixTitles.`lexile_code`,
                EditionTypes.`Code`,
                Bindings.`ProductFormDetailTwo`,
                CAST(
                        PublishingStatus.StatusValue AS NCHAR
                ) AS STRStatusValue
        FROM
                OnixTitles
                LEFT JOIN Bindings
                        ON Bindings.`Binding` = OnixTitles.`binding`
                LEFT JOIN PublishingStatus
                        ON PublishingStatus.`FMStatus` = OnixTitles.`FMStatus`
                LEFT JOIN ProductTitles
                        ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
                LEFT JOIN EditionTypes
                        ON ProductTitles.`EditionType` = EditionTypes.`Type`
                LEFT JOIN OnixEditProductCatalogs
                        ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
        WHERE OnixEditProductCatalogs.`CatalogID` = 4
                AND (
                        OnixTitles.`OnixLogFlag` = 'X'
                        OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY), '%Y-%m-%d')
                        AND OnixTitles.`isbn13` NOT IN
                        (SELECT
                                ISBN13
                        FROM
                                ProductPlaceholderData
                        WHERE DataReleaseDate >= CURRENT_DATE())
                        UNION
                        SELECT
                                ProductPlaceholderData.`ISBN13`,
                                NULL,
                                NULL,
                                NULL,
                                ProductPlaceholderData.`Title`,
                                NULL,
                                ProductPlaceholderData.`Series`,
                                OnixTitles.`series_number`,
                                OnixTitles.`pages`,
                                OnixTitles.`imprint`,
                                OnixTitles.`text_language`,
                                OnixTitles.`imprint_symbol`,
                                OnixTitles.`weight`,
                                OnixTitles.`PhysicalThickness`,
                                OnixTitles.`PhysicalLength`,
                                OnixTitles.`PhysicalWidth`,
                                OnixTitles.`length`,
                                OnixTitles.`width`,
                                ProductPlaceholderData.`DescriptiveCopy`,
                                OnixTitles.`table_of_contents`,
                                OnixTitles.`pub_date`,
                                OnixTitles.`audience_code`,
                                OnixTitles.`author_bio`,
                                Bindings.`ProductForm`,
                                Bindings.`ProductFormDetail`,
                                PublishingStatus.`StatusValue`,
                                OnixTitles.`age_low`,
                                OnixTitles.`age_high`,
                                OnixTitles.`grade_low`,
                                OnixTitles.`grade_high`,
                                ProductTitles.`Edition`,
                                OnixTitles.`onixkeywords`,
                                OnixTitles.`lexile_code`,
                                EditionTypes.`Code`,
                                Bindings.`ProductFormDetailTwo`,
                                CAST(
                                        PublishingStatus.StatusValue AS NCHAR
                                ) AS STRStatusValue
                        FROM
                                ProductPlaceholderData
                                LEFT JOIN OnixTitles
                                        ON OnixTitles.`isbn13` = ProductPlaceholderData.`ISBN13`
                                LEFT JOIN Bindings
                                        ON Bindings.`Binding` = OnixTitles.`binding`
                                LEFT JOIN PublishingStatus
                                        ON PublishingStatus.`FMStatus` = OnixTitles.`FMStatus`
                                LEFT JOIN ProductTitles
                                        ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
                                LEFT JOIN EditionTypes
                                        ON ProductTitles.`EditionType` = EditionTypes.`Type`
                                LEFT JOIN OnixEditProductCatalogs
                                        ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
                        WHERE OnixEditProductCatalogs.`CatalogID` = 4
                                AND (
                                        OnixTitles.`OnixLogFlag` = 'X'
                                        OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY), '%Y-%m-%d')
                                )
                        )) T1
        GROUP BY T1.isbn13;


-- UPDATE OnixTitles
-- SET OnixLogFlag = 'X'
SELECT * FROM OnixTitles
WHERE OnixTitles.isbn13 IN (SELECT ISBN13 FROM `ONIXModifyDatesNow`) OR OnixTitles.isbn13 IN (SELECT ISBN13 FROM OnixManualFlag) OR OnixTitles.ONIXModifyDate >= DATE_FORMAT (DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY), '%Y-%m-%d') OR OnixTitles.`isbn13` IN (SELECT ISBN13 FROM ProductPlaceholderData WHERE CURRENT_DATE() = DataReleaseDate );
-- UPDATE ChildRecords
JOIN OnixTitles
ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`
SET ChildRecords.`ModifyDate` = CURRENT_DATE()
WHERE OnixTitles.isbn13 IN (SELECT ISBN13 FROM `ONIXModifyDatesNow`) OR OnixTitles.ONIXModifyDate >= DATE_FORMAT (DATE_SUB(NOW(), INTERVAL 1 DAY), '%Y-%m-%d')


SELECT * FROM `booktrak_design_note` WHERE `booktrak_design_note`.`booktrak_id` NOT IN (SELECT booktrak_id FROM `booktrak`);


SELECT *
FROM (
        SELECT
            OnixTitles.`isbn13`,
            OnixTitles.`isbn10`,
            OnixTitles.`upc`,
            OnixTitles.`title_prefix`,
            OnixTitles.`title_clean`,
            OnixTitles.`subtitle`,
            OnixTitles.`series`,
            OnixTitles.`series_number`,
            OnixTitles.`pages`,
            OnixTitles.`imprint`,
            OnixTitles.`text_language`,
            OnixTitles.`imprint_symbol`,
            OnixTitles.`weight`,
            OnixTitles.`PhysicalThickness`,
            OnixTitles.`PhysicalLength`,
            OnixTitles.`PhysicalWidth`,
            OnixTitles.`length`,
            OnixTitles.`width`,
            OnixTitles.`description`,
            OnixTitles.`table_of_contents`,
            OnixTitles.`pub_date`,
            OnixTitles.`audience_code`,
            OnixTitles.`author_bio`,
            Bindings.`ProductForm`,
            Bindings.`ProductFormDetail`,
            PublishingStatus.`StatusValue`,
            OnixTitles.`age_low`,
            OnixTitles.`age_high`,
            OnixTitles.`grade_low`,
            OnixTitles.`grade_high`,
            ProductTitles.`Edition`,
            OnixTitles.`onixkeywords`,
            OnixTitles.`lexile_code`,
            EditionTypes.`Code`,
            Bindings.`ProductFormDetailTwo`,
            CAST(
                PublishingStatus.StatusValue AS NCHAR
            ) AS STRStatusValue
        FROM OnixTitles
            LEFT JOIN Bindings ON Bindings.`Binding` = OnixTitles.`binding`
            LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = OnixTitles.`FMStatus`
            LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
            LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
            LEFT JOIN OnixEditProductCatalogs ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
        WHERE
            OnixEditProductCatalogs.`CatalogID` = 1
            AND OnixTitles.`OnixLogFlag` = 'X'
            AND OnixTitles.`isbn13` NOT IN (
                SELECT ISBN13
                FROM
                    ProductPlaceholderData
                WHERE
                    DataReleaseDate >= CURRENT_DATE()
            )
        GROUP BY
            OnixTitles.isbn13
        UNION
        SELECT
            OnixTitles.`isbn13`,
            OnixTitles.`isbn10`,
            OnixTitles.`upc`,
            OnixTitles.`title_prefix`,
            OnixTitles.`title_clean`,
            OnixTitles.`subtitle`,
            OnixTitles.`series`,
            OnixTitles.`series_number`,
            OnixTitles.`pages`,
            OnixTitles.`imprint`,
            OnixTitles.`text_language`,
            OnixTitles.`imprint_symbol`,
            OnixTitles.`weight`,
            OnixTitles.`PhysicalThickness`,
            OnixTitles.`PhysicalLength`,
            OnixTitles.`PhysicalWidth`,
            OnixTitles.`length`,
            OnixTitles.`width`,
            OnixTitles.`description`,
            OnixTitles.`table_of_contents`,
            OnixTitles.`pub_date`,
            OnixTitles.`audience_code`,
            OnixTitles.`author_bio`,
            Bindings.`ProductForm`,
            Bindings.`ProductFormDetail`,
            PublishingStatus.`StatusValue`,
            OnixTitles.`age_low`,
            OnixTitles.`age_high`,
            OnixTitles.`grade_low`,
            OnixTitles.`grade_high`,
            ProductTitles.`Edition`,
            OnixTitles.`onixkeywords`,
            OnixTitles.`lexile_code`,
            EditionTypes.`Code`,
            Bindings.`ProductFormDetailTwo`,
            CAST(
                PublishingStatus.StatusValue AS NCHAR
            ) AS STRStatusValue
        FROM OnixTitles
            LEFT JOIN Bindings ON Bindings.`Binding` = OnixTitles.`binding`
            LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = OnixTitles.`FMStatus`
            LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
            LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
            LEFT JOIN OnixEditProductCatalogs ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
        WHERE
            OnixEditProductCatalogs.`CatalogID` = 1
            AND OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT( (NOW() - INTERVAL 1 DAY),
                '%Y-%m-%d'
            )
            AND OnixTitles.`isbn13` NOT IN (
                SELECT ISBN13
                FROM
                    ProductPlaceholderData
                WHERE
                    DataReleaseDate >= CURRENT_DATE()
            )
        GROUP BY
            OnixTitles.isbn13
        UNION
        SELECT
            ProductPlaceholderData.`ISBN13`,
            OnixTitles.`isbn10`,
            NULL,
            NULL,
            ProductPlaceholderData.`Title`,
            NULL,
            ProductPlaceholderData.`Series`,
            NULL,
            OnixTitles.`pages`,
            OnixTitles.`imprint`,
            OnixTitles.`text_language`,
            OnixTitles.`imprint_symbol`,
            OnixTitles.`weight`,
            OnixTitles.`PhysicalThickness`,
            OnixTitles.`PhysicalLength`,
            OnixTitles.`PhysicalWidth`,
            OnixTitles.`length`,
            OnixTitles.`width`,
            ProductPlaceholderData.`DescriptiveCopy`,
            OnixTitles.`table_of_contents`,
            OnixTitles.`pub_date`,
            OnixTitles.`audience_code`,
            OnixTitles.`author_bio`,
            Bindings.`ProductForm`,
            Bindings.`ProductFormDetail`,
            PublishingStatus.`StatusValue`,
            OnixTitles.`age_low`,
            OnixTitles.`age_high`,
            OnixTitles.`grade_low`,
            OnixTitles.`grade_high`,
            ProductTitles.`Edition`,
            NULL,
            OnixTitles.`lexile_code`,
            EditionTypes.`Code`,
            Bindings.`ProductFormDetailTwo`,
            CAST(
                PublishingStatus.StatusValue AS NCHAR
            ) AS STRStatusValue
        FROM
            ProductPlaceholderData
            LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ProductPlaceholderData.`ISBN13`
            LEFT JOIN Bindings ON Bindings.`Binding` = OnixTitles.`binding`
            LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = OnixTitles.`FMStatus`
            LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
            LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
            LEFT JOIN OnixEditProductCatalogs ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
        WHERE
            OnixEditProductCatalogs.`CatalogID` = 1
            AND OnixTitles.`OnixLogFlag` = 'X'
        GROUP BY
            OnixTitles.isbn13
        UNION
        SELECT
            ProductPlaceholderData.`ISBN13`,
            OnixTitles.`isbn10`,
            NULL,
            NULL,
            ProductPlaceholderData.`Title`,
            NULL,
            ProductPlaceholderData.`Series`,
            NULL,
            OnixTitles.`pages`,
            OnixTitles.`imprint`,
            OnixTitles.`text_language`,
            OnixTitles.`imprint_symbol`,
            OnixTitles.`weight`,
            OnixTitles.`PhysicalThickness`,
            OnixTitles.`PhysicalLength`,
            OnixTitles.`PhysicalWidth`,
            OnixTitles.`length`,
            OnixTitles.`width`,
            ProductPlaceholderData.`DescriptiveCopy`,
            OnixTitles.`table_of_contents`,
            OnixTitles.`pub_date`,
            OnixTitles.`audience_code`,
            OnixTitles.`author_bio`,
            Bindings.`ProductForm`,
            Bindings.`ProductFormDetail`,
            PublishingStatus.`StatusValue`,
            OnixTitles.`age_low`,
            OnixTitles.`age_high`,
            OnixTitles.`grade_low`,
            OnixTitles.`grade_high`,
            ProductTitles.`Edition`,
            NULL,
            OnixTitles.`lexile_code`,
            EditionTypes.`Code`,
            Bindings.`ProductFormDetailTwo`,
            CAST(
                PublishingStatus.StatusValue AS NCHAR
            ) AS STRStatusValue
        FROM
            ProductPlaceholderData
            LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ProductPlaceholderData.`ISBN13`
            LEFT JOIN Bindings ON Bindings.`Binding` = OnixTitles.`binding`
            LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = OnixTitles.`FMStatus`
            LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
            LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
            LEFT JOIN OnixEditProductCatalogs ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
        WHERE
            OnixEditProductCatalogs.`CatalogID` = 1
            AND OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT( (NOW() - INTERVAL 1 DAY),
                '%Y-%m-%d'
            )
        GROUP BY
            OnixTitles.isbn13
    ) T1
GROUP BY T1.isbn13;



SELECT
    OnixTitles.`isbn13`,
    Contributors.`FullNameInPrint`,
    ContributorISBNRelation.`OnixFullName`,
    ContributorISBNRelation.`AuthorLastName`,
    Contributors.`CompanyName`,
    Contributors.`OnixBio`,
    Contributors.`OnixFirstNameInPrint`,
    Contributors.`OnixLastNameInPrint`,
    ContributorRoles.Value,
    Contributors.`WebsiteURL`,
    CountryList.`CountryCode`
FROM OnixTitles
    LEFT JOIN ContributorISBNRelation ON OnixTitles.`isbn13` = ContributorISBNRelation.`ISBN13`
    LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
    LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
    LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
    LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
    LEFT JOIN OnixEditProductCatalogs ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE
    OnixEditProductCatalogs.`CatalogID` = 1
    AND (OnixTitles.`OnixLogFlag` = 'X')
    AND (
        Contributors.`OnixLastNameInPrint` <> ""
        OR Contributors.`CompanyName` <> ""
    )
    AND (
        Contributors.`OnixLastNameInPrint` IS NOT NULL
        OR Contributors.`CompanyName` IS NOT NULL
    )
    AND OnixTitles.`isbn13` NOT IN (
        SELECT ISBN13
        FROM
            `ProductPlaceholderData`
        WHERE
            `DataReleaseDate` > CURRENT_DATE()
    )
UNION
SELECT
    OnixTitles.`isbn13`,
    Contributors.`FullNameInPrint`,
    ContributorISBNRelation.`OnixFullName`,
    ContributorISBNRelation.`AuthorLastName`,
    Contributors.`CompanyName`,
    Contributors.`OnixBio`,
    Contributors.`OnixFirstNameInPrint`,
    Contributors.`OnixLastNameInPrint`,
    ContributorRoles.Value,
    Contributors.`WebsiteURL`,
    CountryList.`CountryCode`
FROM OnixTitles
    LEFT JOIN ContributorISBNRelation ON OnixTitles.`isbn13` = ContributorISBNRelation.`ISBN13`
    LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
    LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
    LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
    LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
    LEFT JOIN OnixEditProductCatalogs ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE
    OnixEditProductCatalogs.`CatalogID` = 1
    AND OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT( (CURRENT_DATE() - INTERVAL 1 DAY),
        '%Y-%m-%d'
    )
    AND (
        Contributors.`OnixLastNameInPrint` <> ""
        OR Contributors.`CompanyName` <> ""
    )
    AND (
        Contributors.`OnixLastNameInPrint` IS NOT NULL
        OR Contributors.`CompanyName` IS NOT NULL
    )
    AND OnixTitles.`isbn13` NOT IN (
        SELECT ISBN13
        FROM
            `ProductPlaceholderData`
        WHERE
            `DataReleaseDate` > CURRENT_DATE()
    )
UNION
SELECT
    OnixTitles.`isbn13`,
    ContributorPlaceHolderData.`FullName`,
    ContributorPlaceHolderData.`FullName`,
    ContributorPlaceHolderData.`ContributorLastName`,
    ContributorPlaceHolderData.`Company`,
    ContributorPlaceHolderData.`Bio`,
    ContributorPlaceHolderData.`ContributorFirstName`,
    ContributorPlaceHolderData.`ContributorLastName`,
    ContributorPlaceHolderData.`Role`,
    ContributorPlaceHolderData.`Website`,
    CountryList.`CountryCode`
FROM `ProductPlaceholderData`
    LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ProductPlaceholderData.`ISBN13`
    LEFT JOIN ContributorISBNRelation ON OnixTitles.`isbn13` = ContributorISBNRelation.`ISBN13`
    LEFT JOIN `ContributorPlaceHolderData` ON ContributorISBNRelation.`AuthorID` = `ContributorPlaceHolderData`.`ContributorID`
    LEFT JOIN `CountryList` ON ContributorPlaceHolderData.`Country` = `CountryList`.`Country`
    LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
    LEFT JOIN OnixEditProductCatalogs ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE
    OnixEditProductCatalogs.`CatalogID` = 1
    AND (
        ContributorPlaceHolderData.`ContributorLastName` <> ""
    )
    AND OnixTitles.`OnixLogFlag` = 'X'
    AND (
        ContributorPlaceHolderData.`ContributorLastName` IS NOT NULL
    )
    AND ProductPlaceholderData.`DataReleaseDate` > CURRENT_DATE()
UNION
SELECT
    OnixTitles.`isbn13`,
    ContributorPlaceHolderData.`FullName`,
    ContributorPlaceHolderData.`FullName`,
    ContributorPlaceHolderData.`ContributorLastName`,
    ContributorPlaceHolderData.`Company`,
    ContributorPlaceHolderData.`Bio`,
    ContributorPlaceHolderData.`ContributorFirstName`,
    ContributorPlaceHolderData.`ContributorLastName`,
    ContributorPlaceHolderData.`Role`,
    ContributorPlaceHolderData.`Website`,
    CountryList.`CountryCode`
FROM `ProductPlaceholderData`
    LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ProductPlaceholderData.`ISBN13`
    LEFT JOIN ContributorISBNRelation ON OnixTitles.`isbn13` = ContributorISBNRelation.`ISBN13`
    LEFT JOIN `ContributorPlaceHolderData` ON ContributorISBNRelation.`AuthorID` = `ContributorPlaceHolderData`.`ContributorID`
    LEFT JOIN `CountryList` ON ContributorPlaceHolderData.`Country` = `CountryList`.`Country`
    LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
    LEFT JOIN OnixEditProductCatalogs ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE
    OnixEditProductCatalogs.`CatalogID` = 1
    AND (
        ContributorPlaceHolderData.`ContributorLastName` <> ""
    )
    AND OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT( (NOW() - INTERVAL 1 DAY),
        '%Y-%m-%d'
    )
    AND (
        ContributorPlaceHolderData.`ContributorLastName` IS NOT NULL
    )
    AND ProductPlaceholderData.`DataReleaseDate` > CURRENT_DATE();
    
    
    
    
    SELECT ChildRecords.`ISBN13`, Contributors.`FullNameInPrint`, ContributorISBNRelation.`OnixFullName`, ContributorISBNRelation.`AuthorLastName`, Contributors.`CompanyName`, 
Contributors.`OnixBio`, Contributors.`OnixFirstNameInPrint`, Contributors.`OnixLastNameInPrint`, ContributorRoles.Value, Contributors.`WebsiteURL`, CountryList.`CountryCode` 
FROM ChildRecords
LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`
LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
LEFT JOIN ContributorISBNRelation ON OnixTitles.`isbn13` = ContributorISBNRelation.`ISBN13` 
LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 6 AND (Contributors.`OnixLastNameInPrint` <> "" OR Contributors.`CompanyName` <> "") 
AND (Contributors.`OnixLastNameInPrint` IS NOT NULL OR Contributors.`CompanyName` IS NOT NULL ) AND ChildRecords.`ModifyDate` >= CURDATE() - 1
ORDER BY ChildRecords.`ISBN13`, ContributorISBNRelation.`ID`;


SELECT ChildRecords.`ISBN13`, OnixTitles.`isbn10`, OnixTitles.`upc`, OnixTitles.`title_prefix`, ChildRecords.`Title` AS title_clean, OnixTitles.`subtitle`, OnixTitles.`series`,
OnixTitles.`series_number`, OnixTitles.`pages`, OnixTitles.`imprint`, OnixTitles.`text_language`, OnixTitles.`imprint_symbol`, OnixTitles.`weight`, OnixTitles.`PhysicalThickness`, 
OnixTitles.`PhysicalLength`, OnixTitles.`PhysicalWidth`, OnixTitles.`length`, OnixTitles.`width`,  COALESCE(ChildRecords.`Description`, OnixTitles.`description`) AS Description, OnixTitles.`table_of_contents`, 
COALESCE(ChildRecords.`PubDate`, OnixTitles.`pub_date`) AS pub_date, OnixTitles.`audience_code`, OnixTitles.`author_bio`,
Bindings.`ProductForm`, Bindings.`ProductFormDetail`, PublishingStatus.`StatusValue`, OnixTitles.`age_low`, OnixTitles.`age_high`, OnixTitles.`grade_low`, OnixTitles.`grade_high`,
ProductTitles.`Edition`, OnixTitles.`onixkeywords`,  OnixTitles.`lexile_code`, EditionTypes.`Code`, Bindings.`ProductFormDetailTwo`, CAST(PublishingStatus.StatusValue AS NCHAR) AS STRStatusValue,
Bindings.`ePubType`, OnixTitles.`SubscriptionRightsFlag`, IF(LENGTH(OnixTitles.`subtitleelq`) > 0,OnixTitles.`subtitleelq`, OnixTitles.`subtitle`) AS AMZSubTitle, OnixTitles.`AmazonAwardsOnixDescriptionAddon` 
FROM ChildRecords 
LEFT JOIN OnixTitles ON ChildRecords.`ParentISBN13` = OnixTitles.`isbn13`
LEFT JOIN Bindings ON Bindings.`Binding` = ChildRecords.`Binding`
LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 5 AND (ChildRecords.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d')OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d'));

SELECT ChildRecords.`ISBN13`, Contributors.`FullNameInPrint`, ContributorISBNRelation.`OnixFullName`, ContributorISBNRelation.`AuthorLastName`, Contributors.`CompanyName`, 
Contributors.`OnixBio`, Contributors.`OnixFirstNameInPrint`, Contributors.`OnixLastNameInPrint`, ContributorRoles.Value, Contributors.`WebsiteURL`, CountryList.`CountryCode` 
FROM OnixTitles
LEFT JOIN ContributorISBNRelation ON OnixTitles.`isbn13` = ContributorISBNRelation.`ISBN13` 
LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
LEFT JOIN ChildRecords ON ChildRecords.`ParentISBN13` = ProductTitles.`ISBN13`
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 6 AND (Contributors.`OnixLastNameInPrint` <> "" OR Contributors.`CompanyName` <> "") 
AND (Contributors.`OnixLastNameInPrint` IS NOT NULL OR Contributors.`CompanyName` IS NOT NULL ) AND (ChildRecords.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixTitles.`OnixLogFlag` = 'X') ORDER BY ChildRecords.`ISBN13`, ContributorISBNRelation.`ID`;


SELECT ChildRecords.`ISBN13`, OnixTitles.`isbn10`, OnixTitles.`upc`, OnixTitles.`title_prefix`, OnixTitles.`title_clean`, OnixTitles.`subtitle`, OnixTitles.`series`,
OnixTitles.`series_number`, OnixTitles.`pages`, OnixTitles.`imprint`, OnixTitles.`text_language`, OnixTitles.`imprint_symbol`, OnixTitles.`weight`, OnixTitles.`PhysicalThickness`, 
OnixTitles.`PhysicalLength`, OnixTitles.`PhysicalWidth`, OnixTitles.`length`, OnixTitles.`width`,  COALESCE(ChildRecords.`Description`, OnixTitles.`description`) AS Description, OnixTitles.`table_of_contents`, 
COALESCE(ChildRecords.`PubDate`, OnixTitles.`pub_date`) AS pub_date, OnixTitles.`audience_code`, OnixTitles.`author_bio`,
Bindings.`ProductForm`, Bindings.`ProductFormDetail`, PublishingStatus.`StatusValue`, OnixTitles.`age_low`, OnixTitles.`age_high`, OnixTitles.`grade_low`, OnixTitles.`grade_high`,
ProductTitles.`Edition`, OnixTitles.`onixkeywords`,  OnixTitles.`lexile_code`, EditionTypes.`Code`, Bindings.`ProductFormDetailTwo`, CAST(PublishingStatus.StatusValue AS NCHAR) AS STRStatusValue,
Bindings.`ePubType`, OnixTitles.`SubscriptionRightsFlag` 
FROM ChildRecords 
LEFT JOIN OnixTitles ON ChildRecords.`ParentISBN13` = OnixTitles.`isbn13`
LEFT JOIN Bindings ON Bindings.`Binding` = ChildRecords.`Binding`
LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 5 AND (ChildRecords.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d')OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixTitles.`OnixLogFlag` = 'X');




SELECT ChildRecords.`ISBN13`, OnixTitles.`isbn10`, OnixTitles.`upc`, OnixTitles.`title_prefix`, ChildRecords.`Title` AS title_clean, OnixTitles.`subtitle`, OnixTitles.`series`,
OnixTitles.`series_number`, OnixTitles.`pages`, OnixTitles.`imprint`, OnixTitles.`text_language`, OnixTitles.`imprint_symbol`, OnixTitles.`weight`, OnixTitles.`PhysicalThickness`,
OnixTitles.`PhysicalLength`, OnixTitles.`PhysicalWidth`, OnixTitles.`length`, OnixTitles.`width`, COALESCE(ChildRecords.`Description`, OnixTitles.`description`) AS Description, OnixTitles.`table_of_contents`,
COALESCE(ChildRecords.`PubDate`, OnixTitles.`pub_date`) AS pub_date, OnixTitles.`audience_code`, OnixTitles.`author_bio`,
Bindings.`ProductFormEBookThree` AS ProductForm, Bindings.`ProductFormEbookThreeDetail` AS ProductFormDetail, PublishingStatus.`StatusValue`, OnixTitles.`age_low`, OnixTitles.`age_high`, OnixTitles.`grade_low`, OnixTitles.`grade_high`,
ProductTitles.`Edition`, OnixTitles.`onixkeywords`,  OnixTitles.`lexile_code`, EditionTypes.`Code`, Bindings.`ProductFormDetailTwo`, CAST(PublishingStatus.StatusValue AS NCHAR) AS STRStatusValue, OnixTitles.`SubscriptionRightsFlag`, ONIXDescription.`DescriptionApple` AS `AppleDescription`
FROM ChildRecords
LEFT JOIN OnixTitles ON ChildRecords.`ParentISBN13` = OnixTitles.`isbn13`
LEFT JOIN Bindings ON Bindings.`Binding` = ChildRecords.`Binding`
LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
LEFT JOIN EditionTypes ON ProductTitles.`EditionType` = EditionTypes.`Type`
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
LEFT JOIN ONIXDescription ON ChildRecords.`ParentISBN13` = ONIXDescription.`ISBN13`
WHERE OnixEditProductCatalogs.`CatalogID` = 8 AND (ChildRecords.`ModifyDate` >= DATE_FORMAT((CURRENT_DATE() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((CURRENT_DATE() - INTERVAL 1 DAY),'%Y-%m-%d'));




/***************** Contributors Child 3.0 */
SELECT ChildRecords.`ISBN13`, Contributors.`FullNameInPrint`, ContributorISBNRelation.`OnixFullName`, ContributorISBNRelation.`AuthorLastName`, Contributors.`CompanyName`, 
Contributors.`OnixBio`, Contributors.`OnixFirstNameInPrint`, Contributors.`OnixLastNameInPrint`, ContributorRoles.Value, Contributors.`WebsiteURL`, CountryList.`CountryCode` 
FROM OnixTitles
LEFT JOIN ContributorISBNRelation ON OnixTitles.`isbn13` = ContributorISBNRelation.`ISBN13` 
LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
LEFT JOIN ChildRecords ON ChildRecords.`ParentISBN13` = ProductTitles.`ISBN13`
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 6 AND (Contributors.`OnixLastNameInPrint` <> "" OR Contributors.`CompanyName` <> "") 
AND (Contributors.`OnixLastNameInPrint` IS NOT NULL OR Contributors.`CompanyName` IS NOT NULL ) AND (ChildRecords.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixTitles.`OnixLogFlag` = 'X') ORDER BY ChildRecords.`ISBN13`, ContributorISBNRelation.`ID`;




/**************** Contributors Child 2.1 */
SELECT ChildRecords.`ISBN13`, Contributors.`FullNameInPrint`, ContributorISBNRelation.`OnixFullName`, ContributorISBNRelation.`AuthorLastName`, Contributors.`CompanyName`, 
Contributors.`OnixBio`, Contributors.`OnixFirstNameInPrint`, Contributors.`OnixLastNameInPrint`, ContributorRoles.Value, Contributors.`WebsiteURL`, CountryList.`CountryCode` 
FROM OnixTitles
LEFT JOIN ContributorISBNRelation ON OnixTitles.`isbn13` = ContributorISBNRelation.`ISBN13` 
LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
LEFT JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.`ISBN13` AND `ChildRecords`.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d')
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 5 AND (Contributors.`OnixLastNameInPrint` <> "" OR Contributors.`CompanyName` <> "") 
AND (Contributors.`OnixLastNameInPrint` IS NOT NULL OR Contributors.`CompanyName` IS NOT NULL ) 
AND (`ChildRecords`.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixTitles.`OnixLogFlag` = 'X')
ORDER BY ChildRecords.`ISBN13`, ContributorISBNRelation.`ID`;




SELECT
        ProductPrices.`Price`,
        ProductPrices.`ISBN13`,
        CountryList.`CountryCode`,
        CountryList.`CurrencyCode`,
        ChildRecords.`discount_code`,
        ChildRecords.`carton_pack`,
        ChildRecords.`pub_date`,
        PublishingStatus.`AvailabilityValue`,
        CAST(
                PublishingStatus.AvailabilityValue AS NCHAR
        ) AS STRAvailabilityValue,
        CAST(CountryList.`Qualifier` AS NCHAR) AS STRQualifier,
        CAST(ProductPrices.`Price` AS NCHAR) AS STRPrice
FROM
        ProductPrices
        LEFT JOIN CountryList
                ON ProductPrices.`CountryID` = CountryList.`ID`
        JOIN
                (SELECT
                        ChildRecords.`ISBN13`,
                        ChildRecords.`ModifyDate`,
                        ChildRecords.`ParentISBN13`,
                        OnixEditProductCatalogs.`ModifyDate` AS `OnixCatalogModifyDate`,
                        ChildRecords.`Status`,
                        OnixTitles.`discount_code`,
                        OnixTitles.`carton_pack`,
                        OnixTitles.`pub_date`,
                        OnixTitles.`OnixLogFlag`
                FROM
                        OnixTitles
                        JOIN ChildRecords
                                ON ChildRecords.`ParentISBN13` = OnixTitles.`isbn13`
                        JOIN OnixEditProductCatalogs
                                ON OnixEditProductCatalogs.`ISBN13` = ChildRecords.`ISBN13`
                                AND OnixEditProductCatalogs.`CatalogID` = 6) ChildRecords
                ON ChildRecords.`ISBN13` = ProductPrices.`ISBN13`
        LEFT JOIN PublishingStatus
                ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
WHERE (
                `ChildRecords`.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY), '%Y-%m-%d')
                OR ChildRecords.`OnixCatalogModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY), '%Y-%m-%d')
                OR ChildRecords.`OnixLogFlag` = 'X'
        );


SELECT * FROM ChildRecords
JOIN OnixTitles
ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`;



SELECT ProductPrices.`Price`, ProductPrices.`ISBN13`, CountryList.`CountryCode`, CountryList.`CurrencyCode`, OnixTitles.`discount_code`, 
OnixTitles.`carton_pack`, OnixTitles.`pub_date`, PublishingStatus.`AvailabilityValue`, CAST(PublishingStatus.AvailabilityValue AS NCHAR) AS STRAvailabilityValue, 
CAST(CountryList.`Qualifier` AS NCHAR) AS STRQualifier, CAST(ProductPrices.`Price` AS NCHAR) AS STRPrice
FROM ProductPrices
JOIN ChildRecords ON ChildRecords.`ISBN13` = ProductPrices.`ISBN13`
JOIN OnixEditProductCatalogs ON OnixEditProductCatalogs.`ISBN13` = ChildRecords.`ISBN13` AND OnixEditProductCatalogs.`CatalogID` = 6
LEFT JOIN CountryList ON ProductPrices.`CountryID` = CountryList.`ID`
LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`
LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
WHERE(
                `ChildRecords`.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY), '%Y-%m-%d')
                OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY), '%Y-%m-%d')
                OR OnixTitles.`OnixLogFlag` = 'X');

SELECT ChildRecords.`ISBN13`, Contributors.`FullNameInPrint`, ContributorISBNRelation.`OnixFullName`, ContributorISBNRelation.`AuthorLastName`, Contributors.`CompanyName`, 
Contributors.`OnixBio`, Contributors.`OnixFirstNameInPrint`, Contributors.`OnixLastNameInPrint`, ContributorRoles.Value, Contributors.`WebsiteURL`, CountryList.`CountryCode` 
FROM OnixTitles
LEFT JOIN ContributorISBNRelation ON OnixTitles.`isbn13` = ContributorISBNRelation.`ISBN13` 
LEFT JOIN `Contributors` ON ContributorISBNRelation.`AuthorID` = `Contributors`.`ContributorID`
LEFT JOIN `ContributorRoles` ON Contributors.`ContributorType` = `ContributorRoles`.`FMDescription`
LEFT JOIN `CountryList` ON Contributors.`Country` = `CountryList`.`Country`
LEFT JOIN ChildRecords ON ChildRecords.`ParentISBN13` = OnixTitles.`ISBN13`
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 5 AND (Contributors.`OnixLastNameInPrint` <> "" OR Contributors.`CompanyName` <> "") 
AND (Contributors.`OnixLastNameInPrint` IS NOT NULL OR Contributors.`CompanyName` IS NOT NULL ) 
AND (`ChildRecords`.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixTitles.`OnixLogFlag` = 'X')
ORDER BY ChildRecords.`ISBN13`, ContributorISBNRelation.`ID`;


SELECT ProductPrices.`Price`, ProductPrices.`ISBN13`, CountryList.`CountryCode`, CountryList.`CurrencyCode`, OnixTitles.`discount_code`, 
OnixTitles.`carton_pack`, OnixTitles.`pub_date`, PublishingStatus.`AvailabilityValue`, CAST(PublishingStatus.AvailabilityValue AS NCHAR) AS STRAvailabilityValue, 
CAST(CountryList.`Qualifier` AS NCHAR) AS STRQualifier, CAST(ProductPrices.`Price` AS NCHAR) AS STRPrice
FROM ProductPrices
JOIN ChildRecords ON ChildRecords.`ISBN13` = ProductPrices.`ISBN13`
JOIN OnixEditProductCatalogs ON OnixEditProductCatalogs.`ISBN13` = ChildRecords.`ISBN13` AND OnixEditProductCatalogs.`CatalogID` = 6
LEFT JOIN CountryList ON ProductPrices.`CountryID` = CountryList.`ID`
LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`
LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
WHERE(
                `ChildRecords`.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY), '%Y-%m-%d')
                OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY), '%Y-%m-%d')
                OR OnixTitles.`OnixLogFlag` = 'X');

SELECT DATE_FORMAT(
                DATE_SUB(NOW(), INTERVAL 4 DAY),
                '%Y-%m-%d');

UPDATE
        OnixTitles
SET
        OnixLogFlag = 'X'
WHERE OnixTitles.isbn13 IN
        (SELECT
                ISBN13
        FROM
                `ONIXModifyDatesNow`)
        OR OnixTitles.isbn13 IN
        (SELECT
                ISBN13
        FROM
                OnixManualFlag)
        OR OnixTitles.ONIXModifyDate >= DATE_FORMAT(
                DATE_SUB(NOW(), INTERVAL 4 DAY),
                '%Y-%m-%d'
        );

UPDATE
        ChildRecords
        JOIN OnixTitles
                ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13` SET ChildRecords.`ModifyDate` = CURRENT_DATE()
WHERE OnixTitles.isbn13 IN
        (SELECT
                ISBN13
        FROM
                `ONIXModifyDatesNow`)
        OR OnixTitles.ONIXModifyDate >= DATE_FORMAT(
                DATE_SUB(NOW(), INTERVAL 1 DAY),
                '%Y-%m-%d'
        )
        OR OnixTitles.`isbn13` IN
        (SELECT
                ISBN13
        FROM
                ProductPlaceholderData
        WHERE CURRENT_DATE() = DataReleaseDate);
        
        
        
        
        EXPLAIN
        SELECT
        `OnixTitles`.`isbn13`        AS `isbn13`,
        `OnixTitles`.`title_clean`   AS `title_clean`,
        `OnixTitles`.`title_prefix`  AS `title_prefix`,
        `OnixTitles`.`series`        AS `series`,
        `OnixTitles`.`series_number` AS `series_number`,
        (SELECT
                 CONCAT(`Contributors`.`OnixFirstNameInPrint`,' ',`Contributors`.`OnixLastNameInPrint`)
         FROM (`Contributors`
                  JOIN `ContributorISBNRelation`
                    ON ((`ContributorISBNRelation`.`AuthorID` = `Contributors`.`ContributorID`)))
         WHERE (`ContributorISBNRelation`.`ISBN13` = `OnixTitles`.`isbn13`)
         LIMIT 0,1) AS `Contributor 1`,
        (SELECT
                 CONCAT(`Contributors`.`OnixFirstNameInPrint`,' ',`Contributors`.`OnixLastNameInPrint`)
         FROM (`Contributors`
                  JOIN `ContributorISBNRelation`
                    ON ((`ContributorISBNRelation`.`AuthorID` = `Contributors`.`ContributorID`)))
         WHERE (`ContributorISBNRelation`.`ISBN13` = `OnixTitles`.`isbn13`)
         LIMIT 1,1) AS `Contributor 2`,
        (SELECT
                 `Contributors`.`OnixFirstNameInPrint`
         FROM (`Contributors`
                  JOIN `ContributorISBNRelation`
                    ON ((`ContributorISBNRelation`.`AuthorID` = `Contributors`.`ContributorID`)))
         WHERE (`ContributorISBNRelation`.`ISBN13` = `OnixTitles`.`isbn13`)
         LIMIT 0,1) AS `Contributor 1 First Name`,
        (SELECT
                 `Contributors`.`OnixLastNameInPrint`
         FROM (`Contributors`
                  JOIN `ContributorISBNRelation`
                    ON ((`ContributorISBNRelation`.`AuthorID` = `Contributors`.`ContributorID`)))
         WHERE (`ContributorISBNRelation`.`ISBN13` = `OnixTitles`.`isbn13`)
         LIMIT 0,1) AS `Contributor 1 Last Name`,
        (SELECT
                 `Contributors`.`OnixFirstNameInPrint`
         FROM (`Contributors`
                  JOIN `ContributorISBNRelation`
                    ON ((`ContributorISBNRelation`.`AuthorID` = `Contributors`.`ContributorID`)))
         WHERE (`ContributorISBNRelation`.`ISBN13` = `OnixTitles`.`isbn13`)
         LIMIT 1,1) AS `Contributor 2 First Name`,
        (SELECT
                 `Contributors`.`OnixLastNameInPrint`
         FROM (`Contributors`
                  JOIN `ContributorISBNRelation`
                    ON ((`ContributorISBNRelation`.`AuthorID` = `Contributors`.`ContributorID`)))
         WHERE (`ContributorISBNRelation`.`ISBN13` = `OnixTitles`.`isbn13`)
         LIMIT 1,1) AS `Contributor 2 Last Name`,
        `OnixTitles`.`binding`       AS `binding`,
        `OnixTitles`.`uk_price`      AS `uk_price`,
        (SELECT
                 CONCAT(`UKProductInfo`.`PubDay`,'/',`UKProductInfo`.`PubMonth`,'/',`UKProductInfo`.`PubYear`)
         FROM `UKProductInfo`
         WHERE (`UKProductInfo`.`ISBN13` = `OnixTitles`.`isbn13`)
         LIMIT 0,1) AS `PubDate`,
        (SELECT
                 `UKProductInfo`.`Length`
         FROM `UKProductInfo`
         WHERE (`UKProductInfo`.`ISBN13`  = `OnixTitles`.`isbn13`)
         LIMIT 0,1) AS `Length`,
        (SELECT
                 `UKProductInfo`.`Width`
         FROM `UKProductInfo`
         WHERE (`UKProductInfo`.`ISBN13`  = `OnixTitles`.`isbn13`)
         LIMIT 0,1) AS `Width`,
        `OnixTitles`.`pages`         AS `pages`,
        `OnixTitles`.`age_low`       AS `age_low`,
        `OnixTitles`.`age_high`      AS `age_high`,
        (SELECT
                 `BICCode`.`BICCode`
         FROM ((`BICCode`
                   JOIN `MapBISACBIC`
                     ON ((`MapBISACBIC`.`BICCode` = `BICCode`.`BICCode`)))
                  JOIN `BISACJoin`
                    ON ((`BISACJoin`.`BISACCode`  = `MapBISACBIC`.`BISACCode`)))
         WHERE (`BISACJoin`.`ISBN13`  = `OnixTitles`.`isbn13`)
         LIMIT 0,1) AS `BIC`,
        (SELECT
                 CONCAT(COALESCE(`THEMACodes`.`ThemaCode1`,''),' ',COALESCE(`THEMACodes`.`ThemaCodeTwo`,''),' ',COALESCE(`THEMACodes`.`ThemaCodeThree`,''),' ',COALESCE(`THEMACodes`.`ThemaCodeFour`,'')) AS `THEMA Codes`
         FROM ((`THEMACodes`
                   JOIN `MapBISACTHEMA`
                     ON ((`MapBISACTHEMA`.`ThemaID` = `THEMACodes`.`ID`)))
                  JOIN `BISACJoin`
                    ON ((`BISACJoin`.`BISACCode`  = `MapBISACTHEMA`.`BISACCode`)))
         WHERE (`BISACJoin`.`ISBN13`  = `OnixTitles`.`isbn13`)
         LIMIT 0,1) AS `THEMACode`,
        `OnixTitles`.`subtitle`      AS `subtitle`,
        `OnixTitles`.`edition`       AS `edition`,
        `OnixTitles`.`onixkeywords`  AS `onixkeywords`,
        `OnixTitles`.`description`   AS `description`,
        `OnixTitles`.`imprint`       AS `imprint`,
        `OnixTitles`.`TitleID`       AS `TitleID`
FROM `OnixTitles`;









UPDATE OnixTitles
SET OnixLogFlag = 'X'
WHERE OnixTitles.isbn13 IN (SELECT ISBN13 FROM `ONIXModifyDatesNow`) OR OnixTitles.isbn13 IN (SELECT ISBN13 FROM OnixManualFlag) OR OnixTitles.ONIXModifyDate >= DATE_FORMAT (DATE_SUB(NOW(), INTERVAL 4 DAY), '%Y-%m-%d');
UPDATE ChildRecords
JOIN OnixTitles
ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`
SET ChildRecords.`ModifyDate` = CURRENT_DATE()
WHERE OnixTitles.isbn13 IN (SELECT ISBN13 FROM `ONIXModifyDatesNow`) OR OnixTitles.ONIXModifyDate >= DATE_FORMAT (DATE_SUB(NOW(), INTERVAL 4 DAY), '%Y-%m-%d') OR OnixTitles.`isbn13` IN (SELECT ISBN13 FROM ProductPlaceholderData WHERE CURRENT_DATE() = DataReleaseDate) ;


SELECT * FROM ProductTitles
GROUP BY ISBN13 HAVING COUNT(ISBN13) > 1

;
UPDATE OnixTitles
SET OnixLogFlag = 'X'
WHERE OnixTitles.isbn13 IN (SELECT ISBN13 FROM `ONIXModifyDatesNow`) OR OnixTitles.isbn13 IN (SELECT ISBN13 FROM OnixManualFlag) OR OnixTitles.ONIXModifyDate >= DATE_FORMAT (DATE_SUB(NOW(), INTERVAL 1 DAY), '%Y-%m-%d');
UPDATE ChildRecords
JOIN OnixTitles
ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`
SET ChildRecords.`ModifyDate` = CURRENT_DATE()
WHERE OnixTitles.isbn13 IN (SELECT ISBN13 FROM `ONIXModifyDatesNow`) OR OnixTitles.ONIXModifyDate >= DATE_FORMAT (DATE_SUB(NOW(), INTERVAL 1 DAY), '%Y-%m-%d') OR OnixTitles.`isbn13` IN (SELECT ISBN13 FROM ProductPlaceholderData WHERE CURRENT_DATE() = DataReleaseDate);


SELECT DISTINCT(EARC) FROM SalesMaterials
WHERE ISBN13 = '9781728278285';



/*********************** Update Dates in OnixTitles **************************/
SET SQL_MODE='';-- SELECT pub_date, isbn13 FROM OnixTitles_copy
WHERE pub_date = '0000-00-00';
UPDATE OnixTitles
SET OnixLogFlag = 'X';




SELECT Reviews.`ISBN13`, Reviews.`ExcerptOnix`, Reviews.`ID`, Reviews.CleanExcerpt, Reviews.`UploadOrder` FROM Reviews
LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = Reviews.`isbn13`
LEFT JOIN OnixEditProductCatalogs ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = Reviews.`isbn13`
WHERE Reviews.`SendOnix` ='Yes' AND OnixEditProductCatalogs.CatalogID = 4 AND OnixTitles.`OnixLogFlag` = 'X'
ORDER BY ISBN13, -UploadOrder DESC
;


SELECT * FROM ChildRecords
UPDATE ChildRecords
SET ModifyDate = CURRENT_DATE()
WHERE ModifyDate > '2023-03-31'

UPDATE ChildRecords
JOIN OnixTitles
ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`
SET ChildRecords.`ModifyDate` = CURRENT_DATE()
WHERE OnixTitles.isbn13 IN (SELECT ISBN13 FROM `ONIXModifyDatesNow`) OR OnixTitles.ONIXModifyDate >= DATE_FORMAT (DATE_SUB(NOW(), INTERVAL 4 DAY), '%Y-%m-%d')
WHERE ModifyDate > '2023-03-31';

SELECT * FROM ParticipantCopies
WHERE ParticipantCopies.`ParticipantID` IS NULL;


SELECT * FROM ChildRecords
UPDATE ChildRecords
SET ModifyDate = NOW()
WHERE ISBN13 IN (SELECT isbn13 FROM OnixTitles WHERE OnixTitles.`ONIXModifyDate` > '2023-04-06') OR ModifyDate > '2023-04-06' OR ISBN13 IN (SELECT ISBN13 FROM `ONIXModifyDatesNow`);

SELECT *
FROM `Sourcebooks`.`SRCountriesNoRightsJoin` T0
LEFT JOIN `Sourcebooks`.`SRCountries` T1 ON T0.CountryCode = T1.CountryCode
WHERE T1.CountryCode IS NULL;

SELECT * FROM ProductIDs
WHERE ProductIDs.`ISBN13` IN (
(
SELECT OnixTitles.`isbn13`, ProductIDs.`ISBN13` FROM ProductIDs
JOIN OnixTitles ON OnixTitles.`TitleID` = ProductIDs.`ProductID`
WHERE ProductIDs.`ISBN13` IS NULL OR ProductIDs.`ISBN13` = ''));


SELECT ProductPrices.`Price`, ProductPrices.`ISBN13`, CountryList.`CountryCode`, CountryList.`CurrencyCode`, OnixTitles.`discount_code`, 
OnixTitles.`carton_pack`, OnixTitles.`pub_date`, PublishingStatus.`AvailabilityValue`, CAST(PublishingStatus.AvailabilityValue AS NCHAR) AS STRAvailabilityValue, CAST(ProductPrices.`Price` AS NCHAR) AS STRPrice, CAST(CountryList.`Qualifier` AS NCHAR) AS STRQualifier
FROM ProductPrices
LEFT JOIN ChildRecords ON ChildRecords.`ISBN13` = ProductPrices.`ISBN13`
LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = ChildRecords.`ParentISBN13`
LEFT JOIN CountryList ON ProductPrices.`CountryID` = CountryList.`ID`
LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`
LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 5 AND (ChildRecords.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d')OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixTitles.`OnixLogFlag` = 'X')
 ORDER BY 
	ChildRecords.`ISBN13`,
	CASE WHEN CountryList.`ID` = 840
	THEN 0
	ELSE 1
	END
	

;

SELECT ProductPrices.`Price`, ProductPrices.`ISBN13`, CountryList.`CountryCode`, CountryList.`CurrencyCode`, OnixTitles.`discount_code`, 
OnixTitles.`carton_pack`, OnixTitles.`pub_date`, PublishingStatus.`AvailabilityValue`, CAST(PublishingStatus.AvailabilityValue AS NCHAR) AS STRAvailabilityValue, 
CAST(CountryList.`Qualifier` AS NCHAR) AS STRQualifier, CAST(ProductPrices.`Price` AS NCHAR) AS STRPrice
FROM ProductPrices
JOIN ChildRecords ON ChildRecords.`ISBN13` = ProductPrices.`ISBN13`
JOIN OnixEditProductCatalogs ON OnixEditProductCatalogs.`ISBN13` = ChildRecords.`ISBN13` AND OnixEditProductCatalogs.`CatalogID` = 6
LEFT JOIN CountryList ON ProductPrices.`CountryID` = CountryList.`ID`
LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`
LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
WHERE(
                `ChildRecords`.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY), '%Y-%m-%d')
                OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY), '%Y-%m-%d')
                OR OnixTitles.`OnixLogFlag` = 'X')
                
                 ORDER BY 
	ChildRecords.`ISBN13`,
	CASE WHEN CountryList.`ID` = 840
	THEN 0
	ELSE 1
	END;
SELECT
ProductPrices.`Price`, ProductPrices.`ISBN13`, CountryList.`CountryCode`, CountryList.`CurrencyCode`, OnixTitles.`discount_code`, 
OnixTitles.`carton_pack`, OnixTitles.`pub_date`, PublishingStatus.`AvailabilityValue`, CAST(PublishingStatus.AvailabilityValue AS NCHAR) AS STRAvailabilityValue, 
CAST(CountryList.`Qualifier` AS NCHAR) AS STRQualifier, CAST(ProductPrices.`Price` AS NCHAR) AS STRPrice
FROM
    `ProductPrices`
    INNER JOIN `ChildRecords` 
        ON (`ProductPrices`.`ISBN13` = `ChildRecords`.`ISBN13`)
    LEFT JOIN `OnixTitles` 
        ON (`ChildRecords`.`ParentISBN13` = `OnixTitles`.`isbn13`)
    LEFT JOIN `PublishingStatus` 
        ON (`PublishingStatus`.`FMStatus` = `ChildRecords`.`Status`)
    LEFT JOIN `OnixEditProductCatalogs` 
        ON (`OnixEditProductCatalogs`.`ISBN13` = `ChildRecords`.`ISBN13`)
    LEFT JOIN `CountryList` 
        ON (`CountryList`.`ID` = `ProductPrices`.`CountryID`)
WHERE `OnixEditProductCatalogs`.`CatalogID` = 8
    AND (ChildRecords.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d')OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixTitles.`OnixLogFlag` = 'X')                  
    ORDER BY 
	ChildRecords.`ISBN13`,
	CASE WHEN CountryList.`ID` = 840
	THEN 0
	ELSE 1
	END;
SELECT ProductPrices.`Price`, ProductPrices.`ISBN13`, CountryList.`CountryCode`, CountryList.`CurrencyCode`, OnixTitles.`discount_code`, 
OnixTitles.`carton_pack`, OnixTitles.`pub_date`, PublishingStatus.`AvailabilityValue`, CAST(PublishingStatus.AvailabilityValue AS NCHAR) AS STRAvailabilityValue, CAST(ProductPrices.`Price` AS NCHAR) AS STRPrice, CAST(CountryList.`Qualifier` AS NCHAR) AS STRQualifier
FROM ProductPrices
LEFT JOIN ChildRecords ON ChildRecords.`ISBN13` = ProductPrices.`ISBN13`
LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = ChildRecords.`ParentISBN13`
LEFT JOIN CountryList ON ProductPrices.`CountryID` = CountryList.`ID`
LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ChildRecords.`ParentISBN13`
LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = ChildRecords.`Status`
LEFT JOIN OnixEditProductCatalogs ON ChildRecords.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 7 AND CountryList.`Qualifier` <> '06' AND (ChildRecords.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d')OR OnixEditProductCatalogs.`ModifyDate` >= DATE_FORMAT((NOW() - INTERVAL 1 DAY),'%Y-%m-%d') OR OnixTitles.`OnixLogFlag` = 'X')
    ORDER BY 
	ChildRecords.`ISBN13`,
	CASE WHEN CountryList.`ID` = 840
	THEN 0
	ELSE 1
	END;

SELECT * FROM ChildRecords;
UPDATE ChildRecords
SET ModifyDate = CURRENT_DATE()
WHERE ISBN13 IN ('9781402231247',
'9781402234811',
'9781402235672',
'9781402245268',
'9781402247446',
'9781402250026',
'9781402250293',
'9781402252075',
'9781402253980',
'9781402253997',
'9781402257445',
'9781402265532',
'9781402277580',
'9781402284236',
'9781402284328',
'9781402293863',
'9781402298691',
'9781464215292',
'9781464215797',
'9781464215971',
'9781492626022',
'9781492665342',
'9781492671534',
'9781492672739',
'9781728209166',
'9781728225807',
'9781728234908',
'9781728235356',
'9781728236520',
'9781728239323',
'9781728240206',
'9781728245058',
'9781728245904',
'9781728247502',
'9781728247533',
'9781728247663',
'9781728247991',
'9781728248394',
'9781728249070',
'9781728250298',
'9781728250465',
'9781728251370',
'9781728252971',
'9781728253404',
'9781728254647',
'9781728255996',
'9781728256139',
'9781728257334',
'9781728257983',
'9781728261362',
'9781728262017',
'9781728262253',
'9781728262543',
'9781728264257',
'9781728266022',
'9781728269986',
'9781728270319',
'9781728271101',
'9781728272832',
'9781728272917',
'9781728272931',
'9781728272955',
'9781728272979',
'9781728273068',
'9781728274348',
'9781728275192',
'9781728275413',
'9781728275536',
'9781728276519',
'9781728276571',
'9781728276632',
'9781728276779',
'9781728278155',
'9781728278292',
'9781728278735',
'9781728278896',
'9781728278988',
'9781728279565',
'9781728280066',
'9781728281247',
'9781728281490',
'9781728282077',
'9781728283142',
'9781728283487',
'9781728283807',
'9781728284910',
'9781728284941',
'9781728290232',
'9781728290515',
'9781728290546',
'9781728290744',
'9781728290775',
'9781728290805',
'9781728290867',
'9781728292458');









/************ Promo Prices for Apple ***************/
SELECT 
	EbookPromoPrices.`ISBN13`,
	EbookPromoPrices.`StartDate`,
	EbookPromoPrices.`EndDate`,
	EbookPromoPrices.`PromoPrice` ,
	EbookPromoPrices.`PromoType`
FROM EbookPromoPrices 
UNION
SELECT 
	ProductPrices.`ISBN13`, 
	(SELECT MAX(EndDate) FROM EbookPromoPrices WHERE ISBN13 = ProductPrices.`ISBN13`) AS `StartDate`, 
	(SELECT MAX(StartDate) FROM EbookPromoPrices WHERE ISBN13 = ProductPrices.`ISBN13`) AS `EndDate`, 
	ProductPrices.`Price` ,
	'ListPrice'
FROM ProductPrices 
	WHERE ISBN13 IN (SELECT EbookPromoPrices.ISBN13 FROM `EbookPromoPrices` JOIN ProductPrices ON ProductPrices.`ISBN13` = EbookPromoPrices.`ISBN13`) 
	AND ProductPrices.`CountryID` = 840
;

/************ Promo Prices for Others ***************/
SELECT 
	EbookPromoPrices.`ISBN13`,
	EbookPromoPrices.`StartDate`,
	EbookPromoPrices.`EndDate`,
	EbookPromoPrices.`PromoPrice` ,
	EbookPromoPrices.`PromoType`
FROM EbookPromoPrices 
UNION
SELECT 
	ProductPrices.`ISBN13`, 
	(SELECT MAX(EndDate) - INTERVAL 1 DAY FROM EbookPromoPrices WHERE ISBN13 = ProductPrices.`ISBN13`), 
	(SELECT MAX(StartDate) FROM EbookPromoPrices WHERE ISBN13 = ProductPrices.`ISBN13`), 
	ProductPrices.`Price` ,
	'Retail'
FROM ProductPrices 
	WHERE ISBN13 IN (SELECT EbookPromoPrices.ISBN13 FROM `EbookPromoPrices` JOIN ProductPrices ON ProductPrices.`ISBN13` = EbookPromoPrices.`ISBN13`) 
	AND ProductPrices.`CountryID` = 840
;


SELECT * FROM ProductDates
WHERE DateType IS NULL;

SELECT * FROM ISBN13Table
LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ISBN13Table.`ISBN13`
WHERE ISBN13Table.`Title` IS NOT NULL AND ISBN13Table.`ISBN13` IS NOT NULL;

SELECT * FROM `ProductSalesRightsFlags`;



SELECT
        OnixTitles.`isbn13`,
        OnixTitles.`isbn10`,
        OnixTitles.`upc`,
        OnixTitles.`title_prefix`,
        OnixTitles.`title_clean`,
        OnixTitles.`subtitle`,
        OnixTitles.`series`,
        OnixTitles.`series_number`,
        OnixTitles.`pages`,
        OnixTitles.`imprint`,
        OnixTitles.`text_language`,
        OnixTitles.`imprint_symbol`,
        OnixTitles.`weight`,
        OnixTitles.`PhysicalThickness`,
        OnixTitles.`PhysicalLength`,
        OnixTitles.`PhysicalWidth`,
        OnixTitles.`length`,
        OnixTitles.`width`,
        OnixTitles.`description`,
        OnixTitles.`table_of_contents`,
        OnixTitles.`pub_date`,
        OnixTitles.`audience_code`,
        OnixTitles.`author_bio`,
        Bindings.`ProductForm`,
        Bindings.`ProductFormDetail`,
        PublishingStatus.`StatusValue`,
        OnixTitles.`age_low`,
        OnixTitles.`age_high`,
        OnixTitles.`grade_low`,
        OnixTitles.`grade_high`,
        ProductTitles.`Edition`,
        OnixTitles.`onixkeywords`,
        OnixTitles.`lexile_code`,
        EditionTypes.`Code`,
        Bindings.`ProductFormDetailTwo`,
        CAST(
                PublishingStatus.StatusValue AS NCHAR
        ) AS STRStatusValue,
        ProductSalesRightsFlags.SGFlag,
        ProductSalesRightsFlags.AEFlag,
        ProductSalesRightsFlags.INFlag
FROM
        OnixTitles
        LEFT JOIN Bindings
                ON Bindings.`Binding` = OnixTitles.`binding`
        LEFT JOIN PublishingStatus
                ON PublishingStatus.`FMStatus` = OnixTitles.`FMStatus`
        LEFT JOIN ProductTitles
                ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
        LEFT JOIN EditionTypes
                ON ProductTitles.`EditionType` = EditionTypes.`Type`
        LEFT JOIN OnixEditProductCatalogs
                ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
	LEFT JOIN `ProductSalesRightsFlags`
		ON ProductSalesRightsFlags.ISBN13 = OnixTitles.`isbn13`
WHERE (OnixEditProductCatalogs.`CatalogID` = 1
        AND OnixTitles.`OnixLogFlag` = 'X'
       )
        AND OnixTitles.`isbn13` NOT IN
        (SELECT
                ISBN13
        FROM
                ProductPlaceholderMain)
        UNION
        SELECT
	ProductPlaceholderMain.`ISBN13`	AS	`isbn13`,
	NULL	AS	`isbn10`,
	NULL	AS	`upc`,
	NULL	AS	`title_prefix`,
	ProductPlaceholderMain.`Title`	AS	`title_clean`,
	NULL	AS	`subtitle`,
	NULL	AS	`series`,
	NULL	AS	`series_number`,
	ProductPlaceholderMain.`pages`	AS	`pages`,
	ProductPlaceholderMain.`imprint`	AS	`imprint`,
	ProductPlaceholderMain.`text_language`	AS	`text_language`,
	ProductPlaceholderMain.`imprint_symbol`	AS	`imprint_symbol`,
	ProductPlaceholderMain.`weight`	AS	`weight`,
	ProductPlaceholderMain.`PhysicalThickness`	AS	`PhysicalThickness`,
	ProductPlaceholderMain.`PhysicalLength`	AS	`PhysicalLength`,
	ProductPlaceholderMain.`PhysicalWidth`	AS	`PhysicalWidth`,
	ProductPlaceholderMain.`length`	AS	`length`,
	ProductPlaceholderMain.`width`	AS	`width`,
	ProductPlaceholderMain.`DescriptiveCopy`	AS	`description`,
	ProductPlaceholderMain.`table_of_contents`	AS	`table_of_contents`,
	ProductPlaceholderMain.`pub_date`	AS	`pub_date`,
	ProductPlaceholderMain.`audience_code`	AS	`audience_code`,
	ProductPlaceholderMain.`author_bio`	AS	`author_bio`,
	ProductPlaceholderMain.`ProductForm`	AS	`ProductForm`,
	ProductPlaceholderMain.`ProductFormDetail`	AS	`ProductFormDetail`,
	ProductPlaceholderMain.`StatusValue`	AS	`StatusValue`,
	ProductPlaceholderMain.`age_low`	AS	`age_low`,
	ProductPlaceholderMain.`age_high`	AS	`age_high`,
	ProductPlaceholderMain.`grade_low`	AS	`grade_low`,
	ProductPlaceholderMain.`grade_high`	AS	`grade_high`,
	ProductPlaceholderMain.`Edition`	AS	`Edition`,
	ProductPlaceholderMain.`onixkeywords`	AS	`onixkeywords`,
	ProductPlaceholderMain.`lexile_code`	AS	`lexile_code`,
	ProductPlaceholderMain.`Code`	AS	`Code`,
	ProductPlaceholderMain.`ProductFormDetailTwo`	AS	`ProductFormDetailTwo`,
		ProductPlaceholderMain.STRStatusValue	AS	`STRStatusValue`,
        ProductSalesRightsFlags.SGFlag,
        ProductSalesRightsFlags.AEFlag,
        ProductSalesRightsFlags.INFlag
        FROM
                ProductPlaceholderMain
	LEFT JOIN `ProductSalesRightsFlags`
		ON ProductSalesRightsFlags.ISBN13 = ProductPlaceholderMain.`isbn13`
        WHERE ProductPlaceholderMain.`CatalogID` = 1;
     
     
     
     SELECT *, CAST(PublishingStatus.AvailabilityValue AS NCHAR) AS STRAvailabilityValue FROM ProductPrices 
LEFT JOIN CountryList ON ProductPrices.`CountryID` = CountryList.`ID` 
LEFT JOIN OnixTitles ON OnixTitles.`isbn13` = ProductPrices.`ISBN13`
LEFT JOIN PublishingStatus ON PublishingStatus.`FMStatus` = OnixTitles.`FMStatus`
LEFT JOIN ProductTitles ON ProductTitles.`ISBN13` = OnixTitles.`isbn13`
LEFT JOIN OnixEditProductCatalogs ON ProductTitles.`ISBN13` = OnixEditProductCatalogs.`isbn13`
WHERE OnixEditProductCatalogs.`CatalogID` = 1 AND OnixTitles.`OnixLogFlag` = 'X';


SELECT isbn13 FROM OnixTitles
WHERE isbn13 LIKE '%\n%';

SELECT isbn13
FROM OnixTitles
WHERE (isbn13 LIKE CONCAT('%', CHAR(9), '%'))
   OR (isbn13 LIKE CONCAT('%', CHAR(10), '%'))
   OR (isbn13 LIKE CONCAT('%', CHAR(13), '%'))
   OR (isbn13 LIKE CONCAT('%', CHAR(32), '%'));
   
   SELECT ISBN13
FROM ProductPrices
WHERE (ISBN13 LIKE CONCAT('%', CHAR(9), '%'))
   OR (ISBN13 LIKE CONCAT('%', CHAR(10), '%'))
   OR (ISBN13 LIKE CONCAT('%', CHAR(13), '%'))
   OR (ISBN13 LIKE CONCAT('%', CHAR(32), '%'));

