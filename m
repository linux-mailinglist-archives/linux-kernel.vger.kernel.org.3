Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0421350C0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 22:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiDVUmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 16:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiDVUmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:42:49 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D380FC41B;
        Fri, 22 Apr 2022 12:40:06 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id e189so10124488oia.8;
        Fri, 22 Apr 2022 12:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESSxqxOQpi/fkkAwzK1UrVnLgRLoSXvjLv+Y8gGFxH8=;
        b=KBSV6/zs/OISGl5rNqgfUwsQpwwM8US73rqNfg8cwsA7s+1WvAYGfca106l63TUgi7
         vCSTPUZKvCXcFpg63yf+F23S9+fFyIA5pxeEVFxJlFIh0WAhFfV0T/fBl5HAuk5MKWnM
         d3sPGtmICGbNdP4wAD3WwRGesr2+lrLJqFjSUzxMNWV2kdDdKWOcu3h6UZdI24zvrnq3
         k/NU2Ca4XRu+MdMieuF/wkFjvG4C+sVI2n0QPX4NS73ThU1yb2VlBXMLMtpwRB1eV8A3
         D9k3ywDevLc8Ut1Ub6EA8hYlbxooq98+2aa0JJmES87QL5ax1lPsYTl+VcRX55isdI/y
         5jRA==
X-Gm-Message-State: AOAM530NTMCvAWbhWeSBqIA5Icx3Q3293D04h8ow9vWsCX4s+kYfdp4h
        6dP6pDYak5TTxuR+JvYML4WF2T78Cw==
X-Google-Smtp-Source: ABdhPJzTgaHRHiSVw3JzlGm13jAQRd5uoKS4VQdRiI/I0L2A+6xlR5NxOtX6aFqeBAGEY8uYjV7r1g==
X-Received: by 2002:a05:6870:2314:b0:e2:a480:eb4d with SMTP id w20-20020a056870231400b000e2a480eb4dmr2580363oao.133.1650655353558;
        Fri, 22 Apr 2022 12:22:33 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id oa9-20020a056870bc0900b000e60e510d5esm928487oab.25.2022.04.22.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:22:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: i3c: Convert cdns,i3c-master to DT schema
Date:   Fri, 22 Apr 2022 14:22:23 -0500
Message-Id: <20220422192224.2594098-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Cadence I3C master to DT schema format. This fixes a warning
as it is used in the i3c.yaml example.

The "nintendo,nunchuk" is not documented by a schema, so change the
example child device to something which is documented.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/i3c/cdns,i3c-master.txt          | 43 -------------
 .../bindings/i3c/cdns,i3c-master.yaml         | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml

diff --git a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
deleted file mode 100644
index 3716589d6999..000000000000
--- a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-Bindings for cadence I3C master block
-=====================================
-
-Required properties:
---------------------
-- compatible: shall be "cdns,i3c-master"
-- clocks: shall reference the pclk and sysclk
-- clock-names: shall contain "pclk" and "sysclk"
-- interrupts: the interrupt line connected to this I3C master
-- reg: I3C master registers
-
-Mandatory properties defined by the generic binding (see
-Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
-
-- #address-cells: shall be set to 1
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
-	i3c-master@0d040000 {
-		compatible = "cdns,i3c-master";
-		clocks = <&coreclock>, <&i3csysclock>;
-		clock-names = "pclk", "sysclk";
-		interrupts = <3 0>;
-		reg = <0x0d040000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-scl-hz = <100000>;
-
-		nunchuk: nunchuk@52 {
-			compatible = "nintendo,nunchuk";
-			reg = <0x52 0x0 0x10>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
new file mode 100644
index 000000000000..cc40d25358ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/cdns,i3c-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence I3C master block
+
+maintainers:
+  - Boris Brezillon <bbrezillon@kernel.org>
+
+allOf:
+  - $ref: i3c.yaml#
+
+properties:
+  compatible:
+    const: cdns,i3c-master
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: sysclk
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i3c-master@d040000 {
+        compatible = "cdns,i3c-master";
+        clocks = <&coreclock>, <&i3csysclock>;
+        clock-names = "pclk", "sysclk";
+        interrupts = <3 0>;
+        reg = <0x0d040000 0x1000>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+        i2c-scl-hz = <100000>;
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

