Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3E56A374
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiGGNXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiGGNXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:23:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F7A167C7;
        Thu,  7 Jul 2022 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657200218; x=1688736218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xiGPbSR49NPyQYHVAWPCYFQ9YgNCvbFt5FTwUWQjCKo=;
  b=EpIFKUxT4ZWVbkNHhes9qg4jRkgGThM93doTuMSUKZB2JkYJoY3UalM9
   0eZkgQ6nc0HM0PUPWR49WEOVtXhKrMxf7PYF2efvKdgIFkDlmxSk4Xf+4
   MDeh3Ox07Fian/QYdPPR1O3t9uuVs9Dz/2+GTMONu3shCpMEE/L5p0yik
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Jul 2022 06:23:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 06:23:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 06:23:37 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 06:23:32 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v14 03/12] arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD 3.0/3.1
Date:   Thu, 7 Jul 2022 18:52:55 +0530
Message-ID: <1657200184-29565-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657200184-29565-1-git-send-email-quic_srivasam@quicinc.com>
References: <1657200184-29565-1-git-send-email-quic_srivasam@quicinc.com>
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

Enable rx, tx and va macro codecs and soundwire nodes for
CRD rev5+ (aka CRD 3.0/3.1) boards.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi   | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi         | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
index 859faaa..1c0bb7c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
@@ -5,6 +5,28 @@
  * Copyright (c) 2022, The Linux Foundation. All rights reserved.
  */
 
+/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
+
+&lpass_rx_macro {
+	status = "okay";
+};
+
+&lpass_tx_macro {
+	status = "okay";
+};
+
+&lpass_va_macro {
+	status = "okay";
+};
+
+&swr0 {
+	status = "okay";
+};
+
+&swr1 {
+	status = "okay";
+};
+
 /* PINCTRL */
 
 &lpass_dmic01_clk {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 4c25ffc..ee7d52a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -309,6 +309,10 @@
 	modem-init;
 };
 
+&lpass_va_macro {
+	vdd-micb-supply = <&vreg_bob>;
+};
+
 /* NOTE: Not all Qcards have eDP connector stuffed */
 &mdss_edp {
 	vdda-0p9-supply = <&vdd_a_edp_0_0p9>;
@@ -381,6 +385,24 @@
 	no-sdio;
 };
 
+&swr0 {
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		#sound-dai-cells = <1>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr1 {
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		#sound-dai-cells = <1>;
+		qcom,tx-port-mapping = <1 2 3 4>;
+	};
+};
+
 uart_dbg: &uart5 {
 	compatible = "qcom,geni-debug-uart";
 	status = "okay";
-- 
2.7.4

