Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD5F4731D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbhLMQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbhLMQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:29:01 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E4AC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:29:01 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 133so14996606pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biiS4C+lzKL6rUA1uy2e/g9FiWgrw/yETmDilWklXNU=;
        b=ZNU/Ru1HXHA2pan1cQDKzDswLSjrFIllZ81BXCYBuYNczkeO21KelJQO+wLXueWJT0
         NwAYq4Cqdw9GeoFHo63gUB6MjRyclPXlwv3iK8k1YCpfUHhOQsGaB4lcKDWqOnCdH5Fo
         dBFPlXLOwc2Z5ZaNzzlzQbyXZnBwHEz6FlR7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biiS4C+lzKL6rUA1uy2e/g9FiWgrw/yETmDilWklXNU=;
        b=2caLiX3vXmue18PC0S2nNLFrWMVRMAZBce5NfVx/AhnoOvUz6kVx3RakWBkymmjRqE
         fwza/muvpIN6i2cum9AeOj3uAsqljIz/YVo1MIj+USThJ9rZhbxOvghBvnqIBliCdLzI
         TLZkCRKZJbGGtAie8fPKFtano1AZXRcbNFK03r+HJpU666RlmUV1HGUaUc2ZHdoXMkSe
         GKgp+opg/SwTOu4abFOiRsXabtwxGDqqIk9D6satIlRxNZq270GGtioBjl0sq5WljyEx
         5EQV/3vRWUBZ43JuRWeYxjSln4nKQJAl4uMmKxSH0GAoNWYuQNzwuZ/PNrlQYDvExlDQ
         Gssg==
X-Gm-Message-State: AOAM530VEF0XetjY8IRKfvdQJWCqD+7pzDD21kthB8RWMA5HS4PMDqe1
        TBnuPGFEE2vH07nXdrloqjikoRb/YkMTZQ==
X-Google-Smtp-Source: ABdhPJzn6LYGfIvTwksk0xQNlW/W3F8r99EJcrlLsE/jQtJCtI4G4XKP/gnT/rT6mUIH5J6AL5Drzw==
X-Received: by 2002:a05:6a00:1385:b0:4ad:580d:8a8 with SMTP id t5-20020a056a00138500b004ad580d08a8mr33932528pfg.10.1639412940703;
        Mon, 13 Dec 2021 08:29:00 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9447:edff:ad23:1bfc])
        by smtp.gmail.com with ESMTPSA id mh1sm7803802pjb.6.2021.12.13.08.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:29:00 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] arm64: dts: mt8183: Add katsu board
Date:   Tue, 14 Dec 2021 00:28:53 +0800
Message-Id: <20211213162856.235130-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Katsu is known as ASUS Chromebook Detachable CZ1.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
This patch depends on [1] to add Himax8279d MIPI-DSI LCD panel driver.

[1] https://patchwork.freedesktop.org/patch/462468/
---
 arch/arm64/boot/dts/mediatek/Makefile         |  2 +
 .../dts/mediatek/mt8183-kukui-katsu-sku32.dts | 38 +++++++++++++++++
 .../dts/mediatek/mt8183-kukui-katsu-sku38.dts | 42 +++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 1613259b686576..c130518c3293d5 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -28,6 +28,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu-sku22.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-katsu-sku32.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-katsu-sku38.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku272.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku288.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
new file mode 100644
index 00000000000000..f923b8c3c49c36
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-kakadu.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
+
+/ {
+	model = "MediaTek katsu board";
+	compatible = "google,katsu-sku32", "google,katsu", "mediatek,mt8183";
+};
+
+&i2c0 {
+	status = "okay";
+
+	/delete-node/touchscreen@10;
+	touchscreen1: touchscreen@5d {
+		compatible = "goodix,gt7375p";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&open_touch>;
+
+		interrupt-parent = <&pio>;
+		interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&panel {
+	compatible = "starry,2081101qfh032011-53g";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_KATSU";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
new file mode 100644
index 00000000000000..1ab14096a279c6
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-kakadu.dtsi"
+#include "mt8183-kukui-audio-rt1015p.dtsi"
+
+/ {
+	model = "MediaTek katsu sku38 board";
+	compatible = "google,katsu-sku38", "google,katsu", "mediatek,mt8183";
+};
+
+&i2c0 {
+	status = "okay";
+
+	/delete-node/touchscreen@10;
+	touchscreen1: touchscreen@5d {
+		compatible = "goodix,gt7375p";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&open_touch>;
+
+		interrupt-parent = <&pio>;
+		interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&panel {
+	compatible = "starry,2081101qfh032011-53g";
+};
+
+&qca_wifi {
+        qcom,ath10k-calibration-variant = "GO_KATSU";
+};
+
+&sound {
+	compatible = "mediatek,mt8183_mt6358_ts3a227_rt1015p";
+};
-- 
2.34.1.173.g76aa8bc2d0-goog

