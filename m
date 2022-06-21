Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7E553793
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353869AbiFUQMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353836AbiFUQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:12:11 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEAB2E686;
        Tue, 21 Jun 2022 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655827930; x=1687363930;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=EunKjSFJ/sK/0qQN9hU2pv3zoTH/rfJQnAfd0uaUZVo=;
  b=pNajbX0r/1bsr5g1ITWkbF1QnyppjSJZ0hBI9ajil2FS8qwCVGMzWYNU
   MNmgWBKk8T1uTCYu2zidqShY0m59adrUbeMC/RsOAo1xXWmQ49rThk/gc
   94U6+Juq9hRE+pOJVWv3Ajb2JFrsLve/I+Au+yzl2nr7jrTMFVrGFehVD
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 21 Jun 2022 09:12:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 09:12:08 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 09:12:08 -0700
Received: from srichara-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 09:12:03 -0700
From:   Sricharan R <quic_srichara@quicinc.com>
To:     <quic_srichara@quicinc.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <p.zabel@pengutronix.de>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 4/8] dt-bindings: pinctrl: qcom: Add ipq5018 pinctrl bindings
Date:   Tue, 21 Jun 2022 21:41:22 +0530
Message-ID: <20220621161126.15883-5-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220621161126.15883-1-quic_srichara@quicinc.com>
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varadarajan Narayanan <quic_varada@quicinc.com>

Add device tree binding Documentation details for ipq5018
pinctrl driver.

Co-developed-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 .../pinctrl/qcom,ipq5018-pinctrl.yaml         | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml
new file mode 100644
index 000000000000..9b16c08bd127
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,ipq5018-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. IPQ5018 TLMM block
+
+maintainers:
+  - Varadarajan Narayanan <quic_varada@quicinc.com>
+  - Sricharan R <quic_srichara@quicinc.com>
+  - Nitheesh Sekar <quic_nsekar@quicinc.com>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer block found in the
+  IPQ5018 platform.
+
+properties:
+  compatible:
+    const: qcom,ipq5018-pinctrl
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Specifies the TLMM summary IRQ
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    description:
+      Specifies the PIN numbers and Flags, as defined in defined in
+      include/dt-bindings/interrupt-controller/irq.h
+    const: 2
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description: Specifying the pin number and flags, as defined in
+      include/dt-bindings/gpio/gpio.h
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+#PIN CONFIGURATION NODES
+patternProperties:
+  '-pinmux$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([1-9]|[1-7][0-9]|80)$"
+        minItems: 1
+        maxItems: 4
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
+          audio_pdm0, audio_pdm1, audio_rxbclk, audio_rxd, audio_rxfsync,
+          audio_rxmclk, audio_txbclk, audio_txd, audio_txfsync, audio_txmclk,
+          blsp0_i2c, blsp0_spi, blsp0_uart0, blsp0_uart1, blsp1_i2c0,
+          blsp1_i2c1, blsp1_spi0, blsp1_spi1, blsp1_uart0, blsp1_uart1,
+          blsp1_uart2, blsp2_i2c0, blsp2_i2c1, blsp2_spi, blsp2_spi0,
+          blsp2_spi1, btss0, btss1, btss10, btss11, btss12, btss13, btss2,
+          btss3, btss4, btss5, btss6, btss7, btss8, btss9, burn0, burn1,
+          cri_trng, cri_trng0, cri_trng1, cxc_clk, cxc_data, dbg_out, eud_gpio,
+          gcc_plltest, gcc_tlmm, gpio, mac0, mac1, mdc, mdio, pcie0_clk,
+          pcie0_wake, pcie1_clk, pcie1_wake, pll_test, prng_rosc, pwm0, pwm1,
+          pwm2, pwm3, qdss_cti_trig_in_a0, qdss_cti_trig_in_a1,
+          qdss_cti_trig_in_b0, qdss_cti_trig_in_b1, qdss_cti_trig_out_a0,
+          qdss_cti_trig_out_a1, qdss_cti_trig_out_b0, qdss_cti_trig_out_b1,
+          qdss_traceclk_a, qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b,
+          qdss_tracedata_a, qdss_tracedata_b, qspi_clk, qspi_cs, qspi0, qspi1,
+          qspi2, qspi3, reset_out, sdc1_clk, sdc1_cmd, sdc10, sdc11, sdc12,
+          sdc13, wci0, wci1, wci2, wci3, wci4, wci5, wci6, wci7, wsa_swrm,
+          wsi_clk3, wsi_data3, wsis_reset, xfem0, xfem1, xfem2, xfem3, xfem4,
+          xfem5, xfem6, xfem7 ]
+
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        default: 2
+        description:
+          Selects the drive strength for the specified pins, in mA.
+
+      bias-pull-down: true
+
+      bias-pull-up: true
+
+      bias-disable: true
+
+      output-high: true
+
+      output-low: true
+
+    required:
+      - pins
+      - function
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        tlmm: pinctrl@1000000 {
+              compatible = "qcom,ipq5018-pinctrl";
+              reg = <0x01000000 0x300000>;
+              interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+              interrupt-controller;
+              #interrupt-cells = <2>;
+              gpio-controller;
+              #gpio-cells = <2>;
+              gpio-ranges = <&tlmm 0 80>;
+
+              serial3-pinmux {
+                      pins = "gpio44", "gpio45";
+                      function = "blsp0_uart0";
+                      drive-strength = <8>;
+                      bias-pull-down;
+              };
+        };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

