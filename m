Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EAA4834EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiACQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiACQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:40:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07355C061761;
        Mon,  3 Jan 2022 08:40:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m21so139222546edc.0;
        Mon, 03 Jan 2022 08:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rfi9L2bbBr1rfKD9x2UDn3lo8VnQftJYAPISZCrx7BU=;
        b=UvVEU5fVWPTExKb1Lc6znD3JzGoOSSPsfgPE8XAfEvxwTxBb+X/6upIh0WuzZ1beU0
         HtS0U7clrMbmK7cnwq4pDRbMCnxcoIgV2fzYHnDN6KaN14Ag1H81CAB8mJtiH4QoTibi
         wDH/LbzIgXWsnnbvxC583iFa4o1oDxlec8j583zJxEcGSFyf+RGuATW2wQTxtHHQVuJE
         kvs12wPxj/NWqvakJI2l9Q2TfoT2H9C6ho+SSwThL8JSQHYXvIPCQIWkt6DHxW+/ZYwh
         Wz5DEs5PIeDkTTytRM23KdxZVJrLyX0ZqFF8lXZppP6vLY4XfW6Q7lygr8kOLZR01rCA
         HTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rfi9L2bbBr1rfKD9x2UDn3lo8VnQftJYAPISZCrx7BU=;
        b=6TMgWNi/dQJClmFA0QEVmhENdoj+pgq++u5nzkra6/fMrUlhWvblYExte9tgaSFBCB
         n1ZfuBgKS/hAwzXSKviH1fcviE3w8C8L06abJ2eb2DzhgEN6JK5BeUioeyTDWm0ZAxGJ
         tZo2QTbvONBUCZbtCEi0X6Z+wa0N2xesBnrew1QTq18mMTaQFwlVRfmmRnaP8s/m6xBm
         ZibicdaxC/iRLK8sT8MxmOfWwT+OO4X946ekmZ7F3MuSRK8j4dNq2OXNfpGD+rSBnKOI
         VE2aoWb1WTIrFXgBFWvDhoVN5q9DR+jMOt4do3sCGrldjZ1tC25YPjhO7O94Bdxti1j7
         EnBg==
X-Gm-Message-State: AOAM532+IFLnKEZ1BL6bmSYZOE+GAZ+lG/cjknM5qRZMfCQn3hmFxfI4
        VIHZUT+rvOuU8fwOAb+aHOc=
X-Google-Smtp-Source: ABdhPJxyYY1khdP1fSLHsZeR9Cgr5nyNXwaA5aEoyOEbO8bzADP7u14un7Xa06quzD6PKE2WYpiTVg==
X-Received: by 2002:a17:907:6095:: with SMTP id ht21mr35447671ejc.67.1641228020586;
        Mon, 03 Jan 2022 08:40:20 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id oz20sm10724068ejc.60.2022.01.03.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:40:20 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v2 9/9] arm64: dts: meson: add initial device-tree for H96-Max
Date:   Mon,  3 Jan 2022 16:39:56 +0000
Message-Id: <20220103163956.6581-10-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220103163956.6581-1-christianshewitt@gmail.com>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Haochuangyi H96-Max is based on the Amlogic S905X3 reference
design with the following specs:

- 4GB DDR4 RAM
- 32/64/128GB eMMC
- HDMI 2.1 video
- S/PDIF optical output
- AV output
- 10/100/1000 Base-T Ethernet
- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
- 1x USB 2.0 OTG port
- 1x USB 3.0 port
- IR receiver
- 1x micro SD card slot (internal)
- 1x Reset/Update button (in AV jack)
- 7-segment VFD

Tested-by: Benoit Masson <yahoo@perenite.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-sm1-h96-max.dts    | 145 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index e87adc6593df..868d74044072 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air-gbit.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
new file mode 100644
index 000000000000..0f6660e68e72
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
@@ -0,0 +1,145 @@
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
+	compatible = "haochuangyi,h96-max", "amlogic,sm1";
+	model = "Shenzhen Haochuangyi Technology Co., Ltd H96 Max";
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "H96-MAX";
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
+
+&uart_A {
+	status = "okay";
+
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
+	};
+};
-- 
2.17.1

