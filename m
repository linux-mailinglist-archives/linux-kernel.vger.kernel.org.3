Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C58B548190
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbiFMIYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239996AbiFMIYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:24:42 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C031EC61;
        Mon, 13 Jun 2022 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655108679; x=1686644679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tZDCigRR1nc+XLeX+qrM6SNY2iYOJcy78bnyP+dxYX4=;
  b=cp+qSHCh+Wy/dszxs3NUmhg3wRsK4gnVidTSaLWof4Gz5qb+ZlTCVmd8
   BV2pSDFknGmbruzgrit5NNxkb6/Xc8JZo50OYoEJkTA06ue0aOIdEwBwM
   05lx/whA1zcanhpR5x+vmBZ9PQNtzgBe6vE4pmnUiLpCw57pLKl4mDRuQ
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jun 2022 01:24:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 01:24:38 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 01:24:38 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 01:24:33 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v15 3/4] arm64: dts: qcom: sc7280: add lpass lpi pin controller node
Date:   Mon, 13 Jun 2022 13:54:04 +0530
Message-ID: <1655108645-1517-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655108645-1517-1-git-send-email-quic_srivasam@quicinc.com>
References: <1655108645-1517-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Add LPASS LPI pinctrl node required for Audio functionality on sc7280
based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
This patch set depends on:
    -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=649484

 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 62 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 92 ++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index acf407a..4461a07 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -367,6 +367,68 @@
 	bias-disable;
 };
 
+&lpass_dmic01_clk {
+	drive-strength = <8>;
+	bias-disable;
+};
+
+&lpass_dmic01_clk_sleep {
+	drive-strength = <2>;
+};
+
+&lpass_dmic01_data {
+	bias-pull-down;
+};
+
+&lpass_dmic23_clk {
+	drive-strength = <8>;
+	bias-disable;
+};
+
+&lpass_dmic23_clk_sleep {
+	drive-strength = <2>;
+};
+
+&lpass_dmic23_data {
+	bias-pull-down;
+};
+
+&lpass_rx_swr_clk {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-disable;
+};
+
+&lpass_rx_swr_clk_sleep {
+	bias-pull-down;
+};
+
+&lpass_rx_swr_data {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-bus-hold;
+};
+
+&lpass_rx_swr_data_sleep {
+	bias-pull-down;
+};
+
+&lpass_tx_swr_clk {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-disable;
+};
+
+&lpass_tx_swr_clk_sleep {
+	bias-pull-down;
+};
+
+&lpass_tx_swr_data {
+	drive-strength = <2>;
+	slew-rate = <1>;
+	bias-bus-hold;
+};
+
 &mi2s1_data0 {
 	drive-strength = <6>;
 	bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index fde55c3..b14134a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2224,6 +2224,98 @@
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		lpass_tlmm: pinctrl@33c0000 {
+			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
+			reg = <0 0x033c0000 0x0 0x20000>,
+				<0 0x03550000 0x0 0x10000>;
+			qcom,adsp-bypass-mode;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 15>;
+
+			#clock-cells = <1>;
+
+			lpass_dmic01_clk: dmic01-clk {
+				pins = "gpio6";
+				function = "dmic1_clk";
+			};
+
+			lpass_dmic01_clk_sleep: dmic01-clk-sleep {
+				pins = "gpio6";
+				function = "dmic1_clk";
+			};
+
+			lpass_dmic01_data: dmic01-data {
+				pins = "gpio7";
+				function = "dmic1_data";
+			};
+
+			lpass_dmic01_data_sleep: dmic01-data-sleep {
+				pins = "gpio7";
+				function = "dmic1_data";
+			};
+
+			lpass_dmic23_clk: dmic23-clk {
+				pins = "gpio8";
+				function = "dmic2_clk";
+			};
+
+			lpass_dmic23_clk_sleep: dmic23-clk-sleep {
+				pins = "gpio8";
+				function = "dmic2_clk";
+			};
+
+			lpass_dmic23_data: dmic23-data {
+				pins = "gpio9";
+				function = "dmic2_data";
+			};
+
+			lpass_dmic23_data_sleep: dmic23-data-sleep {
+				pins = "gpio9";
+				function = "dmic2_data";
+			};
+
+			lpass_rx_swr_clk: rx-swr-clk {
+				pins = "gpio3";
+				function = "swr_rx_clk";
+			};
+
+			lpass_rx_swr_clk_sleep: rx-swr-clk-sleep {
+				pins = "gpio3";
+				function = "swr_rx_clk";
+			};
+
+			lpass_rx_swr_data: rx-swr-data {
+				pins = "gpio4", "gpio5";
+				function = "swr_rx_data";
+			};
+
+			lpass_rx_swr_data_sleep: rx-swr-data-sleep {
+				pins = "gpio4", "gpio5";
+				function = "swr_rx_data";
+			};
+
+			lpass_tx_swr_clk: tx-swr-clk {
+				pins = "gpio0";
+				function = "swr_tx_clk";
+			};
+
+			lpass_tx_swr_clk_sleep: tx-swr-clk-sleep {
+				pins = "gpio0";
+				function = "swr_tx_clk";
+			};
+
+			lpass_tx_swr_data: tx-swr-data {
+				pins = "gpio1", "gpio2", "gpio14";
+				function = "swr_tx_data";
+			};
+
+			lpass_tx_swr_data_sleep: tx-swr-data-sleep {
+				pins = "gpio1", "gpio2", "gpio14";
+				function = "swr_tx_data";
+			};
+		};
+
 		gpu: gpu@3d00000 {
 			compatible = "qcom,adreno-635.0", "qcom,adreno";
 			reg = <0 0x03d00000 0 0x40000>,
-- 
2.7.4

