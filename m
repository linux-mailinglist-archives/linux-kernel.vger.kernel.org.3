Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87258475617
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbhLOKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:19:22 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:51192 "EHLO test.cqplus1.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241586AbhLOKTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:19:21 -0500
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(17176:0:AUTH_RELAY)
        (envelope-from <xt.hu@cqplus1.com>); Wed, 15 Dec 2021 18:18:41 +0800 (CST)
From:   Xiantao Hu <xt.hu@cqplus1.com>
To:     wim@linux-watchdog.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     wells.lu@sunplus.com, qinjian@cqplus1.com,
        Xiantao Hu <xt.hu@cqplus1.com>
Subject: [PATCH v3 1/2] dt-bindings: watchdog: Add bindings doc for Sunplus SP7021
Date:   Wed, 15 Dec 2021 18:18:30 +0800
Message-Id: <20211215101831.256667-2-xt.hu@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215101831.256667-1-xt.hu@cqplus1.com>
References: <20211215101831.256667-1-xt.hu@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for Sunplus SP7021 SoC.

Signed-off-by: Xiantao Hu <xt.hu@cqplus1.com>
---
Changes in v3:
 - removed second reg source. The registers are not used in the driver.

 .../bindings/watchdog/sunplus,sp7021-wdt.yaml | 45 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
new file mode 100644
index 000000000..033e2f599
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/sunplus,sp7021-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SoCs Watchdog Device Tree Bindings
+
+maintainers:
+  - XianTao Hu <xt.hu@cqplus1.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: sunplus,sp7021-wdt
+
+  reg:
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
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    watchdog: watchdog@9c000630 {
+        compatible = "sunplus,sp7021-wdt";
+        reg = <0x9c000630 0x08>;
+        clocks = <&clkc 0x24>;
+        resets = <&rstc 0x14>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e0bca0de0..c2ba65155 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17933,6 +17933,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS WATCHDOG DRIVER
+M:	Xiantao Hu <xt.hu@cqplus1.com>
+L:	linux-watchdog@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.33.1

