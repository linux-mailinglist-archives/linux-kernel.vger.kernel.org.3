Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE7592EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbiHOMa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbiHOMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:30:50 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88856402;
        Mon, 15 Aug 2022 05:30:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2C468320094A;
        Mon, 15 Aug 2022 08:30:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 08:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660566644; x=1660653044; bh=cv5+ERoN6T
        Yoti2zJz1zD407RAX8NoikXtca5DAyxCw=; b=cSjplW+EgdoDQfm7y3u+DNjMeA
        0ndj8BgM4s//VYU5kx+fSVWlrTxAHw+9X+Rom1nxreUY7VRu1OnM/NfZl4dzKYL9
        ni0w5IcPYdAIhttxjPYOQPuUT/rPsv7BmyYSnRdepWvB1sS5Y4DtktpLK+gJS/8r
        IWOiwuKMqmwHF68nqkCTT61WIDqF3zK3cLZCQbB5agU7hFgpEteBwDm8kzoGNMKh
        4Cg5htRj5l2eTmzJCt1RwBEbezyyy/Nxw5Gn8Kb6LVBPcV8IV2SXrJYsZNEL20gK
        E2qnmXmSc6lEOoyNtvuAYOucYL8Kh4U7hE9OA3UEUBvCBG0kJLn7R4qb43CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660566644; x=
        1660653044; bh=cv5+ERoN6TYoti2zJz1zD407RAX8NoikXtca5DAyxCw=; b=Q
        PPFX3TmwAeKPOGG3+BI02urDhlp4T9zX0DBlkfpxBiCPMp9xa9iUlKxqnk1Xgqk3
        oudLYsHOdMoYAvXjD9YrWGkonoTzhObMKkPX2k7P1SD8UzgGrzAjqKYOXEpM9w6E
        jkkJgNjMw7o5Mrx0AKo16gfowD/sXT8FPv2wE5jW3+A6BTWwKd5/HJt1+8P0YhD0
        LDV19IEymDoADCoifPUEucKYfZs7Dk/nWfI15zEJtRbHYYLJ/7VZGuw7N6uEPyrf
        Pea5wTf6rveELQv4P0UJELvVpHdyFX3Sqn5nhc0z0Ba60Y2SsE3liMliult6xIjN
        kHL2Jj1TYRnfg9pjLkAvg==
X-ME-Sender: <xms:dDz6YrIxWpfImpfnXIM9aUg3YFV6_dO5CXrzx7gVLOJchfN7bPqyyw>
    <xme:dDz6YvIwG-7p0QNABNyM-rUKXqQVfQbPvm0SnfS9R6umuH6ONcWrVZ_24x-N2Y8Xb
    E1jp6yKTJ164RGjJA>
X-ME-Received: <xmr:dDz6YjubBcIIOm9H8K-exgwPpvH4gmemaC-Jxo3hqKK93Zop8KA9LvM1ZEpWWfW0ki77-iVU8lx9NXyR_QvZrJPeX0vUpgs7NCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepvfhomhcuhfhithiihhgvnhhrhicuoehtohhmsehtohhm
    qdhfihhtiihhvghnrhihrdhmvgdruhhkqeenucggtffrrghtthgvrhhnpefgkeehudeife
    egkeekueelheeggfevhffgjeeffeetieduieeguddugfeigfeuueenucffohhmrghinhep
    phhinhgvieegrdhorhhgpdhgihhtlhgrsgdrtghomhdpmhgvghhouhhsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhomhesthho
    mhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:dDz6YkaGIS9wr13vay1rmiFxFcpSX0jpW5f2dhwmHI1efQXl81c2Yg>
    <xmx:dDz6YibUtOj1DP4wjaWSdl9fQ1prvjUZADiPiP5YtZtLF0A_l-RC-w>
    <xmx:dDz6YoAUh5NFEb08ZVySaGwe1V9EnMCbGLYEB3KiGta_bLvWkPnefw>
    <xmx:dDz6YoyqHi6FoRrRaNB4KrOPMGrJ8ghjRsrLneLfut8_ZX-FQ99tcw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 08:30:40 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        tom@tom-fitzhenry.me.uk, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro
Date:   Mon, 15 Aug 2022 22:30:04 +1000
Message-Id: <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martijn Braam <martijn@brixit.nl>

This is a basic DT containing regulators and UART, intended to be a
base that myself and others can add additional nodes in future patches.

Tested to work: booting from eMMC, output over UART.

https://wiki.pine64.org/wiki/PinePhone_Pro

This is derived from
https://gitlab.com/pine64-org/linux/-/commit/261d3b5f8ac503f97da810986d1d6422430c8531
with fixes from https://megous.com/git/linux.

Signed-off-by: Martijn Braam <martijn@brixit.nl>
Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
[no SoB, but Kamil is happy for this patch to be submitted]
Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 394 ++++++++++++++++++
 2 files changed, 395 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ef79a672804a1..cb42e0a15808e 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-r4s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinephone-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
new file mode 100644
index 0000000000000..f9f1dcd4f6494
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Martijn Braam <martijn@brixit.nl>
+ * Copyright (c) 2021 Kamil Trzciński <ayufan@ayufan.eu>
+ */
+
+/* PinePhone Pro datasheet:
+ * https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/linux-event-codes.h>
+#include "rk3399.dtsi"
+#include "rk3399-opp.dtsi"
+
+/ {
+	model = "Pine64 PinePhonePro";
+	compatible = "pine64,pinephone-pro", "rockchip,rk3399";
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &sdio0;
+		mmc1 = &sdmmc;
+		mmc2 = &sdhci;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwrbtn_pin>;
+
+		power {
+			debounce-interval = <20>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+			label = "Power";
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	vcc_sysin: vcc-sysin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sysin";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc3v3_sys: vcc3v3-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sysin>;
+	};
+
+	vcca1v8_s3: vcc1v8-s3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcca1v8_s3";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_b>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_b>;
+};
+
+&emmc_phy {
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	i2c-scl-rising-time-ns = <168>;
+	i2c-scl-falling-time-ns = <4>;
+	status = "okay";
+
+	rk818: pmic@1c {
+		compatible = "rockchip,rk818";
+		reg = <0x1c>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		clock-output-names = "xin32k", "rk808-clkout2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>;
+		rockchip,system-power-controller;
+		wakeup-source;
+
+		vcc1-supply = <&vcc_sysin>;
+		vcc2-supply = <&vcc_sysin>;
+		vcc3-supply = <&vcc_sysin>;
+		vcc4-supply = <&vcc_sysin>;
+		vcc6-supply = <&vcc_sysin>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc_sysin>;
+		vcc9-supply = <&vcc3v3_sys>;
+
+		regulators {
+			vdd_cpu_l: DCDC_REG1 {
+				regulator-name = "vdd_cpu_l";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_center: DCDC_REG2 {
+				regulator-name = "vdd_center";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_1v8: vcc_wl: DCDC_REG4 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcca3v0_codec: LDO_REG1 {
+				regulator-name = "vcca3v0_codec";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc3v0_touch: LDO_REG2 {
+				regulator-name = "vcc3v0_touch";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_codec: LDO_REG3 {
+				regulator-name = "vcca1v8_codec";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_power_on: LDO_REG4 {
+				regulator-name = "vcc_power_on";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_3v0: LDO_REG5 {
+				regulator-name = "vcc_3v0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_1v5: LDO_REG6 {
+				regulator-name = "vcc_1v5";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc1v8_dvp: LDO_REG7 {
+				regulator-name = "vcc1v8_dvp";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			vcc3v3_s3: LDO_REG8 {
+				regulator-name = "vcc3v3_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG9 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			vcc3v3_s0: SWITCH_REG {
+				regulator-name = "vcc3v3_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+		};
+	};
+
+	vdd_cpu_b: regulator@40 {
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel1_pin>;
+		regulator-name = "vdd_cpu_b";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_gpu: regulator@41 {
+		compatible = "silergy,syr828";
+		reg = <0x41>;
+		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel2_pin>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&cluster0_opp {
+	opp04 {
+		status = "disabled";
+	};
+
+	opp05 {
+		status = "disabled";
+	};
+};
+
+&cluster1_opp {
+	opp06 {
+		status = "disabled";
+	};
+
+	opp07 {
+		status = "disabled";
+	};
+};
+
+&io_domains {
+	status = "okay";
+
+	bt656-supply = <&vcc1v8_dvp>;
+	audio-supply = <&vcca1v8_codec>;
+	sdmmc-supply = <&vccio_sd>;
+	gpio1830-supply = <&vcc_3v0>;
+};
+
+&pmu_io_domains {
+	pmu1830-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&pinctrl {
+	buttons {
+		pwrbtn_pin: pwrbtn-pin {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		vsel1_pin: vsel1-pin {
+			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		vsel2_pin: vsel2-pin {
+			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	max-frequency = <150000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	vmmc-supply = <&vcc3v3_sys>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
2.37.1

