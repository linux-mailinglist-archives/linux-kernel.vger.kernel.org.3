Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9C49AD53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443002AbiAYHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:17:12 -0500
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:15334
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1443223AbiAYHNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:13:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlJcm7LHyJbLED5KwX749TF/xgldef0Bar/1eJWjnpIP+9VsQBjVBWV/DTLu5B41XIOoR4YGkcOEMQhhmT11vR1aDFeCAhViIfRoJfpNKHInOZzoiBOqf4SIE3yHetdAmIg4KFwS9Dd/KkxvGaGQJPoJ8EP2wracQfUmtTzlK7a4eW0ZTK1yOOEYFXRhxerXMZOrzsU9f5ltpiLUlH+9tQrkoxw/MwPkfuCVgbj3KbKLAaxOBcHrVfFczL5UZ0V6jEi8zHWQ08wvhIy52/q2AHWZ2UYyHeiTb29MDUe3yiC93PLNCVtjHw0Eho4VSibQ6OsJntABFIMVSDGz8+bXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9snIUJxZAQmyg0P1CwtP+CdexAr8Di5UM5LQUFu/BVA=;
 b=lXjRTMjfHSUpntlO1O6iM0qopkOS0WYWxbapCBgnJrRH7afh6fDWruaHzaLx4+/hmeZUy1asacNJoRpmE36iuNkdx/pOS/o5r5vMDOdxjY1GrTa3xHDpQeAae5jI+ZBjpCJSQGt/X9wBZAMj1QbY9t35YhlZU6z/wu6lmWo0WQf58yHq79wAaP5jhbB6h6qjUeg13k6sRxLN4o2SVsnn10Ex3i29wPun12FkZ3Ra043o6mSmvy1CASFL9i9Iw5H6SIEccWRobujP9us3V6YadAtDntb5SsTAzwH0Y0QnhY4H7adkXgXccg95e2zTsZga+0ZTu2kQrKFLDw4K1G3lHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9snIUJxZAQmyg0P1CwtP+CdexAr8Di5UM5LQUFu/BVA=;
 b=lX+elPOcjDdxiY9i5hSYvxDndgDLkz+140QLfdNKEu3qHI/xQK5yuRKy+sy26X2/AlTmr41fLZyIqoBgbumtX2oizVF44RXs5HmMG5bwDc31Wsn/uMjUYOkW2K0QkuIm7xovjZ77HL0PXvrmx7tnDvUCEV1aSS+DYQJWXr4qT+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6157.eurprd04.prod.outlook.com (2603:10a6:803:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 07:12:38 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 07:12:38 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 11/13] ARM64: dts: freescale: imx8q: add imx vpu codec entries
Date:   Tue, 25 Jan 2022 15:11:27 +0800
Message-Id: <2fe32dd3aa85e1cb8e913939e71c673671524d7d.1643077283.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643077283.git.ming.qian@nxp.com>
References: <cover.1643077283.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f2f1d2b-bf6a-4366-687f-08d9dfd21171
X-MS-TrafficTypeDiagnostic: VI1PR04MB6157:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6157725CD515DB6A38AB053DE75F9@VI1PR04MB6157.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWRlpX8rFKQmd/KFmXHj3p+fBJxp6jKR008IxiEN+jKq6Kg4ZObpgW4Kjib6dXQGfPAZKxZ8dNu8uPHqGDf+CxxyQl4/rLyus8pXFpzqqKH74dGhR2LlLshvC1rIeI3glipA1LzYspnuSFi8it1dVEpjj2AQsLDbGGMoigCndz5BVDPhgi8+fiMzzbPOyfRKV+4fBDNiZiVVRBhwfRqkvCaA4MQgO9S0oSlpx5NQgzM/ySB8QJc1gyc8Xc9iiEsHfr3IfjcogKdvTMqos7KsLwfZ6DpNyUqyTNMI8lN95QL2KviJsOoHunqCi/TdvcCZj9VqVwGFkEJUJ6z5gfrQ2gMnj7en519Zwtw8+3qEdruqd0Zg/nrY+UyOUD8ipUQem8a+S1qajsgsVXu0v7X7GBliekg583ygGtL41yUxHSG8qKFNS6o7uq/oqIbkZl6pTh2Wvf1pU0bPVxw5wOLOnnqmrC+dDQnmwhyYiBAjIUDmRGt3EUXIFkAvYgntSvSPQS1XPggCuTZDSBjZk/vgPwQGgLM17j7o5IMps/jfJBmydn2/MqHbqrmJZi0XDHmqpIruHLZpvSWRjgVdvF/xnhdR5dG3CjmHnl/cTI8r06qHBEQ5oKojzrCAIn+O5TLz/ajOkgD8vW87lxHmVBziTTXpyEGAZafRGdl53GUXBzNV41qtdhMyWBSbTCR6b4lq6Pv5PcFDDVbLq5sF2BknHvGYz2nkmf5IYP4AcRjRghIcHYcGb07B4/uf9dbrS7pFvF15dAlVecl3TGcmannW3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(186003)(26005)(2616005)(38100700002)(2906002)(66946007)(66476007)(66556008)(7416002)(44832011)(36756003)(8936002)(5660300002)(4326008)(8676002)(508600001)(52116002)(86362001)(316002)(6506007)(6512007)(6666004)(83380400001)(6486002)(32563001)(414714003)(473944003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1aYHVQl2zQEMaO56OfzP0v15/cG4BlPra8CHtvCNMxDPGZcw7W6kLiCS6Fq?=
 =?us-ascii?Q?sEyvyIOprJXAEn3sjTwFZZOL9PJl+lusO8+ZUjEynKd4Ffgi1N6lrTvfaWcP?=
 =?us-ascii?Q?1CO8vUJyw/SlX2aQEvbGD5Sy9fsTopJligqMuiEecTj/ssQOHIZ5AUhh8yKk?=
 =?us-ascii?Q?kXTH7BPaK5dvqrBbqA4YbPmZaW1B6PF70TkGAu1ahVHsF6GABetjC4NP1KUI?=
 =?us-ascii?Q?xz1RZwJHx3uPbMrpxTDEWv1IXTUCY9NZ33osqL7rnZfpkZbn7HGl2sZUhxjD?=
 =?us-ascii?Q?A3Sn0mwBXD2HaC+dzfKrh6WGzRRKAD2XRclhoc+7yX+OAguzWGuLTA3JBXM2?=
 =?us-ascii?Q?029bQ1hBVHCQNiwD0rCuhpjGBT4gmfGlCEUc/86tjfjkGuP2dImCsKQkbYZQ?=
 =?us-ascii?Q?dNya5gTdhEJxyhBSR8d/8SW8TfhqHqDseNlAHGSY/YvQ8l9Wv7AJ8/VewEpw?=
 =?us-ascii?Q?raLgT9DErr1+oFTJIgG/XhYVvDs4tQCEivX9HW3GIHSuDoyenjzCEnqzVmUD?=
 =?us-ascii?Q?08jXGAckwZ8Cq1SXqyEDAGUPspihvGRZ5pnEmIOxe1csxTfh7wJJKKrDPC6n?=
 =?us-ascii?Q?Zk/X4VKk26XPdpVLoWX6W9D/+f6LNFMHF70ZcbNLxBTxqot7vHLKQwrcNRBe?=
 =?us-ascii?Q?UIwskcXUuplceAl4GfHlmC2ng/gUjNCS3Ln5RlM4XJBgivuI9iwKfb/gsmgX?=
 =?us-ascii?Q?cfK0X5EFwdwSU0pTpTzoieB1FRBxaU3EAJ1ZqwI88MoVbV9miIA04u3tXP6e?=
 =?us-ascii?Q?g6GTDc0CVfNUMe+lYg7Y4lwfL6qwiCq3WCLCDMuaRSOJhkZjG8isfMOu5uLc?=
 =?us-ascii?Q?NUAvjNhYo8G+0lgeX+yKNVRQq/Qz9eiJAGxOwt4otwR65CDD8ZulNGcOUfIe?=
 =?us-ascii?Q?tmcwjty3FZlbjUGS3sRy9QmlYsHirV10HKfZ6SMkMSbfu+3GkU5KfkjlzVYa?=
 =?us-ascii?Q?0VGI102ynFnQk3kbHLCQKF5oaGq3t04vWB4JNv9e+LnVHCI8NugtEX8lN84U?=
 =?us-ascii?Q?3YNvNzH5lIxvJ/JFhU1soj/fsHXwBjL8yu/AOPZFwHCwDkD9d0qazAJggMSh?=
 =?us-ascii?Q?nP6y2IO+bxmhLlhja/c6+Z3S/piD1MgezlpWYLaHEKjeWsUjWoy+lF+NVvnK?=
 =?us-ascii?Q?vsWzlRv6KIvxmvbf0lY32P74E9mcIrF4T4FJgEN9NwGhIcS39P0N2Af9aTTd?=
 =?us-ascii?Q?66KuyUxBA6X/0M7L3grIPpoe+VhbTmOc2I4E+dkICW79qLg9HZfHpxfQ+Sqg?=
 =?us-ascii?Q?NSIPt+OOdMyuyQ7zjKE5M7Gy7ak1tG4NbaHX3QZth2vz1SdwCdRvNd251mhd?=
 =?us-ascii?Q?MYmEuFM/KuTSJ50QyDX8NcqJ/Oq8bKulxT0rb/0JUeTsm3CvDcgTsj+wWncq?=
 =?us-ascii?Q?j4QWIfmhio4jWHcEcFj+27eU7nUM7aTST6Y8pY/NEMtIyK20CRcivag7HFTN?=
 =?us-ascii?Q?jxsIqpB6jqj9rXr0z5ne+zPjI4m7KJ08VljU+5284nRcQ6jNB0LjYlHb+7cE?=
 =?us-ascii?Q?llLq/DK1FoVo/W49F5EYvG0HLhxg1Ew5rrA9kz6rfvMzDADab3l/PKg3+xEV?=
 =?us-ascii?Q?BOlmSMRlRI3P4sSdbtIGnu70ooGnrYKFGvnKtQNx3qLkd8OaL0Xi3ayTgZ0A?=
 =?us-ascii?Q?vnk8w+OnKJW/XNjFYYAZGt4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2f1d2b-bf6a-4366-687f-08d9dfd21171
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 07:12:37.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttWp0kSiOswkO9sm2XWj4sy8l79aExEJOgSrTSpFJN2G0SOvy0HZQCgMMQAKWPWhpAPIz6xDwt3A/VvSQslzuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6157
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

