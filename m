Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8542746554C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352343AbhLAS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352313AbhLASZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:25:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B9DC061574;
        Wed,  1 Dec 2021 10:21:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso1364184wmh.0;
        Wed, 01 Dec 2021 10:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oj33o1gGh0gN+CnURlKi1LWyJrpHKuLFBRHdEYnjbPA=;
        b=QM285lZA63Qd8dB3mPUlj+MLgBFaPa6KFAVyVLqCMhzrBFI03xniB+8BYEm2pcTRit
         UJHwj8wm/T3oe0EOFOAaY2OLHqhCuJ6anzMJj1lOJmqS+nYJYGFj8oGZsbeXpgnk4UDE
         2xNOlXtbdeILjJF/3I71fZtk//fuZVKtzvvJ0ltBSitJ46Aza9473HlhIHQoR1IUNskk
         XNRbXmvO7cnWW7KGige+w8+z0deNG8f8DfiQ7duF9s7MUqPB7BlQFekZ4Ck6aVrMYi0j
         gJLKa5nFQQ9LRuxIkRq8XoVDf4tmSNFipdwcryllz4dU6tygO87QOalzWJE29uJJyhvT
         G8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oj33o1gGh0gN+CnURlKi1LWyJrpHKuLFBRHdEYnjbPA=;
        b=ZUgIs7LcD19fJZbGc/uDmardjqO8IeqLeNPvIL2wF+TjzdhOz/LYlm2cPHCSeDBea6
         CD6AR7MqlIQOIwxI/7akBr6J4MeETTFAOr6ML/fH73usBkXHO5a2LKTFF8yDemPC9DNt
         E1+J+bdD/T2JnMD54qxS6h2UMagflkjIWNPZOb7xO7ptK70AETYCNd+U92mJrSd7e+BP
         HoNFFL7UFrYoWO6a700l98iVK4eOtZSCuM7HIrO1VNqASChhbUekBhWAWuyDjV5MHaBe
         dQMIKimiqBfmziYEt+ojrlFD5I2Esr5+OSdP2OB6MahgNoa9KEtKVF/AIWOqzEDqnu1j
         KOAQ==
X-Gm-Message-State: AOAM533977FSRlS8AaR5kbVZh69zp5wWMmGVvEU2eNKoq7STyKuU+Q4T
        au0wi4n0vg38TdFnND8A5ks=
X-Google-Smtp-Source: ABdhPJzjXWpq/AyOz0Xy0C56UpP7dIFAZxQco8yWsp5qtgDwdNwytWnyUS8pU8DaUKx/FxEAx9Dh9w==
X-Received: by 2002:a05:600c:294c:: with SMTP id n12mr9009559wmd.71.1638382903766;
        Wed, 01 Dec 2021 10:21:43 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id f7sm604705wri.74.2021.12.01.10.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:21:43 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 3/5] arm64: dts: allwinner: h6: Add Tanix TX6 mini dts
Date:   Wed,  1 Dec 2021 19:21:16 +0100
Message-Id: <20211201182118.1213806-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
References: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 mini is less capable version of Tanix TX6 although it comes
with some features not present on Tanix TX6.

Basic specs:
- H6 SoC
- 2 GiB DDR3 RAM
- HDMI
- SPDIF
- 2x USB
- analogue audio
- CVBS
- SD card
- IR remote
- LED display
- fast ethernet
- XR819 wifi
- 16 GiB eMMC

Currently supported features doesn't differ that much from Tanix TX6,
but that will change soon.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/Makefile            |  1 +
 .../dts/allwinner/sun50i-h6-tanix-tx6-mini.dts    | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-mini.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index a96d9d2d8dd8..8fa5c060a4fe 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -37,3 +37,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-mini.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-mini.dts
new file mode 100644
index 000000000000..08d84160d88f
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-mini.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2021 Jernej Skrabec <jernej.skrabec@gmail.com>
+
+/dts-v1/;
+
+#include "sun50i-h6-tanix.dtsi"
+
+/ {
+	model = "Tanix TX6 mini";
+	compatible = "oranth,tanix-tx6-mini", "allwinner,sun50i-h6";
+};
+
+&r_ir {
+	linux,rc-map-name = "rc-tanix-tx3mini";
+};
-- 
2.34.1

