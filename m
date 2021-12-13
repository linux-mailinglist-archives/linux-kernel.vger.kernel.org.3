Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5634472161
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhLMHKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhLMHKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:10:09 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C799EC061748;
        Sun, 12 Dec 2021 23:10:08 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y8so10531364plg.1;
        Sun, 12 Dec 2021 23:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dF5lwhZALGa/FE3flkX4fMDCJELpvDGdCszP3LHjEU8=;
        b=VII5ZpGZhA7hlMw78XRb0LtZUYgHGCtZtHiCBJRKDmZTv08ccrTnMc3n2K/AUZJh0z
         TeRQqq2lGDNlv0E2e/n/wv7Sy5ShokEUTlGC6ToIvbLaztYujOZSsxXjEIHkfa9nu250
         oyt+J5jm25XNbQf7AGiU4BX2prXF/UFPcQHfLKE7fxRDxzg6IJBi5jjdZeNCdpTuzknR
         w4yMXGoMv4pHl1rYlXg/VyU+Vi67TGz4t1hluzoGif94zsfBBXaQw4lD/UzTSc+rJ5Jh
         3WhkpiWPzEHQcvDZtGy3P/xwXXO9yHDa4syh3LsDnjttAhO+yvqwd/bdspbD0/wgc9Hb
         dZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dF5lwhZALGa/FE3flkX4fMDCJELpvDGdCszP3LHjEU8=;
        b=x1CulEkzU+fFQEdxryJvBkdGIvnxZt4uPha+w1ueujyGhniPhfHR9pSXql4LZDP9w1
         hlmZ24yqfa9z8lT8lGXsD3+FMRJBqqlo+7D/aSRO3Vd2l3FenpmOwoJ/1g455gDHxoPU
         4OILO/N11DQ2HcPzjYINiant/xo5NmOCL57JmfGO4XSG5j9aLN2H+YVccrGIorwHKnu+
         09scHcuHc5/fUZ71kjr6JLr+Vq8hp/NjYew/0MBhNfgIqOjChRljkEN8ACLrMaCARz8R
         fs7dPDexOr3meQLNH710vK7kaPgkN3NopZbLn4TE/E1wcsYOJRu4wUMzPjFetm6ncbBk
         wBIw==
X-Gm-Message-State: AOAM531ENpXOZKjt7SEY8jzqmO9qBbN7urNfLe325M78yD7u3ppSoDCE
        dzToDKZD8NywJccxfWJu4Mk=
X-Google-Smtp-Source: ABdhPJxQuesJAveyvdePrCOTsFLHcPL+FMXZDtwZu+nj1VrfKBOaR4H0+VOYASdEkkwwfyBAyaSaRQ==
X-Received: by 2002:a17:902:e74a:b0:142:114c:1f1e with SMTP id p10-20020a170902e74a00b00142114c1f1emr93442364plf.78.1639379408353;
        Sun, 12 Dec 2021 23:10:08 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id x16sm10601848pfo.165.2021.12.12.23.10.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 23:10:08 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v5 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
Date:   Mon, 13 Dec 2021 15:10:06 +0800
Message-Id: <1639379407-28607-2-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus SoC UART Driver

Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
---
Changes in v4:
 - no change.
 - Reviewed-by : Rob Herring <robh@kernel.org> in v3.

Changes in v5:
 - remove another two author's name, the whole driver already quite different compared 
   with patch v1. The other two authors request me to remove it.

 .../bindings/serial/sunplus,sp7021-uart.yaml       | 56 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
new file mode 100644
index 0000000..ab66a0f
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
+  - Hammer Hsieh <hammer.hsieh@sunplus.com>
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
index 3b79fd4..f2ee40c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS UART DRIVER
+M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

