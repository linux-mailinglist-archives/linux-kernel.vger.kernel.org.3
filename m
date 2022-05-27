Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8706E536708
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354419AbiE0SoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354400AbiE0SoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:44:09 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9A5101E7;
        Fri, 27 May 2022 11:44:07 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 88B2E201D57;
        Fri, 27 May 2022 20:44:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 50F5E2013D7;
        Fri, 27 May 2022 20:44:06 +0200 (CEST)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BEB18180031F;
        Sat, 28 May 2022 02:44:04 +0800 (+08)
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        manjunatha.venkatesh@nxp.com, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: [PATCH v4 1/3] dt-bindings: uwb: Device tree information for Nxp SR1XX SOCs
Date:   Sat, 28 May 2022 00:13:49 +0530
Message-Id: <20220527184351.3829543-2-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220527184351.3829543-1-manjunatha.venkatesh@nxp.com>
References: <20220527184351.3829543-1-manjunatha.venkatesh@nxp.com>
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

Ultra-wideband (UWB) is a short-range wireless communication protocol.

NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
are FiRa Compliant. SR1XX SOCs are flash less devices and they need
Firmware Download on every device boot. More details on the SR1XX Family
can be found at https://www.nxp.com/products/:UWB-TRIMENSION

The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
Interface (UCI).  The corresponding details are available in the FiRa
Consortium Website (https://www.firaconsortium.org/).

Message-ID: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
---
 .../bindings/uwb/nxp,uwb-sr1xx.yaml           | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml

diff --git a/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml b/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
new file mode 100644
index 000000000000..226fec908968
--- /dev/null
+++ b/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/uwb/nxp,uwb-sr1xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ultra Wide Band(UWB)driver support for NXP SR1XX SOCs family
+
+maintainers:
+  - Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
+
+description: The sr1xx driver work for the NXP SR1XX Family of Ultra Wide
+    Band Subsystem(UWBS), and uses UWB Controller Interface(UCI).
+    The corresponding details are available in the FiRa Consortium Website
+    (https://www.firaconsortium.org/).More details on the SR1XX Family can be
+    found at https://www.nxp.com/products/:UWB-TRIMENSION
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nxp,sr1xx
+
+      - const: nxp,sr1xx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    spi2: spi@ffd68000 {
+		compatible = "arm,pl022", "arm,primecell";
+		reg = <0x0 0xffd68000 0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&crg_ctrl HI3660_CLK_GATE_SPI2>;
+		clock-names = "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi2_pmx_func &spi2_cfg_func>;
+		num-cs = <1>;
+		cs-gpios = <&gpio27 2 0>;
+		status = "ok";
+	sr1xx@0 {
+	 compatible = "nxp,sr1xx";
+	 reg = <0>;
+	 nxp,sr1xx-irq = <&gpio26 1 0>;
+	 nxp,sr1xx-ce = <&gpio2 5 0>;
+	 nxp,sr1xx-ri = <&gpio24 1 0>;
+	 spi-max-frequency = <20000000>;
+	};
+    };
+
+...
-- 
2.35.1

