Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B64658B2E4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241933AbiHEXpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241927AbiHEXpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:45:00 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B57D1D3;
        Fri,  5 Aug 2022 16:44:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9187F5C012B;
        Fri,  5 Aug 2022 19:44:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 Aug 2022 19:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659743096; x=1659829496; bh=3IVRSRyrB7
        FPlfE92spwjV+FSWz7caxHpzOC2ctJV88=; b=TFNkZSBtoPzd/pL+udxn5LR9QZ
        Dy9W1AkCBJUtOYYmeYin0V2uoTHQIjnHFMdL1B8cPvyI5JhGy/QXSigU6tAs5rFM
        TGAXNfKK+kxrdMo41UuIAnKz9ir+ht1P896hcNdfuKM+aWweJ8R75iAjxVP3XEao
        BlijwuFhLdAAWcH9jvdoC0J1m5bIvc52LiE5LyCN8fQGWO1XZMtcg/Z02bfEjfCp
        J1aaO8ywCnfAKqjh6c2Tc4bJlj8bs7fFWqQ0lWdTRfQBK8FzEYVZhKTteIiA7TsA
        MJpwlNLjyVowYbmCpyW4rLm0ckEsknd7R95MmRbU+rbHdZ6x+BFHy1WZ7WvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659743096; x=
        1659829496; bh=3IVRSRyrB7FPlfE92spwjV+FSWz7caxHpzOC2ctJV88=; b=c
        CU9t2eB+hVltuv1TcfbqxlPuf7Fc1IknDX5xibTNsrrOkqyQrMPX0s7vgnnBkV6i
        u/UaTFvVQKF8/XtqB0iBboq8a6Fe8CK16zEht0Ea836azRTRDfUfLjucpLcYh9Dh
        C/UR5av473jWmykQedimbNfmx3CtQbEkfLlTkkt7+1yrWQLDjVtDOqJNFMBQGlXu
        Yilfr4FoJPX+M2hUwSukTAJdlWglaLlGeDgRkTE51M30RqW6idY3dKztwSn6SaEb
        8kIeJO/oViekigNJ2P45oZ6IDHbh3hKDqgj9GHgiwa+ArzwH4N30VYzrdJQ26PaL
        UyNLbdl/DQwgljSVZBKpw==
X-ME-Sender: <xms:eKvtYtfrWqQIpL5NXB1PHkiG25apHt4wVKsoFntTZwdGdw7-vKeogA>
    <xme:eKvtYrOww84EFWT_cluj1No1LjH90F94m0z28DaqU62Rhft1o7Xh62bk6bI3QHOhI
    K5lvL6VDc3V8Gp8pg>
X-ME-Received: <xmr:eKvtYmhmd_AA-3rgokBhXFtW0IFRwB9XTp67i2s6hZg-sOU1TNGJuTAhju4ecGxyZvYYqASPktFp02KpA4nmjMJNxVzueS58cW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefvddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepvfhomhcuhfhithiihhgvnhhrhicuoehtohhmsehtohhm
    qdhfihhtiihhvghnrhihrdhmvgdruhhkqeenucggtffrrghtthgvrhhnpeekhfekkeduie
    dthefggeehkeeiuedvjedthfevhfejkeegteegffdttdetvdeigfenucffohhmrghinhep
    ghhithhlrggsrdgtohhmpdhmvghgohhushdrtghomhdpphhinhgvieegrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhomhesthho
    mhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:eKvtYm92m4XoEslRBvx4cZp-8mDBGJ3I4mVPK_MC3GzyF5ERovpfRw>
    <xmx:eKvtYpvrMDw9uNRkB7arKlbOKoVmJ8MBXyI9Z6BHdHMltxs-RIc_cA>
    <xmx:eKvtYlEvTLLWTPGS9iJJbD4KnFCdKpGEUU1XmKFFIc-wdFp-kpDNfQ>
    <xmx:eKvtYqOj71wYPwMLqDt4ymFOhgZ1Hq1ZLxGqTyhjFB1TsjCfytALuw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 19:44:52 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     tom@tom-fitzhenry.me.uk, megi@xff.cz, martijn@brixit.nl,
        ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro
Date:   Sat,  6 Aug 2022 09:44:11 +1000
Message-Id: <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
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

This is a basic DT containing regulators and UART, intended to be a
base that myself and others can add additional nodes in future patches.

Tested to work: booting from eMMC, output over UART.

This is derived from a combination of https://gitlab.com/pine64-org/linux
and https://megous.com/git/linux.

https://wiki.pine64.org/wiki/PinePhone_Pro

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Martijn Braam <martijn@brixit.nl>
Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 385 ++++++++++++++++++
 2 files changed, 386 insertions(+)
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
index 0000000000000..f5608487ad58f
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Martijn Braam <martijn@brixit.nl>
+ * Copyright (c) 2021 Kamil Trzciński <ayufan@ayufan.eu>
+ */
+
+// PinePhone Pro datasheet: https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
+
+/dts-v1/;
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include "rk3399.dtsi"
+#include "rk3399-t-opp.dtsi"
+
+/ {
+	model = "Pine64 PinePhonePro";
+	compatible = "pine64,pinephone-pro", "rockchip,rk3399";
+	chassis-type = "handset";
+
+	aliases {
+                mmc0 = &sdio0;
+                mmc1 = &sdmmc;
+                mmc2 = &sdhci;
+        };
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	gpio-key-power {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwrbtn_pin>;
+
+		power {
+			debounce-interval = <20>;
+			// Per "PMU Controler", page 4.
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+			label = "Power";
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	/* Power tree */
+	/* Root power source */
+	vcc_sysin: vcc-sysin {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sysin";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* Main 3.3v supply */
+	vcc3v3_sys: wifi_bat: vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sysin>;
+	};
+
+	vcca1v8_s3: vcc1v8-s3 {
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
+	// Per "SCL clock frequency", page 30, RK818 datasheet.
+	clock-frequency = <400000>;
+	i2c-scl-rising-time-ns = <168>;
+	i2c-scl-falling-time-ns = <4>;
+	status = "okay";
+
+	// Per "PMIC RK818-3", page 13.
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
+			// Audio codec.
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
+			// Touch screen.
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
+&io_domains {
+        status = "okay";
+
+        bt656-supply = <&vcc1v8_dvp>;
+        audio-supply = <&vcca1v8_codec>;
+        sdmmc-supply = <&vccio_sd>;
+        gpio1830-supply = <&vcc_3v0>;
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
+// Per "SDMMC Controler", page 6.
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
+// Enable thermal sensors.
+&tsadc {
+	/* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-mode = <1>;
+	/* tshut polarity 0:LOW 1:HIGH */
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
2.37.1

