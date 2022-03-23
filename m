Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414094E54C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbiCWPFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244950AbiCWPFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:05:07 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn20825.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::825])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0101074848;
        Wed, 23 Mar 2022 08:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUrSrs2beOYVkKC+UFrkoc+RN3iOXN+W0c3foalVeyzbmXauSW5mdh6Hb7HvcTrb3Uad+xwWPNeDHJigx5QJb2Aws0FjeqxXmqfQ34p6mmsy9GngRg9AxADCilXoY8yYxfPHmvVZowUod6mSydkqVfKlwozAFGk3VBvbV9TarolJksqh8H1JOtpW+CogvFWtTJDqwEimDT08HW5gk13bvx9JgtY7uZ+SeKIR5QkfBLqnuz4EsYfStWY1m4V03v4qyHqTRbie0Yow4Lv09lfVwIUVDkljuy5OstfUHaU8ZznqnlT6Fc7Lj6435S5lItUj4CaJ1bZ8PK4g5DghjBeDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxICZtq3LMaqME1mWpQKdDI8ZA6sCfEBNltGSsYmueU=;
 b=Cz29/BI+kfemxicr+fF6ZwHOz3wYzmoK0+oCcdv1f2YgvQ9ybDW2dsWPMr671VuuBfDfLjpqri4Oy0Fxw3xRjnB29gSDstz+Y0uaQGsTSCkywOPzvySTTmU8W9hRRrCk+w3M+vg97ukxi21n6HFuc5WKdmNKdPSk2qV8mj6oV1GGdo4TlyaDdoU+Rhg0T5X6dFyA4fTahGquABY+xv1QHm2dWlvh7ix7Zm1nWQBPdLJWExYQv2yeYDdQuE8MGN2rUlux3fOajB1iXVSAxaYlvrS1EKW2wYQ5MhIF1FwWWAT1SqSe7UfS5x1/xvYSYhG3kYaUhgy+QbY64AE8/26zXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BYAPR04MB5638.namprd04.prod.outlook.com (2603:10b6:a03:101::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Wed, 23 Mar
 2022 15:03:33 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 15:03:33 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 3/7] ARM: dts: s5pv210: Adjust DMA node names to match spec
Date:   Wed, 23 Mar 2022 08:03:07 -0700
Message-ID: <CY4PR04MB0567567329AF08DB4001F233CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220323150311.26699-1-xc-racer2@live.ca>
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220323150311.26699-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [HyrhdYZRycnd7OjWCiAFFFKPRO72ZiOvnecc9/gwLrBYMkFz8QYtHM+A/V8x0Fem]
X-ClientProxiedBy: MWHPR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:301:2::16) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220323150311.26699-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41a48ec7-9c01-4169-4814-08da0cde4c2b
X-MS-TrafficTypeDiagnostic: BYAPR04MB5638:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5bTc7qK267RDNVHOOZIU2rpkutGfBfICCxOrEP9ibCA4M2ClVHNeAy8lMQ24aVUVp2786sUF3MYctaevrn3q+1BIkhZLxLac67a7sMS7HQYf56Ska3Dl63ggS9UpJxvMKYxKxo98n68lvv6gkIBONiXTrnCqTzPGA40/xXqTErVR/R4nrz/SLk4MoP4jtqHxa71XIKe1CN4VDv2bUjIJBJAQF7BZqM2SkIsSh7rPEoA7iqxSlxZ4qy33C2gIa7mTYCpX9dL/8JCxvrhUe3Nuoe+yZe057ijVIDy0agZ/7qwbxfCblCFY4PfiVaM3VGQtI0ukHaAPyDOL/p2EvYjhW53Q9Xb7e/xKfA7ESH/kP9qEeMsFl89Hul10WOio+teBtP663qTNPZL+W4jItyu/RDjP9jLjX/4qFce2ItkGHmgLcAMHVhziS14EO88PbdUk0G1awiDp4DuqoJEE3piKgcI0tU365O8n4M3dlsobf1UAGgkjVNR/4BkPNJ0Q7donFS/0HtP8v5xD0cWfGpJsHzM1/vQdqfQVZhysbJVE2OL4u/Nk0CgQxmLdVDeeIowICVBChm2gJqzJjCpH9MvMw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5t2G+n4FuqepO8zGLn/xKcGmY4SthFQNGLZ9siC0rsEW1pHa3+ARr6J9VPRI?=
 =?us-ascii?Q?Hon9slbh7ZbDK8R95rKuQ3gBLlkbNXhXndHGEmOQ+LYbj2fCNqGElB63Bymf?=
 =?us-ascii?Q?kFOMsegKjYxZgHRkYn8XY2kgKalDPf32eeVDeYFGibW/Psy3tDEnJN12hZY/?=
 =?us-ascii?Q?pXJe65U8nx+l+8Py4V1HsQjYvaQw24sdx7IURdrxAsfqzZ3G3ERvFVLZ3PPT?=
 =?us-ascii?Q?6W4S5k0ilYwdaoUdGBU7I30UqeJ0IaHqXEGYSC0sVp3xwvXkCs6tHtkSuFLm?=
 =?us-ascii?Q?QzSJrrc5E1QpGdGDCqGxeevJZ3Uju3gM0Iolgc0Q3g/9k7CkFVEOSA7SShb7?=
 =?us-ascii?Q?wZu4uE107wRAEjhKpSF+kURzR+NiU3ORtDVQbEWT/FVYMe3NVpHg2d+zGcEM?=
 =?us-ascii?Q?VXKyjCIteWbEv1Hwmfk5Gm4SszWZ9OTEff047qgGkZwkSnAS2Qzp0NjvaB/0?=
 =?us-ascii?Q?Ta3sTJBmUhzLskJYvxUxPJ52BYY6x6lgKcdzVEPLaPg+G0abFclIUiIwRpT2?=
 =?us-ascii?Q?C5K4AhPk1NljWZNuBJMLlUyow2eC5rFuji0vQ+5sXSjODsVyMC+8UGpgZe2Z?=
 =?us-ascii?Q?1CuuPkhDGlSGPmouBB+aWDCtElTwEBMOeBON61hUpsU8Gl6IL+5lfMZnr+o1?=
 =?us-ascii?Q?sdnMOFvWt0E5sK6bbR4xelDsdsZclFTPIhxUzCOmQSTdEou/w64YWj4hF8vr?=
 =?us-ascii?Q?RtN+THdu8xXbL6yKO4eCEyjmuQejSYAMg69y0B+8FH/yNaxwSNWLwjenVbJa?=
 =?us-ascii?Q?Qlww0ILJhQxYeEOjt56aIJ+CaMS/o+XXgznYO/z2FFhC6/SGF83J8OaMHZMW?=
 =?us-ascii?Q?V0pmJ5Fm5kbwmELo/A0ZJ/ryJ5snx862R0zXaf2THV1IW6vn/UXDDlIb92G5?=
 =?us-ascii?Q?dQVOpfWeoSTob6sMxD6F3TkSbSx7+tCSAl6dTZIiakhdUsEKev66QP+3pfN5?=
 =?us-ascii?Q?PTtMCg9HNmxI/OOKgO7gXRbKwqNzfqzlVja/Kibm+FVMTqSp2sTaL0kBjalf?=
 =?us-ascii?Q?icDJvbUm1msTNufXEAO9p1e17H2h/a4jRQxwYdI+Q+2sn2WdogBhiLejBZnb?=
 =?us-ascii?Q?y5JgqEf+8ELvsUnNnKIN+UWSYiXbSmlt3HLWElLtqfSPNukiVowvPqnwaSN4?=
 =?us-ascii?Q?7H0XBmgIYYWAprX5U6nV+5DqLz7ZS0+2/USBgx45QHG33rhKEmx7VdLuMkQ0?=
 =?us-ascii?Q?wE15kugQfMKpj4mNzj1ijLgAavv50M+mI46kUg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a48ec7-9c01-4169-4814-08da0cde4c2b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 15:03:33.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5638
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA node names should be dma-controller according to the DT spec,
so rename them from pdma/mdma.  Prevents warnings when running
make dtbs_check

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 56c1d9a19570..14e6a270363f 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -117,7 +117,7 @@
 			};
 		};
 
-		pdma0: dma@e0900000 {
+		pdma0: dma-controller@e0900000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0xe0900000 0x1000>;
 			interrupt-parent = <&vic0>;
@@ -129,7 +129,7 @@
 			#dma-requests = <32>;
 		};
 
-		pdma1: dma@e0a00000 {
+		pdma1: dma-controller@e0a00000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0xe0a00000 0x1000>;
 			interrupt-parent = <&vic0>;
@@ -528,7 +528,7 @@
 			clock-names = "sclk_fimg2d", "fimg2d";
 		};
 
-		mdma1: mdma@fa200000 {
+		mdma1: dma-controller@fa200000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0xfa200000 0x1000>;
 			interrupt-parent = <&vic0>;
-- 
2.20.1

