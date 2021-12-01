Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179C54659B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353813AbhLAXXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343659AbhLAXWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:22:03 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D2C061574;
        Wed,  1 Dec 2021 15:18:37 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jeanthomas.me;
        s=key1; t=1638400714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XsmTuDJY0ND7gpOacQGnkykcqQJrVKgwUixfwP845I8=;
        b=oi13IQjUpU2jJ6YIJxpmLZVcnE7b3bNg3hc1/uzYcj8hfXKGVS6BIYfBQb0vPX33FdMrqB
        ja1szBSbqvyc79R/sUdUO0ErUkO9uwD5ptF71TgbpaOss8X7ODlSfE6WXBrlXeFXsbwzom
        bUIINpS9ZwejTF3KbGz6jXJS8uzwFJL8B5ZWBOjmn995Z1r3yHE7msj01+xDv9r43KMYP1
        5jQgXWa22m6gdRSLsoWKRsLleqNh53dwUBjmmRsKqox8OIFmVCjvb90dnmHeZdY+Q3kDz3
        qFhHk2jwFZ/4adeX7hVzv0woFr0cK9869vPTr+ei8p7DOMVbRRR+rRbSeBQxKg==
From:   Jean THOMAS <virgule@jeanthomas.me>
To:     virgule@jeanthomas.me
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, petr.vorel@gmail.com,
        konradybcio@gmail.com
Subject: [PATCH v2 1/2] arm64: dts: msm8992-lg-bullhead: Place LG Bullhead generic code into a DTSI file
Date:   Thu,  2 Dec 2021 00:18:31 +0100
Message-Id: <20211201231832.188634-1-virgule@jeanthomas.me>
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

Changes since v1:
 - Added "model" property to the DTS file

Signed-off-by: Jean THOMAS <virgule@jeanthomas.me>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  2 +-
 .../boot/dts/qcom/msm8992-lg-bullhead-rev-101.dts  | 14 ++++++++++++++
 ...llhead-rev-101.dts => msm8992-lg-bullhead.dtsi} |  2 --
 3 files changed, 15 insertions(+), 3 deletions(-)
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
index 000000000000..bcda7dbec6a4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) Jean Thomas <virgule@jeanthomas.me>
+ */
+
+/dts-v1/;
+
+#include "msm8992-lg-bullhead.dtsi"
+
+/ {
+	model = "LG Nexus 5X rev 1.01";
+	
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

