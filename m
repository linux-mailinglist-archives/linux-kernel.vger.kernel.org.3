Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A280352E5B4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiETHCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346158AbiETHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:01:33 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E4CF12612
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:01:22 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(13837:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 20 May 2022 14:51:14 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     sboyd@kernel.org
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v16 01/10] dt-bindings: arm: sunplus: Add bindings for Sunplus SP7021 SoC boards
Date:   Fri, 20 May 2022 14:50:35 +0800
Message-Id: <65d2fbc39e28a2e145695b873339ed8f474987d5.1653027644.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1653027644.git.qinjian@cqplus1.com>
References: <cover.1653027644.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces bindings for boards based Sunplus SP7021 SoC.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 .../bindings/arm/sunplus,sp7021.yaml          | 29 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++++
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml

diff --git a/Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml b/Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
new file mode 100644
index 000000000..def7d0cfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sunplus,sp7021.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 Boards
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
+    items:
+      - enum:
+          - sunplus,sp7021-achip
+          - sunplus,sp7021-demo-v3
+      - const: sunplus,sp7021
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d6d879cb0..db1922eb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2805,6 +2805,13 @@ F:	drivers/clocksource/armv7m_systick.c
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
 M:	Jisheng Zhang <jszhang@kernel.org>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
-- 
2.33.1

