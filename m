Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919E14834E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiACQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiACQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:40:09 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD365C061761;
        Mon,  3 Jan 2022 08:40:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w16so138096502edc.11;
        Mon, 03 Jan 2022 08:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vStsrYZVlp3JaiviApPbcuDrEz2SiF0uoKmHROeaDn4=;
        b=qIuhW22wiz6dK8EMqrWIqN3hj0A1JINBExPi5I9Ci6I4wyyg9IjamjeczFiCnEXxzH
         Fc5nHtTrHsPw3Po+9ECfLHEmz2rEG5lVdXDA0zyChFE9/fxzUTnbHWBs7eGsA9k6zuWX
         DDz8s3S+XPsa1GpCbMyFgaFUDKlHf5b6b/KXO1yL1Y4yHgbDiVT9+JNEGQvruHzETTVv
         E2SuwGo9MP6J4m/xphQ4iuCEVKfVK7DK1TM3qNSo7uuG53QrHoxQor4kWKSCoYIjWkDA
         pHWyyxqNEIomXPBGFjlMnszKqqqBTGSAJI3rMhxPejRYMQ1y/gykKeaMb4gJL2mkcyP6
         lqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vStsrYZVlp3JaiviApPbcuDrEz2SiF0uoKmHROeaDn4=;
        b=CpevXudXTpC1ywj/JDO+WLAAHimuqRdN3VQUBrtGNIwsNYgv1MM1wJGLhDK6vU2ODa
         ajS/QlIVUEX/8x7WNjI4DjZgOJu7lw8Y5H4ZUzs0AwzMqWEMKSnJ5zA4mYjeMTx4aEa8
         vYhrOIQkNqOAzhLz5JgnAOeTuUU0nSbrwNnrxq9h8rPvx5l+Wyv5W62KTAW4XsKGtn9T
         KS+b82SunQbaFvPfUl0VcOkz63Dx7ordMcig0Jw/CeV8WdUJRg/vcEsxwvWJOy7OEPqJ
         +Az5hppr/aj6yG63AZECBq72LnNLYvXPo0zhEHcFyP5juvZl9KTW4w2l4TaNKTZO9ZTq
         dxYQ==
X-Gm-Message-State: AOAM530Fi/hL/Ssz9qTix2SgCTacE8MjJfOkZWYZUoyVVLTfzHuF6jx4
        YnIQ5UVL+IIsislmQviKCGA=
X-Google-Smtp-Source: ABdhPJyePyhpIfSxSNR8MJh3Ch6yiGxxSu5IAoaSJbk4pTVgFi1/kiAmf/hMLdJMFGdIiR8e56dJdg==
X-Received: by 2002:a17:906:828a:: with SMTP id h10mr37074462ejx.164.1641228007310;
        Mon, 03 Jan 2022 08:40:07 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id oz20sm10724068ejc.60.2022.01.03.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:40:07 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v2 3/9] arm64: dts: meson: add initial device-trees for X96-AIR
Date:   Mon,  3 Jan 2022 16:39:50 +0000
Message-Id: <20220103163956.6581-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220103163956.6581-1-christianshewitt@gmail.com>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
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

The device-tree with -gbit suffix supports models with Gigabit
Ethernet, and the device-tree with no suffix supports models
with 10/100 Ethernet.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../dts/amlogic/meson-sm1-x96-air-gbit.dts    | 133 ++++++++++++++++++
 .../boot/dts/amlogic/meson-sm1-x96-air.dts    | 112 +++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 5148cd9e5146..1c0e554f54fc 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -56,4 +56,6 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
new file mode 100644
index 000000000000..7e1a74046ba5
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
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
+	compatible = "amediatech,x96-air-gbit", "amlogic,sm1";
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
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
new file mode 100644
index 000000000000..cd93d798f2a3
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
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
+	compatible = "amediatech,x96-air", "amlogic,sm1";
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
-- 
2.17.1

