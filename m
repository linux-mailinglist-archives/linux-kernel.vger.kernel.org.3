Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C7A5256AB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358516AbiELU4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358490AbiELU4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:56:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E39164BCD;
        Thu, 12 May 2022 13:56:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id E3A041F4586A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652388976;
        bh=10wBmgI34/J0do1CmgWx9w2vRpxw6AIOTWSkrzsF648=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=haO2jVVJrEZ4rl/0F732I3DooNC3vp3Fk8dN9sdEiv9UbT3o/uwH1+q7UmEbh2A5m
         wLVTJrUcBLFfzYe3meB28OGKPCSjhgBNHpEDhyofxz5ybT4usg0163HQNU8ux12wOA
         6nwn3mx6LYlEUWqqH0zCg+NoY9TTBe1yvuSl5NpZoKqNRK71xrzV8WCaFKWmiWpK8y
         JQUdGrn4zFUFyGJjwVAFMi3eIiGDiHOQYRsW6Rz0HFoaO0t2L5HtEJJwC67O1a94/T
         vxY2Pp0jjOjpksqkuwdYN+iALRNYGLwDt8Ve+J53wHqA83h3Cekbr2W2iUZYHwv1Xp
         cOVTzIWvjnH8Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 03/16] arm64: dts: mediatek: Introduce MT8192-based Asurada board family
Date:   Thu, 12 May 2022 16:55:49 -0400
Message-Id: <20220512205602.158273-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512205602.158273-1-nfraprado@collabora.com>
References: <20220512205602.158273-1-nfraprado@collabora.com>
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

(no changes since v2)

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
2.36.1

