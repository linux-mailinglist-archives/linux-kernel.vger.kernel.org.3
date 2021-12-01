Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25D4659B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353782AbhLAXWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbhLAXWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:22:03 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F9C06174A;
        Wed,  1 Dec 2021 15:18:37 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jeanthomas.me;
        s=key1; t=1638400715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pgd3bHeiad2R39kNuS/FvhTMLDisAZND7wX25XIldg8=;
        b=U1r8QepYQOzDRTyd5698WL6m+p6lH1F29f4gc9drZs15jDoQrL+TEXQLF0sUgimzJcMagR
        xdgHGWG2wxrJrGybwtod0M8fzpnwPVn+UOX/12H6L36maZptgs2D5YFc5FCXkgYO4qL/io
        6IXTERVfpG9zXz+JgAeFxjLGvQPQEiCuYhtNE7QL3SGyaFxMU46lfIYahXHWebNAnxDUtd
        laKYdDHosiOrZHU35t/TCoqL5OzqA30HEUnzw9KbbVJVeEKkN2tF9QFw3PpRVpNxXm73Tv
        8NyPDsjzidY4bFwFDcI7jgeHbtXMf3oLKaXiiGPEEmwg2q6X52MVRVsibpceeg==
From:   Jean THOMAS <virgule@jeanthomas.me>
To:     virgule@jeanthomas.me
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, petr.vorel@gmail.com,
        konradybcio@gmail.com
Subject: [PATCH v2 2/2] arm64: dts: msm8992-lg-bullhead: Add support for LG Bullhead rev 1.0
Date:   Thu,  2 Dec 2021 00:18:32 +0100
Message-Id: <20211201231832.188634-2-virgule@jeanthomas.me>
In-Reply-To: <20211201231832.188634-1-virgule@jeanthomas.me>
References: <20211201231832.188634-1-virgule@jeanthomas.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: jeanthomas.me
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements a DTS file for LG Bullhead (Nexus 5X) rev 1.0
with its matching "qcom,board-id" property.

Changes since v1:
 - Added "model" property to the DTS file

Signed-off-by: Jean THOMAS <virgule@jeanthomas.me>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 .../boot/dts/qcom/msm8992-lg-bullhead-rev-10.dts   | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 3617157f1420..17aa096f8b99 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a3u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a5u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-xiaomi-libra.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dts b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dts
new file mode 100644
index 000000000000..7e6bce4af441
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dts
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
+	model = "LG Nexus 5X rev 1.0";
+
+	/* required for bootloader to select correct board */
+	qcom,board-id = <0xa64 0>;
+};
-- 
2.33.1

