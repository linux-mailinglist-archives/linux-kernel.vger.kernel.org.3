Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82659476C15
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhLPIlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:41:13 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:60706 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbhLPIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1639644067; x=1642236067;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v2BDP/nrrhKC/OTSLzFj7dSM473tvYEO8QCbKVhcLWE=;
        b=SA5VVL7rpFBm7zfi2CTcRUiHv9hcmFCIgnzWHKGeFVrDIY0lcwtfXIYNUXj04byo
        Qkb8xlPSc2lCK1tF07VdxY8yEsVorLOKNdGDvcgP9b3IxH9a/+i9boWaUUfu8ujt
        9RjnK5YQCfrZNg9RLb22fAbuXmEW04Ifw+QaS2HacGw=;
X-AuditID: c39127d2-4ef327000000426a-6a-61bafba3ee53
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 77.49.17002.3ABFAB16; Thu, 16 Dec 2021 09:41:07 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021121609410770-2392987 ;
          Thu, 16 Dec 2021 09:41:07 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org
Cc:     festevam@gmail.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] ARM: dts: imx6qdl: phytec: Add support for optional PEB-AV-02 LCD adapter
Date:   Thu, 16 Dec 2021 09:41:06 +0100
Message-Id: <20211216084107.1341968-2-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216084107.1341968-1-y.bas@phytec.de>
References: <20211216084107.1341968-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.12.2021 09:41:07,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.12.2021 09:41:07
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWyRoCBS3fx712JBm+mmFrMP3KO1eLhVX+L
        VVN3slhc3jWHzaJ17xF2i7/bN7FYvNgi7sDusXPWXXaPTas62Tz6/xp4fN4kF8ASxWWTkpqT
        WZZapG+XwJXx//J+5oLfZhXtD++wNzBu0+9i5OCQEDCRuPZUo4uRi0NIYCujxIw5/5ghnAuM
        Eqd/nGLpYuTkYBNQlDh/+y0rSIOIQLzEizfuIGFmAW+J7qVrmUBsYYFEiYUrnjOC2CwCqhLn
        /94Ds3kFzCRm7d3JDGJLCMhLzLz0nR3E5hQwl/i0sxGsRgioZvLpsywQ9YISJ2c+YQG5QULg
        CqPEjUU9UM1CEqcXn2WGWKwtsWzha+YJjAKzkPTMQpJawMi0ilEoNzM5O7UoM1uvIKOyJDVZ
        LyV1EyMwbA9PVL+0g7FvjschRiYOxkOMEhzMSiK8TyJ2JQrxpiRWVqUW5ccXleakFh9ilOZg
        URLnvd/DlCgkkJ5YkpqdmlqQWgSTZeLglGpg3PFruatQZEBukm5W5oqfjyQfX+AWm+FYf6Il
        0W+fw+p7+uXPpPzfLT1X9UfqmfPTjZ0SC+02CX9LXyOyM3hj6qIa4Yur3Sd1OM22d9nwnvEQ
        +6bmtUccLu84o+vz0qJsypewKxxC3e/XGn5aaLPo+qJ7Uy7ymCwqaqt/1OjTKHkhInVN2NKI
        TUosxRmJhlrMRcWJAHak2JRJAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PEB-AV-02 expansion adapter extends the phyBOARD-Mira boards to
connect parallel LCD displays, either with capacitive or resistive
touch.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
Changes in v3:
- Changed display node name to display0
---
 .../boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |   1 +
 .../boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |   1 +
 .../boot/dts/imx6q-phytec-mira-rdk-nand.dts   |   1 +
 .../dts/imx6qdl-phytec-mira-peb-av-02.dtsi    | 119 ++++++++++++++++++
 .../boot/dts/imx6qp-phytec-mira-rdk-nand.dts  |   1 +
 5 files changed, 123 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi

diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/b=
oot/dts/imx6dl-phytec-mira-rdk-nand.dts
index b057fa664a6b..8165fae2b1d1 100644
--- a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
@@ -9,6 +9,7 @@
 #include "imx6qdl-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
+#include "imx6qdl-phytec-mira-peb-av-02.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira DualLite/Solo Carrier-Board with NAND";
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts b/arch/arm/bo=
ot/dts/imx6q-phytec-mira-rdk-emmc.dts
index db6e2cc36759..bbf5097ca974 100644
--- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
@@ -9,6 +9,7 @@
 #include "imx6qdl-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
+#include "imx6qdl-phytec-mira-peb-av-02.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira Quad Carrier-Board with eMMC";
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts b/arch/arm/bo=
ot/dts/imx6q-phytec-mira-rdk-nand.dts
index 51ff601b1aec..95051e18324f 100644
--- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
@@ -9,6 +9,7 @@
 #include "imx6qdl-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
+#include "imx6qdl-phytec-mira-peb-av-02.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira Quad Carrier-Board with NAND";
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi b/arch/ar=
m/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
new file mode 100644
index 000000000000..393475cb0f4d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 PHYTEC Messtechnik
+ * Author: Christian Hemp <c.hemp@phytec.de>
+ */
+
+/ {
+	display: display0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		compatible =3D "fsl,imx-parallel-display";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl=5Fdisp0>;
+		interface-pix-fmt =3D "rgb24";
+		status =3D "disabled";
+
+		port@0 {
+			reg =3D <0>;
+
+			display0=5Fin: endpoint {
+				remote-endpoint =3D <&ipu1=5Fdi0=5Fdisp0>;
+			};
+		};
+
+		port@1 {
+			reg =3D <1>;
+
+			display0=5Fout: endpoint {
+				remote-endpoint =3D <&peb=5Fpanel=5Flcd=5Fin>;
+			};
+		};
+	};
+
+	panel-lcd {
+		compatible =3D "edt,etm0700g0edh6";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl=5Fdisp0=5Fpwr>;
+		power-supply =3D <&reg=5Fdisplay>;
+		enable-gpios =3D <&gpio3 22 GPIO=5FACTIVE=5FHIGH>;
+		backlight =3D <&backlight>;
+		status =3D "disabled";
+
+		port {
+			peb=5Fpanel=5Flcd=5Fin: endpoint {
+				remote-endpoint =3D <&display0=5Fout>;
+			};
+		};
+	};
+
+	reg=5Fdisplay: regulator-peb-display {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "peb-display";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+	};
+};
+
+&i2c1 {
+	edt=5Fft5x06: touchscreen@38 {
+		compatible =3D "edt,edt-ft5406";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl=5Fedt=5Fft5x06>;
+		reg =3D <0x38>;
+		interrupt-parent =3D <&gpio3>;
+		interrupts =3D <2 IRQ=5FTYPE=5FNONE>;
+		status =3D "disabled";
+        };
+};
+
+&ipu1=5Fdi0=5Fdisp0 {
+	remote-endpoint =3D <&display0=5Fin>;
+};
+
+&iomuxc {
+	pinctrl=5Fdisp0: disp0grp {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FDI0=5FDISP=5FCLK=5F=5FIPU1=5FDI0=5FDISP=5FCLK	0x10
+			MX6QDL=5FPAD=5FDI0=5FPIN2=5F=5FIPU1=5FDI0=5FPIN02		0x10
+			MX6QDL=5FPAD=5FDI0=5FPIN3=5F=5FIPU1=5FDI0=5FPIN03		0x10
+			MX6QDL=5FPAD=5FDI0=5FPIN15=5F=5FIPU1=5FDI0=5FPIN15		0x1b080
+			MX6QDL=5FPAD=5FDISP0=5FDAT0=5F=5FIPU1=5FDISP0=5FDATA00	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT1=5F=5FIPU1=5FDISP0=5FDATA01	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT2=5F=5FIPU1=5FDISP0=5FDATA02	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT3=5F=5FIPU1=5FDISP0=5FDATA03	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT4=5F=5FIPU1=5FDISP0=5FDATA04	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT5=5F=5FIPU1=5FDISP0=5FDATA05	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT6=5F=5FIPU1=5FDISP0=5FDATA06	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT7=5F=5FIPU1=5FDISP0=5FDATA07	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT8=5F=5FIPU1=5FDISP0=5FDATA08	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT9=5F=5FIPU1=5FDISP0=5FDATA09	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT10=5F=5FIPU1=5FDISP0=5FDATA10	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT11=5F=5FIPU1=5FDISP0=5FDATA11	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT12=5F=5FIPU1=5FDISP0=5FDATA12	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT13=5F=5FIPU1=5FDISP0=5FDATA13	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT14=5F=5FIPU1=5FDISP0=5FDATA14	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT15=5F=5FIPU1=5FDISP0=5FDATA15	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT16=5F=5FIPU1=5FDISP0=5FDATA16	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT17=5F=5FIPU1=5FDISP0=5FDATA17	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT18=5F=5FIPU1=5FDISP0=5FDATA18	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT19=5F=5FIPU1=5FDISP0=5FDATA19	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT20=5F=5FIPU1=5FDISP0=5FDATA20	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT21=5F=5FIPU1=5FDISP0=5FDATA21	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT22=5F=5FIPU1=5FDISP0=5FDATA22	0x10
+			MX6QDL=5FPAD=5FDISP0=5FDAT23=5F=5FIPU1=5FDISP0=5FDATA23	0x10
+		>;
+	};
+
+	pinctrl=5Fdisp0=5Fpwr: disp0pwrgrp {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FEIM=5FD22=5F=5FGPIO3=5FIO22			0x1b0b0
+		>;
+	};
+
+	pinctrl=5Fedt=5Fft5x06: edtft5x06grp {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FEIM=5FDA2=5F=5FGPIO3=5FIO02			0xb0b1
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts b/arch/arm/b=
oot/dts/imx6qp-phytec-mira-rdk-nand.dts
index 06fe0c5315fc..343639cb035c 100644
--- a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
@@ -9,6 +9,7 @@
 #include "imx6qdl-phytec-phycore-som.dtsi"
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
+#include "imx6qdl-phytec-mira-peb-av-02.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira QuadPlus Carrier-Board with NAND";
--=20
2.25.1

