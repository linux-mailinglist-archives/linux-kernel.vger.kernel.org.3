Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C421492179
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbiARImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbiARImf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:42:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AEAC061574;
        Tue, 18 Jan 2022 00:42:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n11so21771526plf.4;
        Tue, 18 Jan 2022 00:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sRZuPiTJEdUveDe9XIdJ0lUjQKiDquSQ6JLnsl7QR58=;
        b=Gu2FBVZCx6kiarInipQ0w9zFoUSfLZ9p06ySp+7+l17ICUL+pQchtXhIrjfK/V1ZAm
         W3LF7Ka3JVlbDC43lHvC8mJtJvqYIiofRvTR7jEcwoLcBM0tUGgMcX5wC3kPYKNUo/wg
         1p2G8FHRTBrQH8ehSktXNMrFtBmYxUM29uZw6htNO9ukvguZvz/b9FGJRlolfXfu224c
         R1VROYURd6DT4hl9Z5ZX9Av4w4EpUSeOTMxXGXlOO7mE5vV0SsxgJ7kyLrND+3IQoCSP
         ew+fAEbWzBvYsBZITN+5f8CzFidZEHmYfoVwEzRcF5WgGvfKjPieyA8XHimMql/Wxqjc
         tXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sRZuPiTJEdUveDe9XIdJ0lUjQKiDquSQ6JLnsl7QR58=;
        b=qEXYIJV3bMfhm9Tp/m2O5E6dH1hfq0GnsVAflcsqaBZAdwm4vY9lqgD1WkTi45f7yG
         t0q7+MAEe/GDJKJ5kAFY3s//8enzPRF+4M3szsnLCCfSSuU46001rKhiexkH//lf8EVk
         6QHbEOiqT5Adpzd2BfADhcWTXy7q0/69hw9u3XV3B/NgTel6LCXQxvZrrabxpGeVGdxD
         5FYNYZnnIzoKmVKJ6QZusjXWuViidPhg3o910BXritrhvEUHPu/q/hLlLJXYM9/4cBcC
         FHxuv2SyVZbN/rIXiWrZ+TASvFs4CsSAkML1dD96wfLJzw3wjL6Rir8htTO+WGBmAoF3
         UdUQ==
X-Gm-Message-State: AOAM531D0LamDrldmldhcHHs/EUVyceyT8mJYVAWhoBhJ1o03PyINmwR
        riLDsv9mWiFhhMYeGMcVBNw=
X-Google-Smtp-Source: ABdhPJz8NXo0bWLTerju3Y0YAPe17DR8GQN1x+yx/bIbFUJq+EuqubAI5zhnSKbEA8BuUVVCUwtXLw==
X-Received: by 2002:a17:90b:1d11:: with SMTP id on17mr20756778pjb.167.1642495354817;
        Tue, 18 Jan 2022 00:42:34 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id t199sm14227787pgb.64.2022.01.18.00.42.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jan 2022 00:42:34 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org,
        andyshevchenko@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v6 2/2] dt-bindings:spi: Add Sunplus SP7021 schema
Date:   Tue, 18 Jan 2022 16:42:39 +0800
Message-Id: <ef6d893b10afb7f76a910da031a0040c4596cd76.1642494310.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1642494310.git.lhjeff911@gmail.com>
References: <cover.1642494310.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1642494310.git.lhjeff911@gmail.com>
References: <cover.1642494310.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Sunplus SP7021 spi driver

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v6:
 - Change the interrupt-names 
   mas_risc to master_risc
 - Addressed comments from Mr. Andy Shevchenko
   Change the function name: mas is master and sla is slave.
   Add temporary varilable (as suggested by Mr. Andy Shevchenko)
   Modify clk setting
   Modify the master-slave detection of the probe function.(as suggested by Mr. Andy Shevchenko)
   Modify the return value of the probe function.(as suggested by Mr. Andy Shevchenko)
   Change GPL version(as suggested by Mr. Andy Shevchenko)

 .../bindings/spi/spi-sunplus-sp7021.yaml           | 81 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
new file mode 100644
index 0000000..24382cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-sunplus-sp7021.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus sp7021 SPI controller
+
+allOf:
+  - $ref: "spi-controller.yaml"
+
+maintainers:
+  - Li-hao Kuo <lhjeff911@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-spi
+
+  reg:
+    items:
+      - the SPI master registers
+      - the SPI slave registers
+
+  reg-names:
+    items:
+      - const: master
+      - const: slave
+
+  interrupt-names:
+    items:
+      - const: dma_w
+      - const: master_risc
+      - const: slave_risc
+
+  interrupts:
+    minItems: 3
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clocks-names
+  - resets
+  - pinctrl-names
+  - pinctrl-0
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sp-sp7021.h>
+    #include <dt-bindings/reset/sp-sp7021.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi@9C002D80 {
+        compatible = "sunplus,sp7021-spi";
+        reg = <0x9C002D80 0x80>, <0x9C002E00 0x80>;
+        reg-names = "master", "slave";
+        interrupt-parent = <&intc>;
+        interrupt-names = "dma_w",
+                          "master_risc",
+                          "slave_risc";
+        interrupts = <144 IRQ_TYPE_LEVEL_HIGH>,
+                     <146 IRQ_TYPE_LEVEL_HIGH>,
+                     <145 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc SPI_COMBO_0>;
+        resets = <&rstc RST_SPI_COMBO_0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pins_spi0>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a07da20..2e14650 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18497,6 +18497,7 @@ SUNPLUS SPI CONTROLLER INTERFACE DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 F:	drivers/spi/spi-sunplus-sp7021.c
 
 SUPERH
-- 
2.7.4

