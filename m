Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E324641E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbhK3XA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:00:57 -0500
Received: from out1.migadu.com ([91.121.223.63]:19616 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344955AbhK3XAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:00:24 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jeanthomas.me;
        s=key1; t=1638313022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVheI0HHwsC673Oici9qOIZH6KhjlE7nlD+3PNI8Ozc=;
        b=msKyWKHI0ZdCfLwDzAnNrDH7kX8WjN3hdwsu13wg0kf466M/yBBNKnssVg7v4GWummN/2I
        4sdqwTDEaCbSk01MJqP6OLnT9JtBev0NY9d/TeeSNWWgcGoSFlhDHbL/vOygF7BYx6mnvd
        PujjiLFDRgJuXGzcdixjPQSPwZUFKUQIGzOHOkbAc4EL/VmB6dDqojgNzk6InCoKlF/cpc
        zunOnTr7lEaq2oHeCVyjVB1qJ7eYNG1TeSxH4aI8/A7zdocG5AyFdZu45SByTgouqAktnk
        6GH19TSCgziTWhp8i53h9304UmHIPzPIwtaPgI70EtTl0tIQTE3bKRGzH6vzLg==
From:   Jean THOMAS <virgule@jeanthomas.me>
To:     virgule@jeanthomas.me, devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, petr.vorel@gmail.com
Subject: [PATCH 2/2] arm64: dts: Add support for LG Bullhead rev 1.0
Date:   Tue, 30 Nov 2021 23:56:45 +0100
Message-Id: <20211130225645.171725-2-virgule@jeanthomas.me>
In-Reply-To: <20211130225645.171725-1-virgule@jeanthomas.me>
References: <20211130225645.171725-1-virgule@jeanthomas.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: jeanthomas.me
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements a DTS file for LG Bullhead (Nexus 5X) rev 1.0
with its matching "qcom,board-id" property.
---
 arch/arm64/boot/dts/qcom/Makefile                    |  1 +
 .../boot/dts/qcom/msm8992-lg-bullhead-rev-10.dts     | 12 ++++++++++++
 2 files changed, 13 insertions(+)
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
index 000000000000..4d2bea67c646
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dts
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
+	qcom,board-id = <0xa64 0>;
+};
-- 
2.33.1

