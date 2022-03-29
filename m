Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD84EB44E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbiC2TxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiC2Twt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:52:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E418B78E;
        Tue, 29 Mar 2022 12:51:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bq8so23322934ejb.10;
        Tue, 29 Mar 2022 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+XhA8TgVWNCg73BbGOG2hhIxLPG+B7tircTLTVq07s=;
        b=qSQKf469VMGOEcouWjg6eL1N7sLjZ6aziqkMKqa75RXLidLD5mIGh40AcfK05FOuyP
         ivYNGtSvUPN32R3aa40f/2iEyfGUsaXWl/dws/5Eg5grO9bwqK5hOPM7IfrDXgYhFMfJ
         J0/bfxMJiLmdjad5pF3Tj0wK09bYnbkm2jJVPVxsFQCHu973Pkme+AoBF3ZsWAsUGMv2
         ubcf+y1UD0maPYglC5rEo0UgxMcpJVMxq5Fa37qigHq0ZBrigwGfzM9bl6zqhRwskHgK
         jLpDjrBsJjsiS5PzbsakNxGC6iijTmG+XNh9I+t+CYQ6rEyrBmRxOANcqmU2A97Tv/sa
         ymGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+XhA8TgVWNCg73BbGOG2hhIxLPG+B7tircTLTVq07s=;
        b=ouqA8kAj9T9HlWmoRRg43uREY8W4L+XTrusypx9kGg6iEV6CiIZcK8LLIC9Jznd1WJ
         IEvxGcC8UUzZ+5w5mNPAd+HpPv8AvzfpTMpwZZdSmHXVaCttTUsR0PvXqkSiVTQEfJRs
         4Uu4YiINDSssWg/S6mpfthgoSFlXcMspe0tWvXJ1pOfnJ/UJhjZC75kUPgensU0qWUEQ
         ZSWHpaPdvvxKy0+ZEvZC0ZSm8F06zJMisyuY2hHVhPQZ4P87gK/MD5RneQT14qiw2ZOO
         0TId1y2pSd7vvq5vjWSdYrDhY6KmX9fNmobkosYANkaVBt6H2MBfrSGtdubYy9nn+Xzy
         sjHg==
X-Gm-Message-State: AOAM532AGK7UCuj5bmigVMe0qYicsVkUtodmjsrvFlO9Lm609LU8r6aI
        vYCWHFFLgMeZPQLCSXQHX9Y=
X-Google-Smtp-Source: ABdhPJzemaLV/PAuTjVl1105qt6YXlT40w60HAOGOEbmRL3gCpb0Bs4J3g18kYsjrGj7mfY43h0bnw==
X-Received: by 2002:a17:907:72c5:b0:6d6:e749:da41 with SMTP id du5-20020a17090772c500b006d6e749da41mr37598321ejc.591.1648583463507;
        Tue, 29 Mar 2022 12:51:03 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n27-20020a1709062bdb00b006da975173bfsm7546041ejg.170.2022.03.29.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 12:51:03 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: clock: convert rockchip,px30-cru.txt to YAML
Date:   Tue, 29 Mar 2022 21:50:57 +0200
Message-Id: <20220329195057.15571-1-jbx6244@gmail.com>
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

Convert rockchip,px30-cru.txt to YAML.

Changes against original bindings:
  Use compatible string: "rockchip,px30-pmucru"

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,px30-cru.txt      | 70 --------------
 .../bindings/clock/rockchip,px30-cru.yaml     | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 70 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
deleted file mode 100644
index 55e78cdde..000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-* Rockchip PX30 Clock and Reset Unit
-
-The PX30 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: PMU for CRU should be "rockchip,px30-pmu-cru"
-- compatible: CRU should be "rockchip,px30-cru"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- clocks: A list of phandle + clock-specifier pairs for the clocks listed
-          in clock-names
-- clock-names: Should contain the following:
-  - "xin24m" for both PMUCRU and CRU
-  - "gpll" for CRU (sourced from PMUCRU)
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Optional Properties:
-
-- rockchip,grf: phandle to the syscon managing the "general register files"
-  If missing, pll rates are not changeable, due to the missing pll lock status.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/px30-cru.h headers and can be
-used in device tree sources. Similar macros exist for the reset sources in
-these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "xin32k" - rtc clock - optional,
- - "i2sx_clkin" - external I2S clock - optional,
- - "gmac_clkin" - external GMAC clock - optional
-
-Example: Clock controller node:
-
-	pmucru: clock-controller@ff2bc000 {
-		compatible = "rockchip,px30-pmucru";
-		reg = <0x0 0xff2bc000 0x0 0x1000>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-	cru: clock-controller@ff2b0000 {
-		compatible = "rockchip,px30-cru";
-		reg = <0x0 0xff2b0000 0x0 0x1000>;
-		rockchip,grf = <&grf>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@ff030000 {
-		compatible = "rockchip,px30-uart", "snps,dw-apb-uart";
-		reg = <0x0 0xff030000 0x0 0x100>;
-		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&pmucru SCLK_UART0_PMU>, <&pmucru PCLK_UART0_PMU>;
-		clock-names = "baudclk", "apb_pclk";
-		reg-shift = <2>;
-		reg-io-width = <4>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
new file mode 100644
index 000000000..aa095f375
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,px30-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip PX30 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The PX30 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/px30-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"     - crystal input       - required
+    - "xin32k"     - rtc clock           - optional
+    - "i2sx_clkin" - external I2S clock  - optional
+    - "gmac_clkin" - external GMAC clock - optional
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-cru
+      - rockchip,px30-pmucru
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
+    minItems: 1
+    items:
+      - description: Clock for both PMUCRU and CRU
+      - description: Clock for CRU (sourced from PMUCRU)
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: xin24m
+      - const: gpll
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
+  - clocks
+  - clock-names
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/px30-cru.h>
+
+    pmucru: clock-controller@ff2bc000 {
+      compatible = "rockchip,px30-pmucru";
+      reg = <0xff2bc000 0x1000>;
+      clocks = <&xin24m>;
+      clock-names = "xin24m";
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
+
+    cru: clock-controller@ff2b0000 {
+      compatible = "rockchip,px30-cru";
+      reg = <0xff2b0000 0x1000>;
+      clocks = <&xin24m>, <&pmucru PLL_GPLL>;
+      clock-names = "xin24m", "gpll";
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.20.1

