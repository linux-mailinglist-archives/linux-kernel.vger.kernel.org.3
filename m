Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38566577C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiGRHb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiGRHby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:31:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2050.outbound.protection.outlook.com [40.92.52.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861A117E1D;
        Mon, 18 Jul 2022 00:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keJdCtyg5zwU8Vam0MIe5idL6zWNOkeKiBPCQdmq3umrdHxFe4yR2fUXzQ78QWC7cwJMrQ7KSHH2uoOFrRmg2VjZyFy0h2sfLsJuGvjJok8kqx/LqzV813dTiLRp8l2f1BjdujkboRxYdGGSx0I272Z+8Ixq6kT6YZM8JikEOKGQ7UKyXIj8tsrV47E5/lcORFOBrcnYcKlTkvhFDtqOdHYJ4Mk/FOmuWxh3cM0X3pSdChpFOGh/t9TbJkm5TMYT0tm3qwpkOcM5TXPYRMe1A9KnE0kqLRLLjKdomoZ88d4wteeOGXxWQ0V1ahTniJDJ3JP9uj3HWQVefpgU3iH72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN++duaKsUA2SV4ZcLaYBxs0v8x1JgG9nwOqbV84rpE=;
 b=bFLmplIvkoOSjBj43rSbk/M6GPIQ/JeSzH8wC3Cfz8S/wpTfrHFYztXtcdq5CeNZxV27Ny+b13hCDvrxi+y1Akt96JybZdUZCaxUop+kGe4BthNur+L+F3HW+kr9RjAIY711eIy/sBY6bB+wOy+R5sekGfMOS/2yWNdOJjA9cHoiyptkX9U8O60EqsW/+u87G13ha/llj3NZoqweA/z6gCRC3ypA725cm3LVLalt7fe+WG2VYxzZmCxuwbFGPB2MaO/lJFRzy2U2xdpLp/IW0om8gxT/oE2VL4C4MDKxduuDdPQRdEAf6haSpKqGE5ghHrlvdKoqW1zJUkK9syeKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN++duaKsUA2SV4ZcLaYBxs0v8x1JgG9nwOqbV84rpE=;
 b=Sa5b83EzXA6HLFIthfDlgkb9zyiQowklmeIaAIxFGRIs9+Mnbc/zDUjAD/9a9y6jzx7jpBILiPc01iaMQqhB4QEzLGV8u3j4+igRLTNDrKT2ms8BOn1Vm/P9Pb0XuWbJrTyw8KL3GPkarVMDY7a2G2OiqpUX0Ot9zAQQ/CDzSj9EbRUEk3ZPr4V7CRxmdOBl9nl77BDCgjxXF8/oRTzybFesbYTDY6y3n4K6K49SoxgVvI8BUg4HopwTlu6tADGFAvPPL35J1MLAa8cIPnytGOIUMIHI1MkUXHUR/mrya7VSEH4FWxloyhEPBZgfOzD2HwEdZomO39CMH9BAT60HnQ==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 KL1PR03MB5764.apcprd03.prod.outlook.com (2603:1096:820:64::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.7; Mon, 18 Jul 2022 07:31:47 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5458.015; Mon, 18 Jul 2022
 07:31:46 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Mon, 18 Jul 2022 15:31:04 +0800
Message-ID: <SG2PR03MB5006A2ADC6ED22199D8C88D9CC8C9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718073104.146985-1-jinghung.chen3@hotmail.com>
References: <20220718073104.146985-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [o51KJ8TWEqW+e7oSCmbd1pJ6w6FnXvhf]
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220718153048.v6.3.I3d59af7dba48a8448f50ab5fc014ff98cf73c58f@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e0693d-844b-4b8d-6b74-08da688f9202
X-MS-TrafficTypeDiagnostic: KL1PR03MB5764:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfowlElNJwrFQsDs6dRkcBpMH8ml23NYWrXswL6FAEKnB2xLy20QGcTt1W8aUmVsf6+gJcN7nIzO2UQlGOdGizknqhv6WCd8KthBYYxRO+0LmRfTha+9MDeTHc6ZfWeqLpPdNtms0makODpvWq7SFD3MBLj7L0F++Yxon+FVl4Ogx2f/1ZsSZJOerXVQ9AI68fPX/kH+c8TTSs8skERb/mh5Ijkw/LNvBQ7p4Yx0BSDPIGM1CDI75oU+5R6KIU0zppSHSHjguSyqhOUXHXDca/ga9/bvtBHtaIaaT9cG8nYOQF5NDWreCOyLXO3Rt4eI6lNU/7lEpyBZEG4sdnv5wt3GBNscmsIGwIuDjs+PiAc6W0YKzLt9z/BVb5O+x3RrugZh6KqaXOmCRfA45QavwCSQk+xZPNXPtq44g5oUqhjN3t4HtbNM1Xi5nis5p1xO2aixFLOkn0C158RGyHOdMN1wK8KkNYX5lM0XgjgfwT/rGFV6PF9zotGg49/f3zqdgkltcDPTvif8WcIWU1wgLmyimqoCfS6IS5Clvxd2BydyDt+bxpVkAuSBJ3atEg6HJbRLSuFt3/alOVcBOZ1dPsv2JTbL4Fkh1BX3uG2TQELmm1U64x5Jn673RYgQHPDTqDAZwnNtVdBLaj3XWE/dsA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cgac9CNpmxMDwhc0BB7CL3w0P9VV1HgXuLC/EQiBPHT+Jm0jYH0haCWVNXou?=
 =?us-ascii?Q?2thJGlJDF8yBRmoa4iuSbtGu8Uf/hxNrt3plxGMwodSFhAYxVLuC0nmyLLu3?=
 =?us-ascii?Q?S3Z/imZpRI88TDtmxhjndmLxsPFBR0tXP7NmaZCJ/AMVbbj3OcAGpqeYRExF?=
 =?us-ascii?Q?BNzyK9KewigQg+dpf0ptnsz89X2YNN0g+n3IbI9ZfYLW74NNJ6TeMqnhDxx4?=
 =?us-ascii?Q?GlE6FxBpoPGBhi+j9x0VJ8pPVE5JK+dFqsesGfwhJgJIles7Z5hGFJnTE/yy?=
 =?us-ascii?Q?a16nd7Ht93anZV47H5s4oYjFYF1RT1CUwW7VaWi3YDb99+eN2DnsQKRFrvzr?=
 =?us-ascii?Q?WU3I/+pSOK6rzhMnlXbAAmgrBbVWRaxNtFkloSw58u3g50zi9IkJOtAtEjai?=
 =?us-ascii?Q?y6Kg3IPi4vP5YnS5IKkin/Vgo8uztAjllbEQTv00Rh5rIHM+VopkiY4Kdd56?=
 =?us-ascii?Q?BfUebQh80VLeoCjfFZONq2JY+cJvOuOES/0fv6iNdjbkoFkLtsry9M+aMYbr?=
 =?us-ascii?Q?EuHYCITp8CPCQ7QyVOiUTEmdP7wmBDfwdROUsR+vBZ+JJQG/AXtPLjgK7Dm+?=
 =?us-ascii?Q?g3bW4TWu+4NOWJ8XCg9HCtOwx38QkgYMopnHydL3B88kICddz94XEryL/BlB?=
 =?us-ascii?Q?l94ZSTr6KwLG8qRvDJr1vsB48gMnRO4LFwNW/IH7q3kGBhEFiDSK0tFPGKsi?=
 =?us-ascii?Q?a/JXTLkHeVUOb2FNzOjm9PGzgCjyn4tFsVV93spybNkNZODDJAxcLM954ppw?=
 =?us-ascii?Q?sqt72XPRpviG5WbxFIZeadABwsuZvVUcVkbJF+tSNAHFPTkbY3JhLyk74PjI?=
 =?us-ascii?Q?Yg1OEiI2P44hAi3tadG993gHq6c/UKbz3WLv4UQn+dIQzlLFoNiX7EbDOypf?=
 =?us-ascii?Q?R5fkXWYIx/swglWvsPdE1xcw2SDl/iN5ltI2CuGFBkdmd1pmWzEHVBxDdXCi?=
 =?us-ascii?Q?sWckVyU79m2fKIpLmRH3wjDAh1YUlpJS3DY/03ZkEPH1waFrKoSVaImVqSVz?=
 =?us-ascii?Q?gW9D8JjUdNpaAQcJElfU48J8KHzfd+7PCjjEUYPLy5JiQ1NOwR6RE7wAig8o?=
 =?us-ascii?Q?wQcYX94q8hjSjzIKmLfReMSnz6woHMC8VcG4OU/jqNHh2onruPzvUaOnAWkA?=
 =?us-ascii?Q?mg1KNmEv6F0KkFxrTuVjP33BEHqeHwmoRc4ZEBy43Lb4x2kyqYWL4E7quSH6?=
 =?us-ascii?Q?NJG32j/aCTLs7JI+rtFv2wQn/reyP4Sl3bX955/5C4H6NVAKC0sp7vmS1MIx?=
 =?us-ascii?Q?nUDRzSVr+U8yxPbiRvFJdUJm4kYFsKpcIkqGU2D8qXfkG1TyJKx1oCfkOYaZ?=
 =?us-ascii?Q?QbY=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e0693d-844b-4b8d-6b74-08da688f9202
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 07:31:46.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5764
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

Changes in v6:
- Remove v5 accidentally added sc7280-herobrine-herobrine-r1-lte.dts

Changes in v5:
- Reorder '.dtb' in Makefile
- Put the "interconnects" line back

Changes in v4:
- Reorder 'status' last

 arch/arm64/boot/dts/qcom/Makefile               |  2 ++
 .../boot/dts/qcom/sc7280-chrome-common.dtsi     | 11 -----------
 .../boot/dts/qcom/sc7280-herobrine-crd.dts      |  1 +
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 17 +++++++++++++++++
 .../qcom/sc7280-herobrine-villager-r0-lte.dts   | 14 ++++++++++++++
 .../qcom/sc7280-herobrine-villager-r1-lte.dts   | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts         |  1 +
 8 files changed, 50 insertions(+), 11 deletions(-)
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

