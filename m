Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E311958ECB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiHJNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHJND6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:03:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611B36CD2A;
        Wed, 10 Aug 2022 06:03:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f192so13640304pfa.9;
        Wed, 10 Aug 2022 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=D7AvjNvCU9/avibpjDRAqX602XGo8pxDoPMG9JNZLr8=;
        b=LTrX+V1m/JRMI7ZXf7+YyrShFn1VNPzD8F9CGzzWTTrOP0ri2xTJim/W61jK7trPTy
         CuuOTqtevijGr9LiLySI70z/xcre7fIV1wnk85HrFl5UvLICRl+bAJGAdrzi4V6RpB99
         IrXU2/KNSWp26UxqCCZxgCiCxVbPODVTMgh68eEQZZQvLfg96KuEqR1f7wRIPynr9Oh7
         e9ZDLtHE5ETMNXxK+Fdtoy/8pHOpW9o+7PwDgXazwrKjJ7m9n60a9WC07QykgWNamGCr
         N4i1X9Hh0ojz8+CHtdFJEtzMUbqznY4Bu8xOvg1AOJyWuixYX5LFgFWOq+uRCvwSDUnp
         ZSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=D7AvjNvCU9/avibpjDRAqX602XGo8pxDoPMG9JNZLr8=;
        b=Be0J816kmAFQOGc2nZoQIG31MuMFF0urqq8C1X4RlsQNFE045qNdZVk3GVaQTn1LI8
         Tmaum7bD9gIyTUKLh2ErFp8/QLe3UNemUiPGViCviSwPhC2xqwaDCpjBKLlr857ZA8x9
         ZsomiiFBfkgnFqgrM4U1cbrs55H517zqqAhs81rhgzQ6cmWrDr47canGznv7kvHbJXvW
         IhuKsLMe9gV9CFvg6pzMYUlg3WAlfGV+S9KHC2H1GCCJVPLL0DKmcBrFPdeYGLq2mrKG
         KuJec9HKyyLcUWODLgRy3gQPJM8XSBk1QjJoaFNQLk6SEintotX1bQ1uacicX0bJ5sOF
         Gbgw==
X-Gm-Message-State: ACgBeo0F1adTILghWe7D/FtSKAQaZnKTXmsT8GHh6aXPL1uE1Er6VmiV
        gmrq9xMcGlrtyZkEKwCyOpA=
X-Google-Smtp-Source: AA6agR7Q6aybAsOHS/ImkOiQ5Vwadj8raKtP6ekHar1Z3GTa5n1sHjJ3HiO0RGGECUxLY3TtKFcCqA==
X-Received: by 2002:a05:6a00:1255:b0:52f:988f:dfbf with SMTP id u21-20020a056a00125500b0052f988fdfbfmr9368075pfi.82.1660136636782;
        Wed, 10 Aug 2022 06:03:56 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b0016d22e6ed57sm12689761pln.293.2022.08.10.06.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:03:56 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Wed, 10 Aug 2022 21:03:44 +0800
Message-Id: <20220810130344.1488578-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add bindings for Unisoc system global register which provide register map
for clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
new file mode 100644
index 000000000000..ab0a4403b89f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sprd,ums512-glbreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc System Global Register
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description:
+  Unisoc system global registers provide register map
+  for clocks and some multimedia modules of the SoC.
+
+properties:
+  compatible:
+    items:
+      - const: sprd,ums512-glbregs
+      - const: syscon
+      - const: simple-mfd
+
+  "#address-cells": true
+  "#size-cells": true
+
+  ranges:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^clock-controller@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/clock/sprd,ums512-clk.yaml
+    description:
+      Clock controller for the SoC clocks.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ap_apb_regs: syscon@71000000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x71000000 0x3000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0x71000000 0x3000>;
+
+      clock-controller@0 {
+        compatible = "sprd,ums512-apahb-gate";
+        reg = <0x0 0x2000>;
+        #clock-cells = <1>;
+      };
+    };
+
+  - |
+    ap_intc5_regs: syscon@32360000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x32360000 0x1000>;
+    };
-- 
2.25.1

