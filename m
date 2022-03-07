Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3186B4CF0E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiCGFZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiCGFZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:25:46 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439913F35;
        Sun,  6 Mar 2022 21:24:53 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d187so12749170pfa.10;
        Sun, 06 Mar 2022 21:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8I2/8nvosmtRl+beVC0+BuqGr1AZuni8ODmoavP7CwY=;
        b=IQhcd7Oaf3TcdDi77/pJUHONWk0xCmhBlng7zjfO6lkfJ/QYYxGsVZ36R9BoslPAkO
         Tp7YncgvDCsqkDQo5qA1A9HQAtrSo0bf9AL7YGM/m4fTRKiUKptApVqsOGWxGDTVnkW0
         7TyZbteIuAmQRsMDAYuqFUxl/c3Xq18lmCfLbV6bcxqNviA++Ldx+ud2TqyMiOufB1Xd
         iuQSQ4Did+uTyaUH/guN4gmYELvhr7RPKA+vTaFlqKb5SusEIqHk3cDk3MO+jMpSZHEr
         NJmLc6AlIoP4US65ITfaRPDiSTQNgHgSBIam8WGpTlLmewS4QpbHHlG37eyxtyeMUcg/
         OikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8I2/8nvosmtRl+beVC0+BuqGr1AZuni8ODmoavP7CwY=;
        b=22WT5xdGwcy/klM6DCImCiQJM0U7DGR+MEYVY/tfGuTnAptbwd6ez3EPgPg86vnRJ2
         CJZGhjxwgWOFko5sfEOvmjYOkDRGdbRkorAnM/oxh+KYQoiuvFSj5EuBdi76XRUIs1K0
         TWWj37xNKYkLGix54V2McLAbH8Bb8iZurqJTa8CXVwNP9/pkXX05Uw0uY3ryPY6S2jPA
         8o9L4F7ybpB36IpaOF8VEfNsBwIQwArRRCLlRFDtPGM0DNlEAmA5nK4fjSr3HepRGkRt
         DSmSv7/sCvF7EqrudW13+Q7d7Tl6CMv+ve47AluJwLzcCr6+CM+b+KcJGifSmkA+Jw5c
         T2jQ==
X-Gm-Message-State: AOAM530PVslt2eXG0sNqUqM8SakqbEcqIHad8mQxZpvE1+C9t00oXc4M
        6ElZSeHuZxCZ8hu98BmNSZU=
X-Google-Smtp-Source: ABdhPJwW1ztPy8LWSk6lN/usFrpo2CA2G7U0OZmu/52IKai9A0YguZ1Iu4V4F7fhkWpYSDLE4pL3YQ==
X-Received: by 2002:a62:7c03:0:b0:4f7:6a0:6835 with SMTP id x3-20020a627c03000000b004f706a06835mr2357571pfc.72.1646630692767;
        Sun, 06 Mar 2022 21:24:52 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id z2-20020a17090a170200b001bf2d530d64sm9767170pjd.2.2022.03.06.21.24.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2022 21:24:52 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        Dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v10 1/2] dt-binding: misc: Add iop yaml file for Sunplus SP7021
Date:   Mon,  7 Mar 2022 13:25:08 +0800
Message-Id: <57d8c6d8ce52e7152156f2fcc4b61bfd2fed1c40.1646629400.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1646629400.git.tonyhuang.sunplus@gmail.com>
References: <cover.1646629400.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1646629400.git.tonyhuang.sunplus@gmail.com>
References: <cover.1646629400.git.tonyhuang.sunplus@gmail.com>
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
Changes in v10:
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

