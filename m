Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26574E54CF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245026AbiCWPF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245011AbiCWPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:05:19 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2077.outbound.protection.outlook.com [40.92.47.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818ED7D01F;
        Wed, 23 Mar 2022 08:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crC4oTOemn59XpTxq4hedqrgkRKGWioEpM+8cPRI36wkBI9wftNpDzQCHoZERv0crqKMzHyjwVwn6QDUPVna21d2h6tKUuZQ16rfhXAkh4wdWF1MvnlVqqNnssOUadVJwcGzPAaSz/EnVX89HmXOOjRzoEW4JVweWr6blqHcRBLlEx3wW1y+F/LQxdcxSFGZufCHwlhdzw4F9O2kLs8ATNgaOwZgrsb9pWAvqWpAgCwvt8LUkuogTyzkYGZtSt3YMEdZD46DO8Wk9vDZCXIuZGNWjuiUgbxxlrmXrotQfSXvGWXS0iA9c5YOEg0ka6CBA9wSokLpYuVoqoACu8emkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7odFYps8hj4TSD9DRho+dhdfmQqY+5i0dv+u7EeyY4Q=;
 b=PPEXKNm6nAmddcMSHe9i1m+esIDuVCs3yrNdnVrPc6j1HYBEZZPTQ5mp6LYbDNoPs9obkM48Vy6xxFGSi8Y+oK6blnGL4OkJ1lYNSHuAyQyVGXhrBkf11a6B5ZQkaHZJPt6f64EzusacI46H63myt2yZh4uUAWl2n+yAm8lFfQovpISIw5klM836q/AbVhAuhGhU/H2uvzXJElC5WYJhKBWUubED2dm4h9z/0WyXxAwqpzfGp52+1y/GeE1xpI+PaVVgLXJ0NSK612vGdOK3HU/AGZ836ShbqFmmlPMTyThu/jwJcMCdtPLHb4BbbWOpr8iIFEyrdFw0cCO/4Bu5tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BYAPR04MB5638.namprd04.prod.outlook.com (2603:10b6:a03:101::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Wed, 23 Mar
 2022 15:03:42 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 15:03:42 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 6/7] ARM: dts: s5pv210: Add charger regulator to max8998 in Aries
Date:   Wed, 23 Mar 2022 08:03:10 -0700
Message-ID: <CY4PR04MB05673A1CE03D9958C1F3D06CCB189@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220323150311.26699-1-xc-racer2@live.ca>
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220323150311.26699-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [507H+gNQspGrH3BaDAjMJYaWbUgZ3C4aC15BkXWN7u2JEMlirKRrUQnSJrqZobDX]
X-ClientProxiedBy: MWHPR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:301:2::16) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220323150311.26699-5-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32ffcd46-a181-4c03-fbfc-08da0cde51ee
X-MS-TrafficTypeDiagnostic: BYAPR04MB5638:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czH7ffFmLjoKZdjOoQDIFUPFbzgNtd99PDd+JPXtN12UCRielwC/ae6pTSleoxlhjFOoJPxclK4T7NxtjeV1TXIZwAeSYnYoK6Sf1uV/qadN3pdfEqN7C3CnMdcV2LV5QibaunZgg+jbwJj+0nWBSDKi8VoLufIwwjmjcVlrRxprAVAH4QFqo71oQk1pziQGdKru+1lWuxtdkCIfoFUZG0T+OqEDHgsQuB9YPQ9E5mq1VWVOAUcwvraPn6NKoFDBJjjP+7Y00/yGWLmp8UXVz0aWfLYFjP/40OvTmNanhuHP7F4v1oHU1GgWRBzk7y4PS5+9UOaD0ixHQPn/VyCH4ocfm+NECNqetEwTvdY15H42uyMKpWjXrmTO6M719etxMwEYgI1Ztcj5DJMBIgklwfOXQ7Qxfdoe8qpoEUs5W8BRmr/Pp7/x7ZZKnprVt1iU6yAFdATn8mrpVONF+w96qOjUb9GL0PpZ+I0RzhoCpRpDfNKLJuJcoqgAZB64FHG5tVdReRBE9qIWi0yNTazcRCcWRNT5kpCUK9VsqsV2nvL0jhX0UEJO144MJPShxOdbba1LG41Ddr29I/lWEU9nTg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ki8iB3fvhI/l4ZNg8pwQpnRkfQrIMrSF87W/jmcTC0kzH0xN/bueljIWsok?=
 =?us-ascii?Q?MmigZAC5hNv62eEvCnTgIAZIdl3Rd3PLUSVtHjMWvcS71rKmKWQFJlr+ww6W?=
 =?us-ascii?Q?hnKovD9VXnBW4Q89qehy63eP1OhOtQ7YYeBMf2vAr8dbZai6AWCZIPuz+9qg?=
 =?us-ascii?Q?IfLcV3ZX1lFj4VB5+aY+caREFz8hhgFFpXtgBdRPXDl15Ul8fIxJ3z3mJrOS?=
 =?us-ascii?Q?YgIgq0Bb5SRo8RjFeF1wjsBm5XVvFZLjsmbWQmQ0BWLx+anOSEHvackpEOhq?=
 =?us-ascii?Q?UqYc1QBjrAxBBpGr4MXF9EYgfDybgFAUeCztV8UnOmsuyUi7IihqHSkLdjxv?=
 =?us-ascii?Q?do3M0vGgq6q10wfz5X97/9p+uMGZ0q2eY/xL4hWvxmgGlCScY1hylLFuIlmF?=
 =?us-ascii?Q?l9YCGd934p9Rv/Vg7SpsnEJQbfJxdI6AmkE7ePLrpLbRqJHpWF8LsH8yybH6?=
 =?us-ascii?Q?7advezLoqvrhNLhfJ6HsPgZ+FzyB8z8JdCsWCtUZYwqPAxg37LIShLxWi0tL?=
 =?us-ascii?Q?GrfvwJJtZDJCptM2/8qRstZtdpwENIeh98jrKVMnEp0JQDGn1fzoGlmHJ4/A?=
 =?us-ascii?Q?NKS/hNcH09TNYm54bqbGGOzib3a7EaQHdkGKnY92ULNBN6P7DQksAEKAp+1T?=
 =?us-ascii?Q?Xd1nhxqj4CKTOj+MYd8ds399wXfUWtJp4w6doO7TUQBdQ2AMRjk74FC7U7Fs?=
 =?us-ascii?Q?CASIENtNA8uvWa7VQI0UoCXxzOM8RtPYu6MtvLytnK8Mmo5QNyYVWf8sQvo8?=
 =?us-ascii?Q?aFNyrsT3UGw2yQKix+AG1Sp66gEyJdYIw55RdatVkmQI6FdM3CqJx3lC8D3A?=
 =?us-ascii?Q?XKTVq6QaDQTrL9pnc6CPOU4d6ea8vbXP/54qYELqx+DAGGGJkBJNMNqqVn4w?=
 =?us-ascii?Q?5iBvserejTL1UQcsvTg4TU1wXg0ief96X2dKcEOGSn0haoREj5bCmwz+HG6M?=
 =?us-ascii?Q?vDil4UvLB2VjLeJvGHtkeF5JfBM3rx8N80n/ky17HFmsUEKeN5CkUEXhMcDB?=
 =?us-ascii?Q?+UU+FJpabGuFCeRy4hclx9fohmxF7XRCThj8yhtbsiSJ83VwojooPC3YSTo1?=
 =?us-ascii?Q?I7Tt1T6l0nV/unojq1y3BLeGOCKlMgBG9E06zsjzhKfn+9bQySmI3k+pCsPi?=
 =?us-ascii?Q?iNUoYUgIpQjyZ00ysapotLEMEiEzUqFeiIYg2pZvlVeLs6QhXQwPU0PWTle9?=
 =?us-ascii?Q?5ZRCiERmZl9nYUj5T2Sn6SUyWghg26fuTiV9yw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ffcd46-a181-4c03-fbfc-08da0cde51ee
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 15:03:42.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5638
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling and disabling of the charger is done via a regulator on
them max8998 PMIC.  Add control of it in preparation for full
charging support.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 13a065f5df5e..781d843da89b 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -424,6 +424,12 @@
 				safe2_sreg: ESAFEOUT2 {
 					regulator-name = "SAFEOUT2";
 				};
+
+				charger_reg: CHARGER {
+					regulator-name = "CHARGER";
+					regulator-min-microamp = <90000>;
+					regulator-max-microamp = <800000>;
+				};
 			};
 		};
 	};
-- 
2.20.1

