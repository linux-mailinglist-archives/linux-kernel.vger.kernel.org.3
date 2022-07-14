Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA7574631
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiGNHxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiGNHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:52:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2079.outbound.protection.outlook.com [40.92.52.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603B03A4AE;
        Thu, 14 Jul 2022 00:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn/LS8riMiGj6Nu6hFNLFaRSBilpPnGcWxyqfwH23VYHbnRfGTMPkbMvxK6BxI3TYRYkfdT0UH0q0Zw/P0eN9xUCRDdlj9/knKbB6/YpxRPIswkI5CKrMc72DxuWI4nry9R39+MfnPmgXtfAEtQZ7z+MUo7swvWGB3h/cc6Upma8O+N8mRh+tI2XwOohzHB7hOOUlGU1B23wOkr/vpE7LYQge0tuYpD3AA7oPd5vwFCZY9r++jqLdxFuinaOEwh405GNgtJFlVp2Z+XXCzBZGtKisWiA9ZB81x5yL7nqsddmz3mHYUtMMHl5n7HxgU9XaJHVspz4Id+ta0hRzhvqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKGVnaECDg3fwwyrByOh7tHLFkxQ33/hTjmKebsj8XI=;
 b=X9oV7pooAC9H2y2CiGECDhe8tZEyS1844lohHw35Of6iEjyYOKmkkA2ItakNHf8Xwc/BMwYCjvk3HXFFBEywUc+ADclyT5qXY7az8PBqkB/kjg5nn/UDdWgMrWp4wO+eRFr8xe+V3wizxzF9a5VYtleVlLogNDO1qRNieI1RZ10ryqk4ftl2jTQ+xYZCHQ3hiRBzXt4u/ezjmBnnfOSyUCVhhW+tmvfL3MIb1/AOuUJ14ORMc0EJpfO+oDxC6Z8gu86ADndKp703TV4CWut9xMSXaIUyKFORBlqHH9JF1jma3Lt5x8C2McmplI4jq2WgCuwrHLdiM/AU4aACbukiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKGVnaECDg3fwwyrByOh7tHLFkxQ33/hTjmKebsj8XI=;
 b=uHDNjyU4hDvShmGhnVWCqm7+E+hOk4mRyzgzDmm4vqG8XHbILV8nNsfXEO6DtX5rsVAh25ZO6pu3xdQ21ITRE2KXU3uxuXB6Ko7qn4X0f5TOOdZWlAoHryd9AzHNjbOMVTChPV7RsZ4hjYIj2BB5rDp5emcvFbOmYrmFuD133NdQ2qJ0sc16URB/vYJSI+aOE38oB+Z8mm74dayETVjoUTtbYsOB137eJJo1NR1h65Uxy9iIfaT3H9hvH2GJCvi3AMzJKtcjbjQE6VdfSKoPt71f90Nk1vvMrI63qV87nqVyy6FvgErLT2wrsIUrLh8woh5Wml8Y/0wh7ATWi1sAUg==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 HK0PR03MB4868.apcprd03.prod.outlook.com (2603:1096:203:bb::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.11; Thu, 14 Jul 2022 07:50:43 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 07:50:43 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Thu, 14 Jul 2022 15:49:58 +0800
Message-ID: <SG2PR03MB5006A1A4A5F9942C1EA9FA22CC889@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714074958.86721-1-jinghung.chen3@hotmail.com>
References: <20220714074958.86721-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [SLbWlPA5M6bPn3xxAe+yIhgoxMfs/i3U]
X-ClientProxiedBy: TYCPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:405::27)
 To SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220714154940.v4.3.If020c3a251a99ca3a780f7f2e6caf2049a6febae@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea22ee5-f288-4882-c559-08da656d8dad
X-MS-TrafficTypeDiagnostic: HK0PR03MB4868:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLN91SXgPa0TsLJAZSdl9XEkgwxxxDeY3jVtVjAVyhGEkVnncJ8bG+Bo7LhpOQmgPx5BGupZHhU/wCTWGeB7rcZfUoIPfGFpLr0VUNouTSBrOfuPTXzrPStONScCdZIzZR88FkUkt/eyPOjk0KUOxnYVJbG0FNdfhJLua1WWGzaBLtvfjdtjPjVqE9ts1T66OdNco7sOvopi/WxINeQnpxlw21P6R6AZHdrBqwzQ78la7ZIVlTrubY4di+eEKZkXkJTJK6gfNSus1cuoHQSYoLFcJDrvoDULx7G5R9tTK33Wu7sQ3hzYc7atYPrPC0MBFEF4/ZSc3epj8b7pVXwWveZls1gi7SB13qtflP6BdopECrje8fDXvdvMwY0HR1PZs2dNKDRwFL84fnnLwP7D7BunVN5WDCHYblEl4APE1g6zz5B63cunYJnFqb+8UhUWZIGDoWQ1HnrS1nLsRp7AiNDCr/9i2r39Bti9W6Y7RCXkYpFdFf8s56B6g3y7jw7DAqPrxqa1CnW6A2IwYp8XVZ6amzMv9LVPrtwxQp6NvuvpEl/Q8VpcOs/NP4OQNjRYuwwAtympbEVp1Qef5j8ohHNDjimB6J0JMhij3Cyfdzo73tT4TK+R18XiSmm37D8gD00i6RIdLz3tAGbTW3g3QMm31X6DuaGb1sMRpwSxkJKyvCcz2y1CmGuFQxznS6Dj/Qczx2V3fLMoIQKN0CwFSQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SUnu2BmK3sRhomDqiL/GPJ5Ri+5JkZ25V/8eQKpd2LRGUnze4Qz15/nXJHEL?=
 =?us-ascii?Q?cHXJiZTx/GfZ5vB0+LQMB9hr8XPdVTj/7/J+NYh4rRtYad1x0/e9jn39huQB?=
 =?us-ascii?Q?ylPmcIf46OmQ9qucQ6CV8iqNT9WtE/PM0ilP1vNViY0fHja9CXBK1r/Cy5Tc?=
 =?us-ascii?Q?bJGcHwb4Ih+ZSjGjlb3wYK5TO08x0yHxZU7kA8CQyy6GA7sseYBZJOywfxfy?=
 =?us-ascii?Q?Th5pfIGFEfOjCIFZww3OcxJVwlF9SIQjF/xXP33+0p4WXdwEkV/v/SJg4Hdp?=
 =?us-ascii?Q?uHbWaSvSt+tHtKYK1DCrLCRizx42mBeecYiHI/Qdi2ZgsK/dH3DyovsvqwEr?=
 =?us-ascii?Q?6GlVLaK9Ru9JxbBjuqkZbcEm8AYBA+96Ncei0hHk5C4dOA8plQR7JfKY8uFX?=
 =?us-ascii?Q?+eqtaoqIed+Kyj1gK3f/Sei/0lxR4rY0/V21CUORSnIqHtQCZQhPfqzlUbT3?=
 =?us-ascii?Q?FmRBlZ+x+4mSHeiS9ee4r7gC+PxWZh9UZQEbyIH5A8EDLp73Wk4NCwQG1hXc?=
 =?us-ascii?Q?TeRFqZlKETv1aZCqMSDYSCb3+ubCJvyZj5OJ0BvzTXHHsWf/lRZT+AYXko07?=
 =?us-ascii?Q?nG8DpHZUUuOzQseY0BN6DJ/hRwMOTb5StWjRFf1JRM1bCyiX3QEUythq8QWx?=
 =?us-ascii?Q?KjFT/mQULzti62EM3JQTelBWX4hZfjLIL+hora3MpbGWYbR3gTs5dPkq2YRK?=
 =?us-ascii?Q?wpK4+RwDRUvJs6RdeMEmiL5JsLQZxlt3/fQeGKQh/k4Ehee/YXDgil8yCi0f?=
 =?us-ascii?Q?ohiarbhI52CGgLsrCmwbf45xLBZyMqD66gx149u65ye/156cU3k1c+aAyxAM?=
 =?us-ascii?Q?MoUp7J8dYAlBhIK7nTwXNYBo1HVezmgNlKd5Gi+YGMD6Q0EH18PjO2i+puEK?=
 =?us-ascii?Q?Y26TBPpd4xrxiKn9yap9MgyKbklmFsVg2Ekpci0C2fMZX92VvoYud4UXwQQB?=
 =?us-ascii?Q?k7q/oOhnaI7zuBI9G1mVZoSy2xQbHRnP1FXGSq5ZbKAiyWvcvLlxTQt1aRJH?=
 =?us-ascii?Q?pa72goPO21krDqdjh21Z4ouN11Qvr2W+UzuCijzjU02J/BE02tKpJeeis85h?=
 =?us-ascii?Q?rr4B1fBAnQMvY229gR34bNQ/hoDly/EOoDQR1V9Mx6paFFOXqu3J6xect6hA?=
 =?us-ascii?Q?DAVnvdABJLz+w/jRvUrx7dTC+Z7nrClh4hVCoowYpE4dyLpVyuzc6HmpccTE?=
 =?us-ascii?Q?6LfNUz6WQqbefnoyoPz0qskeIgsW3eKoMCA06vrV+KVusLsMi9wUYcCSl8Th?=
 =?us-ascii?Q?CqOUButVfW4S/OPfgycwWJASNsoZkjtvf0K2qt81u7i+ptqUhukqYNb+N3RC?=
 =?us-ascii?Q?9r8=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea22ee5-f288-4882-c559-08da656d8dad
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 07:50:43.1193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4868
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

---

Changes in v4:
 - Reorder 'status' last

 arch/arm64/boot/dts/qcom/Makefile                |  3 +++
 .../boot/dts/qcom/sc7280-chrome-common.dtsi      | 11 -----------
 .../arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  1 +
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts   |  1 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi  | 16 ++++++++++++++++
 .../qcom/sc7280-herobrine-villager-r0-lte.dts    | 14 ++++++++++++++
 .../qcom/sc7280-herobrine-villager-r1-lte.dts    | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts          |  1 +
 8 files changed, 50 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index bb9f4eb3e65a0..7fe7c78a79369 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -103,6 +103,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+dtb-$(CONFIG_ARCH_QCOM) 	+= sc7280-herobrine-villager-r1.dtb
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
index 0000000000000..5af06a08e1a72
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -0,0 +1,16 @@
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

