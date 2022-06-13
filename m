Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B21549111
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346539AbiFMKkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346301AbiFMKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:37:51 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD8813CD2;
        Mon, 13 Jun 2022 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655115775; x=1686651775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rx2DvSLkLdzI3r6yAuUJ2LGZvHt6B8djgeXH8BkRTS0=;
  b=Ri6RJFjLP0U3fTUH0n/u9uIQZz8khEfdn+j8OLy95apJNdNikdhBtRv5
   RN0LCuPSu+s62Ua8Z2j2HsienOGHbOp54M+Q8aWVmIwcGdiJClhLF3PoD
   1rgNSiZzxiU91MtOvtoZ+xmVRtkWpYGTBZ8iFG2PEse2gICZggCbW10VY
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jun 2022 03:22:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 03:22:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 03:22:54 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 03:22:50 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v13 05/12] arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 3.0/3.1
Date:   Mon, 13 Jun 2022 15:52:06 +0530
Message-ID: <1655115733-16309-6-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655115733-16309-1-git-send-email-quic_srivasam@quicinc.com>
References: <1655115733-16309-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wcd9385 codec node for audio use case on CRD rev5+ (aka CRD 3.0/3.1)
boards. Add tlmm gpio property for switching CTIA/OMTP Headset.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  4 ++
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi        | 52 +++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index 32927db..c7537fb 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -155,6 +155,10 @@ ap_ts_pen_1v8: &i2c13 {
 	status = "okay";
 };
 
+&wcd9385 {
+	status = "okay";
+};
+
 /* PINCTRL - BOARD-SPECIFIC */
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index e933ebf..efa6787 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -30,6 +30,37 @@
 		serial1 = &uart7;
 	};
 
+	wcd9385: audio-codec-1 {
+		compatible = "qcom,wcd9385-codec";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&wcd_reset_n>, <&us_euro_hs_sel>;
+		pinctrl-1 = <&wcd_reset_n_sleep>, <&us_euro_hs_sel>;
+
+		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+		us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
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
+
+		status = "disabled";
+	};
+
 	pm8350c_pwm_backlight: backlight {
 		compatible = "pwm-backlight";
 		status = "disabled";
@@ -629,4 +660,25 @@ mos_bt_uart: &uart7 {
 		bias-pull-up;
 		drive-strength = <2>;
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
+	};
 };
-- 
2.7.4

