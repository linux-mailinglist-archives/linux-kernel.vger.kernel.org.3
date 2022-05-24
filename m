Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FC1532794
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiEXKaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiEXKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:30:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B51572D;
        Tue, 24 May 2022 03:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653388201; x=1684924201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=//tcfOjIW5GrEj5HxcU69G9pls360uowxDRN8oikEwQ=;
  b=ZgQc+dqCunniSYOQbYxQPRWB1XZkglC0AwtcoWPmPwzd/LjKY2iPKDTr
   3EglcgItflUbjR1Sbqwf1fc3N7iCudvlwGK0spRCkFiaf2tGOtfIQrdiV
   RQazzNva8NOwnoNDFyDcUxRsYPD5cJyWOQvKIDnrkI+l5baroprXZw2Iv
   PolcqTqfougNosOwTh9LcdKrtKCMRaCR4DleLpszo9WbrV0wAhyHJzPa9
   5Acrm1CvRuZrwYW9ab+VhZe/aIv7yNNwAfqFyba9PeCKv8G89yvigLv6n
   OxPHbHZl5Xcx6DmvqSsiE/Pkfo71uZQngzynSgHomj923htTaUKxqEKwz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="261099226"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="261099226"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 03:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="559069395"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2022 03:29:58 -0700
From:   wen.ping.teh@intel.com
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Teh Wen Ping <wen.ping.teh@intel.com>,
        Yves Vandervennet <yvanderv@opensource.altera.com>,
        Dinh Nguyen <dinguyen@opensource.altera.com>
Subject: [PATCH] arm64: dts: Add support for Stratix 10 Software Virtual Platform
Date:   Tue, 24 May 2022 18:29:12 +0800
Message-Id: <20220524102912.792968-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teh Wen Ping <wen.ping.teh@intel.com>

Add Stratix 10 Software Virtual Platform device tree

Signed-off-by: Yves Vandervennet <yvanderv@opensource.altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
---
 arch/arm64/Kconfig.platforms                  |   3 +-
 arch/arm64/boot/dts/altera/Makefile           |   3 +-
 .../dts/altera/socfpga_stratix10_swvp.dts     | 131 ++++++++++++++++++
 3 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index de9a18d3026f..48abe5dafaae 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -249,7 +249,8 @@ config ARCH_INTEL_SOCFPGA
 	bool "Intel's SoCFPGA ARMv8 Families"
 	help
 	  This enables support for Intel's SoCFPGA ARMv8 families:
-	  Stratix 10 (ex. Altera), Agilex and eASIC N5X.
+	  Stratix 10 (ex. Altera), Stratix10 Software Virtual Platform,
+	  Agilex and eASIC N5X.
 
 config ARCH_SYNQUACER
 	bool "Socionext SynQuacer SoC Family"
diff --git a/arch/arm64/boot/dts/altera/Makefile b/arch/arm64/boot/dts/altera/Makefile
index 4db83fbeb115..1bf0c472f6b4 100644
--- a/arch/arm64/boot/dts/altera/Makefile
+++ b/arch/arm64/boot/dts/altera/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_stratix10_socdk.dtb \
-				socfpga_stratix10_socdk_nand.dtb
+				socfpga_stratix10_socdk_nand.dtb \
+				socfpga_stratix10_swvp.dtb
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
new file mode 100644
index 000000000000..209e26d3611b
--- /dev/null
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2022, Intel Corporation
+ */
+
+#include "socfpga_stratix10.dtsi"
+
+/ {
+	model = "SOCFPGA Stratix 10 SWVP";
+	compatible = "arm,foundation-aarch64", "arm,vexpress";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+
+		timer0 = &timer0;
+		timer1 = &timer1;
+		timer2 = &timer2;
+		timer3 = &timer3;
+
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		bootargs = "rdinit=/sbin/init ip=dhcp mem=2048M";
+		stdout-path = "serial1:115200n8";
+		linux,initrd-start = <0x10000000>;
+		linux,initrd-end = <0x125c8324>;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+
+		l2-cache@fffff000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xfffff000 0x1000>;
+			interrupts = <0x0 0x12 0x4>;
+			cache-unified;
+			cache-level = <0x2>;
+			linux,phandle = <0x1>;
+		};
+	};
+};
+
+&cpu0 {
+	enable-method = "spin-table";
+	cpu-release-addr = <0x0 0x0000fff8>;
+};
+
+&cpu1 {
+	enable-method = "spin-table";
+	cpu-release-addr = <0x0 0x0000fff8>;
+};
+
+&cpu2 {
+	enable-method = "spin-table";
+	cpu-release-addr = <0x0 0x0000fff8>;
+};
+
+&cpu3 {
+	enable-method = "spin-table";
+	cpu-release-addr = <0x0 0x0000fff8>;
+};
+
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-addr = <0xffffffff>;
+	snps,max-mtu = <0x0>;
+};
+
+&gmac1 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-addr = <0xffffffff>;
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-addr = <0xffffffff>;
+};
+
+&mmc {
+	status = "okay";
+	altr,dw-mshc-ciu-div = <0x3>;
+	altr,dw-mshc-sdr-timing = <0x0 0x3>;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	broken-cd;
+	bus-width = <4>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	clocks = <&clkmgr STRATIX10_L4_MP_CLK>;
+	status = "okay";
+};
+
+&usb1 {
+	clocks = <&clkmgr STRATIX10_L4_MP_CLK>;
+	status = "okay";
+};
+
+&rst {
+	altr,modrst-offset = <0x20>;
+};
+
+&sysmgr {
+	reg = <0xffd12000 0x1000>;
+	interrupts = <0x0 0x10 0x4>;
+	cpu1-start-addr = <0xffd06230>;
+};
-- 
2.25.1

