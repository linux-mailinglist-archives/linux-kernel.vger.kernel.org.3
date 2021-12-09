Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C710246E4B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhLIJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhLIJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:01:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDBCC0617A1;
        Thu,  9 Dec 2021 00:58:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y8so3410509plg.1;
        Thu, 09 Dec 2021 00:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ev3PoXej+yCJvXLPR4SzWYZd0sdkwALqRAMiZDnHY7Q=;
        b=gp3hY2aNcni+d2uRZxu9fNXCqOGQZNdpRRHhAj6vHZwlp7yFjlzZhjS1idddim9rfA
         SG3KV+8uYJSGoSu+q4CKN3oVYXnn9kv8fM+bkPlE+0AvQGqnBYoLzQewkzH4i4UGh1K1
         x/oktzW385c6/NjU7Vgu6o+cDZBCrTKRiwzYkmAfsp+qj5tIFHEi57HHE30ezc4W+fAY
         sn3yPT9O+iM/6UFVTZQhURuW6bMJJE/yCKOTzeGrF/GUWFZZaRWSl22BYv2RfpQ8bVir
         3YKCa/cYMefMO8voh33j3LWWZ3Nu9SGLi4UPdI271rHTuHGmPJNJDNHNKNgpmVQU+YFU
         Psnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ev3PoXej+yCJvXLPR4SzWYZd0sdkwALqRAMiZDnHY7Q=;
        b=E+8VJrStCaNsBWp2vecACc6uE0ykRMWNpwKNDsUO3FYbUAlkz9qCAceoIlhSAW7U1V
         oKRDwt52OkZHbu3Oewbf04gazCDLPHpZutxd6mcy32UjzrXHGEsPdGNh3bzaOYYH/Bej
         Ttk+fbOHWFUyfhT9mUV2/UoBSXVpFD0/llpKbB6PRdGU1gDgBpwHH4cyjt3FmZCFAqDh
         sbs8VJe1bjGHpzfIRLQnravQ9LLA1PexcrRTMM59OFxoCNkPOWxDLvQW/TcWqVMvVRar
         p5LLkMYRX1WbdY+SvjVdAJOYPAjKru6OwcVsfU6dwLCdCnzJzVkxtnTcUiIdlqUI/JC0
         Imew==
X-Gm-Message-State: AOAM531n2uzazp9AxOCVe9Y4r8OZr7oyjGesAvqA9K0G5l3bDbCfjF78
        IcbLUCRCLIQzRe1rsfMTew8=
X-Google-Smtp-Source: ABdhPJzNtcKR0F3SiNFQq3yshVipsv+6VpLUceOfizkqoTAfE1JbhTSsRxyNYMw6Z3FGohcbE7m1Qg==
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr13854637pjb.22.1639040290330;
        Thu, 09 Dec 2021 00:58:10 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id n15sm5008881pgs.59.2021.12.09.00.58.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 00:58:10 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v3 1/2] dt-binding: misc: Add iop yaml file for Sunplus SP7021
Date:   Thu,  9 Dec 2021 16:58:08 +0800
Message-Id: <5fb18e784351dab36ed9a8424d24746cc24a3bf2.1639039163.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop yaml file for Sunplus SP7021

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v3:
 - No change.

 .../devicetree/bindings/misc/sunplus-iop.yaml      | 61 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml

diff --git a/Documentation/devicetree/bindings/misc/sunplus-iop.yaml b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
new file mode 100644
index 0000000..07cdbde
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
@@ -0,0 +1,61 @@
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
+    maxItems: 2
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

