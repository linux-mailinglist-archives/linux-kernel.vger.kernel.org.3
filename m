Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09FE462F46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbhK3JMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:12:32 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:61058 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbhK3JMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1638262435; x=1640854435;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Sqc7Mi3wm41zSdRYd8B3rAkW0qisFIwyPTed8zMbegY=;
        b=DWi7qZ1+GHcY22XWLoLhILYGiKqJUeD8YkLMcYZGFAJhuaxLQCbyYCEcAfisKqUa
        6zHd/p5C9o0MqqHrDoWmUYoDqeNYXjKK1yIgDsOqNgpFbzAZsdz+UXbjevmG4TJT
        eQ9CvhlQR/iisIVW8MtljlFmIX07KHTrIwoIj//tEcM=;
X-AuditID: c39127d2-4f7337000000426a-b8-61a5e6a3c2fa
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 61.4F.17002.3A6E5A16; Tue, 30 Nov 2021 09:53:55 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021113009535528-2244390 ;
          Tue, 30 Nov 2021 09:53:55 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: imx6qdl: phytec: Add support for optional PEB-AV-02 LCD adapter
Date:   Tue, 30 Nov 2021 09:53:54 +0100
Message-Id: <20211130085355.2291607-2-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130085355.2291607-1-y.bas@phytec.de>
References: <20211130085355.2291607-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 30.11.2021 09:53:55,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 30.11.2021 09:53:55
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWyRoCBS3fxs6WJBjd61SzmHznHavHwqr/F
        qqk7WSwu75rDZtG69wi7xd/tm1gsXmwRd2D32DnrLrvHplWdbB79fw08Pm+SC2CJ4rJJSc3J
        LEst0rdL4Mo4s/8wY8Fts4oFu5tZGhjn6ncxcnJICJhI7L++j72LkYtDSGAro0Tr8b1QzgVG
        ia3XZ7CBVLEJKEqcv/2WFcQWEYiXmLr/JyOIzSzgLdF64ypzFyMHh7BAnET7RjkQk0VAVeJy
        hzpIBa+AmcS63xCdEgLyEjMvfWcHsTkFzCXeLT8ENl0IqObsqzWMEPWCEidnPmEBOUFC4Aqj
        RO+9W+wQzUISpxefZYZYqy2xbOFr5gmMArOQ9MxCklrAyLSKUSg3Mzk7tSgzW68go7IkNVkv
        JXUTIzBsD09Uv7SDsW+OxyFGJg7GQ4wSHMxKIrzeZxYnCvGmJFZWpRblxxeV5qQWH2KU5mBR
        Eue938OUKCSQnliSmp2aWpBaBJNl4uCUamDc+N70XPqFiXYLZY/Pi+xN/s+byq+05sse1eKO
        ooaetTufLeqdcUnxYDGjfa6bZnPi5J4l9xf/PRxxK6dB3rFNes5qJckkU83L5T5/X3uq1W5z
        97xS0MsmsXiff10jQ0B5cOvPf094S2fmsG7u939u9yVVPuPL40D7lONK3jK/zUu39oj+3anE
        UpyRaKjFXFScCAD+jKVZSQIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PEB-AV-02 expansion adapter extends the phyBOARD-Mira boards to
connect parallel LCD displays, either with capacitive or resistive
touch.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 .../boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |   1 +
 .../boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |   1 +
 .../boot/dts/imx6q-phytec-mira-rdk-nand.dts   |   1 +
 .../dts/imx6qdl-phytec-mira-peb-av-02.dtsi    | 122 ++++++++++++++++++
 .../boot/dts/imx6qp-phytec-mira-rdk-nand.dts  |   1 +
 5 files changed, 126 insertions(+)
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
index 000000000000..671e8024cba5
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 PHYTEC Messtechnik
+ * Author: Christian Hemp <c.hemp@phytec.de>
+ */
+
+/ {
+
+	display: display@di0 {
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
+		compatible =3D "edt,edt-ft5406", "edt,edt-ft5x06";
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
+
+			MX6QDL=5FPAD=5FDI0=5FPIN15=5F=5FIPU1=5FDI0=5FPIN15		0x1b080
+
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

