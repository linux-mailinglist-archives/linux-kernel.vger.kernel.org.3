Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FDB4E893D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiC0SLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiC0SLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:11:01 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07olkn2089.outbound.protection.outlook.com [40.92.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9E43466A;
        Sun, 27 Mar 2022 11:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOnTxOPALGuy1x3PYMQFjpQQF/zOqwxORzjlQRgCB2bsztbwHKvnSTBC7MPjHHzRo308LZqiEgkI3QeEDgXhA0J16MVBGt9zcBtGi+Dxew2i3gi6S3aBEewVT5IRn+FTC8w46jyWxytGMi+Tvko86c1lvx+RGmz3LChS7y74S++GbJ2HbAKS4u1zb5o3GjJUZ+mfBKoxdtDeUJupq/2FywFTtNmmniyn51ZcK0rhD9mPKc3vL/842hDfzy4SCdkIHVPe9QqLy10nDIKuRKAeYN0NC+jhbK5M2jD3Mtbrm2S/kWUA11LDTZB/9iHgvZ2fcZ4/c8CV8oachT3TEWchHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETKIoo7zFkHFLl5B0vYAeoCkzZXf6WdlONDAUr9bmrc=;
 b=FuvtQeZ8mHD8KuovDl+HeYzJBsu4LxwSjkfkTKczcJp6AVmIICTtsQfx0qsrVRVk4VHOL4ccvuLdf/PO8uvCakUqs0q3OTj1V5yzAmjb2MiYGK2tQMWqnMRHEIKJqC86azQ+nBrtMxHx3lwSQIniJjc5OLUFjDAy6nK0mugmJhCNYqUzJLyK03ywak7TRW9S5BzkVXI1m9BDux/iHj4V/ufRUKjWkiaxYSQCOgWFElqHcUcTStsmv6BqTJz7iTYSM/+b+5gfuUKzkvvC0fw5Z7I8OAHhIbnfO6/aph+xXCS9zHJNNEV8kwdiW6EhnrypNBdnBTXvA/SuGxNlRpl59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BN8PR04MB5778.namprd04.prod.outlook.com (2603:10b6:408:a3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Sun, 27 Mar
 2022 18:09:21 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 18:09:20 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 4/5] ARM: dts: s5pv210: Adjust DMA node names to match spec
Date:   Sun, 27 Mar 2022 11:08:53 -0700
Message-ID: <CY4PR04MB0567F52ABAE0A3CCD3C7CE59CB1C9@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
References: <CY4PR04MB05677B4C4E26A8A179F6ABC0CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [jdeDKrzxsGXR+H7QENliUOuFJrVGDOCWMO2T1zokTTxMdb6xNeLuecgobJGpegI7]
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220327180854.4857-5-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c646bd0-7c5b-4902-ea0d-08da101cea6c
X-MS-TrafficTypeDiagnostic: BN8PR04MB5778:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIousbJf1osUiv48W5N1/S05BA6SJVDTC1oC8gJfs0f1AWP48jeADFCzUMcMmo/3C1ZY2icsMv7BWUHp2uqA1x9gywYvSCEbHgJjOefbH6NvM+0RnypjKccB+W/Z00U+Q8QqVFKPLnzZ5iG/g8ocGnOwiOkbxYBPZraNbySUHcxAVsX2msXfryYWTksKgfoFqQtSH6DlVa47bdMFKHGcEybfG55a80ydSfNX4GbYtCk2cbJMjLBiugbuJU1cx5yshHwC8GwQWMK1MUCNuZjPolQglFA1o5CCPczmVz6T3l6zAoI4q59u37oodtrYM4atOMEpmG4iDHpPfnBrAbFzFTvhi3QXqyqOEATAcd5IhxgLPVaARx+KHMvw5zZzI6MHW05D7X6/2Tti2JXQV8Zplkx5eYcBjEXuwbaM4vhGNMyf6/qaeb6ZNgLmvcKUpKGwyeQBPw26PWbSXjbpwleASsWPopmaqUIOo7N8Exw8Os9ZlVkRd8U1RsA/Ofu9kf1oz0a3moUq9eE+qZY25SMPdK8/6QN+4V2Ukqu1TrZdOEEJcVE1psm+mPGq/HMLGRjjOPl4pB293RhMdwNW4hd+0A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WIU5mblY9YBywcvR5C240KuTsDtJanQPFgDJflDVwAC2DuHB9xCf6xhlrJhG?=
 =?us-ascii?Q?MnPmfc1048YO1X5Zngop35R/mpbZ6EYhlRWPEnLGyn+a+CxHWjVecSWl3rE2?=
 =?us-ascii?Q?vA1YcyF6vDd+bVzK26O/DjWCdR91q3aRw+d94iJeeRsUfAFgXxvSP49g2Ng3?=
 =?us-ascii?Q?XvGwTl9WLtloClQBEjVc6lcCBQehyWVCG+LYXiXVkOK4ZNWUHmTqEXQiOFRs?=
 =?us-ascii?Q?SnQFiJ6RlgnSQRJEp/ODISy0YIyg6ssPLWojzBPxR1NylKtwYUjqXGTRitlT?=
 =?us-ascii?Q?ir6WikuaBbZFOFF5iDxyyY0J2JKqVTeCkip0roVjP82HCMw4XPAnrRIj6ogw?=
 =?us-ascii?Q?1tKauV6Xn7BENl5gG/NSjD1OHyp7m1wa5aY+K5rFcOZJnhn5XUjTupGa2i6M?=
 =?us-ascii?Q?Vux1gee6RZscPQmYX2Z+S3sL/vpUfaZrDRwy0igCL//+wCFCKf2H9gttgNQ5?=
 =?us-ascii?Q?+BQYOK84Auxx9UnEC0u29PPY8cPIx4pBZXe9V075LXSJy1WtSIL3SVwjO/YI?=
 =?us-ascii?Q?1hH4DRWbLVeMWblYmXgjp5GuGv3Zy0duhK548+ZlJmt9f5imMNbAou80tJH2?=
 =?us-ascii?Q?BpK6BhDxVLYh7E2jy+oFs8TynwZMp7AfKl4O7C5DOuJqPI9oyHyOs9zfUNB9?=
 =?us-ascii?Q?PrV3Gu0ZzwPVeJFioXoe2rZdqg58loMT3SzkTciz/H5igyt3HuMgHeHcVvG4?=
 =?us-ascii?Q?1Iz1xgRl0srRV6SXuH/eTcI/MNlW1nzq6GQ5brMeDbWHeH69YYOOQ9j/HsVy?=
 =?us-ascii?Q?pcWLceXXl/OYRQUVYNXP2jS3a+FUavznnE5Gw/3rq1/dyrI6hvkUMyuqKZkv?=
 =?us-ascii?Q?1sYBow2BoIWbfUZHMeUUdpjxHGpPoHhq8Vrf0F0h0twHRZICKjljKIju3b48?=
 =?us-ascii?Q?Y56gkRpG3LGIeSFaAe+9PGHj2189EYHZZHzRR3vXKiuNXlpStLT+h0mMmq/W?=
 =?us-ascii?Q?szuWTPEe3aWvAORyeamzglezepDDCRZsnVDXVDHF5eyfh98riroWulAZmWXk?=
 =?us-ascii?Q?zt5mnlMMZcEWRlL0s0jJCsX5k246zO4W98wUy0dYiXUydHkeWZYmq5zzqWlu?=
 =?us-ascii?Q?6I/FhOTxXFUfc2Ou9jYuw4yX0ScYvw4+AQl2wAaJBp/90ir7r2JsfqHxRxIb?=
 =?us-ascii?Q?+CKmATaDTAfW1l0H1gwQKQ22njOaQFwo4/jm3jkDH4Zj4p7rN3Q++Wji98dk?=
 =?us-ascii?Q?6egyF3IToFSyfatFAqevAjncnBf6GE66eBQ5dMb/aTKG8v3Skkismbaftzaj?=
 =?us-ascii?Q?WWbVIiLc98lOazdQhFcoeQDaxGSgj7D8ftGzAwEcY5csY1kYCOkFYKRDrd0f?=
 =?us-ascii?Q?bKVyhQ6JQBc9RRK8NU5U33pcDVujy7eD05gYE+n6SCUpo5rqNQn3SyILEFBy?=
 =?us-ascii?Q?08zaiFWjww2viVAcILaCvDjUOrbkgFEWo9Na8qCmQZLWPKoi1TbqW606s2Yc?=
 =?us-ascii?Q?/PlPOHCvPOpq1hQzc+h4rSlFTenj/iDdMlKXuxXKQHttqheOlIBQrEN+9I7b?=
 =?us-ascii?Q?Fz2DUy1nfdrfc9g=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c646bd0-7c5b-4902-ea0d-08da101cea6c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 18:09:20.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5778
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
index 353ba7b09a0c..0bccfb9d0c0e 100644
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

