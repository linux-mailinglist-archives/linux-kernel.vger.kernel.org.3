Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA77F48C0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbiALJYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbiALJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:24:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193CEC06173F;
        Wed, 12 Jan 2022 01:24:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id i8-20020a17090a138800b001b3936fb375so10722631pja.1;
        Wed, 12 Jan 2022 01:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b+wFmLxdOEySoXfAR8mLa7Xcq34LJD8+IzAqlEa6G+4=;
        b=XyYvrTbYA7dipeU7ZiMGFQRKwBCL072ToPUnEeY7F49xsoaLunkM/+3BbLXR9IZew4
         6RqBUrk7hs95VEvgJcBXfzYr/YTrzsKaYl9Ekok+Vh5TkG2e2K8V/WSH07fKh7+1ryr5
         G27BbB7G77Zq49YSBMtLPgIrtxdHjzeKL/OvXaWcGYV11uanp5PKG6f4JMrfkKSuTmUd
         q744mLteZ1SK6xFeEVq4DdwdvkyVyZS7M/1ftHVjmXRBgtPp+tOGaAkKcsghniS49X7g
         VZYA45i2xKzGhyk/OUdA166ySurGYwexJEll2IimgonbqNB4+uVb0XPjLpnjrGVtSf3s
         EGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b+wFmLxdOEySoXfAR8mLa7Xcq34LJD8+IzAqlEa6G+4=;
        b=QmxbdOn7vpAO6Eixh2UuZQr5BHakitjEhkpiHzbvGq3rvriNykzF3IZw/0OVn4FM5/
         9C/shwDAVeHYx7S8TLLGVzUaYVCxeVNzmlEiPK47vbB70IhsXVcdZf68eg8Z7Te7pl8F
         UOY1mXHKOXXHMoNs8oFbxh4hOeMEVJf1QHcNNkUagvB6WPIIhZgouQEyfM/GQ06FZTC8
         4uR5J62tumJjRU74qPesEL59zH1fq/xkWNpqZOFFehjIxgGClf9RrKGyCVkQ6PSPYlwI
         9MPvGlQ/LZZ3RVxHBAaJsJXZfockbGlzzHlN/t7ojKYNK5YFO14vqnyOhTzvU/w1cNOI
         cO+Q==
X-Gm-Message-State: AOAM530dMzw5smi4Imj2auHNtUBQVz6luBc0mt2uDDCiJ/nGKjv8g7vv
        tFe0InQkBKpmV9gyWQwkAKE=
X-Google-Smtp-Source: ABdhPJzt0gxWFEls1Q9Bqjfren4vUKHMTA7+EjiKIe6kCGg1yfgVEzh9YBAtqORM1Qq16ADpaF3YKg==
X-Received: by 2002:a17:90a:6f42:: with SMTP id d60mr7749890pjk.67.1641979440685;
        Wed, 12 Jan 2022 01:24:00 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h11sm4898527pjs.10.2022.01.12.01.23.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 01:24:00 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
Date:   Wed, 12 Jan 2022 17:24:03 +0800
Message-Id: <1641979444-11661-2-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
References: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus SoC UART Driver

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
Changes in v6:
 - modify author mail match Signed-off-by.

 .../bindings/serial/sunplus,sp7021-uart.yaml       | 56 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
new file mode 100644
index 0000000..894324c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Sunplus SoC SP7021 UART Controller Device Tree Bindings
+
+maintainers:
+  - Hammer Hsieh <hammerh0314@gmail.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: sunplus,sp7021-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    aliases {
+            serial0 = &uart0;
+    };
+
+    uart0: serial@9c000900 {
+        compatible = "sunplus,sp7021-uart";
+        reg = <0x9c000900 0x80>;
+        interrupt-parent = <&intc>;
+        interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x28>;
+        resets = <&rstc 0x18>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..3c1362e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS UART DRIVER
+M:	Hammer Hsieh <hammerh0314@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

