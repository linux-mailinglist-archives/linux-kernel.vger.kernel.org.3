Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A885C4D6B46
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 01:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiCLAIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 19:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCLAIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 19:08:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6811E5331;
        Fri, 11 Mar 2022 16:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647043653; x=1678579653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vzl/jEjfdsCi6JqP7iVxxwjdQOR17jrD8nYVD6RvPHA=;
  b=RS/KgAwEd+Mov2hOOAyHN3+UCqpCEtW72RX10jIukZVgZxKN2xSHXZh2
   UEJCobZkpqyecUcJ2IXPNGPUS0WaTBoMPwGlf1ouHK+EwtDmbgv0QY2lD
   XBna1buC4EHc1uAyVcwPhFlBpv36FMtYTsds1n1WvGpsBGlxfS8UZ2NRG
   nOq1smZvKYYM7uD+55JNQw/fHJVovmZtcrmvQBT5FIZkUHn/ms749Nq5j
   I7cDk1OiQLvRaezWOyNlcEl0ZoywTGqDzBXBAuHuvdATaolarU6lP5+oV
   AGUVgWMOqC0UC+9ysFljgqJQ8YBp3/CkiBYSls83AeBd+HPVPEO0gyn07
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="243124584"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="243124584"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 16:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="713012837"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2022 16:07:31 -0800
From:   niravkumar.l.rabara@intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     niravkumar.l.rabara@intel.com
Subject: [PATCH] arm64: dts: intel: add device tree for n6010
Date:   Sat, 12 Mar 2022 16:07:17 +0800
Message-Id: <20220312080717.1528401-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add a dts file for the Silicom FPGA SmartNIC N6010/N6011,
which is based on the Intel Agliex platform.

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 arch/arm64/boot/dts/intel/Makefile            |  1 +
 .../boot/dts/intel/socfpga_agilex_n6010.dts   | 83 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6010.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 0b5477442263..a05a610a4006 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
+				socfpga_agilex_n6010.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6010.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6010.dts
new file mode 100644
index 000000000000..c105f0621eb4
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6010.dts
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2022, Intel Corporation
+ */
+#include "socfpga_agilex.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex n6010";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+                agilex_hps_bridges: bridge@80000000 {
+                        compatible = "simple-bus";
+                        reg = <0x80000000 0x60000000>,
+                                <0xf9000000 0x00100000>;
+                        reg-names = "axi_h2f", "axi_h2f_lw";
+                        #address-cells = <0x2>;
+                        #size-cells = <0x1>;
+                        ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>,
+                                <0x00000001 0x02001000 0x82001000 0x00000800>,
+                                <0x00000001 0x02080000 0x82080000 0x00004000>,
+                                <0x00000001 0x02100000 0x82100000 0x00080000>,
+                                <0x00000001 0x02000040 0x82000040 0x00000020>,
+                                <0x00000001 0x02000800 0x82000800 0x00000020>,
+                                <0x00000001 0x02000820 0x82000820 0x00000020>,
+                                <0x00000001 0x02000900 0x82000900 0x00000020>,
+                                <0x00000001 0x02000920 0x82000920 0x00000020>,
+                                <0x00000001 0x02000940 0x82000940 0x00000020>,
+                                <0x00000001 0x00000300 0xf9000300 0x00000010>,
+                                <0x00000001 0x02000000 0x82000000 0x00000010>;
+
+                        uio_cp_eng@0xf9000000 {
+                                compatible = "generic-uio";
+                                reg = <0x00000000 0x00000000 0x00001000>;
+                                status = "okay";
+                        };
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+
+	spidev: spidev@0 {
+		status = "okay";
+		compatible = "linux,spidev";
+		spi-max-frequency = <25000000>;
+		reg = <0>;
+	};
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&fpga_mgr {
+	status = "disabled";
+};
-- 
2.25.1

