Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2C1520BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiEJDaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiEJDaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:30:13 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91DFC54003;
        Mon,  9 May 2022 20:26:04 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 55CC91C81111;
        Tue, 10 May 2022 11:26:04 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 10
 May 2022 11:26:03 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 10 May
 2022 11:26:03 +0800
Received: from localhost.localdomain (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 10 May 2022 11:26:03 +0800
From:   Jacky Huang <ychuang3@nuvoton.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ychuang570808@gmail.com>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>, <krzk+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <soc@kernel.org>, <cfli0@nuvoton.com>,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH V4 2/5] dt-bindings: clock: Document MA35D1 clock controller bindings
Date:   Tue, 10 May 2022 11:25:55 +0800
Message-ID: <20220510032558.10304-3-ychuang3@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220510032558.10304-1-ychuang3@nuvoton.com>
References: <20220510032558.10304-1-ychuang3@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Nuvoton MA35D1 clock driver bindings.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
new file mode 100644
index 000000000000..97af7947b6f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nuvoton,ma35d1-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Clock Control Module Binding
+
+maintainers:
+  - Chi-Fang Li <cfli0@nuvoton.com>
+  - Jacky Huang <ychuang3@nuvoton.com>
+
+description: |
+  The MA35D1 clock controller generates clocks for the whole chip,
+  including system clocks and all peripheral clocks.
+
+  See also:
+    include/dt-bindings/clock/ma35d1-clk.h
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-clk
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    items:
+      - description: External 24MHz crystal
+
+  clock-names:
+    items:
+      - const: hxt_24m
+
+  assigned-clocks:
+    maxItems: 5
+
+  assigned-clock-rates:
+    maxItems: 5
+
+  nuvoton,clk-pll-mode:
+    description:
+      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
+      EPLL, and VPLL in sequential. The operation mode value 0 is for
+      integer mode, 1 is for fractional mode, and 2 is for spread
+      spectrum mode.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 5
+    items:
+      minimum: 0
+      maximum: 2
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    clk: clock-controller@40460200 {
+        compatible = "nuvoton,ma35d1-clk";
+        reg = <0x0 0x40460200 0x0 0x100>;
+        #clock-cells = <1>;
+        clocks = <&hxt_24m>;
+        clock-names = "HXT_24MHz";
+    };
+...
-- 
2.30.2

