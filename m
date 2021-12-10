Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED94946FD4B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbhLJJG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbhLJJGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:06:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEC6C061353;
        Fri, 10 Dec 2021 01:02:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so6958004pjb.5;
        Fri, 10 Dec 2021 01:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bmcYzMvj4e9sgnz7LyE1ZF8i1bkPVW4jnQsHZMis6Js=;
        b=GbdWDbJb6mNb0hLXNPEdUTZ6nzyGE6Ionvvz1k0sIrShLMFNUeCnCyDKVfsS59p2OA
         ho6yxak8h25KReHpIx1ZBxJAWgOa30jrWStT+V1k0d48P2DYzHLP6B2SwK1BEntnF2qz
         Rgr4wOF3Og2RH4Hgo0abOXXEcEXx0PUC5UeRpeb6C2DxKDsxd3QISvDpEcX78ks5e41e
         XrqUUL2eAZ5tES4fkjZczNzg6H+9oytr8XdN/SA8HXEXwa2PNaxv1C7sAo8hsqYP5t5p
         QEnX80OthL40SWIOCopJjboSTLNEQv3jq8w7n9QXtfmjKLGWkFS0Y112nx0CZaK+e6ki
         fFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bmcYzMvj4e9sgnz7LyE1ZF8i1bkPVW4jnQsHZMis6Js=;
        b=urSG0zFEmBezkPnnXFxl+CpqBdSYDNPtSQO5DmXbmrYGwHq0u+aqWio1SfpEYQG3w2
         vemt1kFTK1V5XQMXnZg0VeVVlRJbRGCHMC8opNIbUpyxUkRr9aYfBoDm+eM1qcb2Y1y6
         nP7OqvzIHzvbF5XxpIIOL4YixGlmJ39aIpL0Z+G8BGkeyGK40IIGT/wpt4LXfm+fQRtm
         HSCspGc5mxdc36rCdvVNwhO0o/z0OsGQpNbTW0gGxTJfa17pTxcfsLtA89IaG88R6tlC
         Ilqp/g57k/cpTcQCM0ibV+YS8o8RGf7GCH+rRzEgjvzmySMcvWtm6Yn/Qee8HElb6dGu
         BtOg==
X-Gm-Message-State: AOAM5321oxcfhq6RWRblGPdr79pp05gfnPydskqyBtPMba1tm8YxVk6/
        57D9ScBILV+GhwtCepYZtRc=
X-Google-Smtp-Source: ABdhPJzTFvBVJfdUEs/gmGdix16UrSXFnpt1YVyOQEc3Qjt8Bo+NcKDMmxy7tvzQ2WF/yQ9Bsh+/2A==
X-Received: by 2002:a17:90b:1806:: with SMTP id lw6mr21896229pjb.53.1639126968819;
        Fri, 10 Dec 2021 01:02:48 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h15sm2540790pfc.134.2021.12.10.01.02.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 01:02:48 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org,
        andyshevchenko@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        "Li-hao Kuo" <lhjeff911@gmail.com>
Subject: [PATCH v4 2/2] devicetree: bindings SPI Add bindings doc for Sunplus SP7021
Date:   Fri, 10 Dec 2021 17:02:48 +0800
Message-Id: <09f5be1f5c87a05e155dd09e76f074ce38840588.1639123362.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1639123362.git.lhjeff911@gmail.com>
References: <cover.1639123362.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1639123362.git.lhjeff911@gmail.com>
References: <cover.1639123362.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Li-hao Kuo" <lhjeff911@gmail.com>

Add devicetree bindings SPI Add bindings doc for Sunplus SP7021

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v4:
 - Addressed all comments from Mr. Philipp Zabel
 - Addressed all comments from Mr. Rob Herring
 - Addressed all comments from Mr. Andy Shevchenko
 
 .../bindings/spi/spi-sunplus-sp7021.yaml           | 81 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
new file mode 100644
index 0000000..096bfae
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
+      - const: mas_risc
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
+                          "mas_risc",
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
index 91f5707..ee428d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18237,6 +18237,7 @@ SUNPLUS SPI CONTROLLER INTERFACE DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 F:	drivers/spi/spi-sunplus-sp7021.c
 
 SUPERH
-- 
2.7.4

