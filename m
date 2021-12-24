Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7847ED46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352024AbhLXIf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352012AbhLXIfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:35:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571E1C061401;
        Fri, 24 Dec 2021 00:35:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n16so6229958plc.2;
        Fri, 24 Dec 2021 00:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mm2uvqAq1NDgIJwJfJ2YPIHq64SE/UspPrYOEnsGJlo=;
        b=n7CIfUeDASsbMXDX+9O2De9SQE2VkTPN5bqO5D65C/LJGlqL1613PUq4lHz7hZBIzm
         9+FUlWoSA+N0og09TykMqBLvbIsB6XQV7PYzyzzlmNzJjqnexd7d0ruxqSOD/mFyUD9K
         ZLkqDgKv9JgLhdcXmRUTz6fjY5VWREGGWZ5IbVPUUL7zn+SfhCUxbf+CmrsI8iMHqADp
         VJZkhg/BO3nKB9E2V5JbK1szmRtLQ1Dt6YlTL2C3Dx5sCzah678AW/Lea7PeAyNos2JC
         jG8pRTI7bUbAXNxP99TfOgB18N5vlDCcBMbDfOAgqoFrUsK8DUpnhyk8g9KMY27bOZkL
         kP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mm2uvqAq1NDgIJwJfJ2YPIHq64SE/UspPrYOEnsGJlo=;
        b=PuAtXZkAE1b8pGpwmBc6brO7NFLxUb7DGGnRj5Mm+buPa9jk3XwiU5PduoMD8Bi7TA
         bFxNr5zPGOnuqK7Uvr450UidO0VCjENMPNiVl6EjHaLYgS2UgK/Ua6L2b5U/Kppvmgss
         GGamXwQ4p0NbHbkl9H4okLyfIc+i5IDIwRv4+G6oxBOhsvfl3QzU4orzlnzCpbP5Dgs9
         naET3/UUQvGLKXaw1lUMbrnAMj6kFZXrIlP4xB/8rmF2BR8d+rzAjvAHaFeeJUuC1htv
         XyI0W25CJQTE68KA3aSiNdVbs35BVo0ucXhAcTAL8YzaMEE1OytK2hu/AP79wrrqNa5d
         dsMA==
X-Gm-Message-State: AOAM532n1pblxLHcxDzrxGcINpMtMvCtFqfahpllbQW6QVZC/lLLJeCb
        uujxRUAuAmX3xIWIWaj4Tow=
X-Google-Smtp-Source: ABdhPJxpas8OK7wPfjptFdsW6nbSBOpScBtF3upWLV+g2DEmxshVRHQbEeor6xDxdIAxMCaQPr7ZJg==
X-Received: by 2002:a17:902:f701:b0:148:a2e8:276e with SMTP id h1-20020a170902f70100b00148a2e8276emr5740885plo.117.1640334952933;
        Fri, 24 Dec 2021 00:35:52 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 190sm7916293pfe.190.2021.12.24.00.35.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Dec 2021 00:35:52 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v5 1/2] dt-binding: misc: Add iop yaml file for Sunplus SP7021
Date:   Fri, 24 Dec 2021 16:35:55 +0800
Message-Id: <edc63b968d7903cc6e96151c7e51cd6446835b70.1640332430.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1640332430.git.tonyhuang.sunplus@gmail.com>
References: <cover.1640332430.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1640332430.git.tonyhuang.sunplus@gmail.com>
References: <cover.1640332430.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop yaml file for Sunplus SP7021

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v5:
-Add iop-wakeup pin for 8051 to wake up the Linux kernel in shutdown mode.

 .../devicetree/bindings/misc/sunplus-iop.yaml      | 72 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml

diff --git a/Documentation/devicetree/bindings/misc/sunplus-iop.yaml b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
new file mode 100644
index 0000000..fad0f50
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
@@ -0,0 +1,72 @@
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
+  iop-wakeup:
+    description: Notify 8051 to wake up the Linux kernel.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - memory-region
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
+        iop-wakeup = <&pctl 1 GPIO_ACTIVE_HIGH>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..071b5e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
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

