Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC684721A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhLMHYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhLMHYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:24:01 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C99C061748
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:24:00 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id a23so9183688pgm.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tU0hw9Fvr13Zay+fstlz/pyiNLZeA6ZP9w6V5x5DuU=;
        b=EnRJ8l0qkjcf+Gwyi153UB22/glcDqyPcf4QNxQDw64e8+Mao369qZ1nyRuatepvrm
         OWL7FlIebPRTWSl2OMcThVAhxx0cMhwRjuqIS+obSFxFcVpjGIpMiULJhD0M9jrI2A9C
         gRwvqgAhO9tFwxNLdb0JfDAFkJLFhHrHL1g8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tU0hw9Fvr13Zay+fstlz/pyiNLZeA6ZP9w6V5x5DuU=;
        b=Euhb6eBzWCFitj1zxY9mOk+5DH3wnTAcewrOvGNu+/nmF6lTSvBAo11cL7Zg2G6Aup
         WUtWKNut6RFc394Ve+9eLSBd0uC0pliQaUr8vZiii2NCBh9BRu0esLHvLU7LjfmaSCcL
         4DRok59LB2o4ISzbfzAtFVUwlTasyJXwyUMrizDbYoG9cujNOMbIXjAlv3wpLesymJ6j
         t37WVckV2hhtvTnpYBGftisiNnydJ121Ve9CjAQz9xDC3BGQGIKe6KvHfK9K2YWxCfuC
         GZpr5XliN1f0/Vm1PhmJFjVGabaoJAzC/WRjv65Y9ivxi/tUIO7go3wH0/wQ9HexGVSy
         zJng==
X-Gm-Message-State: AOAM5317T+F7tqcwCp+fJPUZfQwkyWDfeDajN1mRkEQr5n++XndAXTJ8
        yljsCMMQFH19Yu6AVvG76rCrWQ==
X-Google-Smtp-Source: ABdhPJx9zzjBSbp76Vo6NSr7Lam2pE5sYioqMaKKb0knYzFmIAMqcf6mT6zHGjOlu4tppmQmhTXlHQ==
X-Received: by 2002:a65:4b8f:: with SMTP id t15mr46674991pgq.223.1639380240456;
        Sun, 12 Dec 2021 23:24:00 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9447:edff:ad23:1bfc])
        by smtp.gmail.com with ESMTPSA id e7sm11747562pfv.156.2021.12.12.23.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 23:24:00 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: mt8183: Add kukui-jacuzzi-makomo board
Date:   Mon, 13 Dec 2021 15:23:53 +0800
Message-Id: <20211213072355.4079568-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211213072355.4079568-1-hsinyi@chromium.org>
References: <20211213072355.4079568-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makomo is known as Lenovo 100e Gen 2.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  2 ++
 .../mt8183-kukui-jacuzzi-makomo-sku0.dts      | 24 +++++++++++++++++++
 .../mt8183-kukui-jacuzzi-makomo-sku1.dts      | 24 +++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index c130518c3293d5..fe60607084f19d 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -24,6 +24,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel14-sku2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kappa.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kenzo.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-makomo-sku0.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-makomo-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
new file mode 100644
index 00000000000000..51bf2893ec03b1
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
+
+/ {
+	model = "Google makomo sku0 board";
+	compatible = "google,makomo-rev4-sku0", "google,makomo-rev5-sku0",
+		"google,makomo", "mediatek,mt8183";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_FENNEL14";
+};
+
+&mmc1_pins_uhs {
+	pins_clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
new file mode 100644
index 00000000000000..c3b7e9bb0c8960
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-rt1015p.dtsi"
+
+/ {
+	model = "Google makomo sku1 board";
+	compatible = "google,makomo-rev4-sku1", "google,makomo-rev5-sku1",
+		"google,makomo", "mediatek,mt8183";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_FENNEL14";
+};
+
+&mmc1_pins_uhs {
+	pins_clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
-- 
2.34.1.173.g76aa8bc2d0-goog

