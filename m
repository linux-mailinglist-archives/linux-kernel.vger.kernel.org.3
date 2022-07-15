Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92236575DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiGOIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGOIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:45:14 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2021.outbound.protection.outlook.com [40.92.107.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801E0814AC;
        Fri, 15 Jul 2022 01:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBBxvKdVUNtK24iiBS2bp7Op3Hl3wSE+ExXVtCY6zkXWuwK9AFWOUsqJcSRssINvwJmISflEYWbIgrf7Gu1JDdRP7NSHos6eOlLaVomQBqwu7IvGJBPMozzBS0VpHlyoy6O2ZnIzmee6BAYAK1SbqWikwzZPd2YHtrpYoTOgvzDuy15VzGvLpPAlUEx9NyQ1r7zQ4air2BnBe1URRNpo1nB48hdGWjCy0xoG2wFRV7GFMG8F6YqX+EK9IY4oyhd3iRrUjVKx6yRW6hoklsrShrzB60ENxuU9ln+dQGy4VPSMONlc+QQkNO4QKkJ9PEjuy9oPiw9JYa0okoGOELMY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeFhfbqzccyl90iV9b4ptUOQUVwmT1RJBsfVaoiOwXk=;
 b=CNew3+Rb+n2hOiPE+1HFVhSX0n//IMXxex2PTa99CeL/m2G8SWU/hYsOEzf3H242ymxG9lyrJbxWBWud6BRBIjPsKSvEGVi/dvy1v+a9GPGuZDuTXh/GjobrHYjRdp0mfNphyhHhkYKMYL7LhGlbqZkbZOsj0jkFTnvudV4umAv5YXuW/PcZeFLZvq1njsO7RqPnHrQGbJN4lYaj9iTK4cNQ2Z0PKZoGtPNTgIhjIm3aNcjIpTCzFHA+i0qJxcGLP+pPFpQaLomq7lm6evBLKxKQ3xnPrJSDAbywWW2tTng2oFHEXmDftg08h5pZv5Pg//yzc4SHgNAjXVFFoxxt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeFhfbqzccyl90iV9b4ptUOQUVwmT1RJBsfVaoiOwXk=;
 b=dQmnznKRJtHstKXEn/mjpbUIU6TgkQg4iM8p7W2g0q1xjps5q2A7k8jU9Ym9UsQlh+w0u/b6k9q40vbbhsBXTLBjQ8NMN/rC+ILoc/qUl8cLi/SBFIsxQ89waeiWjp8mgX1zR1tHqmdJluzQlAlwMz/BmPLvXNieBCYEYBzIm4/Go/mhzv2JdRAAWmVy0Syy/MOstat+frjw/SSFYcFATiWF0plpLsr0YP273DnhfWy/O/wvdHuMN0N4wj5BOFiePjPKUW6wDAmygngsrcQDdosJqN+Wn87jwFjuaTxO5pvRyvmnXP0Za7+BDKb9EapRAPP/HrxLWSTwUuCAkwZa4A==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 TY2PR03MB3421.apcprd03.prod.outlook.com (2603:1096:404:31::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.10; Fri, 15 Jul 2022 08:45:08 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5458.007; Fri, 15 Jul 2022
 08:45:08 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Fri, 15 Jul 2022 16:44:42 +0800
Message-ID: <SG2PR03MB5006FEBF794767B52DD80152CC8B9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715084442.115021-1-jinghung.chen3@hotmail.com>
References: <20220715084442.115021-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [dfkIv1tHzOxXOu039ra4mi5JxXPrjoCr]
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220715164428.v5.3.Ia7271d1b08f68e7a202dd04b946dfe0c229d199a@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d8a5ae2-20a6-4f25-d602-08da663e5269
X-MS-TrafficTypeDiagnostic: TY2PR03MB3421:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLUhb7j15zCPjV9qYs3hGBtJugPay2TiHxfRhLReYBM4fHxUOWaotYySgVTorMxwPbc7li2w8xvp7MqlIgcLVT/eCZTTkTERgBln5zTg78APjxxMcn/Ogh07588y2PkbKQ8m8sJvcTTNfgZr1L1lmdVUaOs5yDzFDkb7WRcxlYdwByALocqMkwpp+YxGsFTXz/ekXIr3pyLNHZm5YodqgZ0nH4E4e/o5sGjq/7vu/ciOStXQKTYipk2SPJZgWwc4unCnC9zeaD10yafSn1J3OLNYbR95/aHqImoZOp+nHeJvs+AsYfSVUJpcwx3hXXhuFnk0doFtXORcuajIPsGXnFLgEUo6Pky+bLTV5jg6q8H3d/y9sE83KdwzqGuPYP4BUM5EvAUt8QrSeHmRYV67xK4UIaXjKgEE3CLpSx78jJo/mklyZNH9GBIXVthTGjwPoHhwdM3rQFty6xGdfMv8Wg5Eo0iXAuQVkaTtbf4KeHr/NaPOWssK3Rex34XGoefTWZvLnowvAA7chDxjnsg8VgZAF0jtlFi9/8UOuuMywZmsl/79hxtstBturs5jSFzI6G4r0+ZVbv2lAf5kBba1FpgNtBax0rKuVyV7Au6gyRhqHpYPuE0V2dOzeqqG7gP4YdFJIWTewKra9BMLDK1cfa7/JyJyvNW1uIy4+WGS2omtTaOiaGqqDd5dxmUogL1cruC1M2NGn6jPycCikAbHTA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ME4bOfZ3xM3B9b8bwQl6wi48mKjHXLRvy7iqhKHiRRPBITju/xWgVrYVVEN?=
 =?us-ascii?Q?3Sn3YSjcfqTI7nGsL4IFJKE1vtsfb9KdNkeVtQzTxxPG2LQOKlU+by/0WtvO?=
 =?us-ascii?Q?KBCq8b/Ng68Rzk3xRPl/wEvZRYrAMIwD1dQG3FhjchIR1LfC5gTv2vzoLgCj?=
 =?us-ascii?Q?knqErv9B8HlmuakNq02mLSSSuNnfA7FhASX93GI65p9HLP7BEcbaGY53bRMY?=
 =?us-ascii?Q?sfjqfJqNbD6UEY0AE797gYGOX2wXwTsbC9/dBhc3dtMLPWVXoQQkQokE+3uV?=
 =?us-ascii?Q?Qhq2v3zp54bSLw0AVHBLqXigqj+zrGOuy/U/qN8QIIY0v5Tp0rK4VG7WYuoT?=
 =?us-ascii?Q?eihypgqV5rLi5yNHKAG/paW6/luFMpnlM9TfhWAwTwe8pRSqsdt7ff7gwTE8?=
 =?us-ascii?Q?VnPLoINcm62442jko/4mBDgfbmGEfEp+Tw4x4twmo5xwDnfw7Gg3kOTiC7N/?=
 =?us-ascii?Q?13GxZmi4czwYCIbMjoqH2g2KgiI05Z4dQww1Kx5pwT551uDwxgb8uYz0RHZV?=
 =?us-ascii?Q?1DyxI53b5MjxMd2LTmYDh43zJTExmN8hyPsRuquXORhHgvxP3l05GjDjmAF9?=
 =?us-ascii?Q?e1bVKFytn0/g1ns198hKlmzXcUilGCkHPC85YtxFnVy9MuhoiiZtE+/ewG5V?=
 =?us-ascii?Q?wMzaE078yaD+G8ZKYi4y6968B339sB6phVft5v1taTKFVrlUBM2eXqpdEJE9?=
 =?us-ascii?Q?oBXb/x3LAorJZW1s5i+R0lLdwbwPzlCCLJ7W6982pIFRGbKjDFqlefttBBIC?=
 =?us-ascii?Q?eDm7ve8p0JdXC2ArRY6qGKUHr+D1e20ttT5EmiwWTR2ZsDB16UG87/2yGSog?=
 =?us-ascii?Q?ac+jFQzvhn/R4BKRtn7RywGXzwbk5ZyiUnPVblpAXbNw2n7YGUae9tQwNOc0?=
 =?us-ascii?Q?KB9A8/g+MRbTnqWjcgv7dAYh4BY5LQmbJ6hGzLRrZbOlj8w5GZDR0CU4XDTe?=
 =?us-ascii?Q?x356EX/+U1KnL8Bj8y/NAbHcddgmRVP3QWyLTnPrmAU+RtuHjY2IzpELF7HO?=
 =?us-ascii?Q?wIbBDaLam3wFKrBj18oy/Qf7pjZfdDynw0NQhWyQBY1AZyBYMyqzDqEsPXeZ?=
 =?us-ascii?Q?CC1FbA+LXlKh0XWNQVlaK91iFUmTRwP58xov9TkSQ6IFvPMRZrN56uX3S1Nh?=
 =?us-ascii?Q?s0miYi+4Ihrha7C4CetPbs0IQWSD9KWiJxNDq/5iKJpEn/6S5YSTrSqFT45z?=
 =?us-ascii?Q?OzXbPjjMudbgR3flsuCjvY9hs3KfqA35UimHJf/6Tfg/GQzalnJ76MIWtBZ2?=
 =?us-ascii?Q?n97Vd8u7XugwKZLvhZt1f0LylZQxFT/E8aWax/P3fAzXmiKm97tcng/+V/+h?=
 =?us-ascii?Q?Zs4=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8a5ae2-20a6-4f25-d602-08da663e5269
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:45:08.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3421
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds LTE skus for villager device tree files.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
---

Changes in v5:
- Reorder '.dtb' in Makefile
- Put the "interconnects" line back

Changes in v4:
- Reorder 'status' last

 arch/arm64/boot/dts/qcom/Makefile               |  2 ++
 .../boot/dts/qcom/sc7280-chrome-common.dtsi     | 11 -----------
 .../boot/dts/qcom/sc7280-herobrine-crd.dts      |  1 +
 .../qcom/sc7280-herobrine-herobrine-r1-lte.dts  | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 17 +++++++++++++++++
 .../qcom/sc7280-herobrine-villager-r0-lte.dts   | 14 ++++++++++++++
 .../qcom/sc7280-herobrine-villager-r1-lte.dts   | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts         |  1 +
 9 files changed, 64 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 7e6a4d7ef3266..bd43d984f69fc 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -103,7 +103,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0-lte.dtb
 dtb-$(CONFIG_ARCG_QCOM)	+= sc7280-herobrine-villager-r1.dtb
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
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts
new file mode 100644
index 0000000000000..e37773fd63b3b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1-lte.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Herobrine board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r0.dts"
+#include "sc7280-herobrine-lte-sku.dtsi"
+
+/{
+	model = "Google Herobrine (rev1+) with LTE";
+	compatible = "google,herobrine-sku0", "qcom,sc7280";
+};
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
index 0000000000000..a92eeccd2b2a9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Herobrine dts fragment for LTE SKUs
+ *
+ * Copyright 2022 Google LLC.
+ */
+/* Modem setup is different on Chrome setups than typical Qualcomm setup */
+
+&remoteproc_mpss {
+	compatible = "qcom,sc7280-mss-pil";
+	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
+	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
+	memory-region = <&mba_mem>, <&mpss_mem>;
+	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
+			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
+	status = "okay";
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

