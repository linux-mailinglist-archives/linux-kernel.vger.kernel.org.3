Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5B51C971
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385317AbiEETt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385303AbiEETty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:49:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D85D651;
        Thu,  5 May 2022 12:46:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id A12161F45CCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651779973;
        bh=sGHBxK6V/fFriQYhcXCXjVn4Eixl4oBE2sqjXMTIte8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7cC7WwrvswPAet+3zghF6librIKngm73EtS/0lUq7zY8jL71ZyuHD7NlryCHwyde
         gwoiWydPnuyLsNMjtKVLEPYJXY0NtZfugYR3nclvxRlWYAJh4JJuU2Mi/CNrqhMv1r
         iSgphCOzAFzc60sb2fASVmuLUik60cQXHvGqzdVuXC4gSL6/7E4aMOb70c42r6YoKv
         Mt3QZcR4hMdQSl+Q1oO+RfKeQhgAIdJOhGW5K75kpZDyN7VJL1zlDxnDTkC2fqi6bW
         z3nfRtQmN1VYxUevVhcMZ1lmsGF9kVqUzaXE1usbg9TXtARvNVTnKtofX1BF0xauZi
         LysvqzuhmvD1Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 03/16] arm64: dts: mediatek: Introduce MT8192-based Asurada board family
Date:   Thu,  5 May 2022 15:45:37 -0400
Message-Id: <20220505194550.3094656-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505194550.3094656-1-nfraprado@collabora.com>
References: <20220505194550.3094656-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the MT8192 Asurada Chromebook platform, including the Asurada
Spherion and Asurada Hayato boards.

This is enough configuration to get serial output working on Spherion
and Hayato.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v2:
- Changed model name prefix from Mediatek to Google on Hayato and
  Spherion dts

 arch/arm64/boot/dts/mediatek/Makefile         |  2 ++
 .../dts/mediatek/mt8192-asurada-hayato-r1.dts | 11 ++++++++
 .../mediatek/mt8192-asurada-spherion-r0.dts   | 13 ++++++++++
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 26 +++++++++++++++++++
 4 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index c7d4636a2cb7..4f2c258311d6 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -37,6 +37,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
new file mode 100644
index 000000000000..00c76709a055
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2020 Google LLC
+ */
+/dts-v1/;
+#include "mt8192-asurada.dtsi"
+
+/ {
+	model = "Google Hayato rev1";
+	compatible = "google,hayato-rev1", "google,hayato", "mediatek,mt8192";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
new file mode 100644
index 000000000000..d384d584bbcf
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+/dts-v1/;
+#include "mt8192-asurada.dtsi"
+
+/ {
+	model = "Google Spherion (rev0 - 3)";
+	compatible = "google,spherion-rev3", "google,spherion-rev2",
+		     "google,spherion-rev1", "google,spherion-rev0",
+		     "google,spherion", "mediatek,mt8192";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
new file mode 100644
index 000000000000..277bd38943fe
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2020 MediaTek Inc.
+ * Author: Seiya Wang <seiya.wang@mediatek.com>
+ */
+/dts-v1/;
+#include "mt8192.dtsi"
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
2.36.0

