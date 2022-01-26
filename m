Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDFF49C1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiAZDLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:11:52 -0500
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:62220
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236896AbiAZDLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:11:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdxozRh6B11Vv5xIMVNe7Imp6VNkb2wGR5hWqEpGpSuDZIg6MUZm9J2NQcjThEf8Ua7CUIkEX0iST0Gf5rijoClXOS7YA/oE60/iMjZOY5NQ2np6QDdA7mw3j55a2GkAjmd9g5CsP4/KT16L7JqJusGb7ndqCAxFjl2lDvgbtE3po3drP2odMtNZH0fHZXu+v3LVJOnonHPmu5oIQTqBNlRxCqBYql+3Nn4bO8+fUiHmkeZSfdbN9ZSGo/QeWDCwkN/NH8ZMn93pqjqzUL0m5B/LvyDBBnV2aAhXtQrDoSFC/H1yIMnRJCDz5OBhV7TkIGmvsDrizKCFlq89Csfqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9snIUJxZAQmyg0P1CwtP+CdexAr8Di5UM5LQUFu/BVA=;
 b=N1vNkilbXG9NIA20FWRyWUucIRpxWr1JX/9Iu60eRLJ0csp5xalAFzg7yuucLdvW4H2SeAH2gV0dkVCVpfrnWMdwWiiEWdu3meiEDyR633b6ggx4hX+7jtb5rJeN8JTCU+A4q0bu4nMBMIPN6P3kgMDSj48jDFEX5u7MNsVB63MUfSLOGIWJM0W6XWIrVFhGePpCHFhWuR885uhvPr8XZG8gToXj3EmmmBStARXe5qpV2vPmNwVgM0/dU/CzcUcMOxSwXD97sX+YgBCOIwmXcD8BYY/ChcMn6yS7d0Y7tV9f07geoDroTlHD56+//a06BYcAp4/HwQksn9Yd/TWg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9snIUJxZAQmyg0P1CwtP+CdexAr8Di5UM5LQUFu/BVA=;
 b=cTnE+JmVASkixOPoegtZpnR4AEzEq5oH0OTPLKuHkLS53NOeRZLzv99HoSZQnWrCzHhHAqzTcG1ZotVS0ekxmc8gRel7ZsNjRKPX7lvH+LzW/QWXHbja5xJktsk70ka5TvHaM2/wrKFL2JvCExBJ+pnX1eCPBmcZpnIBeB/LeRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3319.eurprd04.prod.outlook.com (2603:10a6:209:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 03:10:51 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 03:10:51 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15.1 11/13] ARM64: dts: freescale: imx8q: add imx vpu codec entries
Date:   Wed, 26 Jan 2022 11:09:30 +0800
Message-Id: <7f8db91ae941309e38684a17ae1d3c088e72b209.1643165765.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643165764.git.ming.qian@nxp.com>
References: <cover.1643165764.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0091.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30d9dd2c-be3d-4f46-3d55-08d9e0797557
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3319:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3319CB6EB26EB9DDE2E22A03E7209@AM6PR0402MB3319.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2e4aplgOff+OZVMtWUxySHX2DExrlguWGvdivY2ojITmHuaOH7GQ2Kcjhk7Sw5ul0ixnv2Mqiv5erF78TI3J77YU1qJSuy6LLVYwRFhw5uLN6RcgaeFgw1Ad1TvmpSFLv6+OIDydViSryJLJvMEpPYn5UZazjbmHZ2A/aRRw0H3f2xFzeldgJ/lb925J9OaQr65KJOq5OiAVW3dqwrFa56EsodMlpJ6DJVkYvpBVsDOEj5wyUXlNfn1dqh2wPRviauOT0nwZLW2EkZM/NHeDLnuFAcvNxZW+wmlKdlYb5GBwu4lm+VZ1Pg3+j94xQ0F1TUeJbsnCB3dtyZF3uSISIAVjzEI9+/oUb/BtbhlumOGOswwuN9AUoEknb6+oFbhvpCaF7a8NFTL0ePTOxMiPYdbOZeLsVcKkLHhk8k+cND4TsMaytfMZDuQ0DqsSCCQMQbcGTk0DIiqhKum52Kb0Qpjy07bRP1ov5LBLR/ZR6BRKfiRiw02m5WCbJr4UDKnN8rl4/Za98xOyQ6i9pWHNTkor80Qke2MNMbHfKPUYB5Sdl1mhQx/0GfzvjZkANqKZT9odk3TeREbl/KFR6FPhW8mTqiWamHa9j7Zp7r6oc13RQT6v/pP+ZPgINMKSBpXSW9eIoWscPD3EHtzNrEAt7yvA8xaRN5NCxfWV/eY5CA85pfzzR72FU/dpQtpuSfPECBEs+NCL33jm7QX+JiVea2uX/s0+g/iTpL10LEk0EHOtcGBYmLbBrAOBbMe00x565Wvu/IyeY2EHyaFpzdaXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(2616005)(36756003)(316002)(186003)(26005)(6486002)(66946007)(66476007)(66556008)(8676002)(5660300002)(4326008)(86362001)(52116002)(6666004)(6506007)(6512007)(44832011)(7416002)(8936002)(38100700002)(38350700002)(2906002)(32563001)(414714003)(473944003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+VIooWmEqu0VfZWyJfiH+eM1eM+08FBUS1+bf1oJSCsof1ygK+zo+lvLc1M?=
 =?us-ascii?Q?yMpzW8IyxB5gC21+jkInS9OpZBKXMjdDJHjhmvYJY1+gU0OtYnbM9rD7AvY6?=
 =?us-ascii?Q?jRq1oUw3Ur6DjEMgx1y75V0aoaaF+q8kdpaXI1PqKfzUfJkdndSNVTaJv++F?=
 =?us-ascii?Q?e4jz1UBCR7uEPASBb4aaBPSfMkYYv0yW56Y/zj4TeENLWryg/5siggczBlfZ?=
 =?us-ascii?Q?OuXRtzy3k0haH/U0JYmWayfFKnYU1AiBk5UZKpXoU18LWv98AbmWKsXs/BuP?=
 =?us-ascii?Q?B1BZ4jGP6aCt1FALhhwJVeDfIdWq0veivEilcWudf57H/iaasC+6ilFqTYPZ?=
 =?us-ascii?Q?PZ4JRJ4FnboAfpM+PtCoGXH0dWTHdU+8V8N1CyX0SqFWlOIDKvvB1ctDUvcW?=
 =?us-ascii?Q?ksnzEhPdfr24FLhwyRJSG+92H9C6SXpfafdCJyrRcPQZosnJax9FZrHhz9Bu?=
 =?us-ascii?Q?b6Mhvj0/MRERLh56OVzPE1nHWUcavC4xBvUTPD1w77eGdPgluheswEhKSNpB?=
 =?us-ascii?Q?Z7T1VjhNkUCbbxgiDDgVPluvoA7fChq/7CcncDGuHH9KEqZB1mQ7r1bXu9+v?=
 =?us-ascii?Q?S3SZB60aXJdQZH5kjMS6HJ52jNm7Q6yMp9TAXP1WfsVYjjhxguRk2WBTc6dD?=
 =?us-ascii?Q?V53fvZPBi3tOaRSvxnOC6/w6bjhGm/PDfsRqwRkMEjBJzB2hGhEuDszdiRnO?=
 =?us-ascii?Q?SPy6eBXBb5jFBjIlIg0M8hRL20p9ytT2zOaHP1Git/SOzkoDpBjwBKTJjG6N?=
 =?us-ascii?Q?/55j7Oz5RBsEiMJJgJAnGXVISCB/CEhtAZwcei8hjnbAsJrtpDVnMdDmqRNU?=
 =?us-ascii?Q?IX4MJFpmTsWYELKSk+X2Ees/cwAjwdtVLJ7p2lFKf+l5vbSfUOZkqPSwQBor?=
 =?us-ascii?Q?FhseFNJGWjtr6ZUeDAl7m8B0bKTvuurqNB9lWwDdFvCOWQDgnx1yW/ND4Aoj?=
 =?us-ascii?Q?C6CkVldyxZ8l/OP6imhVHA7gMVimVpQkN9I4mqKxdUJKlH7mGZlHMXYshwjZ?=
 =?us-ascii?Q?EwIsQ2wNlOWOHXr03qFWIvPP1U1CynBlWIhlHiszLfpz3DyXmJU5NSwAtGgt?=
 =?us-ascii?Q?v2I+fRfS6miS47CSLAnVTMd37JUBQYUuBHTxpZUYZhfbZFAGdNYg54ya75x4?=
 =?us-ascii?Q?P0ZLenT0TiVZQqsxRPZlzn6LdwI+AZMUF+egtMyF11pOgFN889w2TLFwjN+R?=
 =?us-ascii?Q?7j0PxjRvO0cOwtSP06e9evSljAMi4QsR+VNPRJPAsXGdYtk5tXUHmC8qMwWl?=
 =?us-ascii?Q?pmO6d9b6vOZg8h2GAcm7RZ8aF8+LKezeBNbUOwZOh5B21CT3BvUYfB8zjnL8?=
 =?us-ascii?Q?a4cqVcNKZt4TGW6dXl0PXFIXvwe35vDiWu37vl5XwU9h6L8kq48sPLOxrLDg?=
 =?us-ascii?Q?yvdtNM3jQqpufIIbZcjFtxKU7rWWXTxJGW2+BRIzXptXDJrLXEf8qUvh9J+E?=
 =?us-ascii?Q?s5aN3viLdkEtfoZk/sZfzcQQHj5+8JE0Gw2j/K3e21xqAvDox0CKIyHvwp22?=
 =?us-ascii?Q?juaL6aHA03gCG56oHFoREZcS7uClPIvAYgu2wv7fCMlKvt0K5qN/V+rrxd+P?=
 =?us-ascii?Q?1VHHqJUPzt2BkkV1er8VJ4zmeHUqeuDtkafaQmhLc0nTqPFkCnXNZgQr068R?=
 =?us-ascii?Q?Yk8Gy0hw/b95M0dRZRFi36k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d9dd2c-be3d-4f46-3d55-08d9e0797557
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 03:10:51.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0q2c1H7TfVbkvL/qGBV3XYv0xmqVV+jxKoo59pF00nzidlir4pC39GZaHMeCyd+Es5eXg5TNYGIcbqZDTCvvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Video Processing Unit node for IMX8Q SoC.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi | 72 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 17 +++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 24 +++++++
 3 files changed, 113 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
new file mode 100644
index 000000000000..f2dde6d14ca3
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+vpu: vpu@2c000000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x2c000000 0x0 0x2c000000 0x2000000>;
+	reg = <0 0x2c000000 0 0x1000000>;
+	power-domains = <&pd IMX_SC_R_VPU>;
+	status = "disabled";
+
+	mu_m0: mailbox@2d000000 {
+		compatible = "fsl,imx6sx-mu";
+		reg = <0x2d000000 0x20000>;
+		interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_VPU_MU_0>;
+		status = "okay";
+	};
+
+	mu1_m0: mailbox@2d020000 {
+		compatible = "fsl,imx6sx-mu";
+		reg = <0x2d020000 0x20000>;
+		interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_VPU_MU_1>;
+		status = "okay";
+	};
+
+	mu2_m0: mailbox@2d040000 {
+		compatible = "fsl,imx6sx-mu";
+		reg = <0x2d040000 0x20000>;
+		interrupts = <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_VPU_MU_2>;
+		status = "disabled";
+	};
+
+	vpu_core0: vpu_core@2d080000 {
+		reg = <0x2d080000 0x10000>;
+		compatible = "nxp,imx8q-vpu-decoder";
+		power-domains = <&pd IMX_SC_R_VPU_DEC_0>;
+		mbox-names = "tx0", "tx1", "rx";
+		mboxes = <&mu_m0 0 0>,
+			<&mu_m0 0 1>,
+			<&mu_m0 1 0>;
+		status = "disabled";
+	};
+	vpu_core1: vpu_core@2d090000 {
+		reg = <0x2d090000 0x10000>;
+		compatible = "nxp,imx8q-vpu-encoder";
+		power-domains = <&pd IMX_SC_R_VPU_ENC_0>;
+		mbox-names = "tx0", "tx1", "rx";
+		mboxes = <&mu1_m0 0 0>,
+			<&mu1_m0 0 1>,
+			<&mu1_m0 1 0>;
+		status = "disabled";
+	};
+	vpu_core2: vpu_core@2d0a0000 {
+		reg = <0x2d0a0000 0x10000>;
+		compatible = "nxp,imx8q-vpu-encoder";
+		power-domains = <&pd IMX_SC_R_VPU_ENC_1>;
+		mbox-names = "tx0", "tx1", "rx";
+		mboxes = <&mu2_m0 0 0>,
+			<&mu2_m0 0 1>,
+			<&mu2_m0 1 0>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 863232a47004..05495b60beb8 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -196,6 +196,23 @@ &usdhc2 {
 	status = "okay";
 };
 
+&vpu {
+	compatible = "nxp,imx8qxp-vpu";
+	status = "okay";
+};
+
+&vpu_core0 {
+	reg = <0x2d040000 0x10000>;
+	memory-region = <&decoder_boot>, <&decoder_rpc>;
+	status = "okay";
+};
+
+&vpu_core1 {
+	reg = <0x2d050000 0x10000>;
+	memory-region = <&encoder_boot>, <&encoder_rpc>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index dbec7c106e0b..a041b85d612b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -46,6 +46,9 @@ aliases {
 		serial1 = &lpuart1;
 		serial2 = &lpuart2;
 		serial3 = &lpuart3;
+		vpu_core0 = &vpu_core0;
+		vpu_core1 = &vpu_core1;
+		vpu_core2 = &vpu_core2;
 	};
 
 	cpus {
@@ -162,10 +165,30 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		decoder_boot: decoder-boot@84000000 {
+			reg = <0 0x84000000 0 0x2000000>;
+			no-map;
+		};
+
+		encoder_boot: encoder-boot@86000000 {
+			reg = <0 0x86000000 0 0x200000>;
+			no-map;
+		};
+
+		decoder_rpc: decoder-rpc@0x92000000 {
+			reg = <0 0x92000000 0 0x100000>;
+			no-map;
+		};
+
 		dsp_reserved: dsp@92400000 {
 			reg = <0 0x92400000 0 0x2000000>;
 			no-map;
 		};
+
+		encoder_rpc: encoder-rpc@0x94400000 {
+			reg = <0 0x94400000 0 0x700000>;
+			no-map;
+		};
 	};
 
 	pmu {
@@ -287,6 +310,7 @@ map0 {
 
 	/* sorted in register address */
 	#include "imx8-ss-img.dtsi"
+	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-adma.dtsi"
 	#include "imx8-ss-conn.dtsi"
 	#include "imx8-ss-ddr.dtsi"
-- 
2.33.0

