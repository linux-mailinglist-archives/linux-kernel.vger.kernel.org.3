Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0950A33C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389683AbiDUOvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348284AbiDUOvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:51:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342182253A;
        Thu, 21 Apr 2022 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650552525; x=1682088525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GVfORpkdB/WbJYntF+LYSjOiZqconCqshlJHYJBzovQ=;
  b=e2cKuxvqKOciLBE2G7we2/c5aNMSXhhgi2+6esYwP1ujg7pmtHDgSQ3A
   QuXQNpmlMhh/vtKgceuLpH517TVO7gGyysBzeaWdXXoymiwUJqkRecDkI
   UEp8UlFaNrpY/AMnREK/fjvzGjVldC46f2DiOQctg5XiO1KXF1InIeDtt
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Apr 2022 07:48:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:48:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Apr 2022 07:48:14 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Apr 2022 07:48:10 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v9 04/12] arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0 and CRD 2.0
Date:   Thu, 21 Apr 2022 20:17:31 +0530
Message-ID: <1650552459-21077-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wcd9385 codec node for audio use case on sc7280 based platforms
of revision 3 and 4 (aka CRD 1.0 and 2.0).
Add tlmm gpio property for switching CTIA/OMTP Headset.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts |  8 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi   | 50 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
index 344338a..462d655 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
@@ -87,6 +87,14 @@ ap_ts_pen_1v8: &i2c13 {
 	pins = "gpio51";
 };
 
+&wcd938x {
+	pinctrl-names = "default", "sleep", "us_euro_hs_sel";
+	pinctrl-0 = <&wcd_reset_n>;
+	pinctrl-1 = <&wcd_reset_n_sleep>;
+	pinctrl-2 = <&us_euro_hs_sel>;
+	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+};
+
 &tlmm {
 	tp_int_odl: tp-int-odl {
 		pins = "gpio7";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 6cb5fc4..b711ad0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -20,6 +20,34 @@
 		serial1 = &uart7;
 	};
 
+	wcd938x: audio-codec-1 {
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
@@ -678,6 +706,28 @@
 		function = "gpio";
 		bias-pull-down;
 	};
+
+	us_euro_hs_sel: us-euro-hs-sel {
+		pins = "gpio81";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
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

