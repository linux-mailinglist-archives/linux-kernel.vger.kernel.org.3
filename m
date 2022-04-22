Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2E50C12A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiDVVh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiDVVhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:37:23 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012333FE7EB;
        Fri, 22 Apr 2022 13:38:03 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e5ca5c580fso9817569fac.3;
        Fri, 22 Apr 2022 13:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkCuqc4lk8yEfR89vQV9qFVj6wArnvFzUiFZKzKZjrc=;
        b=iXtxvrsf8iVjOHl0ej3x+QTE3vMlJkiXBBLikQb4fM2UlPpdO9nIac3bkYbbSfkO3D
         DrI1X8vSyzNLn2j7c7k4qFRN/l5vonnxzZD8if3aa2vfl9+tN+oNKHJWT966w9BjTKAC
         4M4zucWvOKgKbHaYnC+gun0njTMdn0qL5Ug/BuhO7yMkvLYgFnPmqOIwwcieXEamubrw
         b1iOLW86DAXliAkdSHZ5nj21A0SnudyymcscArPFmp8PP5S/MpqjMx7ESf9FEn0IzlGv
         MjOtg3vZGD5AyaXNHjSNKJ4bC6UIJXO/1IjeSJJLz80U6KdfsTEBvFkqMr/LDY0Rcd05
         1gCw==
X-Gm-Message-State: AOAM530PU5/xWU2vVG5xP66nIbKniPxuo9DJQBh/qJWciFZHpO8evTdx
        yhWDZT5LNumadtMaE33NZfhI3XaTrw==
X-Google-Smtp-Source: ABdhPJxrncT4pRUKPew2OPpm8vR0ZDSQQ568OrOABzj1bnXewh83dqFsNF56FDzodHorYpfjmdi2dA==
X-Received: by 2002:a05:6808:2102:b0:322:7e22:da6 with SMTP id r2-20020a056808210200b003227e220da6mr7154736oiw.92.1650655367417;
        Fri, 22 Apr 2022 12:22:47 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id h186-20020acab7c3000000b002ef5106248asm1069591oif.45.2022.04.22.12.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:22:47 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Vitor Soares <vitor.soares@synopsys.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: i3c: Convert snps,dw-i3c-master to DT schema
Date:   Fri, 22 Apr 2022 14:22:36 -0500
Message-Id: <20220422192236.2594577-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Synopsys Designware I3C master to DT schema format.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/i3c/snps,dw-i3c-master.txt       | 41 ---------------
 .../bindings/i3c/snps,dw-i3c-master.yaml      | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
deleted file mode 100644
index 07f35f36085d..000000000000
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Bindings for Synopsys DesignWare I3C master block
-=================================================
-
-Required properties:
---------------------
-- compatible: shall be "snps,dw-i3c-master-1.00a"
-- clocks: shall reference the core_clk
-- interrupts: the interrupt line connected to this I3C master
-- reg: Offset and length of I3C master registers
-
-Mandatory properties defined by the generic binding (see
-Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
-
-- #address-cells: shall be set to 3
-- #size-cells: shall be set to 0
-
-Optional properties defined by the generic binding (see
-Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
-
-- i2c-scl-hz
-- i3c-scl-hz
-
-I3C device connected on the bus follow the generic description (see
-Documentation/devicetree/bindings/i3c/i3c.yaml for more details).
-
-Example:
-
-	i3c-master@2000 {
-		compatible = "snps,dw-i3c-master-1.00a";
-		#address-cells = <3>;
-		#size-cells = <0>;
-		reg = <0x02000 0x1000>;
-		interrupts = <0>;
-		clocks = <&i3cclk>;
-
-		eeprom@57{
-			compatible = "atmel,24c01";
-			reg = <0x57 0x0 0x10>;
-			pagesize = <0x8>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
new file mode 100644
index 000000000000..5b8b43e6f1e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/snps,dw-i3c-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare I3C master block
+
+maintainers:
+  - Vitor Soares <vitor.soares@synopsys.com>
+
+allOf:
+  - $ref: i3c.yaml#
+
+properties:
+  compatible:
+    const: snps,dw-i3c-master-1.00a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i3c-master@2000 {
+        compatible = "snps,dw-i3c-master-1.00a";
+        #address-cells = <3>;
+        #size-cells = <0>;
+        reg = <0x02000 0x1000>;
+        interrupts = <0>;
+        clocks = <&i3cclk>;
+
+        eeprom@57{
+            compatible = "atmel,24c01";
+            reg = <0x57 0x0 0x10>;
+            pagesize = <0x8>;
+        };
+    };
+...
-- 
2.32.0

