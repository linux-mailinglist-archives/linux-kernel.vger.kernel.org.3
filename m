Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE9519E56
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbiEDLsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348982AbiEDLs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:48:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA78A2C12F;
        Wed,  4 May 2022 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651664689; x=1683200689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=P8pwd3ZauUT/o9vLSgv4a8pSQ407qKN8rogMBTCVPpA=;
  b=p6GCpUzGlGi0400u+ICapZNiYCbk+CCj0zCxEIhPIi71fwpS1EUqzqLs
   2KBgmFQT+a1YflUygIQVXYGk85uFz0jaiU5+a3+aRfzYsdRr4PGtmh3Qd
   LdywsRXdDH7SMD8C7pISpNQNpRq94V+3M7j6aiI78lhnAvqkb6dCwBq6s
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 04 May 2022 04:44:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 04:44:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 04:44:48 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 04:44:44 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v11 04/12] arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0/2.0 and IDP boards
Date:   Wed, 4 May 2022 17:14:01 +0530
Message-ID: <1651664649-25290-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651664649-25290-1-git-send-email-quic_srivasam@quicinc.com>
References: <1651664649-25290-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wcd9385 codec node for audio use case on sc7280 based platforms
of revision 3, 4 (aka CRD 1.0 and 2.0) and IDP boards.
Add tlmm gpio property for switching CTIA/OMTP Headset.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 14 ++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi   | 43 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
index 344338a..9c21207 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
@@ -87,6 +87,13 @@ ap_ts_pen_1v8: &i2c13 {
 	pins = "gpio51";
 };
 
+&wcd9385 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&wcd_reset_n>, <&us_euro_hs_sel>;
+	pinctrl-1 = <&wcd_reset_n_sleep>, <&us_euro_hs_sel>;
+	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+};
+
 &tlmm {
 	tp_int_odl: tp-int-odl {
 		pins = "gpio7";
@@ -105,4 +112,11 @@ ap_ts_pen_1v8: &i2c13 {
 		function = "gpio";
 		bias-disable;
 	};
+
+	us_euro_hs_sel: us-euro-hs-sel {
+		pins = "gpio81";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index f68eeb8..92f4436 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -20,6 +20,34 @@
 		serial1 = &uart7;
 	};
 
+	wcd9385: audio-codec-1 {
+		compatible = "qcom,wcd9385-codec";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&wcd_reset_n>;
+		pinctrl-1 = <&wcd_reset_n_sleep>;
+
+		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		vdd-rxtx-supply = <&vreg_l18b_1p8>;
+		vdd-io-supply = <&vreg_l18b_1p8>;
+		vdd-buck-supply = <&vreg_l17b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
+							  500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		#sound-dai-cells = <1>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -666,6 +694,21 @@
 		function = "gpio";
 		bias-pull-down;
 	};
+
+	wcd_reset_n: wcd-reset-n {
+		pins = "gpio83";
+		function = "gpio";
+		drive-strength = <8>;
+		output-high;
+	};
+
+	wcd_reset_n_sleep: wcd-reset-n-sleep {
+		pins = "gpio83";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+		output-low;
+	};
 };
 
 &remoteproc_wpss {
-- 
2.7.4

