Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6B49C37C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiAZGKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:10:33 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:63091 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiAZGKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:10:30 -0500
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Wed, 26 Jan 2022
 14:10:28 +0800
From:   Shunzhou Jiang <shunzhou.jiang@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <narmstrong@baylibre.com>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <jianxin.pan@amlogic.com>, <shunzhou.jiang@amlogic.com>
Subject: [PATCH 1/2] dt-bindings: power: add Amlogic s4 power domains bindings
Date:   Wed, 26 Jan 2022 14:10:17 +0800
Message-ID: <20220126061018.705338-2-shunzhou.jiang@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126061018.705338-1-shunzhou.jiang@amlogic.com>
References: <20220126061018.705338-1-shunzhou.jiang@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings for the Amlogic Secure power domains, controlling the
secure power domains.

The bindings targets the Amlogic s4, in which the power domains registers
are in secure world.

Signed-off-by: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
---
 .../power/amlogic,meson-sec-pwrc.yaml         |  3 ++-
 include/dt-bindings/power/meson-s4-power.h    | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/meson-s4-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
index 5dae04d2936c..7657721a4e96 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
@@ -12,13 +12,14 @@ maintainers:
   - Jianxin Pan <jianxin.pan@amlogic.com>
 
 description: |+
-  Secure Power Domains used in Meson A1/C1 SoCs, and should be the child node
+  Secure Power Domains used in Meson A1/C1/S4 SoCs, and should be the child node
   of secure-monitor.
 
 properties:
   compatible:
     enum:
       - amlogic,meson-a1-pwrc
+      - amlogic,meson-s4-pwrc
 
   "#power-domain-cells":
     const: 1
diff --git a/include/dt-bindings/power/meson-s4-power.h b/include/dt-bindings/power/meson-s4-power.h
new file mode 100644
index 000000000000..462dd2cb938b
--- /dev/null
+++ b/include/dt-bindings/power/meson-s4-power.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2021 Amlogic, Inc.
+ * Author: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_S4_POWER_H
+#define _DT_BINDINGS_MESON_S4_POWER_H
+
+#define PWRC_S4_DOS_HEVC_ID	0
+#define PWRC_S4_DOS_VDEC_ID	1
+#define PWRC_S4_VPU_HDMI_ID	2
+#define PWRC_S4_USB_COMB_ID	3
+#define PWRC_S4_GE2D_ID		4
+#define PWRC_S4_ETH_ID		5
+#define PWRC_S4_DEMOD_ID	6
+#define PWRC_S4_AUDIO_ID	7
+
+#endif
-- 
2.34.1

