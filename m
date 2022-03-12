Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8494D6FFA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiCLQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 11:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCLQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 11:16:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79F858E77;
        Sat, 12 Mar 2022 08:15:53 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d19so3227364pfv.7;
        Sat, 12 Mar 2022 08:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yrcD1G6HHwDCRU9+/o880Il2ZFF6sGg4EeKix4IPxpk=;
        b=YfxIT3wYkQZ+MAsiC64PTdErbpzTuSyTM9KFgxKFrBY39ky/FiWB8N0ntSk1cQGyQr
         XN7QLFVk2x0mnyyPy18E/j0s9nFMEiTsGqM6lIyLsHETC8xJ2gFJd6N7pMLoA0OquJtY
         7/LT9MuXjH+5FLk9AKu0O3CpycjSPdvrJo5FGeUdQjjeiBo5Whlm0whEAXsZUp9y7zrf
         vSpapL5y9R9c68dIL2siEAwggoQ8/+u+XRHOlr+qb572krG5uWrQqyoHAtc6/CnY+Ddi
         Jm0Jr7BPu/iVgBSjnqoawub30/0Z6pZc8dF7bEvM0s525rd/4lNV5bfY7CgC708VD7pW
         xx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yrcD1G6HHwDCRU9+/o880Il2ZFF6sGg4EeKix4IPxpk=;
        b=tWZcCQMkz7nf+7urlYZjemwRYBfMGieT5erKbxO8bo47tEYgXa5uhUUl6jotNI7Cnv
         p4eznyXHwQrot4ay+tUPZQbPKuvgVXE5U1bvCn3FylS3Nb2My1jwonl7NujrwvpB35X9
         wAgzJVpzej7iXbwU2MmOU92CGlXkdll/uJ1+WEXxZ+ltksereBowno/C/gCgwP6AP7XV
         ulMTrMeDvSyRg0ZNxlPezcmsvh3AngCN645du58jCevjhRoeVJNGm9zMj8I7IYHIkD7P
         Fvg/kN+wPQ1S8sRQb+l2p6j/Pq6XYPGkyyP1DPXXCzArV5m+X9w/9QVxy5FPCAz1/hj/
         KzoA==
X-Gm-Message-State: AOAM530fmeIirvtwXXd3CZgyVne44glRGjtWNWh48HtU7++axhqBpqKb
        h3NfrIpKa/0deinjaccB/2wfDwErrJI=
X-Google-Smtp-Source: ABdhPJy4PTix7RP8IV4oZUqxrz4J8PP6DlfpSYIOxRm7TgZELdUnkBt+HKYNCz9tZuFvenEI/i8/fQ==
X-Received: by 2002:a63:82c7:0:b0:37c:8729:a70c with SMTP id w190-20020a6382c7000000b0037c8729a70cmr13339835pgd.108.1647101752993;
        Sat, 12 Mar 2022 08:15:52 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id js15-20020a17090b148f00b001bfc8614b93sm9735079pjb.1.2022.03.12.08.15.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Mar 2022 08:15:52 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, krzysztof.kozlowski@canonical.com
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v11 1/2] dt-bindings: misc: Add iop yaml file for Sunplus SP7021
Date:   Sun, 13 Mar 2022 00:16:04 +0800
Message-Id: <c0ef91adc0af9fedca2791e4006009fabfdfef2c.1647095774.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1647095774.git.tonyhuang.sunplus@gmail.com>
References: <cover.1647095774.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1647095774.git.tonyhuang.sunplus@gmail.com>
References: <cover.1647095774.git.tonyhuang.sunplus@gmail.com>
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
Changes in v11:
 - Addressed comments from krzysztof.

 .../devicetree/bindings/misc/sunplus,iop.yaml      | 78 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus,iop.yaml

diff --git a/Documentation/devicetree/bindings/misc/sunplus,iop.yaml b/Documentation/devicetree/bindings/misc/sunplus,iop.yaml
new file mode 100644
index 0000000..ad1c4be
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/sunplus,iop.yaml
@@ -0,0 +1,78 @@
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
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
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
+        clocks = <&clkc 0x14>;
+        interrupt-parent = <&intc>;
+        interrupts = <41 IRQ_TYPE_LEVEL_HIGH>, <42 IRQ_TYPE_LEVEL_HIGH>;
+        memory-region = <&iop_reserve>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&iop_pins>;
+        wakeup-gpios = <&pctl 1 GPIO_ACTIVE_HIGH>;
+    };
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7..d64c8ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS IOP DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/sunplus,iop.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

