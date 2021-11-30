Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A237462C93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbhK3GJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbhK3GIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:08:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32919C061714;
        Mon, 29 Nov 2021 22:05:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so82133208edd.9;
        Mon, 29 Nov 2021 22:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTIpHt4abFxiwEWu16rsOsGtzLsE5A+z1Ris+tROnSk=;
        b=FvROx5aIIMa8cktQfVQXAf/onwmI+1uEipiNStcFWnKSD416lwNL07vVabk651Zkpk
         vc/X8Eg53LVvl2zMR8sMnn8wugAx1+dcZIZEhty/P9Ws43cg++XDbu6KUEeroWC3VJrp
         uLeECNOk1XjQwJx/sv9jcARvy7YNU4oz7vwKNT8F/KFVk7f+9iDRJb1CzkKkmbze5377
         28S6yPbYnvA+LBP+jMSrFG5iD9x44xQxCCxVSOoGb4xouMe8OzspLSR6mHIdwX1NT6DR
         AW6tJP4PDgCy05o4sFM7LwCGUP05EqA6VaXO0VKvgX3pFEvTIuX0fkqFXmxp3jDOeiku
         QHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTIpHt4abFxiwEWu16rsOsGtzLsE5A+z1Ris+tROnSk=;
        b=3S+6pgPqYbmCgZ+JM0qHynIqHU/3I7DQ5gplP9wezmx+2SIrgl4rIj+QSFjECwPCaM
         CKZq1TLlYoqyu7nvqHGacHQHRIgepM1Vu2o8GHbiWm9WpueCn0gcxPEMlbrHCw/rxiG+
         CDcRkesmD8IcKkee6mL4uDnmoaEnV56IEEIxRouAv/ojybF7mKB6GqSRKRfPxJ//P7/M
         pWzpQfVRKrWcRtAvrLm7Pb67S37lUtroJJ1+N6AWSsxvNov3s27QoVAJnJnnnYfgGaB6
         Q60ZzLOFa0BDbP5pO5cnKxXDNl76DauIZMRON8zx6sFcBbtTx/VVZAC16MBrsHHN+W2S
         /STA==
X-Gm-Message-State: AOAM531w3EmyIucHwmm+SeeqHj0YQa3RP8W4nhh8ujkAYq+ueiqpiKZd
        /nhQvBFIVYGXlQH3/up75YAPUzxpWgSOOFap
X-Google-Smtp-Source: ABdhPJx/7zdmGJGv4UlZCKtRPafPbYKVivXJWnQQ14/91uu6R1sQJhFsogni4mQbHRCVECQuPD+nfQ==
X-Received: by 2002:a05:6402:90c:: with SMTP id g12mr80777174edz.217.1638252333807;
        Mon, 29 Nov 2021 22:05:33 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e1sm10542153edc.27.2021.11.29.22.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 22:05:33 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [RFC PATCH 3/9] arm64: dts: meson: add initial device-trees for X96-AIR
Date:   Tue, 30 Nov 2021 06:05:17 +0000
Message-Id: <20211130060523.19161-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130060523.19161-1-christianshewitt@gmail.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amediatek X96-AIR is based on Amlogic S905X3 reference board
designs and ships in multiple configurations:

– 4GB DDR3 + 64GB eMMC + WiFi a/b/g/n/ac + BT + Gb Ethernet
– 4GB DDR3 + 32GB eMMC + WiFi a/b/g/n/ac + BT + Gb Ethernet
– 4GB DDR3 + 32GB eMMC + WiFi b/g/n (no BT) + 10/100 Ethernet
– 2GB DDR3 + 16GB eMMC + WiFi b/g/n (no BT) + 10/100 Ethernet
...
- HDMI 2.1 video
- S/PDIF optical output
- AV output
- 2x USB 2.0 inc. OTG port
- 1x USB 3.0 port
- IR receiver
- 1x micro SD card slot (internal)
- 1x Reset/Update button (in AV jack)
- 7-segment VFD

The device-tree with -100 suffix supports models with 10/100 Ethernet
and with -1000 suffix supports models with Gigabit Ethernet.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../dts/amlogic/meson-sm1-x96-air-100.dts     | 112 +++++++++++++++
 .../dts/amlogic/meson-sm1-x96-air-1000.dts    | 133 ++++++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-100.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-1000.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 5148cd9e5146..a0c1a7fbae57 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -56,4 +56,6 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-100.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-1000.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-100.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-100.dts
new file mode 100644
index 000000000000..d9e5bc98a46a
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-100.dts
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre SAS. All rights reserved.
+ * Copyright (c) 2020 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-sm1-ac2xx.dtsi"
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	compatible = "amediatech,x96-air-100", "amlogic,sm1";
+	model = "Shenzhen Amediatech Technology Co., Ltd X96 Air";
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "X96-AIR";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-4 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&ethmac {
+	status = "okay";
+	phy-handle = <&internal_ephy>;
+	phy-mode = "rmii";
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+&ir {
+	linux,rc-map-name = "rc-beelink-gs1";
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-1000.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-1000.dts
new file mode 100644
index 000000000000..8047c6b116fe
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-1000.dts
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre SAS. All rights reserved.
+ * Copyright (c) 2020 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-sm1-ac2xx.dtsi"
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	compatible = "amediatech,x96-air-1000", "amlogic,sm1";
+	model = "Shenzhen Amediatech Technology Co., Ltd X96 Air";
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "X96-AIR";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-4 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&ethmac {
+	status = "okay";
+
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	phy-mode = "rgmii-txid";
+	phy-handle = <&external_phy>;
+
+	rx-internal-delay-ps = <800>;
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+&ir {
+	linux,rc-map-name = "rc-x96max";
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
-- 
2.17.1

