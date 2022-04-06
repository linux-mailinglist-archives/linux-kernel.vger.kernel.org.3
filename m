Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217994F6EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiDFXj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbiDFXjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:39:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615EF1FD55A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:37:24 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h5so2546280pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xrGEseTnOXDcnInp7rslAcipRSkuafy8vIlxmx/yJcU=;
        b=HcgEsBp04qCCkMBHxRxOS+f0hIdsP2aK5TZwDBI7d7E2DdWajYMb9TLh2NSLG8SOTH
         zXmvMXYWf7bEIKnHJohA6yqCfsI4mLrHUfY+4Qdfhh23DnY9fcIVS7DBGz1NDnL71Z0m
         o6rPSWC43kQs0YAEVga03WLzlg0Aw+x6PNEgjNh5JZ8WITbZIQCzTnHhLjdnAjvmNKft
         DgFdJSGHC8ZvlL7bAvwhypP/dMAIy4Vxll57nKEFPFirOont78WOxBfV1z8Kx/n0Fvvh
         GTtkOMEJQMXspTyKwWYzPXzQAlKGxfMhUmvSoMkgj48mBm5XuCzYrspXOxwxUjh3D63f
         U89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xrGEseTnOXDcnInp7rslAcipRSkuafy8vIlxmx/yJcU=;
        b=7UnFdKrPUXb23EDXt+0QTbi7slGITaXdkPqUJHcst7uL/XujEuXFiuiW44c0GV/jox
         1x5olt2X1UYQQJTuoDwA/5l6DE1WQo4rQUKLLm5gt5BA9jjBPRNsiCGrQ0r2KGFgCnJJ
         GSwlubnFkGkUdDiGM6JBhBQSu9LGTXFMuWrxOh6e/ukLk8AdHa0rYP+TRqywtxPV3etc
         rIoYHPC0ETqFtb+UCkH2gsFX2nKR6MgNpmzbs0Bi62T9ighUN/IZ24bNYbZCXKOUMlbW
         IvZhhuV+L7T2cnvVhoXDH8k4E/SrvEPcemvzSGfy9aOUUo00lJhT6hMNQu+c95XDxNZn
         y9TQ==
X-Gm-Message-State: AOAM533wgfQ0ll0OoRd5m5kGHwQA6kAtidDjDnTLrqAs53yJAh0ip+25
        svvJjbEJpBD1XEKbXFiu31hQOg==
X-Google-Smtp-Source: ABdhPJzpy5tTVO/wbXcozmIXXbEI911CpYygGjCgdbrfTSuag/66aqmNZIO0YgMlghdNPQOX6MESrA==
X-Received: by 2002:a63:2b84:0:b0:398:2527:df55 with SMTP id r126-20020a632b84000000b003982527df55mr9065640pgr.281.1649288243871;
        Wed, 06 Apr 2022 16:37:23 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:37:23 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] arm64: dts: Add Pensando Elba SoC support
Date:   Wed,  6 Apr 2022 16:36:48 -0700
Message-Id: <20220406233648.21644-12-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406233648.21644-1-brad@pensando.io>
References: <20220406233648.21644-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Pensando common and Elba SoC specific device nodes

Signed-off-by: Brad Larson <brad@pensando.io>
---
Change from V3:
- Changed to dual copyright (GPL-2.0+ OR MIT)
- Minor changes from review input

 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/pensando/Makefile         |   3 +
 arch/arm64/boot/dts/pensando/elba-16core.dtsi | 189 ++++++++++++++++++
 .../boot/dts/pensando/elba-asic-common.dtsi   |  98 +++++++++
 arch/arm64/boot/dts/pensando/elba-asic.dts    |  28 +++
 .../boot/dts/pensando/elba-flash-parts.dtsi   | 106 ++++++++++
 arch/arm64/boot/dts/pensando/elba.dtsi        | 189 ++++++++++++++++++
 7 files changed, 614 insertions(+)
 create mode 100644 arch/arm64/boot/dts/pensando/Makefile
 create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
 create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 1ba04e31a438..cb697f9be2a4 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -20,6 +20,7 @@ subdir-y += marvell
 subdir-y += mediatek
 subdir-y += microchip
 subdir-y += nvidia
+subdir-y += pensando
 subdir-y += qcom
 subdir-y += realtek
 subdir-y += renesas
diff --git a/arch/arm64/boot/dts/pensando/Makefile b/arch/arm64/boot/dts/pensando/Makefile
new file mode 100644
index 000000000000..3d34b8a28a3f
--- /dev/null
+++ b/arch/arm64/boot/dts/pensando/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+dtb-$(CONFIG_ARCH_PENSANDO) += elba-asic.dtb
diff --git a/arch/arm64/boot/dts/pensando/elba-16core.dtsi b/arch/arm64/boot/dts/pensando/elba-16core.dtsi
new file mode 100644
index 000000000000..9de602cdeb8b
--- /dev/null
+++ b/arch/arm64/boot/dts/pensando/elba-16core.dtsi
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020-2022 Pensando Systems Inc.
+ */
+
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 { cpu = <&cpu0>; };
+				core1 { cpu = <&cpu1>; };
+				core2 { cpu = <&cpu2>; };
+				core3 { cpu = <&cpu3>; };
+			};
+
+			cluster1 {
+				core0 { cpu = <&cpu4>; };
+				core1 { cpu = <&cpu5>; };
+				core2 { cpu = <&cpu6>; };
+				core3 { cpu = <&cpu7>; };
+			};
+
+			cluster2 {
+				core0 { cpu = <&cpu8>; };
+				core1 { cpu = <&cpu9>; };
+				core2 { cpu = <&cpu10>; };
+				core3 { cpu = <&cpu11>; };
+			};
+
+			cluster3 {
+				core0 { cpu = <&cpu12>; };
+				core1 { cpu = <&cpu13>; };
+				core2 { cpu = <&cpu14>; };
+				core3 { cpu = <&cpu15>; };
+			};
+		};
+
+		/* CLUSTER 0 */
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x0>;
+			next-level-cache = <&l2_0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x1>;
+			next-level-cache = <&l2_0>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x2>;
+			next-level-cache = <&l2_0>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x3>;
+			next-level-cache = <&l2_0>;
+			enable-method = "psci";
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+		};
+
+		/* CLUSTER 1 */
+		cpu4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x100>;
+			next-level-cache = <&l2_1>;
+			enable-method = "psci";
+		};
+
+		cpu5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x101>;
+			next-level-cache = <&l2_1>;
+			enable-method = "psci";
+		};
+
+		cpu6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x102>;
+			next-level-cache = <&l2_1>;
+			enable-method = "psci";
+		};
+
+		cpu7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x103>;
+			next-level-cache = <&l2_1>;
+			enable-method = "psci";
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+		};
+
+		/* CLUSTER 2 */
+		cpu8: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x200>;
+			next-level-cache = <&l2_2>;
+			enable-method = "psci";
+		};
+
+		cpu9: cpu@201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x201>;
+			next-level-cache = <&l2_2>;
+			enable-method = "psci";
+		};
+
+		cpu10: cpu@202 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x202>;
+			next-level-cache = <&l2_2>;
+			enable-method = "psci";
+		};
+
+		cpu11: cpu@203 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x203>;
+			next-level-cache = <&l2_2>;
+			enable-method = "psci";
+		};
+
+		l2_2: l2-cache2 {
+			compatible = "cache";
+		};
+
+		/* CLUSTER 3 */
+		cpu12: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x300>;
+			next-level-cache = <&l2_3>;
+			enable-method = "psci";
+		};
+
+		cpu13: cpu@301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x301>;
+			next-level-cache = <&l2_3>;
+			enable-method = "psci";
+		};
+
+		cpu14: cpu@302 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x302>;
+			next-level-cache = <&l2_3>;
+			enable-method = "psci";
+		};
+
+		cpu15: cpu@303 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0 0x303>;
+			next-level-cache = <&l2_3>;
+			enable-method = "psci";
+		};
+
+		l2_3: l2-cache3 {
+			compatible = "cache";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
new file mode 100644
index 000000000000..7a89df68fdf7
--- /dev/null
+++ b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020-2022, Pensando Systems Inc.
+ */
+
+&ahb_clk {
+	clock-frequency = <400000000>;
+};
+
+&emmc_clk {
+	clock-frequency = <200000000>;
+};
+
+&flash_clk {
+	clock-frequency = <400000000>;
+};
+
+&ref_clk {
+	clock-frequency = <156250000>;
+};
+
+&qspi {
+	status = "okay";
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+		spi-rx-bus-width = <2>;
+		m25p,fast-read;
+		cdns,read-delay = <0>;
+		cdns,tshsl-ns = <0>;
+		cdns,tsd2d-ns = <0>;
+		cdns,tchsh-ns = <0>;
+		cdns,tslch-ns = <0>;
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&emmc {
+	bus-width = <8>;
+	status = "okay";
+};
+
+&wdt0 {
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	status = "okay";
+	rtc@51 {
+		compatible = "nxp,pcf85263";
+		reg = <0x51>;
+	};
+};
+
+&spi0 {
+	num-cs = <4>;
+	cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
+		   <&porta 7 GPIO_ACTIVE_LOW>;
+	status = "okay";
+	spi0_cs0@0 {
+		compatible = "semtech,sx1301";	/* Enable spidev */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <12000000>;
+		reg = <0>;
+	};
+
+	spi0_cs1@1 {
+		compatible = "semtech,sx1301";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <12000000>;
+		reg = <1>;
+	};
+
+	spi0_cs2@2 {
+		compatible = "semtech,sx1301";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <12000000>;
+		reg = <2>;
+		interrupt-parent = <&porta>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	spi0_cs3@3 {
+		compatible = "semtech,sx1301";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <12000000>;
+		reg = <3>;
+	};
+};
diff --git a/arch/arm64/boot/dts/pensando/elba-asic.dts b/arch/arm64/boot/dts/pensando/elba-asic.dts
new file mode 100644
index 000000000000..01251143dd5e
--- /dev/null
+++ b/arch/arm64/boot/dts/pensando/elba-asic.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Pensando Elba Board.
+ *
+ * Copyright (c) 2020-2022 Pensando Systems Inc.
+ */
+
+/dts-v1/;
+
+#include "elba.dtsi"
+#include "elba-16core.dtsi"
+#include "elba-asic-common.dtsi"
+#include "elba-flash-parts.dtsi"
+
+/ {
+	model = "Pensando Elba Board";
+	compatible = "pensando,elba-ortano", "pensando,elba";
+
+	aliases {
+		serial0 = &uart0;
+		spi0 = &spi0;
+		spi1 = &qspi;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
diff --git a/arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi b/arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
new file mode 100644
index 000000000000..4b2e54d97494
--- /dev/null
+++ b/arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020-2022 Pensando Systems Inc.
+ */
+
+&flash0 {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "flash";
+			reg = <0x10000 0xfff0000>;
+		};
+
+		partition@f0000 {
+			label = "golduenv";
+			reg = <0xf0000 0x10000>;
+		};
+
+		partition@100000 {
+			label = "boot0";
+			reg = <0x100000 0x80000>;
+		};
+
+		partition@180000 {
+			label = "golduboot";
+			reg = <0x180000 0x200000>;
+		};
+
+		partition@380000 {
+			label = "brdcfg0";
+			reg = <0x380000 0x10000>;
+		};
+
+		partition@390000 {
+			label = "brdcfg1";
+			reg = <0x390000 0x10000>;
+		};
+
+		partition@400000 {
+			label = "goldfw";
+			reg = <0x400000 0x3c00000>;
+		};
+
+		partition@4010000 {
+			label = "fwmap";
+			reg = <0x4010000 0x20000>;
+		};
+
+		partition@4030000 {
+			label = "fwsel";
+			reg = <0x4030000 0x20000>;
+		};
+
+		partition@4090000 {
+			label = "bootlog";
+			reg = <0x4090000 0x20000>;
+		};
+
+		partition@40b0000 {
+			label = "panicbuf";
+			reg = <0x40b0000 0x20000>;
+		};
+
+		partition@40d0000 {
+			label = "uservars";
+			reg = <0x40d0000 0x20000>;
+		};
+
+		partition@4200000 {
+			label = "uboota";
+			reg = <0x4200000 0x400000>;
+		};
+
+		partition@4600000 {
+			label = "ubootb";
+			reg = <0x4600000 0x400000>;
+		};
+
+		partition@4a00000 {
+			label = "mainfwa";
+			reg = <0x4a00000 0x1000000>;
+		};
+
+		partition@5a00000 {
+			label = "mainfwb";
+			reg = <0x5a00000 0x1000000>;
+		};
+
+		partition@6a00000 {
+			label = "diaguboot";
+			reg = <0x6a00000 0x400000>;
+		};
+
+		partition@8000000 {
+			label = "diagfw";
+			reg = <0x8000000 0x7fe0000>;
+		};
+
+		partition@ffe0000 {
+			label = "ubootenv";
+			reg = <0xffe0000 0x10000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/pensando/elba.dtsi b/arch/arm64/boot/dts/pensando/elba.dtsi
new file mode 100644
index 000000000000..10e06eb8cda6
--- /dev/null
+++ b/arch/arm64/boot/dts/pensando/elba.dtsi
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020-2022, Pensando Systems Inc.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include "dt-bindings/interrupt-controller/arm-gic.h"
+
+/ {
+	model = "Elba ASIC Board";
+	compatible = "pensando,elba";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	dma-coherent;
+
+	ahb_clk: oscillator0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	emmc_clk: oscillator2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	flash_clk: oscillator3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	ref_clk: oscillator4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a72-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		i2c0: i2c@400 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x400 0x0 0x100>;
+			clocks = <&ahb_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-sda-hold-time-ns = <480>;
+			snps,sda-timeout-ms = <750>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		wdt0: watchdog@1400 {
+			compatible = "snps,dw-wdt";
+			reg = <0x0 0x1400 0x0 0x100>;
+			clocks = <&ahb_clk>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		qspi: spi@2400 {
+			compatible = "pensando,elba-qspi", "cdns,qspi-nor";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2400 0x0 0x400>,
+			      <0x0 0x7fff0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&flash_clk>;
+			cdns,fifo-depth = <1024>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x7fff0000>;
+			status = "disabled";
+		};
+
+		spi0: spi@2800 {
+			compatible = "pensando,elba-spi";
+			reg = <0x0 0x2800 0x0 0x100>;
+			pensando,syscon-spics = <&mssoc 0x2468>;
+			clocks = <&ahb_clk>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			num-cs = <2>;
+			status = "disabled";
+		};
+
+		gpio0: gpio@4000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x4000 0x0 0x78>;
+			status = "disabled";
+
+			porta: gpio-port@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <8>;
+				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				interrupt-parent = <&gic>;
+				#interrupt-cells = <2>;
+			};
+
+			portb: gpio-port@1 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <1>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <8>;
+			};
+		};
+
+		uart0: serial@4800 {
+			compatible = "ns16550a";
+			reg = <0x0 0x4800 0x0 0x100>;
+			clocks = <&ref_clk>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		gic: interrupt-controller@800000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			interrupt-controller;
+			reg = <0x0 0x800000 0x0 0x200000>,	/* GICD */
+			      <0x0 0xa00000 0x0 0x200000>;	/* GICR */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+			/*
+			 * Elba specific pre-ITS is enabled using the
+			 * existing property socionext,synquacer-pre-its
+			 */
+			gic_its: msi-controller@820000 {
+				compatible = "arm,gic-v3-its";
+				msi-controller;
+				#msi-cells = <1>;
+				reg = <0x0 0x820000 0x0 0x10000>;
+				socionext,synquacer-pre-its =
+							<0xc00000 0x1000000>;
+			};
+		};
+
+		emmc: mmc@30440000 {
+			compatible = "pensando,elba-sd4hc", "cdns,sd4hc";
+			clocks = <&emmc_clk>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x0 0x30440000 0x0 0x10000>,
+			      <0x0 0x30480044 0x0 0x4>;	/* byte-lane ctrl */
+			cdns,phy-input-delay-sd-highspeed = <0x4>;
+			cdns,phy-input-delay-legacy = <0x4>;
+			cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
+			cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;
+			mmc-ddr-1_8v;
+			status = "disabled";
+		};
+
+		mssoc: mssoc@307c0000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0x307c0000 0x0 0x3000>;
+		};
+	};
+};
-- 
2.17.1

