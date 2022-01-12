Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3590848BD36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348648AbiALC1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348620AbiALC11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:27:27 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D49C061757;
        Tue, 11 Jan 2022 18:27:26 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 30so3993809edv.3;
        Tue, 11 Jan 2022 18:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tO7gLLSSRIA6YdT6ONG7gPtYf9ZGEU1QKx6OFESgT8=;
        b=B21e7D0p/9ZTHSXmve5A7l5ASiQ1T0vdgsCBID0eIWmJ8/MG7pn0igFBMFDj08swYN
         NHUEKLk325bGnHwJNOhEwatezmjk/elpqcOMAVl8ondMrChdxmXG5NOBmaJzqaPLat0R
         l3wGiq+D5hkeOZFJTH8zqELNTBnND9C4wT5ZsEKq4oqa+OAPNkrPgURFS8tM/pa6LIb7
         DxFlWBS9//TPOLPnyl16FMsXRg6EkAXiJm2ywNNrPHNl55irRlFiQMqjZ6/2tSIiLbA3
         tJ4L1Hz/FW5pKe7Zc2aXk0ux2m+F1NE7aVmQXUKP6t7oujmio/eHZHrIiqa2N6am488A
         oKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tO7gLLSSRIA6YdT6ONG7gPtYf9ZGEU1QKx6OFESgT8=;
        b=DVflPGwaWQRqAUyU4RiDcT2zqaltXDEknd1w72IlC0qKpkhoGAp1987WQ+zK+ikBsu
         hA/o0vKcEiQ3NRxNU5aLdMkoylLwURZazUY9DR/U8f+HUVE/pqa7cWenrtgGul+Ku8kL
         Tl3FG0IaL6Ip267ElHn8oZK6aO+mt4TVOZmAXxV9C8crIxZ9KwUIzHwl3IXnHExQZPXm
         mgRRUp4AXOgDAhb+jTs5VYVhyou2/r7aL5BfYCfQkn3OSMf1h06oTIcA+Txk30Vm1VaI
         040b00+wOo81YqS7r0YpEz9dxUxD/zqqAV7nGaNmYmlK8BAiduSCtmudf8MvimmpOx/L
         xM0Q==
X-Gm-Message-State: AOAM530i2JD4dDxJzCAuW4roPpELqI5zxlvt2G8ju4Pk0rjDoi5zrGUW
        q69tlM5XEzFG3UJ7fUhDfno=
X-Google-Smtp-Source: ABdhPJz0ELn2BbvargaSfhYnZz0tX0cv/I3d18xfHRD2my/ORgmwadugy6PBgFaBYcSiKyrteWAC6w==
X-Received: by 2002:a05:6402:1e94:: with SMTP id f20mr6861905edf.212.1641954445240;
        Tue, 11 Jan 2022 18:27:25 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ky10sm4041772ejc.151.2022.01.11.18.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:27:25 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v3 3/9] arm64: dts: meson: add initial device-trees for X96-AIR
Date:   Wed, 12 Jan 2022 02:27:07 +0000
Message-Id: <20220112022713.25962-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112022713.25962-1-christianshewitt@gmail.com>
References: <20220112022713.25962-1-christianshewitt@gmail.com>
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
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # X96-Air with Gbit PHY
Tested-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com> # X96-Air with 10/100 Eth
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

