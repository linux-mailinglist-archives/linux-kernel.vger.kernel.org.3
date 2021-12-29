Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519F548128C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhL2MQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:16:19 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:23463 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbhL2MQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:16:16 -0500
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Wed, 29 Dec 2021
 20:16:11 +0800
From:   Qianggui Song <qianggui.song@amlogic.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Qianggui Song <qianggui.song@amlogic.com>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: gpio: Add a header file for Amlogic Meson S4
Date:   Wed, 29 Dec 2021 20:16:04 +0800
Message-ID: <20211229121605.10513-3-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229121605.10513-1-qianggui.song@amlogic.com>
References: <20211229121605.10513-1-qianggui.song@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new dt-binding header file which documents the detail pin names.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
---
 include/dt-bindings/gpio/meson-s4-gpio.h | 99 ++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 include/dt-bindings/gpio/meson-s4-gpio.h

diff --git a/include/dt-bindings/gpio/meson-s4-gpio.h b/include/dt-bindings/gpio/meson-s4-gpio.h
new file mode 100644
index 000000000000..35aee21b94f1
--- /dev/null
+++ b/include/dt-bindings/gpio/meson-s4-gpio.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
+ * Author: Qianggui Song <qianggui.song@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_S4_GPIO_H
+#define _DT_BINDINGS_MESON_S4_GPIO_H
+
+#define	GPIOB_0		0
+#define	GPIOB_1		1
+#define	GPIOB_2		2
+#define	GPIOB_3		3
+#define	GPIOB_4		4
+#define	GPIOB_5		5
+#define	GPIOB_6		6
+#define	GPIOB_7		7
+#define	GPIOB_8		8
+#define	GPIOB_9		9
+#define	GPIOB_10	10
+#define	GPIOB_11	11
+#define	GPIOB_12	12
+#define	GPIOB_13	13
+
+#define	GPIOC_0		14
+#define	GPIOC_1		15
+#define	GPIOC_2		16
+#define	GPIOC_3		17
+#define	GPIOC_4		18
+#define	GPIOC_5		19
+#define	GPIOC_6		20
+#define	GPIOC_7		21
+
+#define	GPIOE_0		22
+#define	GPIOE_1		23
+
+#define	GPIOD_0		24
+#define	GPIOD_1		25
+#define	GPIOD_2		26
+#define	GPIOD_3		27
+#define	GPIOD_4		28
+#define	GPIOD_5		29
+#define	GPIOD_6		30
+#define	GPIOD_7		31
+#define	GPIOD_8		32
+#define	GPIOD_9		33
+#define	GPIOD_10	34
+#define	GPIOD_11	35
+
+#define	GPIOH_0		36
+#define	GPIOH_1		37
+#define	GPIOH_2		38
+#define	GPIOH_3		39
+#define	GPIOH_4		40
+#define	GPIOH_5		41
+#define	GPIOH_6		42
+#define	GPIOH_7		43
+#define	GPIOH_8		44
+#define	GPIOH_9		45
+#define	GPIOH_10	46
+#define	GPIOH_11	47
+
+#define	GPIOX_0		48
+#define	GPIOX_1		49
+#define	GPIOX_2		50
+#define	GPIOX_3		51
+#define	GPIOX_4		52
+#define	GPIOX_5		53
+#define	GPIOX_6		54
+#define	GPIOX_7		55
+#define	GPIOX_8		56
+#define	GPIOX_9		57
+#define	GPIOX_10	58
+#define	GPIOX_11	59
+#define	GPIOX_12	60
+#define	GPIOX_13	61
+#define	GPIOX_14	62
+#define	GPIOX_15	63
+#define	GPIOX_16	64
+#define	GPIOX_17	65
+#define	GPIOX_18	66
+#define	GPIOX_19	67
+
+#define	GPIOZ_0		68
+#define	GPIOZ_1		69
+#define	GPIOZ_2		70
+#define	GPIOZ_3		71
+#define	GPIOZ_4		72
+#define	GPIOZ_5		73
+#define	GPIOZ_6		74
+#define	GPIOZ_7		75
+#define	GPIOZ_8		76
+#define	GPIOZ_9		77
+#define	GPIOZ_10	78
+#define	GPIOZ_11	79
+#define	GPIOZ_12	80
+
+#define	GPIO_TEST_N	81
+#endif /* _DT_BINDINGS_MESON_S4_GPIO_H */
-- 
2.34.1

