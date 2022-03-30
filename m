Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99474EC423
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbiC3Meg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiC3Mdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:33:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6A6C49D;
        Wed, 30 Mar 2022 05:19:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so41133421ejd.5;
        Wed, 30 Mar 2022 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mDVuQKSlm5xd/4ZBvFr9HbdN100hZFnLWXptWqyI1A=;
        b=NzYSE1GEzipFpPz8yWywZroIiRaGERgfkU3aIyjLjxNUSwJWByqS4s7w2gLXrcPWsr
         FXnBnEmgHiZCdegVNlSItW7xe8cYNr2zS731eieslkLPbchLmvGbVLXvPi3daC4WXP1D
         jR2mI4P924VK1NdwBE9sEjWX+o1FBNan9jfnywMHo2EpVrGqh1y+9pbxPrclcT1hlzle
         4aG8jTF4YzhtV8703b5m2Cu7hYiTEMAMYkLspml9RpxpheEgjGo7ocrPmT1ZwfJWaOw2
         E0wL3xG79SySsFPNVmukNC263UcsnQWpfwIQv8chg3k5EZl5KmIgMmQd8VxvosQGWOop
         w0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mDVuQKSlm5xd/4ZBvFr9HbdN100hZFnLWXptWqyI1A=;
        b=6ry+Eu9fhQ7p85Cr7Cb0TC3B84ccNyKRBvYaiXl7rEogD6PHa6kClKeEL1zic+KGbg
         NSu6nD1W04TpUMATCkQ54gCjL6//JL0SVAG7c5Pmxqe8NCz+R23NH9WFEJR0Skoiib6b
         LjfEVeAM+H/T0AH8q9glbEBMumO2T7BA61lNqkP2eWXMGEXL3Z8sRCeuaxce85TxMHC/
         blbO3mjJhinzaew736CDF7lqZvDufxu3GoucRDibCKuYXwqZ/Nu+Dfk5wiLj58lI5OIk
         bmy9JpOz1KQtG1taIShRttvt72pSU95ymIdIPH3ZKabQWH8U/qRGF3Z9sTxQz5vQ6lfQ
         Gglg==
X-Gm-Message-State: AOAM530DQiFpcNbC+3T77rfCMFkxOcQdga0GRfbvIdd7rsYFT6/NAUAa
        Re9daY8TpA4hqTuUHpnhAas=
X-Google-Smtp-Source: ABdhPJwLYPlD8kBE+uO+I0ODS6hr6ze+DT6BQDe9nG2ycmHkRWfgazFMNyK+vXnGmPdAB7CyarDmvw==
X-Received: by 2002:a17:907:3e14:b0:6e0:1ef7:6319 with SMTP id hp20-20020a1709073e1400b006e01ef76319mr39537633ejc.321.1648642770379;
        Wed, 30 Mar 2022 05:19:30 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906255500b006e08c4862ccsm7288778ejb.96.2022.03.30.05.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 05:19:29 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: clock: convert rockchip,rk3228-cru.txt to YAML
Date:   Wed, 30 Mar 2022 14:19:21 +0200
Message-Id: <20220330121923.24240-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert rockchip,rk3228-cru.txt to YAML.

Changes against original bindings:
  Add clocks and clock-names because the device has to have
  at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3228-cru.txt    | 58 ---------------
 .../bindings/clock/rockchip,rk3228-cru.yaml   | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.txt
deleted file mode 100644
index f32304812..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Rockchip RK3228 Clock and Reset Unit
-
-The RK3228 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: should be "rockchip,rk3228-cru"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Optional Properties:
-
-- rockchip,grf: phandle to the syscon managing the "general register files"
-  If missing pll rates are not changeable, due to the missing pll lock status.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/rk3228-cru.h headers and can be
-used in device tree sources. Similar macros exist for the reset sources in
-these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "ext_i2s" - external I2S clock - optional,
- - "ext_gmac" - external GMAC clock - optional
- - "ext_hsadc" - external HSADC clock - optional
- - "phy_50m_out" - output clock of the pll in the mac phy
-
-Example: Clock controller node:
-
-	cru: cru@20000000 {
-		compatible = "rockchip,rk3228-cru";
-		reg = <0x20000000 0x1000>;
-		rockchip,grf = <&grf>;
-
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@10110000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x10110000 0x100>;
-		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clocks = <&cru SCLK_UART0>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
new file mode 100644
index 000000000..cf7dc01d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3228-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3228 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3228 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3228-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"      - crystal input                          - required
+    - "ext_i2s"     - external I2S clock                     - optional
+    - "ext_gmac"    - external GMAC clock                    - optional
+    - "ext_hsadc"   - external HSADC clock                   - optional
+    - "phy_50m_out" - output clock of the pll in the mac phy
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3228-cru
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: xin24m
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the "general register files" (GRF),
+      if missing pll rates are not changeable, due to the missing pll
+      lock status.
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    cru: clock-controller@20000000 {
+      compatible = "rockchip,rk3228-cru";
+      reg = <0x20000000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1

