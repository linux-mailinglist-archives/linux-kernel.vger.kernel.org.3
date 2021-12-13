Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4731472A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbhLMK3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344709AbhLMK1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:27:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C30C01DF1D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:01:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso14311341pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJNVCG0knDeDsaJRBAsMdg1APPcQKKogOd6G1MVemXg=;
        b=DPcRvru3qJqvicpeOQ+vQB3I3IO5BXqCTF2H3ZKojA9g8ns45pUKT5oEYLKezSz9yZ
         aSPAfYrKzi9M4CaT69Pf6aL2s3/Bk7ZJyhXBEF/c4bAGYRKxghqgcaSmXzB7357fY8UZ
         uJG/1K3uHPZiVj7AqxEyo6estqXj/5d/uujqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJNVCG0knDeDsaJRBAsMdg1APPcQKKogOd6G1MVemXg=;
        b=ENpld771KJDDX9f07t5WCMFck7dhA3gOGK1KHsS/G6i2jhFRWRpJI8cYm/mdkXs6Y6
         l95d4d8CijZm00d+B86ZXazvzPsuWalBIR5S8a9H8WiaaT9oDm0oDSaIbgk9qAaff/B4
         vftWbUaZ2yxwf7aVR5z9Fw+K3k7nmFtOfw6ekpX5ttWyh+0s1m2w0ulk4YclaULy5Ix0
         Ljca1FxpPA1cvuQ41hqtq6WgEGxTuFbdH4mPXPSl89cOesMa3Bx5jeoKBdvFhVk1mxZI
         n4NjbZmnJ9cRH1HKD9SZ+prMWuLIFR2qut/5jDsgFZPuOpKqK7nsCMFAgBIuSZ1PSNMe
         DD6Q==
X-Gm-Message-State: AOAM531tZdPEEuT8kFdJwmH9pk33knyA/3xeCJ2Wc3Rhew/l8R9YQLSq
        Hoe71W9fUNjMcIrsPpaDII9E1g==
X-Google-Smtp-Source: ABdhPJwwL/u3IPZJ00nFwwzVlwweo7HKtRHuaYR9nNRNYZ9QrFT8p+HpS+Yn/TJOApIRQiOzrP/OFA==
X-Received: by 2002:a17:902:9694:b0:143:6f27:29ad with SMTP id n20-20020a170902969400b001436f2729admr95912342plp.46.1639389693777;
        Mon, 13 Dec 2021 02:01:33 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id d185sm9953767pgc.58.2021.12.13.02.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:01:33 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/3] ARM: dts: mstar: Add a dts for Miyoo Mini
Date:   Mon, 13 Dec 2021 19:01:12 +0900
Message-Id: <20211213100112.1791192-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213100112.1791192-1-daniel@0x0f.com>
References: <20211213100112.1791192-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miyoo has released a portable retro games machine based
on the SigmaStar SSD202D. Add the initial device tree
for this machine. Just enough to get to an initramfs
shell.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Link: http://linux-chenxing.org/infinity2/miyoomini/
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../mstar-infinity2m-ssd202d-miyoo-mini.dts   | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0de64f237cd8..b270a4d8e0d6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1468,6 +1468,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_MSTARV7) += \
 	mstar-infinity-msc313-breadbee_crust.dtb \
+	mstar-infinity2m-ssd202d-miyoo-mini.dtb \
 	mstar-infinity2m-ssd202d-ssd201htv2.dtb \
 	mstar-infinity2m-ssd202d-unitv2.dtb \
 	mstar-infinity3-msc313e-breadbee.dtb \
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts
new file mode 100644
index 000000000000..1bbbf47132dc
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "mstar-infinity2m-ssd202d.dtsi"
+
+/ {
+	model = "Miyoo Mini";
+	compatible = "miyoo,miyoo-mini", "mstar,infinity2m";
+
+	aliases {
+		serial0 = &pm_uart;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&pm_uart {
+	status = "okay";
+};
-- 
2.34.1

