Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4422C472C62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhLMMip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:38:45 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:64380 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhLMMil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1639399113; x=1641991113;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rKnA0t1YU5FfRts2fbpjKB09OfFGuDO0ECstnRPcchE=;
        b=LyuS8lY3jKAKOhexatLpuVBUAv3Q4Exw2R0dnNBuA4vNJSNfJoxh9+Dgos9QLZCM
        H/x8a3JPJUB2eeBG6MVsrHxYKDtPu1D1OOA1+qmgj2syIi6ByEyNbInIclWH1/Ku
        HtlDRvnzwiXW0VgxUBxAQbfx8b0TCcuTh48gWhGNVR4=;
X-AuditID: c39127d2-4f7337000000426a-a7-61b73ec9e0f9
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A5.D3.17002.9CE37B16; Mon, 13 Dec 2021 13:38:33 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021121313383357-2359969 ;
          Mon, 13 Dec 2021 13:38:33 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org
Cc:     festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: dts: imx6: phytec: Add PEB-WLBT-05 support
Date:   Mon, 13 Dec 2021 13:38:33 +0100
Message-Id: <20211213123833.3011525-3-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213123833.3011525-1-y.bas@phytec.de>
References: <20211213123833.3011525-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.12.2021 13:38:33,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.12.2021 13:38:33
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWyRoCBS/ek3fZEg/NLdCzmHznHavHwqr/F
        psfXWC0u75rDZtG69wi7xd/tm1gsXmwRd2D32DnrLrvHplWdbB6bl9R79P818Pi8SS6ANYrL
        JiU1J7MstUjfLoEro/v9bvaCGREV9yf8YGlgnO7TxcjJISFgIjF99TrmLkYuDiGBrYwS7Q97
        GSGcC4wS36a9YgOpYhNQlDh/+y1rFyMHh4hAvMSLN+4gYWaBKIkPv1aBlQgLuEtce3GDCcRm
        EVCV2HWvnQXE5hUwk7j/vZUdYpm8xMxL38FsTgFziQOP3oDVCwHVTD5zlRmiXlDi5MwnLCA3
        SAhcYZR4PvMOG0SzkMTpxWeZIRZrSyxb+Jp5AqPALCQ9s5CkFjAyrWIUys1Mzk4tyszWK8io
        LElN1ktJ3cQIDODDE9Uv7WDsm+NxiJGJg/EQowQHs5II70vrrYlCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEee/3MCUKCaQnlqRmp6YWpBbBZJk4OKUaGLt4NkhaJYQYLFGf0PDIzcwlLEWZk3fG
        0gmyvQczep+eOD9hkWqQ+kfnOLGOvWqre1mP6Gw7vWHChkehxxLkTW9Zvbp08zvb5mlbpqem
        TbkdZVAS16J+Ls/5l7BojcQeZekvp54cTDXSMpq2fOG/cLPGsmtTfpTIfXXhzpNifPbvk1y2
        1iret0osxRmJhlrMRcWJAPyhB5dOAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PEB-WLBT-05 is equipped with a Sterling-LWB radio module, which is
capable of Wi-Fi 802.11 b/g/n and Bluetooth 4.2.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
Changes in v2:
- Changed node-name underscores to hyphens
---
 .../boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |  1 +
 .../boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |  1 +
 .../boot/dts/imx6q-phytec-mira-rdk-nand.dts   |  1 +
 .../dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi  | 82 +++++++++++++++++
 .../boot/dts/imx6qp-phytec-mira-rdk-nand.dts  |  1 +
 .../dts/imx6ul-phytec-segin-ff-rdk-nand.dts   |  1 +
 .../dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi  | 87 +++++++++++++++++++
 .../dts/imx6ull-phytec-segin-ff-rdk-nand.dts  |  1 +
 .../dts/imx6ull-phytec-segin-lc-rdk-nand.dts  |  1 +
 .../dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi | 19 ++++
 10 files changed, 195 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi

diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/b=
oot/dts/imx6dl-phytec-mira-rdk-nand.dts
index 8165fae2b1d1..d906a7f05aaa 100644
--- a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
@@ -10,6 +10,7 @@
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
 #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
+#include "imx6qdl-phytec-mira-peb-wlbt-05.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira DualLite/Solo Carrier-Board with NAND";
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts b/arch/arm/bo=
ot/dts/imx6q-phytec-mira-rdk-emmc.dts
index bbf5097ca974..322f071d972f 100644
--- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
@@ -10,6 +10,7 @@
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
 #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
+#include "imx6qdl-phytec-mira-peb-wlbt-05.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira Quad Carrier-Board with eMMC";
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts b/arch/arm/bo=
ot/dts/imx6q-phytec-mira-rdk-nand.dts
index 95051e18324f..3f13726c8058 100644
--- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
@@ -10,6 +10,7 @@
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
 #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
+#include "imx6qdl-phytec-mira-peb-wlbt-05.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira Quad Carrier-Board with NAND";
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi b/arch/=
arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi
new file mode 100644
index 000000000000..0abf3e1e1f62
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2021 PHYTEC Messtechnik GmbH
+ * Author: Yunus Bas <y.bas@phytec.de>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	reg=5Fwl=5Fen: regulator-wl-en {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "wlan=5Fen";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl=5Fwl>;
+		gpio =3D <&gpio5 2 GPIO=5FACTIVE=5FHIGH>;
+		enable-active-high;
+		startup-delay-us =3D <100>;
+		status =3D "disabled";
+	};
+};
+
+&uart3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl=5Fuart3=5Fbt>;
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible =3D "brcm,bcm43438-bt";
+		shutdown-gpios =3D <&gpio7 0 GPIO=5FACTIVE=5FHIGH>;
+		device-wakeup-gpios =3D <&gpio7 1 GPIO=5FACTIVE=5FHIGH>;
+		host-wakeup-gpios =3D <&gpio5 26 GPIO=5FACTIVE=5FHIGH>;
+		status =3D "disabled";
+	};
+};
+
+&usdhc3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl=5Fusdhc3=5Fwl>;
+	vmmc-supply =3D <&reg=5Fwl=5Fen>;
+	bus-width =3D <4>;
+	non-removable;
+	no-1-8-v;
+	status =3D "disabled";
+
+	brmcf: wifi@1 {
+		compatible =3D "brcm,bcm4329-fmac";
+	};
+};
+
+&iomuxc {
+	pinctrl=5Fuart3=5Fbt: uart3grp-bt {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FEIM=5FD25=5F=5FUART3=5FRX=5FDATA	0x1b0b1
+			MX6QDL=5FPAD=5FEIM=5FD24=5F=5FUART3=5FTX=5FDATA	0x1b0b1
+			MX6QDL=5FPAD=5FEIM=5FEB3=5F=5FUART3=5FRTS=5FB		0x1b0b1
+			MX6QDL=5FPAD=5FEIM=5FD23=5F=5FUART3=5FCTS=5FB		0x1b0b1
+			MX6QDL=5FPAD=5FSD3=5FDAT5=5F=5FGPIO7=5FIO00		0xb0b1	/* BT ENABLE */
+			MX6QDL=5FPAD=5FSD3=5FDAT4=5F=5FGPIO7=5FIO01		0xb0b1	/* DEV WAKEUP */
+			MX6QDL=5FPAD=5FCSI0=5FDAT8=5F=5FGPIO5=5FIO26	0xb0b1  /* HOST WAKEUP */
+		>;
+	};
+
+	pinctrl=5Fusdhc3=5Fwl: usdhc3grp-wl {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FSD3=5FCMD=5F=5FSD3=5FCMD		0x17059
+			MX6QDL=5FPAD=5FSD3=5FCLK=5F=5FSD3=5FCLK		0x10059
+			MX6QDL=5FPAD=5FSD3=5FDAT0=5F=5FSD3=5FDATA0		0x17059
+			MX6QDL=5FPAD=5FSD3=5FDAT1=5F=5FSD3=5FDATA1		0x17059
+			MX6QDL=5FPAD=5FSD3=5FDAT2=5F=5FSD3=5FDATA2		0x17059
+			MX6QDL=5FPAD=5FSD3=5FDAT3=5F=5FSD3=5FDATA3		0x17059
+		>;
+	};
+
+	pinctrl=5Fwl: wlgrp {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FEIM=5FA25=5F=5FGPIO5=5FIO02      0xb0b1	/* WLAN ENABLE */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts b/arch/arm/b=
oot/dts/imx6qp-phytec-mira-rdk-nand.dts
index 343639cb035c..a18266598d39 100644
--- a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
@@ -10,6 +10,7 @@
 #include "imx6qdl-phytec-mira.dtsi"
 #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
 #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
+#include "imx6qdl-phytec-mira-peb-wlbt-05.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Mira QuadPlus Carrier-Board with NAND";
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts b/arch/a=
rm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
index bff98e676980..607eddc5030f 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
@@ -10,6 +10,7 @@
 #include "imx6ul-phytec-segin.dtsi"
 #include "imx6ul-phytec-segin-peb-eval-01.dtsi"
 #include "imx6ul-phytec-segin-peb-av-02.dtsi"
+#include "imx6ul-phytec-segin-peb-wlbt-05.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Segin i.MX6 UltraLite Full Featured with NAND";
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi b/arch/=
arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi
new file mode 100644
index 000000000000..4a75745d6030
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2021 PHYTEC Messtechnik GmbH
+ * Author: Yunus Bas <y.bas@phytec.de>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	reg=5Fwl=5Fen: regulator-wl-en {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "wlan=5Fen";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl=5Fwl>;
+		gpio =3D <&gpio5 9 GPIO=5FACTIVE=5FHIGH>;
+		enable-active-high;
+		startup-delay-us =3D <100>;
+		status =3D "disabled";
+	};
+};
+
+&iomuxc {
+	pinctrl=5Fbt: btgrp {
+		fsl,pins =3D <
+			MX6UL=5FPAD=5FGPIO1=5FIO01=5F=5FGPIO1=5FIO01	0x3031	/* BT ENABLE */
+			MX6UL=5FPAD=5FGPIO1=5FIO03=5F=5FGPIO1=5FIO03	0x3031	/* HOST WAKEUP */
+			MX6UL=5FPAD=5FJTAG=5FMOD=5F=5FGPIO1=5FIO10		0x3031	/* DEV WAKEUP */
+		>;
+	};
+
+	pinctrl=5Fuart2=5Fbt: uart2grp-bt {
+		fsl,pins =3D <
+			MX6UL=5FPAD=5FUART2=5FTX=5FDATA=5F=5FUART2=5FDCE=5FTX   0x17059
+			MX6UL=5FPAD=5FUART2=5FRX=5FDATA=5F=5FUART2=5FDCE=5FRX   0x17059
+			MX6UL=5FPAD=5FUART2=5FCTS=5FB=5F=5FUART2=5FDCE=5FCTS    0x17059
+			MX6UL=5FPAD=5FUART2=5FRTS=5FB=5F=5FUART2=5FDCE=5FRTS    0x17059
+		>;
+	};
+
+	pinctrl=5Fusdhc2=5Fwl: usdhc2grp-wl {
+		fsl,pins =3D <
+			MX6UL=5FPAD=5FLCD=5FDATA18=5F=5FUSDHC2=5FCMD    0x10051
+			MX6UL=5FPAD=5FLCD=5FDATA19=5F=5FUSDHC2=5FCLK    0x10061
+			MX6UL=5FPAD=5FLCD=5FDATA20=5F=5FUSDHC2=5FDATA0  0x10051
+			MX6UL=5FPAD=5FLCD=5FDATA21=5F=5FUSDHC2=5FDATA1  0x10051
+			MX6UL=5FPAD=5FLCD=5FDATA22=5F=5FUSDHC2=5FDATA2  0x10051
+			MX6UL=5FPAD=5FLCD=5FDATA23=5F=5FUSDHC2=5FDATA3  0x10051
+		>;
+	};
+
+	pinctrl=5Fwl: wlgrp {
+		fsl,pins =3D <
+			MX6UL=5FPAD=5FSNVS=5FTAMPER9=5F=5FGPIO5=5FIO09  0x3031	/* WLAN ENABLE */
+		>;
+	};
+};
+
+&uart2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl=5Fuart2=5Fbt &pinctrl=5Fbt>;
+	uart-has-rtscts;
+	status =3D "disabled";
+
+	bluetooth {
+		compatible =3D "brcm,bcm43438-bt";
+		shutdown-gpios =3D <&gpio1 1 GPIO=5FACTIVE=5FHIGH>;
+		device-wakeup-gpios =3D <&gpio1 10 GPIO=5FACTIVE=5FHIGH>;
+		host-wakeup-gpios =3D <&gpio1 3 GPIO=5FACTIVE=5FHIGH>;
+	};
+};
+
+&usdhc2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl=5Fusdhc2=5Fwl>;
+	vmmc-supply =3D <&reg=5Fwl=5Fen>;
+	bus-width =3D <4>;
+	non-removable;
+	no-1-8-v;
+	status =3D "disabled";
+
+	brmcf: wifi@1 {
+		compatible =3D "brcm,bcm4329-fmac";
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts b/arch/=
arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts
index c8d3eff9ed4b..1d7362b5ac91 100644
--- a/arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts
@@ -10,6 +10,7 @@
 #include "imx6ull-phytec-segin.dtsi"
 #include "imx6ull-phytec-segin-peb-eval-01.dtsi"
 #include "imx6ull-phytec-segin-peb-av-02.dtsi"
+#include "imx6ull-phytec-segin-peb-wlbt-05.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Segin i.MX6 ULL Full Featured with NAND";
diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts b/arch/=
arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts
index e168494e0a6d..4bcbae024d8d 100644
--- a/arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dts
@@ -9,6 +9,7 @@
 #include "imx6ull-phytec-phycore-som.dtsi"
 #include "imx6ull-phytec-segin.dtsi"
 #include "imx6ull-phytec-segin-peb-eval-01.dtsi"
+#include "imx6ull-phytec-segin-peb-wlbt-05.dtsi"
=20
 / {
 	model =3D "PHYTEC phyBOARD-Segin i.MX6 ULL Low Cost with NAND";
diff --git a/arch/arm/boot/dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi b/arch=
/arm/boot/dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi
new file mode 100644
index 000000000000..df25814a3371
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-phytec-segin-peb-wlbt-05.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2021 PHYTEC Messtechnik GmbH
+ * Author: Yunus Bas <y.bas@phytec.de>
+ */
+
+#include "imx6ul-phytec-segin-peb-wlbt-05.dtsi"
+
+&iomuxc {
+	/delete-node/ wlgrp;
+};
+
+&iomuxc=5Fsnvs {
+	pinctrl=5Fwl: wlgrp {
+		fsl,pins =3D <
+			MX6ULL=5FPAD=5FSNVS=5FTAMPER9=5F=5FGPIO5=5FIO09	0x3031
+		>;
+	};
+};
--=20
2.25.1

