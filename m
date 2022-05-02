Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4663517538
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbiEBRCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiEBRCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:02:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C86A101F;
        Mon,  2 May 2022 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651510713; x=1683046713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wdkPKD+2olSZMP2pvVUKLQSf4T0fJjUAyhUpxv6oQQM=;
  b=M3KRZu2CUgaDc56Skujk4wLtFAT3Orlj+IMmoqLjH0ubU+vMl9FVrvRt
   Ggkgba5KvgRJpN4bxgy5jYPgdQolSI7iiK8f3qIg09Z62lk/uX1SRJPNd
   dkudj+D+t8CvGAriqATGRR+s2JOS4GvEkkqBkPbJbO7er3FtQQll1ficT
   r5h7AMlmMzBVY1I9Tfx3EOrQRQ9JZQy5Yf7Ld3L99yf7BoRoBiurY5OAs
   jkJvlhhesYdE6XPZWyxR5SKN4b+xp0V2pcDwiKNaFx/SjhlwC4cwVNYlK
   gR2qIPtrPBsMcAxOHGjZs9Fn5ECc/+qCd+qjY2zmfe9z1MKL6pxd2FLZL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353696317"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="353696317"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:58:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="583796556"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:58:32 -0700
From:   matthew.gerlach@linux.intel.com
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dinguyen@vger.kernel.org, robh+dt@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH] arm64: dts: intel: add device tree for n6000
Date:   Mon,  2 May 2022 09:58:18 -0700
Message-Id: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add a device tree for the n6000 instantiation of Agilex
Hard Processor System (HPS).

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 arch/arm64/boot/dts/intel/Makefile            |  1 +
 .../boot/dts/intel/socfpga_agilex_n6000.dts   | 77 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 0b5477442263..1425853877cc 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
+				socfpga_agilex_n6000.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
new file mode 100644
index 000000000000..07f5a5983e5c
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2021-2022, Intel Corporation
+ */
+#include "socfpga_agilex.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex n6000";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart0;
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
+		agilex_hps_bridges: bridge@80000000 {
+			compatible = "simple-bus";
+			reg = <0x80000000 0x60000000>,
+				<0xf9000000 0x00100000>;
+			reg-names = "axi_h2f", "axi_h2f_lw";
+			#address-cells = <0x2>;
+			#size-cells = <0x1>;
+			ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
+
+			uio_cp_eng@0xf9000000 {
+				compatible = "generic-uio";
+				reg = <0x00000000 0x00000000 0x00001000>;
+				status = "okay";
+			};
+		};
+	};
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

