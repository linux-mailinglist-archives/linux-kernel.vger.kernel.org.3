Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC4566197
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiGEC6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbiGEC6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:58:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2081.outbound.protection.outlook.com [40.92.52.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBE22184;
        Mon,  4 Jul 2022 19:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqPriHVjh7usbxqW+IYFFYiRzeXVfzoBag2Cu5f8UiEiCqCeGO8N6WcR/6lOeA99B/aF8jAGIHDrH8sVOiINsBepqrGoKj+oNkK2ruhxYB3B3b5LyTzSnkFjcbte6jla+KnhJ95dRND7gbx+nY3/9luRwieQjD37CtKh/3syaJVKuPQ3rozpYiuBCTrh0QyY+AU9bsDv/j1MnUWK6Kfdj8Cipkz/w9pnIwxNafIwyyRenQvxKl9yUXjk8LbEW6jz5IoOvyFtR76OCmCxLWFh2HIZi5+k5EN+3C4h3oxGbcL/SbS4r38nSsAcGi6d8gEXOc+CeJWLk8m9Px2DE8A5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEnQpGE0QULHpLbMVheYdzcd+QGBfHdf5VmeZssmbzQ=;
 b=gFH9Uf5nWwc6c/DoLTMYVIm78JfwtK76GNWoP6H455NgPItA+A/fL7l+PcT41ybtZn/aiaraF4AVCyd9wMXtS3HkC72cpYV2+dm2sfk4JgILm6W1EWgDxtO+NjUR2N1O+KRmk3lAuKCkaFcqAi4na7vSxE+CGk01hrWm8Bs4h5nfG+RVumnp3uKHtQ19eZHASskaR5+bazsITzeLau0Sx1JH88X8rmfAm88W88VwbtAbWvUhvqcnuX0wdrzz7U9QQcRTU06YlaG1jxOsyXsyTHmS/wuQfm8ZAwlfr315uPbkOl1NE5mkXk0RK/IDS0QZbaJ6KOnTPQaeaPLWZQbQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEnQpGE0QULHpLbMVheYdzcd+QGBfHdf5VmeZssmbzQ=;
 b=fREcukhu9hGzyG9wCF+jS0OBWTnOScNZ5xJabQygeUBFgy+OPeiSsEGsLDJS0TTAyV1TFaFnp5FhA7u1Ntaz4JhmhoRbZS9xjKcEl7mVLJjgoMTMOo3BgM/uxiEv3vCDxy2yBtx5HIe/UhaNz6cksIeH/xOPRSQ/d7Kw4PULfXSsIIGaXRaXbynLYYmyreWnUDhsT7KiZAuVVgePb9Im65JXOq51zVY2zYFWcNqg5XfW0fZhsXvY6cS6/Bup4u2YfsAL6v2pSkkWvF2xzFxENWbqbLyatWcxR5uK8IhMGbZo+ioexdBl8n02w2uL1Se272yOgJ1cmaA4n10kvh+lUw==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 SI2PR03MB6461.apcprd03.prod.outlook.com (2603:1096:4:1a1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.14; Tue, 5 Jul 2022 02:58:11 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5417.012; Tue, 5 Jul 2022
 02:58:11 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] [v3 2/2] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Tue,  5 Jul 2022 10:57:48 +0800
Message-ID: <SG2PR03MB50064D458B27E0C9641CEDCECC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705105730.1.Ie6e9ee9bf889abfdd1a44d9f7a61b62c0c5c97c3@changeid>
References: <20220705105730.1.Ie6e9ee9bf889abfdd1a44d9f7a61b62c0c5c97c3@changeid>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GTRm6wToV0xo9YyS2swV9AgVWiN+Ls+l]
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220705105730.2.I31e05d3184dbcf0578b32593fe5d150b80a46624@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cd8003b-d04a-4148-c719-08da5e323211
X-MS-TrafficTypeDiagnostic: SI2PR03MB6461:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 264WqbMe8wm3mkpiUpwL/EkepRz0k1o4o0TJmErz2xvMn2ZhTjOLpV6Tr32/qrlVW+8/pf4flu6dWLCpnIfrr2XYx1CokfiKV+2C/poA+lv9knVlmsSYUWXbZXncJWlVuWheW+EDYdEMK1c9NgaPkobF3cs4zIenNKMyf6yjaGENRfZi5bWuzl7VnC5i4io1CHVgMKk7Y5c2lYnQ6IgKmRMdHRmxjDTmWzoQYZp1vGKY/Ly0Wz73zXlP4SSsIvEAxjgHTwBbdocU/IcdBvNi7awe6X9AJvk81VatQ0+aiWoLDoEvB5VRAmJOBUL5bEe4mKgeI2T2LKGfMnRIjEDsSFN084S4g6j5Z3douGi+RiHAECJjtIEmAT5HGUldY9NJSMnymQvwgLRQjkn51iVcCqBTTxfUOc/eKW1CDE1klPVdNjqRGfNCXZym680rsp91ulk1zSjUe6dIXa1RpFvxbiPe5/Y5kWfiWFlniBryrh4TeO6ypd/l8OuwRAoZX2tvuSp7qU4M5pOSeuEgQpUsm4JOg9+YfvQV0Iq83nn/WHPv/tC71z7SsXmBRhc5P0R5y1Qz2Xe8ZWqW93PMaCsR6izy5ps89H69L+jMWoZx8IPGeH3cEiAWW1Y1rugkRUOvLPWsB1+RQ+KgwLIrHtDPiw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?65cUKOLweO7JOhXUsGV2uR8pnuCcgPL+9/LHoLLBUfXC88eF9/2aYO1EWNnI?=
 =?us-ascii?Q?NRqMRGqH36uziYoo1pibkVkQQHiCNcsb6G9e2iyx+UGEkS4YjPBLBJVZphTt?=
 =?us-ascii?Q?g1s/3jDonH6LJI+7FDHH0FzdIU2igqB1CnCF2J8lDFv7koxmUzG94DIPv+Fo?=
 =?us-ascii?Q?msnF1dLCuYdWTR9mPOl/vJyzYSoGtSnABecv9PbzP/tlaFKzUGByPQMZpwZO?=
 =?us-ascii?Q?9DNM89fbkXCDQRHqBOp2PVT9oTPAJaWQBckp8kGwQplME3UtqsUinBS8KMxT?=
 =?us-ascii?Q?EyIXK5QrfHzPWdqvMzAOJYv7pCno7PWhtoyIc0p9agvOIch6q5IMHqWOoiTn?=
 =?us-ascii?Q?dYUm5HG+XnFKwilN/rbcq9cfsB3to/vYlUsg2qUDsh8O1b3pHjFJhoDFx8f1?=
 =?us-ascii?Q?fTSWaWKrKFjkn5eku0tPEAab1QwGDLB0FJo1HCdTD78QptzVMldgN81bL7+t?=
 =?us-ascii?Q?9SaP1S52sEkQfJV3O0RCxQmW9Uu+g37k2C4Sq+Yl8MMI32wyrrkd0w6fXCmO?=
 =?us-ascii?Q?otn5SOJbYjty97tx5lxqfuz2nV4vrAJTXXPqCdBBINWEctRKs4KXLshimvBs?=
 =?us-ascii?Q?5o+zMzVsEOgJTnLkAoNgeN1q6ZrKDhuCZxBkLJE+2UZ1mc/nRN82ZsiPeCj3?=
 =?us-ascii?Q?uCOG9uIgsHOWAQn6B+qkDjuVN45FHDZ1Xbntfqh8xtp8CB0HV72XkEyxZIlh?=
 =?us-ascii?Q?5Ae/suDM9OxWgwFTqbdjmGdD70Gx5OCdlFcuo5CVNw9pqZwQ0KIJcX16VjWB?=
 =?us-ascii?Q?PNCJ+LMKws2TY/USGJnahEvCCTKJ7o7mEFYqv2F0jgpT8FiuVr3h9UJAtMK8?=
 =?us-ascii?Q?4A5U6/zV/VtnuMQg5CsjpqcF4ojeql6Z070TniYDwcyT7d//7qK+5KC4HvJe?=
 =?us-ascii?Q?QL+XrfVllebgVkUlC3B687uTKb313jYwAuGZx4dxd+UgSl/arB0FRG9lmaIk?=
 =?us-ascii?Q?VA8G+iGRWCcndNL1ELiuI2WBLxcJuE7HMGqMm7q3QbDw8UqD9/PT5oGDATsm?=
 =?us-ascii?Q?tqqvrYsioNf7/zs3FudbzATEG7uYPK4rATfM4Sr4Ym3mNWJaEjBYrNooujeP?=
 =?us-ascii?Q?87ixH5dHMXFgvSCK2Oz3kEP2xdXDAa4fnNqQU078TPB0ijDYr3he0sR8Xof1?=
 =?us-ascii?Q?l1rBnTbgR/EM/QGhItj6/pCCnHjdmaBj4OYjgEvk+EevoUJReY+C7DimDnfa?=
 =?us-ascii?Q?yrn8lYaf5YtpWVRoZqf+2BJ3sCkNEIPPLI+6LxmgPzMACD4I3CeukbyT4VdU?=
 =?us-ascii?Q?JZiuLjUfKNMSHiv2sdcOdj7g1In+UjH1y27gBgQhuFJvfNTE+8fS6xZWcX+U?=
 =?us-ascii?Q?nAg=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd8003b-d04a-4148-c719-08da5e323211
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 02:58:11.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds LTE skus for villager device tree files.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
--
Changes in v3:
-no change
Changes in v2:
-no change
---

 arch/arm64/boot/dts/qcom/Makefile                 |  2 ++
 .../arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 11 -----------
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  1 +
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts    |  1 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi   | 15 +++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r0-lte.dts | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r1-lte.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts           |  1 +
 8 files changed, 48 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index bb9f4eb3e65a0..6d81ff12f5af2 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -103,6 +103,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index cfe2741456a1a..25f31c81b2b74 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -83,17 +83,6 @@ spi_flash: flash@0 {
 	};
 };
 
-/* Modem setup is different on Chrome setups than typical Qualcomm setup */
-&remoteproc_mpss {
-	status = "okay";
-	compatible = "qcom,sc7280-mss-pil";
-	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
-	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
-	memory-region = <&mba_mem>, <&mpss_mem>;
-	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
-			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
-};
-
 &remoteproc_wpss {
 	status = "okay";
 	firmware-name = "ath11k/WCN6750/hw1.0/wpss.mdt";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index e9ca6c5d24a16..921eccfec39ae 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -9,6 +9,7 @@
 
 #include "sc7280-herobrine.dtsi"
 #include "sc7280-herobrine-audio-wcd9385.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index c1647a85a371a..c1a6719687252 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-herobrine.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Google Herobrine (rev1+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
new file mode 100644
index 0000000000000..a4809dd2f4e8a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Herobrine dts fragment for LTE SKUs
+ *
+ * Copyright 2022 Google LLC.
+ */
+/* Modem setup is different on Chrome setups than typical Qualcomm setup */
+&remoteproc_mpss {
+	status = "okay";
+	compatible = "qcom,sc7280-mss-pil";
+	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
+	memory-region = <&mba_mem>, <&mpss_mem>;
+	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
+			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
new file mode 100644
index 0000000000000..672cb78e3088f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r0.dts"
+#include "sc7280-herobrine-lte-sku.dtsi"
+
+/ {
+	model = "Google Villager (rev0) with LTE";
+	compatible = "google,villager-rev0-sku0", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
new file mode 100644
index 0000000000000..2f05a19cc388e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r1.dts"
+#include "sc7280-herobrine-lte-sku.dtsi"
+
+/ {
+	model = "Google Villager (rev1+) with LTE";
+	compatible = "google,villager-sku0", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 6d3ff80582ae9..fba7e938ce35a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include "sc7280-idp.dtsi"
 #include "pmr735a.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
-- 
2.25.1

