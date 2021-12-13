Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34B472C60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhLMMim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:38:42 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:64392 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhLMMif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1639399113; x=1641991113;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7x2pUVpHiWNnhIPaDB335YYbPge7e4R/69xb3LAQdr8=;
        b=bDhi2jbalCNs65Gj7+C/KaWYQCIGxt2HGfijcSDneGV4FwT5USAHIr3WoD2nLfk0
        S/lCgmFqsTXIRll+niTkILYSkT5+85HEqj855ists7z63WvH3btnqxE8ICF/WjQu
        DP0iUQPjCpBKCA/Pw2hB6+ayMrTsrlrv7MZJAjrOZTM=;
X-AuditID: c39127d2-4f7337000000426a-a5-61b73ec955b1
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A4.D3.17002.9CE37B16; Mon, 13 Dec 2021 13:38:33 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021121313383329-2359967 ;
          Mon, 13 Dec 2021 13:38:33 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org
Cc:     festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ARM: dts: imx6qdl: phytec: Add support for optional PEB-EVAL-01 board
Date:   Mon, 13 Dec 2021 13:38:31 +0100
Message-Id: <20211213123833.3011525-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.12.2021 13:38:33,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.12.2021 13:38:33
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWyRoCBS/ek3fZEg84PEhbzj5xjtXh41d9i
        0+NrrBaXd81hs2jde4Td4u/2TSwWL7aIO7B77Jx1l91j06pONo/NS+o9+v8aeHzeJBfAGsVl
        k5Kak1mWWqRvl8CVsW/WDtaCtaoVt/e6NjC+ku9i5OSQEDCRuPN+FVsXIxeHkMBWRokZx7az
        gSSEBC4wSlxtKQex2QQUJc7ffsvaxcjBISIQL/HijTtImFkgSuLDr1Vg5cICsRJrJ29nAbFZ
        BFQlZkx4zQxi8wqYSfRf/sAMsUteYual7+wQcUGJkzOfsIDslRC4wijxfOYdNogiIYnTi88y
        QyzQlli28DXzBEa+WUh6ZiFJLWBkWsUolJuZnJ1alJmtV5BRWZKarJeSuokRGIyHJ6pf2sHY
        N8fjECMTB+MhRgkOZiUR3pfWWxOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ897vYUoUEkhPLEnN
        Tk0tSC2CyTJxcEo1MDat9igO7bh9xXTVi2fbtDawnZKTabJ+dKJW1ukFs6/WBeVkO8Un9jsu
        5v0+Ua1fIBnWdG6jxIJ1O6ROPyyzrPUJ8XFddPad5BYeqwP97gt/it03dnj4n/es7e/F/15/
        trIUyg0p5PZs+ZXZ+LL0x17fzypWrzkF847LLjx0eNmOHTxq/g0vhJRYijMSDbWYi4oTAcB7
        wrw0AgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHYTEC PEV-EVAL-01 expansion board adds support for additional
gpio-triggered user-leds and gpio-key support.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
Changes in v2:
- Changed node-name and lable of a gpio-key to fit the key binding
---
 .../boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |  1 +
 .../boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |  1 +
 .../boot/dts/imx6q-phytec-mira-rdk-nand.dts   |  1 +
 .../dts/imx6qdl-phytec-mira-peb-eval-01.dtsi  | 71 +++++++++++++++++++
 .../boot/dts/imx6qp-phytec-mira-rdk-nand.dts  |  1 +
 5 files changed, 75 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi

diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/b=
oot/dts/imx6dl-phytec-mira-rdk-nand.dts
index 9f7f9f98139d..b057fa664a6b 100644
--- a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
@@ -8,6 +8,7 @@
 #include "imx6dl.dtsi"
 #include "imx6qdl-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
+#include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira DualLite/Solo Carrier-Board with NAND";
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts b/arch/arm/bo=
ot/dts/imx6q-phytec-mira-rdk-emmc.dts
index 2e70ea5623c6..db6e2cc36759 100644
--- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
@@ -8,6 +8,7 @@
 #include "imx6q.dtsi"
 #include "imx6qdl-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
+#include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira Quad Carrier-Board with eMMC";
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts b/arch/arm/bo=
ot/dts/imx6q-phytec-mira-rdk-nand.dts
index 65d2e483c136..51ff601b1aec 100644
--- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
@@ -8,6 +8,7 @@
 #include "imx6q.dtsi"
 #include "imx6qdl-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
+#include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira Quad Carrier-Board with NAND";
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi b/arch/=
arm/boot/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi
new file mode 100644
index 000000000000..037b60197598
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 PHYTEC Messtechnik
+ * Author: Christian Hemp <c.hemp@phytec.de>
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio-keys {
+		compatible =3D "gpio-keys";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl=5Fgpio=5Fkeys>;
+		status =3D "disabled";
+
+		power {
+			label =3D "Power Button";
+			gpios =3D <&gpio5 28 GPIO=5FACTIVE=5FLOW>;
+			linux,code =3D <KEY=5FWAKEUP>;
+			wakeup-source;
+		};
+
+		sleep {
+			label =3D "Sleep Button";
+			gpios =3D <&gpio6 18 GPIO=5FACTIVE=5FLOW>;
+			linux,code =3D <KEY=5FSLEEP>;
+		};
+	};
+
+	user=5Fleds: user-leds {
+		compatible =3D "gpio-leds";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl=5Fuser=5Fleds>;
+		status =3D "disabled";
+
+		user-led1 {
+			gpios =3D <&gpio7 1 GPIO=5FACTIVE=5FHIGH>;
+			linux,default-trigger =3D "gpio";
+			default-state =3D "on";
+		};
+
+		user-led2 {
+			gpios =3D <&gpio7 0 GPIO=5FACTIVE=5FHIGH>;
+			linux,default-trigger =3D "gpio";
+			default-state =3D "on";
+		};
+
+		user-led3 {
+			gpios =3D <&gpio5 29 GPIO=5FACTIVE=5FHIGH>;
+			linux,default-trigger =3D "gpio";
+			default-state =3D "on";
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl=5Fgpio=5Fkeys: gpiokeysgrp {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FSD3=5FDAT6=5F=5FGPIO6=5FIO18		0x1b0b0
+			MX6QDL=5FPAD=5FCSI0=5FDAT10=5F=5FGPIO5=5FIO28	0x1b0b0
+		>;
+	};
+
+	pinctrl=5Fuser=5Fleds: userledsgrp {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FSD3=5FDAT4=5F=5FGPIO7=5FIO01		0x1b0b0
+			MX6QDL=5FPAD=5FSD3=5FDAT5=5F=5FGPIO7=5FIO00		0x1b0b0
+			MX6QDL=5FPAD=5FCSI0=5FDAT11=5F=5FGPIO5=5FIO29	0x1b0b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts b/arch/arm/b=
oot/dts/imx6qp-phytec-mira-rdk-nand.dts
index f27d7ab42626..06fe0c5315fc 100644
--- a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
@@ -8,6 +8,7 @@
 #include "imx6qp.dtsi"
 #include "imx6qdl-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
+#include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira QuadPlus Carrier-Board with NAND";
--=20
2.25.1

