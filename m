Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D9556B9F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiGHMoL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Jul 2022 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiGHMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:44:04 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBF2D30F5A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:44:02 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-dhStFJlDN0eIXRiuH2RTUQ-2; Fri, 08 Jul 2022 14:42:32 +0200
X-MC-Unique: dhStFJlDN0eIXRiuH2RTUQ-2
Received: from GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:57::6) by
 GV0P278MB0401.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Fri, 8 Jul 2022 12:42:29 +0000
Received: from GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 ([fe80::60ab:6866:72d4:904a]) by GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 ([fe80::60ab:6866:72d4:904a%7]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 12:42:29 +0000
From:   Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 2/2] arm64: dts: imx8mm-verdin: use level interrupt for mcp251xfd
Date:   Fri,  8 Jul 2022 14:42:05 +0200
Message-ID: <20220708124205.59564-3-andrejs.cainikovs@toradex.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220708124205.59564-1-andrejs.cainikovs@toradex.com>
References: <20220708124205.59564-1-andrejs.cainikovs@toradex.com>
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5513352c-1f64-4cab-5a80-08da60df51fb
X-MS-TrafficTypeDiagnostic: GV0P278MB0401:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: g0ZBI7HS1dVBYCKrZhzuJ+mFj8JeOJb7Sb6LHtoGDvaiL/05/1bYcA3Fg797C+IDA8RGEUnstoknn+eu11fkzum8ZecIUwHpmwgE9Dzq8WX6OFKwZD9ZWTfD84Hhy+CFybJG5eYKhccRLohMzfpb/K5awEGzdY7iQpaq9TAQ8PnD4LbML/R7nuIo51O3KChQ3+v5ni9GcoCiJyeSAwIjaxgmkjy3ny60Js1ftMdoSx5dwH/nQB3KPKM7DiE5dtXT+JdDiKdePHgkQblcPFly0Vgn0711yewHxjvtjj/3tEjua53aledtPWeepzQ/JGN0ixd8E/DKK+rlW94rtg0O+08yW/eleb1jLfiAjjRRSNgYViwFp7uEmtckudtbPM+N9UdpC9yP7f5Lus/CO02OywlfXC60muFD0C04sQSIWO2uH4RB9cLjTAUB9/ZfhRfSyvniIEtCNXie3cD0YXqVs0bK3GgNp5hpt/VZKiuwObmk2Bq7z0lHgQdbX+heHp/cf5J7ecK/o/9o+AGi0uZNzdnkeaBiBRhu3oX4X9qSqG0RpkPpshVXUH1m5L1kCm5WyESU+yzbKuNA/ZYsrNMv6CKTs8GCOHkFIBZNoNEmA3VSjbJ5cBkojnOwMyDiE/NFYHEPxO7VndJr0sVIL8RGHBnEMl8J9t1Otc2iqEn7QvG+rfFFiQph557izdXs/voD1uOVOdB56Xzsi56mS6a0jbQEyPUnJqYxzqelFAUoLVXU4diI8zK1LVA6otOWkRHO5nQmOGbmtclwlh3CGv/dsEKRqn1oCyt9DB+y2ojtu+krDaQrx8D+5Zr+z5c5rLXU5GsVr/d1O2X1bKWDtKXJMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39850400004)(366004)(376002)(136003)(54906003)(7416002)(4744005)(8936002)(66946007)(66476007)(83380400001)(6512007)(5660300002)(316002)(26005)(44832011)(86362001)(8676002)(6486002)(1076003)(38350700002)(107886003)(6666004)(478600001)(52116002)(2616005)(66556008)(110136005)(36756003)(6506007)(41300700001)(38100700002)(2906002)(4326008)(186003)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QrlAdgiLxXH3Gx2WhyYq23i6Qf41hjoaI9sXE5jPSY+Ul7hMEMuZhrMTX4xd?=
 =?us-ascii?Q?ij1+TUG4dXiWLcZrxT+Ykw1ImkKr8Hmvek8M5PqYkX5kiy1c+cUiPt1ZacoZ?=
 =?us-ascii?Q?7KF0aRS4ymHioSOVvFBSo33qK7GgEuAWqgDl+2FVQfbfchcUuO4CLV2VJ5kv?=
 =?us-ascii?Q?eAUKzx6AN84u4JKXqINeR8leOWwmarW2Ugi6JE/XXwVAne5rHar3qOQBTwcY?=
 =?us-ascii?Q?gnPVQhZqHPYbL6Oq+mqMl2ap44PLP/yvnFDbqeC4PI+GhcJyVtcYIznVUPus?=
 =?us-ascii?Q?ZEJ0BBsdv+vervpOYS0InpFtTGs/DFRjXV6uPrJ4RahHmx5Ezp79olCaqE40?=
 =?us-ascii?Q?3FyAPeKBB60DMTd5E3u6FUMqORHI0DCWQ6DcHVy+sOkV/AQ5ud8p3X8T+o8L?=
 =?us-ascii?Q?OP5daluojJ+F7FE+y5XZhzFL5ReEk9nSm8NHDQv/RH+0Y+l2THjy94GdGT4/?=
 =?us-ascii?Q?Oloapc3vmuh09Lfj212eZ4/lZaJOHv0Np1wWA7BfppVFuQapzDlYhHOfGReT?=
 =?us-ascii?Q?zKGXHruNU1+20+U3w44KbyTe0vblBR6IAj6MDg8//Lxpx+nIp89tA11cZ4GL?=
 =?us-ascii?Q?5kLjRmIsXVsbIcDNE0HlrX2q53Rb6T3iNfJ2sqBczVFesC7uRl+6zb8Ga7pC?=
 =?us-ascii?Q?iXGE2Aleydp94f9HGwAQYBbeh6UZ9fZC3DwvWNyYLIolbEKyUK2lTvN48qNX?=
 =?us-ascii?Q?4g2RMSW5VtW0TzXHRRUFW3VPqD8j620zXsfL7ZvBkSp2+kIOfCRR8/QnFWy4?=
 =?us-ascii?Q?yPxbsJvcbRLJAEa45AMLv1El+fddCWyynXeFyGlHVU24v2ZuBBa9Xs33mc2L?=
 =?us-ascii?Q?i9cUtBCRaobe5BY+jVXjnmwA7OZeIgmX/wOvf7p1ou+sRhzjX3/hnoKJpWVc?=
 =?us-ascii?Q?ds9k7jUMRjavTfGu2wwREtrrCOn62ArLgVtgojrPJr+FZSPe9so4hfTdd9UV?=
 =?us-ascii?Q?Fe/8YXYwNaMWXEOBnrLWJbKqGQ2N6DJZUijxEPO2yIP97/Q44gShXUdWi41w?=
 =?us-ascii?Q?Rz+bwkadX9/0D85FT3lhnT8We/P4QW6FAZ1okMuZTfaJswGhb1ynZO+GdyA8?=
 =?us-ascii?Q?PBDWb0foV1GOGOX7uZtmyovE2Is9L6PrEn5KTWn8zbInuJ/JyihKpVLy/Xhf?=
 =?us-ascii?Q?TaeWk0MDE9CXnFVPTsUOdbTxANmRT8TPQZyQLKjnVPnIDP97UjIksqkshjzu?=
 =?us-ascii?Q?9v2tIfDN8AA7iQxjWhq+O/aJSqRqtXlM+mDziklRnS3YSEfVa/eku7HBQMsG?=
 =?us-ascii?Q?FqE1GcZj62O87xN2Cp9X8M8YCNCAZAFvqeHB6AC5dEOEL061H+kxtp0E8ESP?=
 =?us-ascii?Q?HtkmGLNP8B0paAy9mYvmr2UE4zkR3ECtKhhQTAN0/Q/C9NKWJ9/b7g4e75eF?=
 =?us-ascii?Q?w5vFoKKEYKIDxo+EDtl+6SWIebaVSezI40lZgIFltnC6Jw3s1qd1zr/sOgn8?=
 =?us-ascii?Q?fS0UVU867ipNkWaW13hjK9JcDg8gb7nWlzwlNyWmxZUnLEWnuXjJ+eYg6doL?=
 =?us-ascii?Q?vkCLLb5kTkj9mGWFGqyQBsUkvyXEKq5XQ2AXBrf0b0kck9ZXrI+ceNcO0LnJ?=
 =?us-ascii?Q?AYUprVjD5jvPrBlps7jOQhpf9Z5WnNgV6e3bN3+6ENU/5VYgi+MybLB78qP5?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5513352c-1f64-4cab-5a80-08da60df51fb
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 12:42:29.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjJisJKX8XBJHLKxIDWj+xSmoWQUDSyqoGSihbWR6K7j//C2jCSuI+01beqoaVg1Na18ssHpmgkhf02yvN+k6EG+7KB0iSuRe2vnl9eDGrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0401
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=andrejs.cainikovs@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to level interrupt for mcp251xfd. This will make sure no
interrupts are lost.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 2841c6bfe3a9..6491e745b3fa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -195,7 +195,7 @@ &ecspi3 {
 	can1: can@0 {
 		compatible = "microchip,mcp251xfd";
 		clocks = <&clk40m>;
-		interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_can1_int>;
 		reg = <0>;
-- 
2.34.1

