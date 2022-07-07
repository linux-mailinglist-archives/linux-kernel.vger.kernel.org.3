Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F923569EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiGGJkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiGGJkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:40:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511813FA7;
        Thu,  7 Jul 2022 02:40:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d16so19155569wrv.10;
        Thu, 07 Jul 2022 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OUVPcq4q3E4bhVRZ+lHAS4gY3QFj2Ligmd2Amh/NpBM=;
        b=cgcPPB2i6sWifOs6kPfLkJDu6QyNBgvnYiAW+eD3N7VX9ur4tjhvpsY2jeYTx9kbl5
         0OOea+sl6H45lrQu3944DtOZgS3MIaqdbPo7xg8loq10oFF/3cNiApRxvKUSQ2mcBaZ8
         mngsc/FQomfaMPav2kxUBKocvvUwos8tG2r7eU4GTSEncvjVUQyUnQK70J4Q7aJ2yB0P
         qZ8IFhuOYXNFkYuLjq8AXNb8p38UtdzMSiO/HFxKHD1Z9/KNh0RHs4WdV2dahZHeWjLk
         L5w6OmYZob+etg5OMpa+Zc4qf1kO61HZIHPeGrYHRIx2zgKCUKNNovexWSJWRQYXM8Gh
         zVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OUVPcq4q3E4bhVRZ+lHAS4gY3QFj2Ligmd2Amh/NpBM=;
        b=lupHC/uFgwjUiA/YvaSpIXufq8BN/aqZ2fhoJmESgwHC58RL1eZClmpGjuJAGylTxY
         i5oQu7N3CALTkgFOIALgpjA0iqXMvgks9K6dGcfdukFzElVSabfPU4/VaPjxr/sN3FqK
         ipf01l4husEW/BVhg+kgrqcQTzHPxqFZaIivYh00p7s3YsGpWyHZQbxslsOsfZYnRvXd
         8PE8barXglPKhQzn+u+Xtlg8uTxutbxlfbrmwWA4pBkbIKjYdS037tu24l31UJEVfJuA
         LZ/wziQ+O+ICHlHD+w518W+xZ2ZQ2ZVhpGq+EX8U+xFje0S4/364Kb3kdgNu3bMLB6Nn
         Bsiw==
X-Gm-Message-State: AJIora9W7QybbwPmTkX+J1NUCzfAGWbNSc7NB0THCmn5dId1YkcAjx9v
        DNqlk1+b7sRyu79Vnglj5Ec/ZTvuClJMn9Eu
X-Google-Smtp-Source: AGRyM1s6r93NBy8U+IzwmI6xLdJA4hfOwghOpUgOiLfmSmEXkggIy53JffKlIDobnT9i2qxfZrxgLA==
X-Received: by 2002:a5d:4402:0:b0:21d:8093:138c with SMTP id z2-20020a5d4402000000b0021d8093138cmr5079378wrq.535.1657186801740;
        Thu, 07 Jul 2022 02:40:01 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d564e000000b0021d68d3a27dsm13831314wrw.45.2022.07.07.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 02:40:01 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Furkan Kardame <furkan@fkardame.com>
Subject: [PATCH 2/2] arm64: dts: meson: add support for Beelink GT1 Ultimate
Date:   Thu,  7 Jul 2022 09:39:54 +0000
Message-Id: <20220707093954.21716-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707093954.21716-1-christianshewitt@gmail.com>
References: <20220707093954.21716-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Beelink GT1 Ultimate is based on the Amlogic S912 (Q200)
reference design with the following specifications:

- 3GB DDR3 RAM
- 32GB eMMC
- HDMI 2.1 video
- S/PDIF optical output
- 10/100/1000 Ethernet
- AP6356S Wireless (802.11 a/b/g/n, BT 4.2)
- 3x USB 2.0 ports
- IR receiver
- 1x micro SD card slot
- 1x Power LED (white)
- 1x Reset button (internal)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-gxm-gt1-ultimate.dts    | 91 +++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-gt1-ultimate.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 8773211df50e..641399fcbdd9 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-gt1-ultimate.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-mecool-kiii-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-minix-neo-u9h.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-gt1-ultimate.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-gt1-ultimate.dts
new file mode 100644
index 000000000000..2c267884cc16
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-gt1-ultimate.dts
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "azw,gt1-ultimate", "amlogic,s912", "amlogic,meson-gxm";
+	model = "Beelink GT1 Ultimate";
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-white {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			panic-indicator;
+		};
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-function {
+			label = "update";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&external_phy>;
+	amlogic,tx-delay-ns = <2>;
+	phy-mode = "rgmii";
+};
+
+&external_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_15 */
+		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&ir {
+	linux,rc-map-name = "rc-beelink-gs1";
+};
+
+&sd_emmc_a {
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&uart_A {
+	status = "okay";
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

