Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3946B5EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhLGIaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:30:09 -0500
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:11631
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232860AbhLGI3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:29:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuOvP070MOe2TkPQplKTQDCkL3T7aDH2b5iyk7yBaEWR88SOsaqn9NZ4uQmNR8FOXLcHZ8t5MIMGWNLuVYGr5rabUpRP5If5phkksgPcpzOMWJ/dJnVftqnmFEf6owtS6VyXdVapg5P6EhzOSSZnE3sQBCh5ji2FChkXxjzGAZKzsKebzpahYPSL37ikM266sRxAj1yAtmrPL3EzDS5+1pk2X2NB89b+v/Ru0uQ4r0daLP8lBkcluA2LiCJGfAFdhmRBkHtvzHa5gArJnYQzvskqxq8vMIjeoLee9jF69qYskT8uJgB57hlanas3EouBUmtsrkJCRugziRomdcOT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1yuTm8ltuOBKEJp+clavNMjLapwbUoi8mg34j31yw4=;
 b=kCD1m+kXnkSuKbq9WkOa3zhwnnplTLGOYjEXHZlHJLttBAE0RTmd9GO84ddsoUdfI/vNRyyYuXRGm86j/qSwrNv/Ptfce7OV2xc111YQPyYge/Wc+c3w1g5TPAldSnA576w4qmPM1Mw+hr0pL0hKUEcQmgB12bnKj6yaCvIqgMdFKgQ5Vbuge+RffS/Q3hAl8vcXO+sJcf5PyZ/U1gwpwfKfqQsJCNQSbJ4MYsgxDbueso5cW2HqmZUH9Rh1zbZrIbuJ0W+lXDUNofwDfZlFZ2TtfV1zwBs5+9K4P4K+BHF7i89rat8htXubjhk25ehtbGR13E34z2PEfMWvhTC0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1yuTm8ltuOBKEJp+clavNMjLapwbUoi8mg34j31yw4=;
 b=dfCsrqsD44dSoRVlBEafHtZ0WylwZz0FzLamtxab3eOtlgk8pn8EIfP1594HDFLLEJ99oVVaXn/DpVViGE34tvtnGombKMBbndwCTDCRWzqdyrkbvtEt+wFAYwa7hhTegYHUBEYeollxiBi9cD3vOT+pyX9+X/vRlDovQ1vecV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 08:25:57 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 08:25:57 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v14 13/13] MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
Date:   Tue,  7 Dec 2021 16:24:28 +0800
Message-Id: <1f317ca14804a279628ea65ed68178f0979dcfa9.1638865027.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638865027.git.ming.qian@nxp.com>
References: <cover.1638865027.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 08:25:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60ae4993-d5eb-4ac7-a57c-08d9b95b3167
X-MS-TrafficTypeDiagnostic: AS8PR04MB8200:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB820057E8CE4C8FDF9D0B7BB5E76E9@AS8PR04MB8200.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jq8AV6TMlD/94n6XHtEC6YGij8fJ3S8tDll0IZGKFwV8c0BMWEN6shTUzTsJ0uWaVz/fUrji5ML5IbJbWxNxU0J66ngi+HP4cygCC1KFJEbGaf3v9fN1LlYWfo4b/GhyQk4MPzootiDSZbrE+Nwhx2Z8wyeTiyOMCGScyW9kpoPLXlTny2UuVX9yP4aXo6bsDF6OUWl+9gVl0lTPlRy9EBfGmxk4DblEX4oqJXjS2JHRV64632Ti0vhvR/lClcSP1e8FFJ9XQdn2e9o7p0iP3BN0dAAl1av41BCuwcFASC2tIfzGUgEX9Ol/ci5UVx1VEwrrpCkIjxZ7LrVutLCXkY3aw/H+JFtZIJuK5c6Eq6Iko1rMjX6NXxyrBkawrb6XoQaosHEii2yEnW9epqjSvS+j96wkrwmn7/oy4D5Ety1PVOg6fx3iq/g34KDL/IVn4lyQZh4UwnmDikB9yYuYFmVAkaBmIrgKvbp31Baziea5HiONjFSE8o9zyhocW6I5Y3qlDLjd0wDRW0hROdwPaKEwETZCmJ6rvuRy2DckZXje7L8wcrTbFYamZKsN1bysxTYE7veWHEFapbYkTX0GfAk1HVfQtbjL/78mOlhxI+QMuU/B6ylIzCKSfgBWFpVhz92lxXhZfRQHBnrmqQw0cHUQQMtoSxDfWKQHGCVYhyKlnriX9OmdGOm6G2qSIZi8zLQv+8r0x45daY92ZX6kIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(4326008)(8936002)(6666004)(66946007)(8676002)(66556008)(38350700002)(6486002)(38100700002)(36756003)(2906002)(316002)(52116002)(5660300002)(7416002)(4744005)(44832011)(2616005)(508600001)(956004)(186003)(86362001)(7696005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZriYQn4pnaCzXCAH8fp1wDC9kfFlpLoEH5kOE57ZtfaWAfJa0Ap/bM+8JOa?=
 =?us-ascii?Q?bq3Vmvv4OfvvTD7Vi6exKTCa9Zxk9t3C1s3w+ep253AagIJc34Jn/3K+2FQY?=
 =?us-ascii?Q?C2uR94CwiwedWVdnnpaqBxawYZTcASeA5G0LMleS3yK3ZBrj+JRFTl4zsqGM?=
 =?us-ascii?Q?VXtgaW2kkpFBTkHCFb7GoOVum1Ab0HIe1ARylDKCP0pzNvtJ5/6KA8FDqrlO?=
 =?us-ascii?Q?Hf8yPwH5YtuBFUTs2kmCEJMK3ruMctw33zcN4sOiY4A+yxPEFcJbB/Az2raL?=
 =?us-ascii?Q?ZeWXCuUqMgkVyhr22KvklE1alfNnu3APBO2QZ4q0NKJHg5pXWPI7aptpNtG2?=
 =?us-ascii?Q?1KXbh8mmJjl18p2tmZiHbx++GajUxWcAm3YDOBmk+yelj6f5uwVTCXqxP4Sm?=
 =?us-ascii?Q?0cuXoRgKHRBHWWhYMnGRFUkPmTqoq2Uc5JL1ThmNQ375ZucmoLXn44iu5A4F?=
 =?us-ascii?Q?dwzsNE9WLURkurmqcHGTh7bxJu2ABOD5rdBWelpDrFkUoHwy4DqiDdG6VnVa?=
 =?us-ascii?Q?m8lDYYZtqrtqZgczTzFu8l91N4TGzQsXQddfUj6hRvQsKN0IFBtfjg+befvc?=
 =?us-ascii?Q?N4GWCHIoSjeRYFt7WTRp7Isl/RKn4rR6ZirFE9H2/uuj+p5Qgs7RCq/JkAzE?=
 =?us-ascii?Q?bCXDbNrAH36M6GE0AIDz2BNZwQeeX8yy4Tgmj8ynz3KSBp8vLrI74dZiU9WG?=
 =?us-ascii?Q?GzyItx+/e+3fNG6NMOjciX6t/NYk3/DqfYCfdKB6naYxoQEC76li4zaSvkia?=
 =?us-ascii?Q?rdlOE8RCbWk+liwNRA9M866a/d7ltAqVzOoFk5/yIx2lipcCbSOxrho95wZR?=
 =?us-ascii?Q?dR4479HVjjHZvsWUy3NEs+hQmpcKfAKDYhAg3KqOBtlmDMINLKSdZ7v6ViGq?=
 =?us-ascii?Q?TGCR6bmNSU/dSxwMct5lbomZLSiL3Ij3a/sbZoDtd2oj25eAOts0+eZoXL3x?=
 =?us-ascii?Q?APJOA88iQqy0djvKs8n4nX8PZUcCKzqmYZfVwU5ILZ+J4FrwvQmga4ssf0Km?=
 =?us-ascii?Q?JjQwgrhOAHF3BiWRRyuicamtE4uCGz9Uy0llvEUMmy89h5cBqG6f4GqrTLHW?=
 =?us-ascii?Q?nYiR4rvIe6AU/wTaXct+3ng8ZO7l5/nAM45UD97FkVK9lIxCHq3VpAayqW6G?=
 =?us-ascii?Q?TOHMjMo1LQK1TECBD7MD+3rT1JTfhOX8+Rx4ZTlYD4Um1SoappjMVYg/DkRP?=
 =?us-ascii?Q?5Sif11NIsc4CsHjrIZp9nNhVLn+9pUQU25eOspyAb41c4VWbzOLobX7Q6J3/?=
 =?us-ascii?Q?SVj08vBPRIM5mclhPHCJCW6gDBb1Ww8GuNqQOQ8PFgcdNgoKXMfaIome6Gv/?=
 =?us-ascii?Q?poq30/C/q+V5Gk4eJM2f9JJz3iqlRLymkm5CYLwvOoRSwks3tlJCPJZpUQP+?=
 =?us-ascii?Q?BF65DyGxGkIrwkoR1wUYOGVqmLtlaUX4wN74YyRDltECnidHBCvar90/ZN6O?=
 =?us-ascii?Q?JZ9iAJOHZgNXWHukfgCIAixApHv0RgDWUIyAlKNKHZHlHvQfxgB9lDpmAbrm?=
 =?us-ascii?Q?cq8nhyiNur+4/Yts5EjZlA6HfE8JbXc4jxyPlMwg0hamJCNPHEyW9x5x+Lsb?=
 =?us-ascii?Q?nK12IX8e+qCuybCfxaO2PybPNfKGRGrytQZ0GBTMAeCULPD+OUkFwNCAVYS1?=
 =?us-ascii?Q?HrWg2FTrYQ7r9A6JG8Bk8xU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ae4993-d5eb-4ac7-a57c-08d9b95b3167
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:25:57.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maUnDp+9g+TmJ532Ed5roFDpHiIQ0QkWPZm63V+RJSObmm5OBGu1Ozx0ENYhGomGXj0mFYMTDEAm4a/ibYxPYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMPHION VPU CODEC v4l2 driver entry

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8eea24d54624..a20fafc832da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13775,6 +13775,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/imx-jpeg
 
+AMPHION VPU CODEC V4L2 DRIVER
+M:	Ming Qian <ming.qian@nxp.com>
+M:	Shijie Qin <shijie.qin@nxp.com>
+M:	Zhou Peng <eagle.zhou@nxp.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/amphion,vpu.yaml
+F:	drivers/media/platform/amphion/
+
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
 M:	Jonas Malaco <jonas@protocubo.io>
 L:	linux-hwmon@vger.kernel.org
-- 
2.33.0

