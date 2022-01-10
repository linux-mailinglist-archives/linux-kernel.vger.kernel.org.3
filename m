Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DFA489A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiAJNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:48:02 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:43016 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234435AbiAJNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:47:46 -0500
X-IronPort-AV: E=Sophos;i="5.88,277,1635174000"; 
   d="scan'208";a="106014836"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 22:47:45 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5666142E354B;
        Mon, 10 Jan 2022 22:47:43 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 12/12] arm64: dts: renesas: Add support for r9a07g044c1/r9a07g054l1-smarc.dts
Date:   Mon, 10 Jan 2022 13:46:59 +0000
Message-Id: <20220110134659.30424-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2
* None
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 +
 .../boot/dts/renesas/r9a07g044c1-smarc.dts    | 99 +++++++++++++++++++
 .../boot/dts/renesas/r9a07g054l1-smarc.dts    | 25 +++++
 3 files changed, 126 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044c1-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g054l1-smarc.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 2daba38d1161..8de5561a3902 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -77,4 +77,6 @@ dtb-$(CONFIG_ARCH_R8A77965) += r8a779m5-salvator-xs.dtb
 
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc.dtb
+dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c1-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
+dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l1-smarc.dtb
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c1-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044c1-smarc.dts
new file mode 100644
index 000000000000..43af14ef0103
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c1-smarc.dts
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2LC SMARC EVK board
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a07g044c1.dtsi"
+#include "rzg2lc-smarc-som.dtsi"
+#include "rzg2lc-smarc-pinfunction.dtsi"
+#include "rzg2l-smarc.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK based on r9a07g044c2";
+	compatible = "renesas,smarc-evk", "renesas,r9a07g044c2", "renesas,r9a07g044";
+
+};
+
+&canfd {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&ehci0 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&ehci1 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&hsusb {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&i2c0 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&i2c1 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&i2c3 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&ohci0 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&ohci1 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&phyrst {
+	status = "disabled";
+};
+
+&scif2 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&sdhi1 {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-1;
+	/delete-property/ vmmc-supply;
+	status = "disabled";
+};
+
+&spi1 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&ssi0 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&usb2_phy0 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
+
+&usb2_phy1 {
+	/delete-property/ pinctrl-0;
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l1-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g054l1-smarc.dts
new file mode 100644
index 000000000000..2d9d397cef06
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g054l1-smarc.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2L SMARC EVK board
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a07g054l1.dtsi"
+#include "rzg2l-smarc-som.dtsi"
+#include "rzg2l-smarc-pinfunction.dtsi"
+#include "rzg2l-smarc.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK based on r9a07g054l1";
+	compatible = "renesas,smarc-evk", "renesas,r9a07g054l1", "renesas,r9a07g054";
+};
+
+&pinctrl {
+	/delete-node/ can0-stb;
+	/delete-node/ can1-stb;
+	/delete-node/ gpio-sd0-pwr-en-hog;
+	/delete-node/ sd0-dev-sel-hog;
+	/delete-node/ sd1-pwr-en-hog;
+};
-- 
2.17.1

