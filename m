Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B110F481C34
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhL3Mvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbhL3Mvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:51:43 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23C4C061574;
        Thu, 30 Dec 2021 04:51:42 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 8so21341146pfo.4;
        Thu, 30 Dec 2021 04:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9QtTi9fKakj4bVF7btD7tsID9ReBIBxpflveOKOIa9E=;
        b=ZD+1IjtvFMswAs0PUW3ZeGSNIUdipXp96d3bpu0l3cjiU9LR1COtUxkmCiMqTsWpV8
         I248ZjbP4jlvAbCJc3GjTLhzcXT3oNpZOS9hHx5IasMAQrjHkktUYKq30B4WMdsLItrV
         1T4hoEXQxbXzIgfUZk2xuYwgxbTFUXpiL4/Q7+/T3VZKdAiow1E9DVEBsGdbXk5mjki1
         evMW6IEvlJ7+J56LNXGIcIDjN3NL7dV4B8f7Vn7c0b3zBu4PtzE5K2S7JGdh8iYWQ4Pt
         0O4DUmZT6dKlTJwr9J1Xph/sv/GyfabCRZND/iTQYAsHEXJIraPWejpWMA/sBIRsRAI+
         C81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9QtTi9fKakj4bVF7btD7tsID9ReBIBxpflveOKOIa9E=;
        b=1Uv9I/k3GrdIc6kVlxT2OyVIEzTTQ8BBd6RXYnMPezUOva+vKpSqU/t1ywh/SFSEFI
         URILhY5yv6zlC4L1KHOMo+MAPfALNnAhJlDaHF1UqbpYTHTySkyA4UCKMHFlN+3TeMSj
         xRR7s7kqWqdGTuJR4CGT15HOxNjJbqkCEE+9dcDlTbzTiFZeULQSFd+IsbaxFXtLbDTr
         0IExETBdQ+dL8ATe0jaMbY9IgOKDO+0vJD7sphsnGV/ZI7ja0EaB9zbbIQY8TFUIV1XF
         8JeN21MA+3IkkreaR+y4FsW1VMjkbPow5PR04r3VhrXdFlkJOv7ki7KCOaYIWodvCzVy
         M2Ag==
X-Gm-Message-State: AOAM533pTElq8OTI+2/+OYg+UAIJRnMREr8RJdYWvv/v2iLTPcE143K1
        CZaOo9g5FiKQOMtZLQ+/llI=
X-Google-Smtp-Source: ABdhPJw7/vfmP6vAK8Kmv8CmmglKryc/kyvsQ6Xtf6Q/MWg1KIAbu1zKyTiGNhlOE/7U+vMixJx0fQ==
X-Received: by 2002:a05:6a00:d6d:b0:4bc:f86:335d with SMTP id n45-20020a056a000d6d00b004bc0f86335dmr14241830pfv.23.1640868702512;
        Thu, 30 Dec 2021 04:51:42 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id e12sm19217864pjs.35.2021.12.30.04.51.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Dec 2021 04:51:42 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v6 1/2] dt-binding: misc: Add iop yaml file for Sunplus SP7021
Date:   Thu, 30 Dec 2021 20:51:44 +0800
Message-Id: <f1acc53155bbc724db24d8957b0dc18b154461ba.1640836400.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1640836400.git.tonyhuang.sunplus@gmail.com>
References: <cover.1640836400.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1640836400.git.tonyhuang.sunplus@gmail.com>
References: <cover.1640836400.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop yaml file for Sunplus SP7021

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v6:
 -Modify incorrect name of gpio. Added wakeup-gpios pin for 8051.

 .../devicetree/bindings/misc/sunplus-iop.yaml      | 76 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml

diff --git a/Documentation/devicetree/bindings/misc/sunplus-iop.yaml b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
new file mode 100644
index 0000000..b37e697
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Ltd. Co. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/sunplus-iop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus IOP(8051) controller
+
+maintainers:
+  - Tony Huang <tonyhuang.sunplus@gmail.com>
+
+description: |
+  Processor for I/O control, RTC wake-up procedure management,
+  and cooperation with CPU&PMC in power management.
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-iop
+
+  reg:
+    items:
+      - description: IOP registers regions
+      - description: PMC registers regions
+      - description: MOON0 registers regions
+
+  reg-names:
+    items:
+      - const: iop
+      - const: iop_pmc
+      - const: moon0
+
+  interrupts:
+    items:
+      - description: IOP_INT0. IOP to system Interrupt 0.
+                     Sent by IOP to system RISC.
+      - description: IOP_INT1. IOP to System Interrupt 1.
+                     Sent by IOP to system RISC.
+
+  memory-region:
+    maxItems: 1
+
+  wakeup-gpios:
+    description: When the linux kernel system is powered off.
+      8051 is always powered. 8051 cand receive external signals
+      according to this gpio pin. 8051 receives external signal
+      through gpio pin. 8051 can power on linux kernel system.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - memory-region
+  - wakeup-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+    iop: iop@9c000400 {
+        compatible = "sunplus,sp7021-iop";
+        reg = <0x9c000400 0x80>, <0x9c003100 0x80>, <0x9c000000 0x80>;
+        reg-names = "iop", "iop_pmc", "moon0";
+        interrupt-parent = <&intc>;
+        interrupts = <41 IRQ_TYPE_LEVEL_HIGH>, <42 IRQ_TYPE_LEVEL_HIGH>;
+        memory-region = <&iop_reserve>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&iop_pins>;
+        wakeup-gpios = <&pctl 1 GPIO_ACTIVE_HIGH>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7..6f336c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS IOP DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

