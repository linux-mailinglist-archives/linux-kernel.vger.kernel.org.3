Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC375491D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344535AbiFMKht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbiFMKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:37:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD9B120BD;
        Mon, 13 Jun 2022 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655115766; x=1686651766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=aYwxWhkR54p21X8xH7TcTR0H53//wdwLb0i2oW6DOzI=;
  b=Mf1/0hl0J3DBox0nFPlmakbexHDh38r/d0yeQAJfQnokhl+WS3vye/iA
   7YzrmPyUGbeIqqU05YkA26o/3oQahp49wP0TkF1I8ZzhnbWTg+OCv0iDr
   cY7vibHs54R/ZLt3Kr8PYcHH9tXAN7wpUyhzdpHUBL+1zr2NgHMhyAkQb
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jun 2022 03:22:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 03:22:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 03:22:45 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 03:22:41 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v13 03/12] arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD 3.0/3.1
Date:   Mon, 13 Jun 2022 15:52:04 +0530
Message-ID: <1655115733-16309-4-git-send-email-quic_srivasam@quicinc.com>
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

Enable rx, tx and va macro codecs and soundwire nodes for
CRD rev5+ (aka CRD 3.0/3.1) boards.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi        | 22 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index d92575e..32927db 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -103,6 +103,18 @@ ap_ts_pen_1v8: &i2c13 {
 	};
 };
 
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
 &mdss_edp {
 	status = "okay";
 };
@@ -135,6 +147,14 @@ ap_ts_pen_1v8: &i2c13 {
 	status = "okay";
 };
 
+&swr0 {
+	status = "okay";
+};
+
+&swr1 {
+	status = "okay";
+};
+
 /* PINCTRL - BOARD-SPECIFIC */
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index d59002d..e933ebf 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -303,6 +303,10 @@
 	modem-init;
 };
 
+&lpass_va_macro {
+	vdd-micb-supply = <&vreg_bob>;
+};
+
 /* NOTE: Not all Qcards have eDP connector stuffed */
 &mdss_edp {
 	vdda-0p9-supply = <&vdd_a_edp_0_0p9>;
@@ -375,6 +379,24 @@
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

