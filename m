Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCF48905C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiAJGr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbiAJGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:47:18 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059AC061756;
        Sun,  9 Jan 2022 22:47:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id l8so8832211plt.6;
        Sun, 09 Jan 2022 22:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=K+JqE2tyTorqvR6yS5YtYuj0Oj8mlqpF/CiPy9CvjgM=;
        b=LSr5KBYIUOQD8ty2YNv/MUd2OZ+xWEkIBkx7F1jcFFaD58MJSBuZw1Y9VLYnWtNrFt
         IuMb7WiF0bufl0qorzQHcAZTrUFxB/9YbsOSK8hrrYMP9Ycxs39F7Za5BLEi28upAwRb
         ajrjqYLoN7ee1/rNWxX0xWQOn7ku5BSyvlvdvWeS76QB08+q+Qwsz8QpxVxgvzk9AP7u
         zj7gyd01sy+ifp8nLcFKES3IZiSmrDkNMlyhAoss1Lxc075HMeVo+x+IZXxQfTPWq8MF
         OzhwbrYwQAOnTiFWmGsibikgWs+Dt3O7Ab3X3VGpVv/XHHBJ/yphFTz/kuBCdqFioOqR
         ba4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=K+JqE2tyTorqvR6yS5YtYuj0Oj8mlqpF/CiPy9CvjgM=;
        b=8KVqUDjQ8oijBUbbtK6KsaesC5MopFgsEK+I2/sjw+OEF9b4io0EcUpcA0bmXxr5V/
         6aLyF90WkvG8iGFqLpjIzkFp7oiZh3xDC5QHzdpq4M0FYIOBvTPXKXhsvAllAMFvuMEo
         MawOF9DM/17jAiB4CtIH02WfBAY+e05Hzv579jE6RZVEKJBI70qtmIkJkxxxuLL9vyhy
         RR4AbNmMKgFQfq93kmJsVYpTobHFLSy39qRBm4/0Tx1QYJxII5EoE5qw/BMCWuA4W9l7
         ENKfDyElpgwdRhHV6MoFIpQA1Vskicnctv5EhHuFHK6BxtI91oIU5z40tdfmKZ+9yIN3
         klDw==
X-Gm-Message-State: AOAM530UbkWxVvIsjOKNPZSSsvN+EBjGPEz9JtUcy+kP5kxicMFwryWn
        Nk3w/dcT8KiRcvjYXRQERh4=
X-Google-Smtp-Source: ABdhPJwgSQxklCgMXo6h7bguV9tbQ+BDpS6es7UEy9b06uHhzF3WE3Ub7yXLyGPp6y+NIkO4J5sIzg==
X-Received: by 2002:a17:90a:c24d:: with SMTP id d13mr8360036pjx.238.1641797238016;
        Sun, 09 Jan 2022 22:47:18 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h4sm5591031pfi.79.2022.01.09.22.47.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 22:47:17 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org,
        andyshevchenko@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v5 2/2] devicetree: bindings SPI Add bindings doc for Sunplus SP7021
Date:   Mon, 10 Jan 2022 14:47:22 +0800
Message-Id: <7d25d1ee004dd668bc5cc122912c5dbeb6ff245f.1641797029.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1641797029.git.lhjeff911@gmail.com>
References: <cover.1641797029.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1641797029.git.lhjeff911@gmail.com>
References: <cover.1641797029.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings SPI Add bindings doc for Sunplus SP7021

Reviewed by Mr. Rob Herring <robh+dt@kernel.org>
Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v5:
 - no change.
 - Reviewed by Mr. Rob Herring <robh+dt@kernel.org>

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
index 1732a9e..2f487be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18247,6 +18247,7 @@ SUNPLUS SPI CONTROLLER INTERFACE DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 F:	drivers/spi/spi-sunplus-sp7021.c
 
 SUPERH
-- 
2.7.4

