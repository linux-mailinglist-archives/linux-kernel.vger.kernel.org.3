Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BE24641DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345034AbhK3XAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344819AbhK3XAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:00:09 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D2C061574;
        Tue, 30 Nov 2021 14:56:48 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jeanthomas.me;
        s=key1; t=1638313007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dyqan58KK4Vj1U5mzXx1IapLYaJZe0oyYkrA0sFvVOk=;
        b=Vd4+zZeZJkcLl35UXrOTAOgsqMbCRll+NqVSC9mcD7TUHYZf7KMbILW8SL8YiITMKA+iWB
        DaYrR997lkMj8Dtlj3KEiukyCW+XyqPpgoEW5sMWquuFjWfRWOfw4ABYjUgBe+qMoy8feJ
        hNx8DlIWmso3xNJNaafwYUbdML/cJUrEAQTrkR/6U5rOdg2O70xxXq/JjJ2EB391pdzsMW
        RNerAegT84sZ47KqlsnKmL0zVWkc2QKUOoDstzPxGO0hluNEAc+lqXXljxjMEm8Ftob53R
        7TYrDI6DE1n1e+MB/62SXimdDjYcVumpbyFwqQiO42BFj+hPjk1Ei/APXBq3Cw==
From:   Jean THOMAS <virgule@jeanthomas.me>
To:     virgule@jeanthomas.me, devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, petr.vorel@gmail.com
Subject: [PATCH 1/2] arm64: dts: Place LG Bullhead generic code into a DTSI file
Date:   Tue, 30 Nov 2021 23:56:44 +0100
Message-Id: <20211130225645.171725-1-virgule@jeanthomas.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: jeanthomas.me
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch puts the generic code common across all hardware revisions
into a DTSI file.

It also prefixes the DTS filename with the vendor name, to follow the
naming convention used by other DTS files.
---
 arch/arm64/boot/dts/qcom/Makefile                    |  2 +-
 .../boot/dts/qcom/msm8992-lg-bullhead-rev-101.dts    | 12 ++++++++++++
 ...bullhead-rev-101.dts => msm8992-lg-bullhead.dtsi} |  2 --
 3 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dts
 rename arch/arm64/boot/dts/qcom/{msm8992-bullhead-rev-101.dts => msm8992-lg-bullhead.dtsi} (98%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6b816eb33309..3617157f1420 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -17,7 +17,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a3u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a5u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-bullhead-rev-101.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-xiaomi-libra.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dts
new file mode 100644
index 000000000000..5151c6128b09
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) Jean Thomas <virgule@jeanthomas.me>
+ */
+
+/dts-v1/;
+
+#include "msm8992-lg-bullhead.dtsi"
+
+/ {
+	/* required for bootloader to select correct board */
+	qcom,board-id = <0xb64 0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
similarity index 98%
rename from arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
rename to arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
index 4da6c44bf532..3b0cc85d6674 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
@@ -18,9 +18,7 @@ / {
 	compatible = "lg,bullhead", "qcom,msm8992";
 	chassis-type = "handset";
 
-	/* required for bootloader to select correct board */
 	qcom,msm-id = <251 0>, <252 0>;
-	qcom,board-id = <0xb64 0>;
 	qcom,pmic-id = <0x10009 0x1000A 0x0 0x0>;
 
 	/* Bullhead firmware doesn't support PSCI */
-- 
2.33.1

