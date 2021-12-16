Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B6476829
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhLPCfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhLPCe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:34:59 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E7C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:34:59 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z6so22329875pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LWu0eWna+8G7/usn/EvnCn27RmaCJyMrDiNHc/2jVoE=;
        b=Rk3Z1D9auh3hYARlWsmnQAdOIrDpoPLszXINhLzT7FJl2yWuz2YbNJJWpejB60YEZk
         iEC74/eCzeluAU0d96q3FSJ5RNhjjR0LqEJT/9B/VdmEFwDNyQoQ9UJw2YARdtSt9j4F
         Ly6bcaOfsSPblUlgR5FRo8NoWO8Od6O2KPkIP3eWSRV7QaKw2MExUFrkrEpIjWuTo/4v
         NLcpR110H3E5iHbe23J/5sXGLfzdwlc5NBYo5WrGkQx20PXpZBDJ9m5PmR0q2lOctOCd
         DDrPQxSSXbv7UWMyDD5Wzi6+ySi90PkbTenS7OFemNp6+7TpnYY+KinzDdR27Oi79EOz
         yXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LWu0eWna+8G7/usn/EvnCn27RmaCJyMrDiNHc/2jVoE=;
        b=C1Xq8zgYN7WKNBPlRD4mUt5zuhD9Ks6VIdC6helbtF/fI2ynX2Un9TCBlwqto1XRyB
         RlzGAIkMgji7m3WAJXo75DG+dYP1JbaM2w3Mf2BXhxMpZ+Az3IuUjZWABOsIPjIEPzvl
         8g6oGXydnFval8ZXTES/NqEK5yzYainqC2mKTEG5poeJjOaAR4phKJHhBDBuwszZoe/A
         l5uQlmoCY+mKqC45zA5B5qYST1YBerWAD95mG1tHFCLJBkvnIzLJ/2vJevC9vIQi2kYp
         md/7PDN6Sn/kmrwhEXOWWt7JCEN4XFWRh1aHVTzdEs1SrNOE0j91xqtnO4V5v4YmBVIg
         6PBQ==
X-Gm-Message-State: AOAM533DmpqNMtsVBs4ogUMf6kxSHjw6XcNv0MLnQQ1VZzirpOf4bNEA
        DQu/gZy8Wkhcmqhry6xbYqePWpMTBo8=
X-Google-Smtp-Source: ABdhPJwRxGZ1pG9mqCkUDCawBauuiZzvdY6uLwvwmJPhe9zSyol0NwI7QpwUiFi+scnq83dnp0NFvA==
X-Received: by 2002:a63:8148:: with SMTP id t69mr10474359pgd.318.1639622098449;
        Wed, 15 Dec 2021 18:34:58 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d23sm3580932pgm.37.2021.12.15.18.34.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Dec 2021 18:34:58 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v4 1/2] dt-binding: misc: Add iop yaml file for Sunplus SP7021
Date:   Thu, 16 Dec 2021 10:34:59 +0800
Message-Id: <27a26f5ac62dfabc47b27cde2488f79bf7bd68c1.1639557112.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
References: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
References: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop yaml file for Sunplus SP7021

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v4:
 - Addressed comments from Rob Herring.

 .../devicetree/bindings/misc/sunplus-iop.yaml      | 65 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml

diff --git a/Documentation/devicetree/bindings/misc/sunplus-iop.yaml b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
new file mode 100644
index 0000000..8510ef8
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
@@ -0,0 +1,65 @@
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
+    iop: iop@9c000400 {
+        compatible = "sunplus,sp7021-iop";
+        reg = <0x9c000400 0x80>, <0x9c003100 0x80>, <0x9c000000 0x80>;
+        reg-names = "iop", "iop_pmc", "moon0";
+        interrupt-parent = <&intc>;
+        interrupts = <41 IRQ_TYPE_LEVEL_HIGH>, <42 IRQ_TYPE_LEVEL_HIGH>;
+        memory-region = <&iop_reserve>;
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

