Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB44ED306
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiCaEin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiCaEih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:38:37 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27B155C371;
        Wed, 30 Mar 2022 21:36:48 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 29AA11C81195;
        Thu, 31 Mar 2022 10:43:19 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 31
 Mar 2022 10:43:19 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 31 Mar
 2022 10:43:18 +0800
Received: from localhost.localdomain (172.19.1.47) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Thu, 31 Mar 2022 10:43:14 +0800
From:   Jacky Huang <ychuang3@nuvoton.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>, <krzk+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <cfli0@nuvoton.com>, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 2/3] dt-bindings: clock: Document MA35D1 clock controller bindings
Date:   Thu, 31 Mar 2022 10:42:55 +0800
Message-ID: <20220331024256.14762-3-ychuang3@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220331024256.14762-1-ychuang3@nuvoton.com>
References: <20220331024256.14762-1-ychuang3@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Nuvoton MA35D1 clock driver bindings.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
new file mode 100644
index 000000000000..bf5474b10420
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
@@ -0,0 +1,59 @@
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
+    dt-bindings/clock/ma35d1-clk.h
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
+    maxItems: 1
+
+  assigned-clocks:
+    maxItems: 4
+
+  assigned-clock-rates:
+    maxItems: 4
+
+  clock-pll-mode:
+    maxItems: 4
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  # clock control module node:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    clk: clock-controller@40460200 {
+        compatible = "nuvoton,ma35d1-clk";
+        reg = <0x40460200 0x100>;
+        #clock-cells = <1>;
+    };
+...
-- 
2.30.2

