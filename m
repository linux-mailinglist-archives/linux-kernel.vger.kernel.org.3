Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF594AB4E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349391AbiBGGhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiBGG35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:29:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A211FC043184;
        Sun,  6 Feb 2022 22:29:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u12so3280747plq.10;
        Sun, 06 Feb 2022 22:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CpQoC6BpaQ14c8xpHvHSZfO/e4PX8wXeyUZwi9sox80=;
        b=PzxDlZnPz3s/zC5c+Q+Qff1agP8y6AcfDt7nMu1PfK8r7BW3qRjh1ebpf6K0POgcNt
         TWBRF8ECWbY1cT4urFgVA3pdPlpAGeWGjQ7FTmpWKLa/njcrKtYaX1j1yXbKZVYVR8zP
         KvdnWhATWQtshPwjcc2JV7JpqtMMgDx6WT1kIOUI1R+eaQc3mTCVeEtghW50usvokPYq
         /6XaWSIGMl6YDhZFLmSF0hvBUiT7pAOVh2/Ig8Kpf1jxeRDN+B43dxVx+TEqCZ6V2BGp
         B2HuvJkUItJ9V3cmHUb+liPzbp6E3ur+q0kEMgWeFLNJED18bAOK7pQMmfegmA/cwXbw
         9O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CpQoC6BpaQ14c8xpHvHSZfO/e4PX8wXeyUZwi9sox80=;
        b=mvOwbecZ5/VfQNMPrFw2AwBtZ1PbTcQK9LqPMQzr3LHKf4erAgHNR7jEELGlbwK+TF
         i+Oy9VT/mItE4JqzusKIC1AMYXJhJpsf4BLN+P8X3teY0KvOjz3If3oOrJmTx0pJxJtF
         7xoeAzbjPHe75cH1aUhgGlkSwsWPykmjDYGSgzmAssKnXsTT6Q2zEMO2LI56qVemYjUq
         n6V55SE3eng5XeP+Jiddo4eEZDksHOI90GJNEF7dhionMa6e/7bM8iN1Q7qbQ0Ubbh62
         ztZOpGmIolUkAT8hFxLJROquuKHfeSJt1qGNvuXAHH2Jru/8ScuzNY9sNd+/nKcz9YFq
         ujcg==
X-Gm-Message-State: AOAM5339/qut6WkfbCJA2Az5shEeVRcPcv36tIs40u0vq36RPFKNjFfl
        DurMPGOefUO0gL7o69lkRMI=
X-Google-Smtp-Source: ABdhPJzMYJ7HvvqDLUzu+yH57sJdcIwB1e5pkvzwAyo0Lb4imKeyCI4hwznQXo/NsOpWwQHAAaxn8w==
X-Received: by 2002:a17:90b:4f4b:: with SMTP id pj11mr16701231pjb.120.1644215396173;
        Sun, 06 Feb 2022 22:29:56 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id j8sm3994386pjc.11.2022.02.06.22.29.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Feb 2022 22:29:55 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, tony.huang@sunplus.com,
        wells.lu@sunplus.com
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v8 1/2] dt-binding: misc: Add iop yaml file for Sunplus SP7021
Date:   Mon,  7 Feb 2022 14:30:05 +0800
Message-Id: <9aa1c339079d919bd780146a93a6db226486373c.1644212476.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1644212476.git.tonyhuang.sunplus@gmail.com>
References: <cover.1644212476.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1644212476.git.tonyhuang.sunplus@gmail.com>
References: <cover.1644212476.git.tonyhuang.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop yaml file for Sunplus SP7021

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v8:
 -No change

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

