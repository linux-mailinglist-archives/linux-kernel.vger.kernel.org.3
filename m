Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4642B57D01E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiGUPqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiGUPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:46:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390A98E1D8;
        Thu, 21 Jul 2022 08:41:52 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LEWBZD018932;
        Thu, 21 Jul 2022 15:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=FOsGJUyKE6iXXV2mk28X3How/ZzkoLRlTvGSa8YomFw=;
 b=A1T8DMyUIBqUGrq/1TIvgLtcEZ/U+j+IIiozyoHb8p2xZ2k+dRl+LmdWFndiKwtWkbsf
 31uw+/qIwEBZY/YKyo9Qlr7dALjMZ4gqXl2pq1u56s92BEdDnaFm1pcGEuTJ6mlMIC+n
 M5zLvvGfwAH1UOp9VCTKFAHSZOKz0/LRwFFYoDM1pYrwaDiVArsVXrMqj2lmBh6bGli/
 wftDCDiR6EVorYYq3hsVuew594e8ZZnUse5YOdFk/yFPwRyeik2goE/P6hfSilWQspFL
 Wr0JMlk9gDsgyG68+2Kmz1BKQdFlc3pm0CPHz5i7I7PYLZd3UGqYJ5WLq8zqvg694Wjo 8A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3heucv9yp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 15:41:38 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26LFfbFe008094
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 15:41:37 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Jul 2022 08:41:36 -0700
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Jul 2022 08:41:33 -0700
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH 1/2] arm64: dts: qcom: introduce sa8540p-ride dts
Date:   Thu, 21 Jul 2022 21:10:57 +0530
Message-ID: <20220721154057.15276-1-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NhZMfgDnQNYIQw3sVH8Vb2uLJPGDycf8
X-Proofpoint-GUID: NhZMfgDnQNYIQw3sVH8Vb2uLJPGDycf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207210062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new dts file specific for Qdrive board based on sa8540p chipset.
Introduce common dtsi file sa8295p-adp.dtsi, to be included for adp and
Qdrive board.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 378 +----------------
 arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi     | 385 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts |  15 +
 4 files changed, 403 insertions(+), 376 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 9e2a13d75f9d..fa0abcf7660b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
+dtb-$(CONFIG_ARCH_QCOM) += sa8540p-adp-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 9398f0349944..adb6637117bc 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -2,388 +2,14 @@
 /*
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022, Linaro Limited
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-#include <dt-bindings/spmi/spmi.h>
-
-#include "sa8540p.dtsi"
+#include "sa8295p-adp.dtsi"
 
 / {
 	model = "Qualcomm SA8295P ADP";
 	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";
-
-	aliases {
-		serial0 = &qup2_uart17;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&apps_rsc {
-	pmm8540-a-regulators {
-		compatible = "qcom,pm8150-rpmh-regulators";
-		qcom,pmic-id = "a";
-
-		vreg_l3a: ldo3 {
-			regulator-name = "vreg_l3a";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1208000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l5a: ldo5 {
-			regulator-name = "vreg_l5a";
-			regulator-min-microvolt = <912000>;
-			regulator-max-microvolt = <912000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l7a: ldo7 {
-			regulator-name = "vreg_l7a";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l13a: ldo13 {
-			regulator-name = "vreg_l13a";
-			regulator-min-microvolt = <3072000>;
-			regulator-max-microvolt = <3072000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-	};
-
-	pmm8540-c-regulators {
-		compatible = "qcom,pm8150-rpmh-regulators";
-		qcom,pmic-id = "c";
-
-		vreg_l1c: ldo1 {
-			regulator-name = "vreg_l1c";
-			regulator-min-microvolt = <912000>;
-			regulator-max-microvolt = <912000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l2c: ldo2 {
-			regulator-name = "vreg_l2c";
-			regulator-min-microvolt = <3072000>;
-			regulator-max-microvolt = <3072000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l3c: ldo3 {
-			regulator-name = "vreg_l3c";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l4c: ldo4 {
-			regulator-name = "vreg_l4c";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1208000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l6c: ldo6 {
-			regulator-name = "vreg_l6c";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l7c: ldo7 {
-			regulator-name = "vreg_l7c";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l10c: ldo10 {
-			regulator-name = "vreg_l10c";
-			regulator-min-microvolt = <2504000>;
-			regulator-max-microvolt = <2504000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l17c: ldo17 {
-			regulator-name = "vreg_l17c";
-			regulator-min-microvolt = <2504000>;
-			regulator-max-microvolt = <2504000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-	};
-
-	pmm8540-g-regulators {
-		compatible = "qcom,pm8150-rpmh-regulators";
-		qcom,pmic-id = "g";
-
-		vreg_l3g: ldo3 {
-			regulator-name = "vreg_l3g";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l7g: ldo7 {
-			regulator-name = "vreg_l7g";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-
-		vreg_l8g: ldo8 {
-			regulator-name = "vreg_l8g";
-			regulator-min-microvolt = <880000>;
-			regulator-max-microvolt = <880000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-allow-set-load;
-		};
-	};
-};
-
-&qup2 {
-	status = "okay";
-};
-
-&qup2_uart17 {
-	compatible = "qcom,geni-debug-uart";
-	status = "okay";
-};
-
-&remoteproc_adsp {
-	firmware-name = "qcom/sa8540p/adsp.mbn";
-	status = "okay";
-};
-
-&remoteproc_nsp0 {
-	firmware-name = "qcom/sa8540p/cdsp.mbn";
-	status = "okay";
-};
-
-&remoteproc_nsp1 {
-	firmware-name = "qcom/sa8540p/cdsp1.mbn";
-	status = "okay";
-};
-
-&spmi_bus {
-	pm8450a: pmic@0 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x0 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450a_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450c: pmic@4 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x4 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450c_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450e: pmic@8 {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x8 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450e_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
-	pm8450g: pmic@c {
-		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0xc SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8450g_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
-			reg = <0xc000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-};
-
-&ufs_mem_hc {
-	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
-
-	vcc-supply = <&vreg_l17c>;
-	vcc-max-microamp = <800000>;
-	vccq-supply = <&vreg_l6c>;
-	vccq-max-microamp = <900000>;
-
-	status = "okay";
-};
-
-&ufs_mem_phy {
-	vdda-phy-supply = <&vreg_l8g>;
-	vdda-pll-supply = <&vreg_l3g>;
-
-	status = "okay";
 };
-
-&ufs_card_hc {
-	reset-gpios = <&tlmm 229 GPIO_ACTIVE_LOW>;
-
-	vcc-supply = <&vreg_l10c>;
-	vcc-max-microamp = <800000>;
-	vccq-supply = <&vreg_l3c>;
-	vccq-max-microamp = <900000>;
-
-	status = "okay";
-};
-
-&ufs_card_phy {
-	vdda-phy-supply = <&vreg_l8g>;
-	vdda-pll-supply = <&vreg_l3g>;
-
-	status = "okay";
-};
-
-&usb_0 {
-	status = "okay";
-};
-
-&usb_0_dwc3 {
-	/* TODO: Define USB-C connector properly */
-	dr_mode = "peripheral";
-};
-
-&usb_0_hsphy {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7a>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_0_qmpphy {
-	vdda-phy-supply = <&vreg_l3a>;
-	vdda-pll-supply = <&vreg_l5a>;
-
-	status = "okay";
-};
-
-&usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
-	/* TODO: Define USB-C connector properly */
-	dr_mode = "host";
-};
-
-&usb_1_hsphy {
-	vdda-pll-supply = <&vreg_l1c>;
-	vdda18-supply = <&vreg_l7c>;
-	vdda33-supply = <&vreg_l2c>;
-
-	status = "okay";
-};
-
-&usb_1_qmpphy {
-	vdda-phy-supply = <&vreg_l4c>;
-	vdda-pll-supply = <&vreg_l1c>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy0 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy1 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy2 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_hsphy3 {
-	vdda-pll-supply = <&vreg_l5a>;
-	vdda18-supply = <&vreg_l7g>;
-	vdda33-supply = <&vreg_l13a>;
-
-	status = "okay";
-};
-
-&usb_2_qmpphy0 {
-	vdda-phy-supply = <&vreg_l3a>;
-	vdda-pll-supply = <&vreg_l5a>;
-
-	status = "okay";
-};
-
-&usb_2_qmpphy1 {
-	vdda-phy-supply = <&vreg_l3a>;
-	vdda-pll-supply = <&vreg_l5a>;
-
-	status = "okay";
-};
-
-&xo_board_clk {
-	clock-frequency = <38400000>;
-};
-
-/* PINCTRL */
diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi b/arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi
new file mode 100644
index 000000000000..75ef77b7cac1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/spmi/spmi.h>
+
+#include "sa8540p.dtsi"
+
+/ {
+	aliases {
+		serial0 = &qup2_uart17;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&apps_rsc {
+	pmm8540-a-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vreg_l3a: ldo3 {
+			regulator-name = "vreg_l3a";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l5a: ldo5 {
+			regulator-name = "vreg_l5a";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l7a: ldo7 {
+			regulator-name = "vreg_l7a";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l13a: ldo13 {
+			regulator-name = "vreg_l13a";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+	};
+
+	pmm8540-c-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vreg_l1c: ldo1 {
+			regulator-name = "vreg_l1c";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l2c: ldo2 {
+			regulator-name = "vreg_l2c";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l3c: ldo3 {
+			regulator-name = "vreg_l3c";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l4c: ldo4 {
+			regulator-name = "vreg_l4c";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l6c: ldo6 {
+			regulator-name = "vreg_l6c";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l7c: ldo7 {
+			regulator-name = "vreg_l7c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l10c: ldo10 {
+			regulator-name = "vreg_l10c";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l17c: ldo17 {
+			regulator-name = "vreg_l17c";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+	};
+
+	pmm8540-g-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "g";
+
+		vreg_l3g: ldo3 {
+			regulator-name = "vreg_l3g";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l7g: ldo7 {
+			regulator-name = "vreg_l7g";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l8g: ldo8 {
+			regulator-name = "vreg_l8g";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+	};
+};
+
+&qup2 {
+	status = "okay";
+};
+
+&qup2_uart17 {
+	compatible = "qcom,geni-debug-uart";
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8540p/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_nsp0 {
+	firmware-name = "qcom/sa8540p/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_nsp1 {
+	firmware-name = "qcom/sa8540p/cdsp1.mbn";
+	status = "okay";
+};
+
+&spmi_bus {
+	pm8450a: pmic@0 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450a_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8450c: pmic@4 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450c_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8450e: pmic@8 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x8 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450e_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8450g: pmic@c {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0xc SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8450g_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l17c>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l6c>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l8g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&ufs_card_hc {
+	reset-gpios = <&tlmm 229 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l10c>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l3c>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_card_phy {
+	vdda-phy-supply = <&vreg_l8g>;
+	vdda-pll-supply = <&vreg_l3g>;
+
+	status = "okay";
+};
+
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	/* TODO: Define USB-C connector properly */
+	dr_mode = "peripheral";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7a>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	/* TODO: Define USB-C connector properly */
+	dr_mode = "host";
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l1c>;
+	vdda18-supply = <&vreg_l7c>;
+	vdda33-supply = <&vreg_l2c>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l4c>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy0 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy1 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy2 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_hsphy3 {
+	vdda-pll-supply = <&vreg_l5a>;
+	vdda18-supply = <&vreg_l7g>;
+	vdda33-supply = <&vreg_l13a>;
+
+	status = "okay";
+};
+
+&usb_2_qmpphy0 {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&usb_2_qmpphy1 {
+	vdda-phy-supply = <&vreg_l3a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&xo_board_clk {
+	clock-frequency = <38400000>;
+};
+
+/* PINCTRL */
diff --git a/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
new file mode 100644
index 000000000000..87077f7a321c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "sa8295p-adp.dtsi"
+
+/ {
+	model = "Qualcomm SA8540 ADP";
+	compatible = "qcom,sa8540p-adp-ride", "qcom,sa8540p";
+};
-- 
2.17.1

