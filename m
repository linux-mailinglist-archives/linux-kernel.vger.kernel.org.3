Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320005498DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbiFMKhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346204AbiFMKg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:36:59 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107910FFC;
        Mon, 13 Jun 2022 03:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655115762; x=1686651762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kW2JZLfcN2/TBSEbyLIBogBKHPmKsa+h+qA83vhr7FA=;
  b=FCrddeqYvhUDoOecpOZwfySUyfZrpJl0IHbCjFUPhV+KWZJM97wW1z/7
   cV8PYGKDV0q4+dky3m5TkEx+yOPwQXT4b92tIfwmQMcLVwc6o+Eu3w6oK
   uh/OdIbwHqXEDCxW1/PIpCOw5jFGszMz0aRdOeUJKi7niUbLbsA8nSJ6X
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jun 2022 03:22:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 03:22:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 03:22:41 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 03:22:36 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v13 02/12] arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD 1.0/2.0 and IDP boards
Date:   Mon, 13 Jun 2022 15:52:03 +0530
Message-ID: <1655115733-16309-3-git-send-email-quic_srivasam@quicinc.com>
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

Enable rx, tx and va macro codecs and soundwire nodes on revision 3,
4 (aka CRD 1.0 and 2.0) and IDP boards.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 4461a07..eb61135 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -246,6 +246,19 @@
 	modem-init;
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
+	vdd-micb-supply = <&vreg_bob>;
+};
+
 &pcie1 {
 	status = "okay";
 	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
@@ -306,6 +319,28 @@
 	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
 };
 
+&swr0 {
+	status = "okay";
+
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		#sound-dai-cells = <1>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr1 {
+	status = "okay";
+
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		#sound-dai-cells = <1>;
+		qcom,tx-port-mapping = <1 2 3 4>;
+	};
+};
+
 &uart5 {
 	compatible = "qcom,geni-debug-uart";
 	status = "okay";
-- 
2.7.4

