Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF70B51EE0B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 16:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiEHOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 10:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiEHOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:30:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DEB60D7;
        Sun,  8 May 2022 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652019988; x=1683555988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=owflUxJwye43Jslm11MI/MaUZtH0owF4PzzUJNNfyZ0=;
  b=IYsxrc0NnbQ0DudQz/FLaFEgqcT0N68GMVkHA89d2GMGMfiTymfd9fU9
   Us2VhZQoaOABmWWToLZUP917QAZVXSpBWvcLteXTFQV8vulgOMkcYeKxs
   H0UlWPPvDNxHoi9OZ+1bvMTIVwRhDmHkerlDPK1qVpQ/pflTh6X49KSKG
   s/NN6sDV7qCoPw/ZKgeUn6Y4W3luYitPN955Tm2IXAosTl1AY7xk+sfxW
   8ngQLdil2qPVhFfnO+Ry1trKbW1ituWNc9U6Gu7l+wPKQ+NGcytOC6MiK
   GirhT9DiRBbic0SxrDIquDNVfK+aRQg1/ANb0MysURHUvd04FEWOncjrx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="268488489"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="268488489"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 07:26:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="737738699"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 07:26:25 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v4 3/3] arm64: dts: intel: add device tree for n6000
Date:   Sun,  8 May 2022 07:26:24 -0700
Message-Id: <20220508142624.491045-4-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v3:
  - add unit number to memory node
  - remove unused label
  - remove 0x from #address-cells/#size-cells values
  - change hps_cp_eng@0 to dma-controller@0
  - remove spi node with unaccepted compatible value

v2:
  - fix copy engine node name
  - fix compatible field for copy engine
  - remove redundant status field
  - add compatibility field for the board
  - fix SPDX
  - fix how osc1 clock frequency is set
---
 arch/arm64/boot/dts/intel/Makefile            |  3 +-
 .../boot/dts/intel/socfpga_agilex_n6000.dts   | 66 +++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 0b5477442263..c2a723838344 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_socdk.dtb \
+dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
+				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
new file mode 100644
index 000000000000..6231a69204b1
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021-2022, Intel Corporation
+ */
+#include "socfpga_agilex.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex n6000";
+	compatible = "intel,socfpga-agilex-n6000", "intel,socfpga-agilex";
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
+	memory@0 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		bus@80000000 {
+			compatible = "simple-bus";
+			reg = <0x80000000 0x60000000>,
+				<0xf9000000 0x00100000>;
+			reg-names = "axi_h2f", "axi_h2f_lw";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
+
+			dma-controller@0 {
+				compatible = "intel,hps-copy-engine";
+				reg = <0x00000000 0x00000000 0x00001000>;
+				#dma-cells = <1>;
+			};
+		};
+	};
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
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
+&watchdog0 {
+	status = "okay";
+};
+
+&fpga_mgr {
+	status = "disabled";
+};
-- 
2.25.1

