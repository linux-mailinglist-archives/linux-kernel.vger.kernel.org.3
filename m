Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5DA5441AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiFICzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiFICzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:55:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6441A0AF7;
        Wed,  8 Jun 2022 19:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654743318; x=1686279318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5PYMIT/uUsI3RZRwx4CIFw86+8DJBh3cZNahF5UEA5Y=;
  b=NmPdV5W+GYaeFVUYN+400nJ5IqZBDGhKjHMieUexTCW+AGP4CMpV8Fqc
   wWZ03j1EyR3VjpJqkFJcOQI9kadJ82KggF2wy8CEabec9woZGlaXf/Jmg
   e7QVmJYvuaS86LQx8+snULSFhB7Qr2zUaPf2NNa7yDfhCz32UqyrGybwT
   tyXfIun68JEpwIoOJHqVNcGMa02wA4Rc5776mRxNV+84cEbZQTFZ64tsx
   B9zqfc3sZBMcChE3ELhujKS47aBDfmJDT2u8r05eyMBG7iYBVqWP3lKei
   G2C6/qhCT0PERLV5o6lu7UNDriwvJ0AEoejLZM9BTlFT4G1gwqdU/nsIw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="257554451"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257554451"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="609963854"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga008.jf.intel.com with ESMTP; 08 Jun 2022 19:55:15 -0700
From:   wen.ping.teh@intel.com
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Teh Wen Ping <wen.ping.teh@intel.com>
Subject: [PATCH v3] arm64: dts: Add support for Stratix 10 Software Virtual Platform
Date:   Thu,  9 Jun 2022 10:55:00 +0800
Message-Id: <20220609025500.400695-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teh Wen Ping <wen.ping.teh@intel.com>

Add Stratix 10 Software Virtual Platform device tree

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
---

changes in v2:
-remove indentation before GPL
-change root compatible to "altr,socfpga-stratix10"
-remove bootargs
-move clock-frequency to label
-remove l2-cache
-remove no longer exist authors from commit message

changes in v3:
-change root compatible to "altr,socfpga-stratix10-swvp"

 arch/arm64/Kconfig.platforms                  |   3 +-
 arch/arm64/boot/dts/altera/Makefile           |   3 +-
 .../dts/altera/socfpga_stratix10_swvp.dts     | 117 ++++++++++++++++++
 3 files changed, 121 insertions(+), 2 deletions(-)
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
index 000000000000..a8db58573954
--- /dev/null
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022, Intel Corporation
+ */
+
+#include "socfpga_stratix10.dtsi"
+
+/ {
+	model = "SOCFPGA Stratix 10 SWVP";
+	compatible = "altr,socfpga-stratix10-swvp", "altr,socfpga-stratix10";
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
+		stdout-path = "serial1:115200n8";
+		linux,initrd-start = <0x10000000>;
+		linux,initrd-end = <0x125c8324>;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
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
+&osc1 {
+	clock-frequency = <25000000>;
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

