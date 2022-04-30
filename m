Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617B7515F10
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359754AbiD3Q3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383347AbiD3Q3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:29:11 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D36128D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:25:32 -0700 (PDT)
Received: from localhost.localdomain (abxh26.neoplus.adsl.tpnet.pl [83.9.1.26])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id D69723F729;
        Sat, 30 Apr 2022 18:25:29 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8996-tone: Rule out PM(I)8994 variants
Date:   Sat, 30 Apr 2022 18:25:24 +0200
Message-Id: <20220430162525.607946-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like all Tone devices out in the wild are using PMI8996, which
suggests the PMI8994-variant DTs are not needed. Remove them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/Makefile                     |  3 ---
 .../qcom/msm8996-pmi8996-sony-xperia-tone-dora.dts    | 11 -----------
 .../qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dts  | 11 -----------
 .../qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dts  | 11 -----------
 .../arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi |  2 +-
 5 files changed, 1 insertion(+), 37 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f9e6343acd03..37c3b48d0411 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -30,9 +30,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-satsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-sumire.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-suzuran.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-pmi8996-sony-xperia-tone-dora.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-pmi8996-sony-xperia-tone-kagura.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-pmi8996-sony-xperia-tone-keyaki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-dora.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-kagura.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-keyaki.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dts b/arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dts
deleted file mode 100644
index b018693600a5..000000000000
--- a/arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dts
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
- */
-
-#include "msm8996-sony-xperia-tone-dora.dts"
-#include "pmi8996.dtsi"
-
-/ {
-	model = "Sony Xperia X Performance (PMI8996)";
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dts b/arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dts
deleted file mode 100644
index 842ea3cf557e..000000000000
--- a/arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dts
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
- */
-
-#include "msm8996-sony-xperia-tone-kagura.dts"
-#include "pmi8996.dtsi"
-
-/ {
-	model = "Sony Xperia XZ (PMI8996)";
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dts b/arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dts
deleted file mode 100644
index b3f9062da4b0..000000000000
--- a/arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dts
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
- */
-
-#include "msm8996-sony-xperia-tone-keyaki.dts"
-#include "pmi8996.dtsi"
-
-/ {
-	model = "Sony Xperia XZs (PMI8996)";
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index 8f0ffa4b114b..7d1e12a62ddb 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -8,6 +8,7 @@
 #include "msm8996.dtsi"
 #include "pm8994.dtsi"
 #include "pmi8994.dtsi"
+#include "pmi8996.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
@@ -19,7 +20,6 @@
 
 / {
 	qcom,msm-id = <246 0x30001>; /* MSM8996 V3.1 (Final) */
-	qcom,pmic-id = <0x20009 0x2000a 0 0>; /* PM8994 + PMI8994 */
 	qcom,board-id = <8 0>;
 
 	chosen {
-- 
2.35.2

