Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A428759B73F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 03:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiHVBZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 21:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiHVBZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:25:13 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208AC21246;
        Sun, 21 Aug 2022 18:25:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D11BC5C00F5;
        Sun, 21 Aug 2022 21:25:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 21 Aug 2022 21:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661131509; x=1661217909; bh=rzxIyhFORE
        NkrPFAdRyGQV6vkZxGejvsrHsgPyetd7s=; b=i4tpTtxwgYELHapf5fcKONURns
        j0iw70P53RoM79Hdjn5NWcVTt8lf+yjRHpMzQG4k6k8QUxOZ74+wyPhnvPmLx4Jc
        E8p8rnRJmUo5vDdEOyPugk8iAniCVngrOOM315Ig2OQOOn1BLs+V+TeuOnbgWL1b
        iPIYM+/u7AOWKYNeaIYCPjEiWMYm5LGlMT6xFcN0lyWJpWvGhC6qLxFtD9wChHIV
        jg/nb6ILZFhW0MtPSb11qrvdxXwEILHwC9YdYpQMgYNTKFT7egRvItfjKkX6aNE3
        EjVLkS9nbmcLYMLSMg0Y64ABj0+1Xv3fVYtLVxEwDMPnn4xydTtSacXpv+gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661131509; x=
        1661217909; bh=rzxIyhFORENkrPFAdRyGQV6vkZxGejvsrHsgPyetd7s=; b=d
        s4UqFr/jrkY+ww2pwpRNlVJEtF+11klzlVBTxSo4HcJKJjWX19RdhIsjEg+L5E9o
        O9Y8DCZPRrPVrIcklId1g7X7y54UAI1OAy0dnhBKoLZSoXx8iY1pqJ68j8CU0h4A
        b3tufA8dIHAG1yQQz6AhDTiDBLw2tCQIn46z7oxeyma/q+tbsYThw1u5Zeq7Bxph
        mJaWt6kjhSvX6oU2yXWTy/4eYIim0EnDXp2Ig/YfOKTu6u3ort/3XY++22khyKuC
        junmimpHNwXK3wTGTvtCI+ns/AKSLyKb3UleUv6zvZu4qgTGZTGnxXtvhSWm4QsM
        pN8aq42zxf/vpMoCERxdw==
X-ME-Sender: <xms:9doCY0_80xnoLUdzUYuQepsrHLVgo4jvk1Iw1ouPmDeqpbntPUy9JA>
    <xme:9doCY8uDu9bG1BtvqgX7WGAVAZjtF9I5uFuJVxgvlVkdMwCKPGmoFp9qnNBlyDcTm
    yAAq1RNLsFWpfnXtw>
X-ME-Received: <xmr:9doCY6DXw2Z1nvyAIjVq_ebJ8RoEztXDQKaWryuFRSM39uS_5zzZaaRkDA64Es33XLGZTQKCD5rUYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvohhm
    ucfhihhtiihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
    eqnecuggftrfgrthhtvghrnhepgfekheduieefgeekkeeuleehgefgvefhgfejfeefteei
    udeigeduudfgiefgueeunecuffhomhgrihhnpehpihhnvgeigedrohhrghdpghhithhlrg
    gsrdgtohhmpdhmvghgohhushdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruh
    hk
X-ME-Proxy: <xmx:9doCY0f7f4H-Zlhrrr9FUbAagI3Nyt1vvpAVrCS0fJlTLRH889Z9Zg>
    <xmx:9doCY5OL95JrLPWip5fLbcF14iZXZfuV6ohTyyb1v-tLr-ZgypiXEA>
    <xmx:9doCY-kbN6Gbr-W1kuM8KdWaaCMPMEatnu8yFGv__1QaCu8QYJ3c4w>
    <xmx:9doCY2cvNB8O65Bqw6C0daHBurHoh3WMnznVfPQPe5VlaIyChEfjIQ>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Aug 2022 21:25:08 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Martijn Braam <martijn@brixit.nl>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Ondrej Jirman <megi@xff.cz>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Caleb Connolly <kc@postmarketos.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <n@nfraprado.net>
Subject: [PATCH v4 1/1] arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro
Date:   Mon, 22 Aug 2022 11:24:49 +1000
Message-Id: <20220822012449.21005-2-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822012449.21005-1-tom@tom-fitzhenry.me.uk>
References: <20220822012449.21005-1-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martijn Braam <martijn@brixit.nl>

This is a basic DT containing regulators and UART, intended to be a
base that myself and others can add additional nodes in future patches.

Tested to work: booting from eMMC/SD, output over UART.

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
Reviewed-by: Caleb Connolly <kc@postmarketos.org>
Reviewed-by: Nícolas F. R. A. Prado <n@nfraprado.net>
Tested-by: Nícolas F. R. A. Prado <n@nfraprado.net>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 422 ++++++++++++++++++
 2 files changed, 423 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ef79a672804a..cb42e0a15808 100644
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
index 000000000000..f0be897d4e84
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Martijn Braam <martijn@brixit.nl>
+ * Copyright (c) 2021 Kamil Trzciński <ayufan@ayufan.eu>
+ */
+
+/*
+ * PinePhone Pro datasheet:
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
+		key-power {
+			debounce-interval = <20>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+			label = "Power";
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
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
+		vin-supply = <&vcc_sys>;
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
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+
+		regulators {
+			vdd_cpu_l: DCDC_REG1 {
+				regulator-name = "vdd_cpu_l";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <875000>;
+				regulator-max-microvolt = <975000>;
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
+			vcc_1v8: DCDC_REG4 {
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
+			rk818_pwr_on: LDO_REG4 {
+				regulator-name = "rk818_pwr_on";
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
+		regulator-min-microvolt = <875000>;
+		regulator-max-microvolt = <1150000>;
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
+		regulator-min-microvolt = <875000>;
+		regulator-max-microvolt = <975000>;
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
+		opp-hz = /bits/ 64 <1500000000>;
+		opp-microvolt = <1100000 1100000 1150000>;
+	};
+
+	opp07 {
+		status = "disabled";
+	};
+};
+
+&gpu_opp_table {
+	opp00 {
+		opp-hz = /bits/ 64 <200000000>;
+		opp-microvolt = <825000 825000 975000>;
+	};
+	opp01 {
+		opp-hz = /bits/ 64 <297000000>;
+		opp-microvolt = <825000 825000 975000>;
+	};
+	opp02 {
+		opp-hz = /bits/ 64 <400000000>;
+		opp-microvolt = <825000 825000 975000>;
+	};
+	opp03 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <875000 875000 975000>;
+	};
+	opp04 {
+		opp-hz = /bits/ 64 <600000000>;
+		opp-microvolt = <925000 925000 975000>;
+	};
+	opp05 {
+		status = "disabled";
+	};
+};
+
+
+&io_domains {
+	bt656-supply = <&vcc1v8_dvp>;
+	audio-supply = <&vcca1v8_codec>;
+	sdmmc-supply = <&vccio_sd>;
+	gpio1830-supply = <&vcc_3v0>;
+	status = "okay";
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

