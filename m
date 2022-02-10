Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08184B1307
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbiBJQh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:37:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbiBJQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:37:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45164E94;
        Thu, 10 Feb 2022 08:37:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k18so10562373wrg.11;
        Thu, 10 Feb 2022 08:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6f8MT+XMOS9CpQCm1NGb0hlMLGq8J8pk7v7AiFAEiK8=;
        b=DFcXkWHZuWS14U+1Q+QhCLis7vOyWjMJu6hS1+XRTHPRc430SdifI+V1RCbX8fjrKm
         eKSnA662eyxGe+vDUNku/ZVeVXgRX3ItXcB5H76NHOfVdy2ShCvR56A66DH2afwOix1B
         sQe1GbSPFJJArj7omH2UJuvKqWlhVsEnEugZrNhlWcAzcKm3sUogU2nmuDXWwjFYvgu3
         +BOH5oRNaBt4UGeQC8zmx8kM/HNUYTn3YfviBRlv9TqrvhM1rC0wMuDqdvBWPkBkL/qW
         Vt7fTtIghTY/TgVTngRJsrRb6CLR8thlAhQfwIm/g6UGUgVI2Ms2ccJZlTuHdNOWfvLv
         F1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6f8MT+XMOS9CpQCm1NGb0hlMLGq8J8pk7v7AiFAEiK8=;
        b=iE8cTPvIufWjxQLYrzNzFEUGc3yixq1k2QIUvLbL551Tjfj6i7cGGH03uxheGJXGRX
         SYasz5833Qfw3Cu53s8yjghc6+uE/R3VNYZbrqk1gOUqWDUhbv+/9IYi8YAlktrkc9xt
         orzpTUuh3PxaGSI2NW4QC/z28B9Fxp9C8cu3eIEbSNY7JHKJxqkN7WNYRBFsh2dgCCfn
         KbOnlKglp5nIvWfhVTleHrYPEA0FVaZMX1hFP4mULT6HvMhXSEFjHVDASkncXH6hpWls
         7mUGnO+FNo7jCvDQY4HZ+8SINmFwgkcP835jgkkNZ7/7LkWG6UNpyuXKxliD8/kyJDe4
         nd7w==
X-Gm-Message-State: AOAM531MPeA31Onhz7/QtGaEVJdRZyZLkDzOsnTJPa1fq7qP9530MRfK
        P6qNkIZlEh8NmcahtOKQTb4p349pQvfcAQ==
X-Google-Smtp-Source: ABdhPJxx5U0k+T5VeAovoLYozLiKZ9NWYTxYr+VxK6LX5/0upSLE0Hdh57H2icnJ1+BH/NyBgwwBPw==
X-Received: by 2002:a05:6000:1c0d:: with SMTP id ba13mr5813536wrb.423.1644511060752;
        Thu, 10 Feb 2022 08:37:40 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id k5sm5871795wrw.117.2022.02.10.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:37:40 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: input/touchscreen: bindings for Imagis
Date:   Thu, 10 Feb 2022 18:37:06 +0200
Message-Id: <20220210163708.162866-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220210163708.162866-1-markuss.broks@gmail.com>
References: <20220210163708.162866-1-markuss.broks@gmail.com>
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

This patch adds device-tree bindings for the Imagis
IST3038C touch screen IC.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../input/touchscreen/imagis,ist3038c.yaml    | 78 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
new file mode 100644
index 000000000000..da1630eb957b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagis IST30XXC family touchscreen controller bindings
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  $nodename:
+    pattern: "^touchscreen(@.*)?$"
+
+  compatible:
+    items:
+      - enum:
+          - imagis,ist3038c
+
+  reg:
+    description: I2C address
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply regulator for the chip
+
+  vddio-supply:
+    description: Power supply regulator for the I2C bus
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-fuzz-x: true
+  touchscreen-fuzz-y: true
+  touchscreen-fuzz-pressure: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+  touchscreen-max-pressure: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@48 {
+        compatible = "imagis,ist3038c";
+        reg = <0x50>;
+        interrupt-parent = <&gpio>;
+        interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+        vdd-supply = <&ldo1_reg>;
+        vddio-supply = <&ldo2_reg>;
+        touchscreen-size-x = <720>;
+        touchscreen-size-y = <1280>;
+        touchscreen-fuzz-x = <10>;
+        touchscreen-fuzz-y = <10>;
+        touchscreen-fuzz-pressure = <10>;
+        touchscreen-inverted-x;
+        touchscreen-inverted-y;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index cdc851e275f1..9357cdc5aef5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -551,6 +551,8 @@ patternProperties:
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
     description: ILI Technology Corporation (ILITEK)
+  "^imagis,.*":
+    description: Imagis Technologies Co., Ltd.
   "^img,.*":
     description: Imagination Technologies Ltd.
   "^imi,.*":
-- 
2.35.0

