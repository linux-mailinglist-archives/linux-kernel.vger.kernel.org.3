Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0D464807
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347259AbhLAH2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241436AbhLAH2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:28:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148FBC061746;
        Tue, 30 Nov 2021 23:24:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60EBACE1D49;
        Wed,  1 Dec 2021 07:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE79C53FD2;
        Wed,  1 Dec 2021 07:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343487;
        bh=XFCHcoATzgutf2RF2j7TlVR3ctzYx8y38v1gbQmqITM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jH76vE5+w8SNnP6f7hJRMbUQfW8C3ZRaSCXIVQVBqELjd4jd+DNsCefgfjKWlTvd5
         yxpLP7ASmHXPvRxc+kcElFwxPycY1gvwug/iSZ+0jrayhg4DehJ0/cbirUuQucYLVO
         ZUFAB7qNtvvSGV0HtWgEUuFJ8RsLBi6JrbSb2nIziqNZrU9OccSwKKzog2dPzxQWMf
         bx/DBmagIsNJqpN/WifS9cUOLdwA38c/kxL/nRG/TiF9Z28yeEMv9NReHDX0PIJtjA
         vNVvV2RCcIXZ0gS3+LJ/4sGeml3DG5q8nwpQRpaj6rgzKF9lVl0M3UJOQUdeTctajV
         /aFlpPELxn3kg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add SM8450 pinctrl bindings
Date:   Wed,  1 Dec 2021 12:54:33 +0530
Message-Id: <20211201072434.3968768-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072434.3968768-1-vkoul@kernel.org>
References: <20211201072434.3968768-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding Documentation details for Qualcomm SM8450
TLMM device

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
new file mode 100644
index 000000000000..9c891246245b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8450-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SM8450 TLMM block
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer (TLMM) block found
+  in the SM8450 platform.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm8450-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  '#interrupt-cells': true
+  gpio-controller: true
+  gpio-reserved-ranges: true
+  '#gpio-cells': true
+  gpio-ranges: true
+  wakeup-parent: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+patternProperties:
+  '-state$':
+    oneOf:
+      - $ref: "#/$defs/qcom-sm8450-tlmm-state"
+      - patternProperties:
+          ".*":
+            $ref: "#/$defs/qcom-sm8450-tlmm-state"
+
+$defs:
+  qcom-sm8450-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])$"
+            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ aon_cam, atest_char, atest_usb, audio_ref, cam_mclk, cci_async,
+                cci_i2c, cci_timer, cmu_rng, coex_uart1, coex_uart2, cri_trng,
+                cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
+                ddr_pxi2, ddr_pxi3, dp_hot, gcc_gp1, gcc_gp2, gcc_gp3,
+                gpio, ibi_i3c, jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1,
+                mdp_vsync2, mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck,
+                mi2s0_ws, mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws,
+                mss_grfc0, mss_grfc1, mss_grfc10, mss_grfc11, mss_grfc12,
+                mss_grfc2, mss_grfc3, mss_grfc4, mss_grfc5, mss_grfc6,
+                mss_grfc7, mss_grfc8, mss_grfc9, nav, pcie0_clkreqn,
+                pcie1_clkreqn, phase_flag, pll_bist, pll_clk, pri_mi2s,
+                prng_rosc, qdss_cti, qdss_gpio, qlink0_enable, qlink0_request,
+                qlink0_wmss, qlink1_enable, qlink1_request, qlink1_wmss,
+                qlink2_enable, qlink2_request, qlink2_wmss, qspi0, qspi1,
+                qspi2, qspi3, qspi_clk, qspi_cs, qup0, qup1, qup10, qup11,
+                qup12, qup13, qup14, qup15, qup16, qup17, qup18, qup19, qup2,
+                qup20, qup21, qup3, qup4, qup5, qup6, qup7, qup8, qup9, qup_l4,
+                qup_l5, qup_l6, sd_write, sdc40, sdc41, sdc42, sdc43, sdc4_clk,
+                sdc4_cmd, sec_mi2s, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2,
+                tgu_ch3, tmess_prng0, tmess_prng1, tmess_prng2, tmess_prng3,
+                tsense_pwm1, tsense_pwm2, uim0_clk, uim0_data, uim0_present,
+                uim0_reset, uim1_clk, uim1_data, uim1_present, uim1_reset,
+                usb2phy_ac, usb_phy, vfr_0, vfr_1, vsense_trigger ]
+
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      drive-strength: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+      - function
+
+    additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        pinctrl@f100000 {
+                compatible = "qcom,sm8450-tlmm";
+                reg = <0x0f100000 0x300000>;
+                gpio-controller;
+                #gpio-cells = <2>;
+                gpio-ranges = <&tlmm 0 0 211>;
+                interrupt-controller;
+                #interrupt-cells = <2>;
+                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+                gpio-wo-subnode-state {
+                        pins = "gpio1";
+                        function = "gpio";
+                };
+
+                uart-w-subnodes-state {
+                    rx {
+                            pins = "gpio26";
+                            function = "qup7";
+                            bias-pull-up;
+                    };
+
+                    tx {
+                            pins = "gpio27";
+                            function = "qup7";
+                            bias-disable;
+                    };
+               };
+        };
+...
-- 
2.31.1

