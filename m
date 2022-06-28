Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ECB55E39B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345776AbiF1Mp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiF1MpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B45193ED;
        Tue, 28 Jun 2022 05:45:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id fd6so17390766edb.5;
        Tue, 28 Jun 2022 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAna91f+tExWr/xWBecqjF79wZKKeqItDZrQk9dt538=;
        b=Sblb9A+txozzU3Urkkt5DVK0X8vW5h35NCjvQGnC8IdzJP8IskPVuBwJkTMIpo6mBf
         9Y5qFSvLioo2V1KgLZ6VMzanYI2xnoroG+Klqq1GbrwkDhhnpQALto2hVW/qjzKrb6Hb
         wyKQPCkPVP3ICPyfXH9YhIbtUuRqWmS7tW+dWPxpdqkDNvhiSeM8PJUWBJxzNrXzt95N
         ehftd/9GtMoEqs0hjB7Y7D3su6I21X1USbUHtX5sYjcwz4EyRKyB2fPLw+JSmp24hyI4
         Cv0U+L5aGHpx6MQLzrV/nddZQ4nzOgZ57ZK4C4YOhQ2cNrhTYfzw/UUP2FBqQxZHWIJM
         XgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAna91f+tExWr/xWBecqjF79wZKKeqItDZrQk9dt538=;
        b=QWqpkVIwfQ/hpT8GC6VVnQ8D+7xqvVXOt1pG7s/xbYcWhg1k1A/e3j7hIBC+qjiKgD
         rsxOSzY/n8R/L7O9lj/Btk40XbB5M101pIRrOqxAgQZBkyBZYPeKHPd43YetXlTlfP33
         JUAHmIe/bzd5NuEB3KScbZPpjY+FsQSlIjpp+IVYOoeL21zbIeXK4vyZyW2FRsBkDGS4
         nfBX6kK//bGQ7RpmX8RGsF4J29X7ZATqUAwH7JD+2mqT6KzOsYYm9yyKvdwB4THh/to5
         0464cG+BAy1tIpWwE3WiVXweMzZTqSCZsyOsUmg8s7JrkrDtZzz5zDURzPyDcV5RBJIT
         80mA==
X-Gm-Message-State: AJIora8CiLUJVlM2aXUM/icsp/QAWXZKiFePcIEXnkVLkQRBmn8abGad
        G8tSfUjFxuWSUqJ07BhyzsA=
X-Google-Smtp-Source: AGRyM1svJ8HWxHMKZ5Pu+TeawAFOCOEc/Rr1r9IR8nhjJ1l4ClmXg77Faof3WxaqAt2jTvIMO2mSpg==
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id ew4-20020a056402538400b004316d84b451mr22821873edb.46.1656420317609;
        Tue, 28 Jun 2022 05:45:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm622871ejx.173.2022.06.28.05.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:45:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/9] dt-bindings: phy: lantiq: xway-rcu-usb2-phy: Convert to YAML
Date:   Tue, 28 Jun 2022 14:44:33 +0200
Message-Id: <20220628124441.2385023-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
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

Convert the Lantiq XWAY RCU USB2 PHY bindings to YAML.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../phy/lantiq,xway-rcu-usb2-phy.yaml         | 68 +++++++++++++++++++
 .../bindings/phy/phy-lantiq-rcu-usb2.txt      | 40 -----------
 2 files changed, 68 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/lantiq,xway-rcu-usb2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt

diff --git a/Documentation/devicetree/bindings/phy/lantiq,xway-rcu-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/lantiq,xway-rcu-usb2-phy.yaml
new file mode 100644
index 000000000000..702a8e8c64b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/lantiq,xway-rcu-usb2-phy.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/lantiq,xway-rcu-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+properties:
+  "#phy-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - lantiq,ase-usb2-phy
+      - lantiq,danube-usb2-phy
+      - lantiq,xrx100-usb2-phy
+      - lantiq,xrx200-usb2-phy
+      - lantiq,xrx300-usb2-phy
+
+  reg:
+    minItems: 2
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: phy
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: phy
+      - const: ctrl
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    usb_phy0: usb2-phy@18 {
+        compatible = "lantiq,xrx200-usb2-phy";
+        reg = <0x18 4>, <0x38 4>;
+
+        clocks = <&pmu_USB0_PHY>;
+        clock-names = "phy";
+
+        resets = <&reset1 4 4>, <&reset0 4 4>;
+        reset-names = "phy", "ctrl";
+
+        #phy-cells = <0>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
deleted file mode 100644
index 643948b6b576..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
-===========================================
-
-This binding describes the USB PHY hardware provided by the RCU module on the
-Lantiq XWAY SoCs.
-
-This node has to be a sub node of the Lantiq RCU block.
-
--------------------------------------------------------------------------------
-Required properties (controller (parent) node):
-- compatible	: Should be one of
-			"lantiq,ase-usb2-phy"
-			"lantiq,danube-usb2-phy"
-			"lantiq,xrx100-usb2-phy"
-			"lantiq,xrx200-usb2-phy"
-			"lantiq,xrx300-usb2-phy"
-- reg		: Defines the following sets of registers in the parent
-		  syscon device
-			- Offset of the USB PHY configuration register
-			- Offset of the USB Analog configuration
-			  register (only for xrx200 and xrx200)
-- clocks	: References to the (PMU) "phy" clk gate.
-- clock-names	: Must be "phy"
-- resets	: References to the RCU USB configuration reset bits.
-- reset-names	: Must be one of the following:
-			"phy" (optional)
-			"ctrl" (shared)
-
--------------------------------------------------------------------------------
-Example for the USB PHYs on an xRX200 SoC:
-	usb_phy0: usb2-phy@18 {
-		compatible = "lantiq,xrx200-usb2-phy";
-		reg = <0x18 4>, <0x38 4>;
-
-		clocks = <&pmu PMU_GATE_USB0_PHY>;
-		clock-names = "phy";
-		resets = <&reset1 4 4>, <&reset0 4 4>;
-		reset-names = "phy", "ctrl";
-		#phy-cells = <0>;
-	};
-- 
2.36.1

