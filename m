Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD90489043
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiAJGh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiAJGhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:37:47 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D5C06173F;
        Sun,  9 Jan 2022 22:37:47 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t135so2672830pgb.4;
        Sun, 09 Jan 2022 22:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4rUDVePEAjQ1unthyl5dr4MNsgtGl3+0OG1KI9t2fe4=;
        b=ecXN9aEpv70cxEoW6yQCWQv7w468x7ixuAFlBjM+dYNf5ZQjuup0k0alyF64KTU/m4
         hnuUWaxcqwOHiebsIeDf0/qfskeE/2O5VmpXQ42NI5sbvsJNv46npcFiYfD64Z92VrpS
         EHfxYcylmUb4oHceecmPVN60QXju7IgZG3+Q+IzjSHXtJV9UjP43nvQah2Wb7QQoqOi/
         tmcGuno8zI/x0I20uRNPrCqW2sWdgPLpRxMMTsNlfSxN28SIQe66tOaRkGIPhzVU976m
         53QwuxEv/mOzYLtWzf0ieAYawrNAfC3gz5/k0Et6r5mrBnSx90so8SETvHFlB8qo3lwq
         bSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4rUDVePEAjQ1unthyl5dr4MNsgtGl3+0OG1KI9t2fe4=;
        b=CF30hgbYGxmaf4GxHpiyrEWpnx7jp7H4lT1qg6/yMgcQr13wadWTCDm94MT+k+H0F/
         FWDkujktCqpy3cGyN4aqEWTGlQ0aqOPj0AMPAJWqUY5+aNj2hDycRwQdvIMdGIePP/fM
         ptDcEl+FC+yAN1Dt2uq+abiV2T+aqzDH4kthi4DnikGvAJDdFk+3NzR8jH0XbnhunLxS
         vskfvMX4bysQZt+vnKX2RQcvNHws+RCCC+mECsiSNhrorNiOfwyGIC7AMK2FSxB6Pb18
         PsJQbH3MBHJCNZLw5rzN1Ld3tc9BOg6ZSkmWV1ABbXb2vC9qZ6O73oIhm+gmPAZaiAoz
         nPkA==
X-Gm-Message-State: AOAM532IXpmfom/FLOR2kv88pcJ5WzNvtkktZPCbVGR4QOmo+4d64P7D
        sNuUSTH0Cb15RexXTeIr7/I=
X-Google-Smtp-Source: ABdhPJw4uJjxXAgMeydWVh+HUWuy6P1XoJVENAxLCUyR5vtdwVEqtzEPLvODDVq7LOzYLxxkuqLTGw==
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr64699293pgr.434.1641796666961;
        Sun, 09 Jan 2022 22:37:46 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id ne14sm1977081pjb.19.2022.01.09.22.37.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 22:37:46 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kerenl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v7 1/2] dt-binding: misc: Add iop yaml file for Sunplus SP7021
Date:   Mon, 10 Jan 2022 14:37:53 +0800
Message-Id: <5c92ef8837a16420fb3de78720142bf4a498194b.1641794532.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1641794532.git.tonyhuang.sunplus@gmail.com>
References: <cover.1641794532.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1641794532.git.tonyhuang.sunplus@gmail.com>
References: <cover.1641794532.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop yaml file for Sunplus SP7021

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v7:
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

