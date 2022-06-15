Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F78A54C4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346616AbiFOJkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346595AbiFOJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:39:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0518C3FD8C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:39:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i15so9962480plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Iecv2XJyu1TvBDLnNmwvvZnMwzgL4rcsmuun8gLeAU=;
        b=BLWD8a3xygAdGvWLG+G/wk1HH+NGfJMiNahesaIiHNz1kTr2Ps6mcoC3Y+YX/59NSN
         XzsaEMECFh5jvn+GpUmtgYIxTvEFfoogxhUR50YzWThIxc1XtBpICMXI5vy2L2pOhaAn
         GtfPf5gLXzjSL8YtQ7ZD7WQBezwbSJ/jhWBPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Iecv2XJyu1TvBDLnNmwvvZnMwzgL4rcsmuun8gLeAU=;
        b=ctCAwOh2kW096dlzG+TF48NszYYNqtZVV+W/JN/CqyrVKPhXqZ16CRvFEUgQYKsT5c
         /b5CIdPz/lS3l+f4ttSxeUS4JzgqmVc5B2SRj1nxGz3Fm6ZM/u4I+EU7fTzNML4nGT5d
         qxt6gJ/ayNTrCgtPVYmPhqEIZyvxHzBQexpdcFlv79MlJJJyQK1GP6s0bt043mcKTN6D
         JRkuoBNGBMgqDwj1a1woWOHQYmYQPpAojC6+jnRcoINvGLUiBj+Zo8aVcDEJ7M480XGk
         eCUkLv81KsmmnR1gaNAjKf6jCbvQ1PXtcZUvh5pQ6B1whJa6AhLLwZV1glAcziOErau4
         EXvQ==
X-Gm-Message-State: AJIora+W7RMqhuO3KBpySxOb7zAZE59SdAvvjmwOkw/KHqCmKxCJBiL5
        GZi8fhHjMo/pEPlzkF5DPROpdQ==
X-Google-Smtp-Source: AGRyM1uQNtbtqz6jp24CQ6VampseGvnE8ST04wSTlPq85ivKSs9GQSMXffvTDDuvA5LpM7A7oXUsLA==
X-Received: by 2002:a17:90a:ce18:b0:1e7:71de:7721 with SMTP id f24-20020a17090ace1800b001e771de7721mr9082610pju.244.1655285965456;
        Wed, 15 Jun 2022 02:39:25 -0700 (PDT)
Received: from localhost.localdomain ([183.83.136.224])
        by smtp.gmail.com with ESMTPSA id jf17-20020a170903269100b00163f183ab76sm8662543plb.152.2022.06.15.02.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:39:24 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Christopher Vollo <chris@renewoutreach.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-amarula@amarulasolutions.com
Subject: [PATCH v2 2/2] ARM: dts: sun8i: Add R16 Vista E board from RenewWorldOutreach
Date:   Wed, 15 Jun 2022 15:09:00 +0530
Message-Id: <20220615093900.344726-3-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615093900.344726-1-sunil@amarulasolutions.com>
References: <20220615093900.344726-1-sunil@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R16-Vista-E board from RenewWorldOutreach based on allwinner
R16(A33).

General features:
- 1GB RAM
- microSD slot
- Realtek Wifi
- 1 x USB 2.0
- HDMI IN
- HDMI OUT
- Audio out
- MIPI DSI
- TI DLPC3433

It has also connectors to connect an external mini keypad.

Signed-off-by: Christopher Vollo <chris@renewoutreach.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>

---
Changes for v2:
- Add missing compatible string
- insert missing signatures of contributors
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-r16-renew-vista-e.dts | 361 ++++++++++++++++++
 2 files changed, 362 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-r16-renew-vista-e.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 184899808ee7..b5966c0742e1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1353,6 +1353,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-r16-nintendo-nes-classic.dtb \
 	sun8i-r16-nintendo-super-nes-classic.dtb \
 	sun8i-r16-parrot.dtb \
+	sun8i-r16-renew-vista-e.dtb \
 	sun8i-r40-bananapi-m2-ultra.dtb \
 	sun8i-r40-oka40i-c.dtb \
 	sun8i-s3-elimo-initium.dtb \
diff --git a/arch/arm/boot/dts/sun8i-r16-renew-vista-e.dts b/arch/arm/boot/dts/sun8i-r16-renew-vista-e.dts
new file mode 100644
index 000000000000..45f620203c33
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-r16-renew-vista-e.dts
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2022 RenewWorldOutreach
+ * Copyright (C) 2022 Amarula Solutions(India)
+ */
+
+/dts-v1/;
+#include "sun8i-a33.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "RenewWorldOutreach R16-Vista-E";
+	compatible = "renewworldoutreach,r16-vista-e", "allwinner,sun8i-r16", "allwinner,sun8i-a33";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		ok {
+			label = "ok";
+			linux,code = <KEY_OK>;
+			gpios = <&pio 4 0 GPIO_ACTIVE_LOW>;
+		};
+
+		left {
+			label = "left";
+			linux,code = <KEY_LEFT>;
+			gpios = <&pio 4 1 GPIO_ACTIVE_LOW>;
+		};
+
+		right {
+			label = "right";
+			linux,code = <KEY_RIGHT>;
+			gpios = <&pio 4 2 GPIO_ACTIVE_LOW>;
+		};
+
+		up {
+			label = "up";
+			linux,code = <KEY_UP>;
+			gpios = <&pio 4 3 GPIO_ACTIVE_LOW>;
+		};
+
+		down {
+			label = "down";
+			linux,code = <KEY_DOWN>;
+			gpios = <&pio 4 4 GPIO_ACTIVE_LOW>;
+		};
+
+		back {
+			label = "back";
+			linux,code = <KEY_BACK>;
+			gpios = <&pio 4 5 GPIO_ACTIVE_LOW>;
+		};
+
+		power {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&pio 4 6 GPIO_ACTIVE_LOW>;
+		};
+
+		vol-down {
+			label = "vol-down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&pio 7 3 GPIO_ACTIVE_LOW>;
+		};
+
+		vol-up {
+			label = "vol-up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pio 7 9 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		battery-led0 {
+			label = "renew-e:battery-led0";
+			gpios = <&r_pio 0 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		battery-led1 {
+			label = "renew-e:battery-led1";
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		battery-led2 {
+			label = "renew-e:battery-led2";
+			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		battery-led3 {
+			label = "renew-e:battery-led3";
+			gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		pad-intz {
+			label = "renew-e:pad-intz";
+			gpios = <&pio 4 16 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		battery-led4 {
+			label = "renew-e:battery-led4";
+			gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		volume-led0 {
+                        label = "renew-e:volume-led0";
+                        gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
+                };
+
+		volume-led1 {
+			label = "renew-e:volume-led1";
+			gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>;
+		};
+
+		volume-led2 {
+			label = "renew-e:volume-led2";
+			gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>;
+		};
+
+		volume-led3 {
+			label = "renew-e:volume-led3";
+			gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		volume-led4 {
+			label = "renew-e:volume-led4";
+			gpios = <&pio 6 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		fans-on {
+			label = "renew-e:fans-on";
+			gpios = <&pio 4 14 GPIO_ACTIVE_HIGH>; /* FAN_ON/OFF: PE14 */
+			default-state = "on";
+		};
+	};
+
+	reg_vcc5v0: vcc5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&codec {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
+&cpu0_opp_table {
+	opp-1104000000 {
+		opp-hz = /bits/ 64 <1104000000>;
+		opp-microvolt = <1320000>;
+		clock-latency-ns = <244144>; /* 8 32k periods */
+	};
+
+	opp-1200000000 {
+		opp-hz = /bits/ 64 <1200000000>;
+		opp-microvolt = <1320000>;
+		clock-latency-ns = <244144>; /* 8 32k periods */
+	};
+};
+
+&dai {
+	status = "okay";
+};
+
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pg_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	broken-cd;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&r_rsb {
+	status = "okay";
+
+	axp22x: pmic@3a3 {
+		compatible = "x-powers,axp223";
+		reg = <0x3a3>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
+	};
+};
+
+#include "axp223.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-io";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vdd-dll";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_dc1sw {
+	regulator-name = "vcc-lcd";
+};
+
+&reg_dc5ldo {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-3v0";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_dldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3-main1";
+};
+
+&reg_dldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3-main2";
+};
+
+&reg_dldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3-main3";
+};
+
+&reg_dldo4 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3-main4";
+};
+
+&reg_eldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vcc-1v2-hdmi";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
+&reg_rtc_ldo {
+	regulator-name = "vcc-rtc";
+};
+
+&sound {
+	status = "okay";
+	simple-audio-card,routing =
+		"Left DAC", "AIF1 Slot 0 Left",
+		"Right DAC", "AIF1 Slot 0 Right";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_vbus-supply = <&reg_vcc5v0>;
+	status = "okay";
+};
-- 
2.25.1

