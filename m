Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3C47CD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbhLVHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:08:50 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:49280 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242913AbhLVHIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:08:48 -0500
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(4818:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 22 Dec 2021 15:06:15 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 02/10] dt-bindings: arm: sunplus: Add bindings for Sunplus SP7021 SoC boards
Date:   Wed, 22 Dec 2021 15:05:58 +0800
Message-Id: <87cc20bb3ef747c4da89f9e60c0847532bb0a679.1640154492.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640154492.git.qinjian@cqplus1.com>
References: <cover.1640154492.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces bindings for boards based Sunplus SP7021 SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 .../bindings/arm/sunplus,sp7021.yaml          | 27 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml

diff --git a/Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml b/Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
new file mode 100644
index 000000000..5b9985b73
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sunplus,sp7021.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 Boards Device Tree Bindings
+
+maintainers:
+  - qinjian <qinjian@cqplus1.com>
+
+description: |
+  ARM platforms using Sunplus SP7021, an ARM Cortex A7 (4-cores) based SoC.
+  Wiki: https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: sunplus,sp7021-achip
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e0bca0de0..6a5422f10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2655,6 +2655,13 @@ F:	drivers/clocksource/armv7m_systick.c
 N:	stm32
 N:	stm
 
+ARM/SUNPLUS SP7021 SOC SUPPORT
+M:	Qin Jian <qinjian@cqplus1.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for mon-subscribers)
+S:	Maintained
+W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
+F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
+
 ARM/Synaptics SoC support
 M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
-- 
2.33.1

