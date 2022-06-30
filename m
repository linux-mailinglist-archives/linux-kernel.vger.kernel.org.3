Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159EB561F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbiF3Pdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiF3Pda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:33:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECF0E0F7;
        Thu, 30 Jun 2022 08:33:27 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 550ED6601967;
        Thu, 30 Jun 2022 16:33:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656603206;
        bh=nOhUYm0IpD/r1TykJ1rAO+e9Iu31jMTfdhwk8vihElo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFfhWxuSBWqkSfXsPVunMYMQkVJY8BXA0MhFArUZ46NJ7p62OdDljvSVEXy2QeOYf
         l+8GkP9/Us8ROdHej63ydggHcBo+xnHXEZGtThGGuaxpbUawObBYS7QA3vHUnwNXfB
         HRFfJvfz+PuIMlhZwyB3j9gcix+OdnWZrAzMI24cSRGbCS5dLLrgYzfAFFl+wfsekW
         ymEcGd2Qm9kay97ztD5UYXbKYqAhol4ZnZqhu31KGrpG014/wbAflZbtQxm2e9L/vZ
         Kk4Dtb6F9ZtTIkMPKZsIh5JKS4Xdl+Gfz5q2OVlNd05R5nVq3mA4OtTd1PVAHw3jUR
         M04zt3f5L4f+g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        gtk3@inbox.ru, luca@z3ntu.xyz, sam.shih@mediatek.com,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH 02/11] arm64: dts: mediatek: Introduce MT8195 Cherry platform's Tomato
Date:   Thu, 30 Jun 2022 17:33:07 +0200
Message-Id: <20220630153316.308767-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the MT8195 Cherry Chromebook platform, including three
revisions of Cherry Tomato boards.

This basic configuration allows to boot Linux on all board revisions
and get a serial console from a ramdisk.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  3 +++
 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  | 11 ++++++++
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  | 11 ++++++++
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  | 12 +++++++++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 26 +++++++++++++++++++
 5 files changed, 63 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 50a2c58c5f56..0b12035a4f08 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -39,6 +39,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r1.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r2.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
new file mode 100644
index 000000000000..17e9e4d6f6ab
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ */
+/dts-v1/;
+#include "mt8195-cherry.dtsi"
+
+/ {
+	model = "MediaTek Tomato (rev1) board";
+	compatible = "google,tomato-rev1", "google,tomato", "mediatek,mt8195";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
new file mode 100644
index 000000000000..b915fba311e9
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ */
+/dts-v1/;
+#include "mt8195-cherry.dtsi"
+
+/ {
+	model = "MediaTek Tomato (rev2) board";
+	compatible = "google,tomato-rev2", "google,tomato", "mediatek,mt8195";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
new file mode 100644
index 000000000000..2ead9eca2ec9
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ */
+/dts-v1/;
+#include "mt8195-cherry.dtsi"
+
+/ {
+	model = "MediaTek Tomato (rev3 - 4) board";
+	compatible = "google,tomato-rev4", "google,tomato-rev3",
+		     "google,tomato", "mediatek,mt8195";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
new file mode 100644
index 000000000000..7406d7bbf725
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include "mt8195.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.35.1

