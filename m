Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1B150BE32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbiDVRNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344689AbiDVRMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:12:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EB79136B;
        Fri, 22 Apr 2022 10:09:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7DC721F468EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650647379;
        bh=vR2NR5xALH20cg36OBtgf5+3FjEQDnqSK+qke+aCek0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cg4/kJpuVnPg/x/05XfG40IpRpuRt816+xgpdNCrXz8lbZ+qeCK63ybaB0dLE/ION
         UlAw8s02smGbHDwb6oo5xoEJtbXEBhH/Ug9peoNsDXaEmxWFQCZhvQCH6vOJ1l+fXM
         eeJa8uXRbSnm8bnulTsnnEuOr/X/FTCMilzjaegFDVBJRb1o00xSBjtVqaGMHP59JI
         6ru5U0E4u79G2rENmP5pOt79iFEcOQbKyB+HGACzEhhRVaY5cd/CwA7zFWw/ezpig5
         0e1ZrArJ7YrbNBEHhJaolbwZTtezX6JckzG+JsrLqfjW+v5KNJzEZnhYnVm4HEEnpd
         u8Q30CaN9JaDQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id EFE17480C32; Fri, 22 Apr 2022 19:09:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 19/19] arm64: dts: rockchip: Add rk3588-evb1 board
Date:   Fri, 22 Apr 2022 19:09:20 +0200
Message-Id: <20220422170920.401914-20-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422170920.401914-1-sebastian.reichel@collabora.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kever Yang <kever.yang@rock-chips.com>

Add board file for the RK3588 evaluation board. While the hardware
offers plenty of peripherals and connectivity this basic implementation
just handles things required to successfully boot Linux from eMMC
and connect via UART.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
[rebase, update commit message, use EVB1 for SoC bringup]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/arm/rockchip.yaml     |  5 +++
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 34 +++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index eece92f83a2d..b14d0c84c69b 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -664,6 +664,11 @@ properties:
           - const: rockchip,rk3568-bpi-r2pro
           - const: rockchip,rk3568
 
+      - description: Rockchip RK3588 Evaluation board
+        items:
+          - const: rockchip,rk3588-evb1-v10
+          - const: rockchip,rk3588
+
 additionalProperties: true
 
 ...
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 4ae9f35434b8..8a53ab6d37a1 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -61,3 +61,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
new file mode 100644
index 000000000000..68b19acb1550
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "rk3588.dtsi"
+
+/ {
+	model = "Rockchip RK3588 EVB1 V10 Board";
+	compatible = "rockchip,rk3588-evb1-v10", "rockchip,rk3588";
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	max-frequency = <200000000>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	status = "ok";
+};
+
+&uart2 {
+	status = "ok";
+	pinctrl-0 = <&uart2m0_xfer>;
+};
-- 
2.35.1

