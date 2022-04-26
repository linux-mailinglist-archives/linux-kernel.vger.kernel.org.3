Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB39A50F23F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbiDZHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343932AbiDZHY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:24:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0033E5D0;
        Tue, 26 Apr 2022 00:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650957711; x=1682493711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tkgfhYn3wntTRUfPMP9Ukb6nWf2+DdZVZrZvxyc2pug=;
  b=OEyEn5o8Ra0xN9yvQPYM4d4Tp3g3whk+0Q/LzAn6QDTvCw5tqwAinvNW
   QPG11VKkd1bf2XStq/5HK7nWrw5tBZEUL7wR6KXU0c9FhvyiNNeuVOhUG
   hpEGdxAkb7vM7SzRptEr0qUppPNNntmtZJdcK1I4ss2ESnAM+qro6ktb7
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Apr 2022 00:21:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:21:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 00:21:50 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 00:21:45 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v11 4/4] arm64: dts: qcom: sc7280-herobrine: Add lpi pinmux properties for CRD 3.0/3.1
Date:   Tue, 26 Apr 2022 12:51:06 +0530
Message-ID: <1650957666-6266-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650957666-6266-1-git-send-email-quic_srivasam@quicinc.com>
References: <1650957666-6266-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LPASS LPI pinctrl properties, which are required for Audio
functionality on herobrine based platforms of rev5+
(aka CRD 3.0/3.1) boards.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 84 ++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 4c4a0e9..1510118 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -588,6 +588,90 @@ ap_ec_spi: &spi10 {
 	bias-disable;
 };
 
+&lpass_dmic01 {
+	clk {
+		drive-strength = <8>;
+	};
+};
+
+&lpass_dmic01_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	data {
+		pull-down;
+	};
+};
+
+&lpass_dmic23 {
+	clk {
+		drive-strength = <8>;
+	};
+};
+
+&lpass_dmic23_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	data {
+		pull-down;
+	};
+};
+
+&lpass_rx_swr {
+	clk {
+		drive-strength = <2>;
+		slew-rate = <1>;
+		bias-disable;
+	};
+
+	data {
+		drive-strength = <2>;
+		slew-rate = <1>;
+		bias-bus-hold;
+	};
+};
+
+&lpass_rx_swr_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	data {
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&lpass_tx_swr {
+	clk {
+		drive-strength = <2>;
+		slew-rate = <1>;
+		bias-disable;
+	};
+
+	data {
+		slew-rate = <1>;
+		bias-bus-hold;
+	};
+};
+
+&lpass_tx_swr_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	data {
+		bias-bus-hold;
+	};
+};
+
 &mi2s0_data0 {
 	drive-strength = <6>;
 };
-- 
2.7.4

