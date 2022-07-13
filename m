Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F2572C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiGMEYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiGMEYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:24:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2024.outbound.protection.outlook.com [40.92.21.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432724F65F;
        Tue, 12 Jul 2022 21:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIh4f1GxxLfmPtyCqCLaztNNaKa1tSB6DAFRU7uGcI8lLVLoBGCsu2Dz49BBXXRzvHWQzFsDuxWuXjq1hnHlrlFgt9mBUnwwATNLKtstEBu+tvXMrveQKWfc0fbSKl1miMjWNWpQbmjRERUZSBgVazWEKhoPaOgUD8w2BWAz+7eg7eUum5AFkxkxIGcF73PQDuzoTWRPHjoGVfWmAZLE2Ak2vYeT7dHVqmOM1oRCjYLJLgS/bjoKDa+slGhXv8abz8Q2qqsIQwyhTP/gzdX81yIFX0v60bAIq4vNoeMJP9RhDrWMXv4EZHK5aIGyd7IpZjg+LqAruJs/Uz2s0867xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn2FeymYptwhD2it0oITGti/8m3kN6YdE1EjOIr0Yis=;
 b=QuOE9lPUmz4O500ViSumIEFZcntJ5BhQI3137yQa2vYAitl4XWlkIjABBNtiIaoDqjXR3+g8141klX+Rpc9235VQHF3PtWEaM6+fLwXHmKafPIXqrgRE6GPItrIccu+DWoUnWV9OHKY16CCYOPC3Icv8iABOutc2+BGZDud/jiIWqU5bv5uHOmWWlJRtsB1pw6P/GDiVNvZsW2Oa7nXCMFi4dFQkl0ziDCK7Th2RF6W4LP9Yar4zc6fHxzsPEqEDxY8L/7+OJ7SsmxGUZoOx2ECHRz+/EmeF386WzPOaudJcX4njhC5DAwrMYQQIHdP0j29kn01yck1ttAXqICImug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by DM5PR02MB3895.namprd02.prod.outlook.com (2603:10b6:4:b9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 04:24:16 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 04:24:15 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 4/5 RESEND] arm64: dts: qcom: sdm845-xiaomi-beryllium: introduce ebbg variant
Date:   Wed, 13 Jul 2022 09:52:48 +0530
Message-ID: <BY5PR02MB700951DAA15ED7FD54400B5CD9899@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713042249.31421-1-jo@jsfamily.in>
References: <20220713042249.31421-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [vZukZcYZ1B3JP3FUrqrCkUfKF5+wRUTZjS9N/W9XcuJ2ekZixxVwpMRsJu47DU3w]
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220713042249.31421-5-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f5231f4-7bf5-4190-1313-08da64878bd0
X-MS-TrafficTypeDiagnostic: DM5PR02MB3895:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7W2tlIrKOpxsvgyIq188dB1bbB+NOAUsdN0G+INWl7z8smapxGLJCWojo5PIo81jmJZ4+NVZID2el/NimW3AZ6iCqFbcYn5cu8PZ20V4T8GnBwj+b88m/3FsPLVyHX//0DAfpsy3StMQa0HksaoPfBoYIOxBzmNwp9/MnvBf5UDBLIz6JZlX3UqCyGVLSyAtVjhK/j57s+jMsdaWhWdAn6pFS9tS9S00FCi7bxodNsTvfowzTX2i66vmtj8GqUhqXZ7mzUZxOAWK+GQcHXQpSzD8aeB2orMY0zGIEM4tWiY/4VXtGZaDcpIbNP7kNICdu1PM/VVNywaDb9Oc01DPcGJViD7BK7/tZ6R6cc/pAM3y48qIeJlqzGDEUY7FPNcUz1eRtfrnZhzZYEdKEq57g7yH562MCnbAs60MlsHpWlkw1t2W+5q45LiYdxGMa1g0QhnuuGK64QxJNaATk2pnwNDqZ1TLcS2UIZNq/HjIrDavHHmvMvbYIMVv32R1vtL1Y+tRTdBsYPi40j1j1UOhgj2FbHke+R2H69mbDEt0LH4wLxJVCYp45G3DPB9t7CTSWnN5CU6cyAZb74JEkpM3WjSRJM9HdDe5xDpGbZJ4GrcgAz00kict4W9YHajonDmhjJIO8x/OHAWZW2fsV0HD7qn0/YDRI81lQ/4zqYRoqQANIju6RClbFXIHIIx3wBTVm3WDTYTouwiOHyFcnfIZA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09QtDaMndSBpHm3b6RdcvHCIQVq/RYwc69By5fN4hIvohxu0dfsZErYmUtFu?=
 =?us-ascii?Q?sTs/e1UADQjazjfnXe9kRrqTIRDjZS5jmOqP+FsAHaIryHTpYOAfz0Gqa9WC?=
 =?us-ascii?Q?hpc/CtJXnhexTkhGj9fFM1qAfQEXGSK7uomc8+BiU0giRVRrwDfBZwcD2+DU?=
 =?us-ascii?Q?TYtepBfm3dBM0aS2FINMrR16p2OqTeNYCxM/nF8Uzv0R4LvQLLvAjAvozI08?=
 =?us-ascii?Q?2CsgYj/NyN4usff9+0e7X5q+DNpsgKofGYVqJAKPYI3AWD2Vo2Me5R2rf3D3?=
 =?us-ascii?Q?zJXO2gl7XUgQBkZGc5kGw0ZvDSpKpmqw36RD/vQCKXtTLdPMY1nAuV4565Mc?=
 =?us-ascii?Q?QXAiHbRofaIeGJKXP7YUJP0kjDiioUkQng3qlBRii+RyOYv0DSSFNoyPdORP?=
 =?us-ascii?Q?CrHvKJAHN4ZXJO34vQSGVT00r+2WG0ERmPA9hYZhGxB39vm8+ro0k3QzBHfq?=
 =?us-ascii?Q?R6xa3IEEMEotWH/myt4iFesvRXBHPWQBQuMcuWeNOI1X1X8LdW7q7CciT69E?=
 =?us-ascii?Q?7ykrYsx0SuuBwsFYvcDivwNq2zgxzRaJ6pIkLJfTtYtm1FiZG+LjWtpP00yH?=
 =?us-ascii?Q?zs3idGSAIPMXjMFKQZeeTcU14MvweV3DG4dmv7VWbcUhB9AKWifKC3KTG9l0?=
 =?us-ascii?Q?8KOhgmq5FO4CePCPrCWJa9/01WCkjmg2j/F/YUwi6ZXxh3MCLQs3cZJDUBJ2?=
 =?us-ascii?Q?2btk4rEoOJdR6G9Y9WomZ7PuC5cjnt8CQuU1HnAKeNvZ76FXqiCUk0/zqo7u?=
 =?us-ascii?Q?fWfdFL5yI8Qjp66X7hw35fZdXb/SeakySOEMMlhp5E1e/LZC5DIEixWcrRoS?=
 =?us-ascii?Q?pD7zYVTQ3vzp0U+DDwttZnNfkijGJmK8ysGGkT08G04UytBJFrZs3kMJx68n?=
 =?us-ascii?Q?2SooH4GEbhnd0BUddX1Vog7rtGUCoWcL+UwIGW0xIXHXGaudVgK7Mx0n9xXy?=
 =?us-ascii?Q?c7KQ2f3st3/HZvih/Bopq08q+SphLhmLUNcP39gr2XLncHD7sUzRs9NH1nyH?=
 =?us-ascii?Q?NVRYQvFEuuwJnx8uDD9eqfzF27FHxevqzTo3nelTY0456e0u3vkxpNGPZTY0?=
 =?us-ascii?Q?CD7kXtUsxv0QPFE2IUTEowSs/28/r05JaC+JpD/KnybneRWafbACkUOtyywg?=
 =?us-ascii?Q?tieQQfmy9SbRtputSG/XuKqb1mEUzY3/V53yC6eSmDMUP/P5ezar+Z361ySj?=
 =?us-ascii?Q?KGRn7OhaQGqyl5DVALdq5yVMtK3X62Dki66nZEVYib3H7jl9ADnjXaVdazjt?=
 =?us-ascii?Q?exwPp6KAAN1S1hB14ygbRhwoGChqleDKY8UO96idR9U3fF5WSsAssQK1ggzW?=
 =?us-ascii?Q?OXzBseGibDpWaO/799Q9OgEu?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5231f4-7bf5-4190-1313-08da64878bd0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 04:24:15.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3895
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ebbg variant uses EBBG FT8719 panel manufactured by EBBG.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
new file mode 100644
index 000000000000..3716e16e79b1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "sdm845-xiaomi-beryllium-common.dtsi"
+
+&display_panel {
+	status = "okay";
+	compatible = "ebbg,ft8719";
+};
-- 
2.36.1

