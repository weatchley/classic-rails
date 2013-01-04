CREATE TABLE `cnatestyear` (
  `controlKey` int(11) DEFAULT NULL,
  `testYear` int(11) DEFAULT NULL,
  `controlFamilyCode` char(2) DEFAULT NULL,
  `controlNumber` int(11) DEFAULT NULL,
  `enhancement` int(11) DEFAULT NULL,
  `accomplished` binary(1) DEFAULT NULL,
  `originalID` int(11) DEFAULT NULL,
  `enclaveID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `control` (
  `ControlKey` int(11) NOT NULL AUTO_INCREMENT,
  `controlNumber` int(11) NOT NULL,
  `parentControlKey` int(11) DEFAULT NULL,
  `controlFamilyCode` char(2) DEFAULT NULL,
  `controlName` varchar(256) DEFAULT NULL,
  `controlType` varchar(20) DEFAULT NULL,
  `enhancement` int(11) DEFAULT NULL,
  `controlDescription` text,
  `impactLevel` char(3) DEFAULT NULL,
  `criticalControl` binary(1) DEFAULT NULL,
  `RMF` binary(1) DEFAULT NULL,
  `SSPImplementationStatus` varchar(30) DEFAULT NULL,
  `SSPImplementationDescription` text,
  `implementingDocumentationOrArticfacts` varchar(255) DEFAULT NULL,
  `deviationIdentifier` varchar(255) DEFAULT NULL,
  `testMethod` varchar(20) DEFAULT NULL,
  `testProcedure` varchar(255) DEFAULT NULL,
  `plannedTestDate` date DEFAULT NULL,
  `scheduledTestYear` char(6) DEFAULT NULL,
  `actualTestDate` date DEFAULT NULL,
  `testResult` varchar(20) DEFAULT NULL,
  `testResultDescription` text,
  `assessorName` varchar(100) DEFAULT NULL,
  `Revision` varchar(10) DEFAULT '3',
  `cAndADoc` varchar(255) DEFAULT NULL,
  `controlReference` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ControlKey`)
) ENGINE=InnoDB AUTO_INCREMENT=8153 DEFAULT CHARSET=latin1;

CREATE TABLE `controls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `controlNumber` int(11) NOT NULL,
  `parentControlKey` int(11) DEFAULT NULL,
  `controlFamilyCode` char(2) DEFAULT NULL,
  `controlName` varchar(256) DEFAULT NULL,
  `controlType` varchar(20) DEFAULT NULL,
  `enhancement` int(11) DEFAULT NULL,
  `controlDescription` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `impactLevel` char(3) DEFAULT NULL,
  `criticalControl` binary(1) DEFAULT NULL,
  `RMF` binary(1) DEFAULT NULL,
  `SSPImplementationStatus` varchar(30) DEFAULT NULL,
  `SSPImplementationDescription` text,
  `implementingDocumentationOrArticfacts` varchar(255) DEFAULT NULL,
  `deviationIdentifier` varchar(255) DEFAULT NULL,
  `testMethod` varchar(20) DEFAULT NULL,
  `testProcedure` varchar(255) DEFAULT NULL,
  `plannedTestDate` date DEFAULT NULL,
  `scheduledTestYear` char(6) DEFAULT NULL,
  `actualTestDate` date DEFAULT NULL,
  `testResult` varchar(20) DEFAULT NULL,
  `testResultDescription` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `assessorName` varchar(100) DEFAULT NULL,
  `Revision` varchar(10) DEFAULT '3',
  `cAndADoc` varchar(255) DEFAULT NULL,
  `controlReference` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `cybercontrols` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `originalID` int(11) NOT NULL,
  `Revision` varchar(10) DEFAULT '3',
  `controlNumber` int(11) NOT NULL,
  `parentControlKey` int(11) DEFAULT NULL,
  `controlFamilyCode` char(2) DEFAULT NULL,
  `controlName` varchar(256) DEFAULT NULL,
  `controlType` varchar(20) DEFAULT NULL,
  `enhancement` int(11) DEFAULT NULL,
  `controlDescription` text,
  `impactLevel` char(3) DEFAULT NULL,
  `criticalControl` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=629 DEFAULT CHARSET=latin1;

CREATE TABLE `enclaves` (
  `id` int(11) NOT NULL DEFAULT '0',
  `Name` varchar(24) DEFAULT NULL,
  `long_name` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `enclavequarters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enclave_id` int(11) DEFAULT NULL,
  `enclaveQuarter` int(11) DEFAULT NULL,
  `enclaveYear` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE `enclavecontrols` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enclave_id` int(11) NOT NULL,
  `enclaveYear` int(11) NOT NULL,
  `cybercontrol_id` int(11) NOT NULL,
  `RMF` tinyint(1) NOT NULL DEFAULT '0',
  `SSPImplementationStatus` varchar(30) DEFAULT NULL,
  `SSPImplementationDescription` text,
  `implementingDocumentationOrArticfacts` varchar(255) DEFAULT NULL,
  `deviationIdentifier` varchar(255) DEFAULT NULL,
  `testMethod` varchar(20) DEFAULT NULL,
  `testProcedure` varchar(255) DEFAULT NULL,
  `plannedTestDate` date DEFAULT NULL,
  `scheduledTestYear` char(6) DEFAULT NULL,
  `actualTestDate` date DEFAULT NULL,
  `testResult` varchar(20) DEFAULT NULL,
  `testResultDescription` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `assessorName` varchar(100) DEFAULT NULL,
  `cAndADoc` varchar(255) DEFAULT NULL,
  `controlReference` varchar(255) DEFAULT NULL,
  `enclavequarter_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=629 DEFAULT CHARSET=latin1;

CREATE TABLE `implementationstatus` (
  `ImplementationStatus` varchar(30) NOT NULL,
  PRIMARY KEY (`ImplementationStatus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `testmethod` (
  `testMethod` varchar(20) NOT NULL,
  PRIMARY KEY (`testMethod`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `testresults` (
  `testResult` varchar(20) NOT NULL,
  PRIMARY KEY (`testResult`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

