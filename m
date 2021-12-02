Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C34660F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356875AbhLBJ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:57:35 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:53967 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356713AbhLBJ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:46 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPA id DCB29240012;
        Thu,  2 Dec 2021 09:53:21 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 6/6] ARM: dts: spear3xx: Add spear320s dtsi
Date:   Thu,  2 Dec 2021 10:52:55 +0100
Message-Id: <20211202095255.165797-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202095255.165797-1-herve.codina@bootlin.com>
References: <20211202095255.165797-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPEAr320s SOC is a SPEAr320 SOC variant.

Mostly identical to the SPEAr320 SOC variant, it has a
new interrupt routing for PL_PGIOs.

Add spear320s.dtsi to handle SPEAr320s SOC

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/spear320s.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm/boot/dts/spear320s.dtsi

diff --git a/arch/arm/boot/dts/spear320s.dtsi b/arch/arm/boot/dts/spear320s.dtsi
new file mode 100644
index 000000000000..133236dc190d
--- /dev/null
+++ b/arch/arm/boot/dts/spear320s.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DTS file for SPEAr320s SoC
+ *
+ * Copyright 2021 Herve Codina <herve.codina@bootlin.com>
+ */
+
+/include/ "spear320.dtsi"
+
+/ {
+	ahb {
+		apb {
+			gpiopinctrl: gpio@b3000000 {
+				/*
+				 * The "RM0321 SPEAr320s address and map
+				 * registers" document mentions interrupt 6
+				 * (NPGIO_INTR) for the PL_GPIO interrupt.
+				 */
+				interrupts = <6>;
+				interrupt-parent = <&shirq>;
+			};
+		};
+	};
+};
-- 
2.31.1

