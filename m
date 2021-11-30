Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB074462F42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbhK3JMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:12:17 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:61048 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhK3JMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:12:16 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Nov 2021 04:12:16 EST
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1638262435; x=1640854435;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jAc82N8sXx+t9xrTXwC/h8CRj4vw3tyUDaSXh/5aH7c=;
        b=dgfcQBQz31PUb4PhFxqUkSinvtmk2MVs4zWbUJG55bdSUrf3AI0Dxhn8hSBp+m73
        FB0gEn6XduedfvdFX41uT/ahvNImEIanyti9OiUEcUSGtPxrZx0+y4BNJrka5QXU
        viLf/jIHhlCxA+Ht0OamP4UOJTRjnc8VZP1b4SVhuTY=;
X-AuditID: c39127d2-4ef327000000426a-b7-61a5e6a3603b
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E0.4F.17002.3A6E5A16; Tue, 30 Nov 2021 09:53:55 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021113009535504-2244389 ;
          Tue, 30 Nov 2021 09:53:55 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: imx6qdl: phytec: Add support for optional PEB-EVAL-01 board
Date:   Tue, 30 Nov 2021 09:53:53 +0100
Message-Id: <20211130085355.2291607-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 30.11.2021 09:53:55,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 30.11.2021 09:53:55
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWyRoCBS3fxs6WJBtdWilnMP3KO1eLhVX+L
        VVN3slhc3jWHzaJ17xF2i7/bN7FYvNgi7sDusXPWXXaPTas62Tz6/xp4fN4kF8ASxWWTkpqT
        WZZapG+XwJXx88F1poLTKhWP9vWwNzDOle9i5OSQEDCReHSmka2LkYtDSGAro8TD1TeZIZwL
        jBLnl55nBaliE1CUOH/7LZgtIhAvMXX/T0YQm1nAW6L1xlVmEFtYIEri2KxHLCA2i4CqxJ/P
        LewgNq+AmcSVu4vZIbbJS8y89B0qLihxcuYTFpBlEgJXGCV6792CKhKSOL34LDPEAm2JZQtf
        M09g5JuFpGcWktQCRqZVjEK5mcnZqUWZ2XoFGZUlqcl6KambGIGheHii+qUdjH1zPA4xMnEw
        HmKU4GBWEuH1PrM4UYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv/R6mRCGB9MSS1OzU1ILUIpgs
        EwenVAOjm2ZRYOaeF8s3vPJumftY4gzn4SNPLQ/Nf8/9YvXFYydfRes9Dpy7wOZZnPPXfTsn
        2Ltdb5+nnFaxctIfV/vVTmu42faUvpc6fkTK+9/OhelFohmrLveJ9X3SydLo3HqLQ6vEQuAr
        162l0+Y6pMy+mzZTok2s5MaakKPKb+ze7J9wy/eHA7tosxJLcUaioRZzUXEiACzuHSszAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHYTEC PEV-EVAL-01 expansion board adds support for additional
gpio-triggered user-leds and gpio-key support.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
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
index 000000000000..3bcad402d3ec
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
+		home {
+			label =3D "Home";
+			gpios =3D <&gpio6 18 GPIO=5FACTIVE=5FLOW>;
+			linux,code =3D <KEY=5FSLEEP>;
+		};
+
+		power {
+			label =3D "Power Button";
+			gpios =3D <&gpio5 28 GPIO=5FACTIVE=5FLOW>;
+			linux,code =3D <KEY=5FWAKEUP>;
+			wakeup-source;
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

