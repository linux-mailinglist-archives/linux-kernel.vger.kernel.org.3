Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06659782F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbiHQUob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbiHQUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:44:24 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A507BAA3E6;
        Wed, 17 Aug 2022 13:44:16 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44529200277;
        Wed, 17 Aug 2022 22:44:15 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE1EB200276;
        Wed, 17 Aug 2022 22:44:14 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 181BB40AA2;
        Wed, 17 Aug 2022 13:44:12 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Santan Kumar <santan.kumar@nxp.com>,
        Tao Yang <b31903@freescale.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Abhimanyu Saini <abhimanyu.saini@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 4/6] arm64: dts: ls2081a-rdb: Add DTS for NXP LS2081ARDB
Date:   Wed, 17 Aug 2022 15:43:55 -0500
Message-Id: <20220817204357.21753-5-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220817204357.21753-1-leoyang.li@nxp.com>
References: <20220817204357.21753-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Priyanka Jain <priyanka.jain@nxp.com>

This patch adds support for NXP LS2081ARDB board which has LS2081A SoC.

LS2081A SoC is 40-pin derivative of LS2088A SoC. From functional
perspective both are same. Hence, LS2088a SoC dtsi file is included
from LS2081ARDB dts.

Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Santan Kumar <santan.kumar@nxp.com>
Signed-off-by: Tao Yang <b31903@freescale.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/fsl-ls2081a-rdb.dts    | 131 ++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 2cf55534c162..bf7c448fa817 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -36,6 +36,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-ten64.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2081a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
new file mode 100644
index 000000000000..0148f8c93442
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for NXP LS2081A RDB Board.
+ *
+ * Copyright 2017 NXP
+ *
+ * Priyanka Jain <priyanka.jain@nxp.com>
+ *
+ */
+
+/dts-v1/;
+
+#include "fsl-ls2088a.dtsi"
+
+/ {
+	model = "NXP Layerscape 2081A RDB Board";
+	compatible = "fsl,ls2081a-rdb", "fsl,ls2081a";
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+};
+
+&dspi {
+	status = "okay";
+
+	n25q512a: flash@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <3000000>;
+		reg = <0>;
+	};
+};
+
+&esdhc {
+	status = "okay";
+};
+
+&ifc {
+	status = "disabled";
+};
+
+&i2c0 {
+	status = "okay";
+
+	pca9547: mux@75 {
+		compatible = "nxp,pca9547";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+			rtc@51 {
+				compatible = "nxp,pcf2129";
+				reg = <0x51>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			ina220@40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <500>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			adt7481@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+		};
+	};
+};
+
+&qspi {
+	status = "okay";
+
+	s25fs512s0: flash@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+
+	s25fs512s1: flash@1 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		spi-max-frequency = <20000000>;
+		reg = <1>;
+	};
+};
+
+&sata0 {
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
-- 
2.37.1

