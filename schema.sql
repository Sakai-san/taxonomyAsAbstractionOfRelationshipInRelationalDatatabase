
CREATE TABLE `Meta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `foreign_table_id` bigint(20) UNSIGNED NOT NULL,
  `table_name` bigint(20) UNSIGNED NOT NULL,  
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (meta_id)
--  UNIQUE KEY (foreign_table_id, table_name, meta_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `Term` (
  `term_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (term_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Relationship` (
  `content_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (content_id, taxonomy_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `Taxonomy` (
  `taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (taxonomy_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `Content` (
  `content_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `text` longtext COLLATE utf8mb4_unicode_ci,
  `title` text COLLATE utf8mb4_unicode_ci,
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (content_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

INSERT INTO `Content` (`content_id`, `date_gmt`, `text`, `title` ) VALUES
(1, '2014-06-30 20:22:30', "En informatique il est souvent nécessaire de pratiquer pour d'assimiler les différents concepts. Les exercices suivants couvrent les notions abordées dans la théorie.", 'SQL en pratique'),
(2, '2014-07-04 11:16:25', "Ce cours est destiné à quiconque s’intéresse au sujet. Il explique les divers concepts d'une manière aussi simple que possible. Aucune connaissance préalable n'est nécessaire.\r\n\r\nSont abordées, dans un premier temps, les notions d'entité, schéma de base de données, table, enregistrement, attribut, clé primaire, association, clé étrangère et typage de données.", 'Apprendre SQL'),
(3, '2014-10-09 19:27:08', "This course is intended for anyone with an interest in SQL. No prerequisites are needed. Explanations are made as simple as possible.\r\n\r\nFirst, we are going to cover the concepts of entity, database schema, table, record, attribute, primary key, association, foreign key and data type.", 'Learn SQL'),
(4, '2014-10-09 19:13:20', "The practice plays an important role in understanding the concepts. Doing the following exercises may help the progress in learning SQL. All the studied concepts are covered.", "Let's practice SQL"),
(5, '2016-10-09 19:13:20', '', 'Thomas Rubattel'),
(6, '2015-04-10 08:13:20', '', 'Franz Sturzenegger'),
(7, '2017-04-24 08:13:20', "1. Qu’est-ce qu’une base de données ? Une base de données est un ensemble de données structurées.", "Chapitre 1 : Introduction");

INSERT INTO `Term` (`term_id`, `name`) VALUES
(1, 'ENG'),
(2, 'JPN'),
(3, 'FRA'),
(4, 'DEU'),
(5, 'Male'),
(6, 'Female'),
(7, 'IT'),
(8, 'Editing'),
(9, 'SQL'),
(10, 'Linear Algebra'),
(11, 'Algèbre linéaire'),
(12, 'Theory'),
(13, 'Practice'),
(14, 'Chapter');


INSERT INTO `Taxonomy` (`taxonomy_id`, `term_id`, `taxonomy`, `parent`) VALUES
(1, (SELECT term_id FROM Term WHERE name = 'FRA'), 'Internationalization', 0 ),
(2, (SELECT term_id FROM Term WHERE name = 'FRA'), 'Internationalization', 0 ),
(3, (SELECT term_id FROM Term WHERE name = 'ENG'), 'Internationalization', 0 ),
(4, (SELECT term_id FROM Term WHERE name = 'Male'), 'Person', 0 ), 
(5, (SELECT term_id FROM Term WHERE name = 'Female'), 'Person', 0 ), 
(6, (SELECT term_id FROM Term WHERE name = 'DEU'), 'Language', 0 ),
(7, (SELECT term_id FROM Term WHERE name = 'FRA'), 'Language', 0 ),
(8, (SELECT term_id FROM Term WHERE name = 'IT'), 'Employee', 0 ),
(9, (SELECT term_id FROM Term WHERE name = 'Editing'), 'Employee', 0 ),
(10, (SELECT term_id FROM Term WHERE name = 'SQL'), 'Course', 0 ),
(11, (SELECT term_id FROM Term WHERE name = 'Theory'), 'Course', 10 ),
(12, (SELECT term_id FROM Term WHERE name = 'Practice'), 'Course', 10 ),
(13, (SELECT term_id FROM Term WHERE name = 'Chapter'), 'Course', 11 ),
(14, (SELECT term_id FROM Term WHERE name = 'Chapter'), 'Course', 12 );


INSERT INTO `Relationship` (`content_id`, `taxonomy_id`, `term_order`) VALUES
( (SELECT content_id FROM Content WHERE title = 'Apprendre SQL'), (SELECT taxonomy_id FROM Taxonomy WHERE taxonomy = 'Course' AND term_id = (SELECT term_id FROM Term WHERE name='SQL' ) ), 0 ),
( (SELECT content_id FROM Content WHERE title = 'Chapitre 1 : Introduction'), (SELECT taxonomy_id FROM Taxonomy WHERE taxonomy = 'Course' AND term_id = (SELECT term_id FROM Term WHERE name='Chapter' ) ), 1 );


/*
SELECT *
FROM Content AS C
INNER JOIN Relationship AS R ON C.content_id = R.content_id
INNER JOIN Taxonomy AS TA ON TA.taxonomy_id = R.taxonomy_id
WHERE TA.taxonomy_id = (
	select taxonomy_id
    from Taxonomy AS TA
    where TA.taxonomy_id = (
    	select taxonomy_id
	    from Taxonomy AS TA3
    	where TA3.term_id = (select term_id from Term where name= 'Chapter' ) AND TA3.parent = (
        	select taxonomy_id
    		from Taxonomy AS TA2
    		where TA2.term_id = (select term_id from Term where name='Theory') AND TA2.parent = (
	            select taxonomy_id
    			from Taxonomy AS TA1
    			where TA1.taxonomy = 'Course' and TA1.term_id = (select term_id from Term where name = 'SQL' )
            )
        )
    )
)

*/