Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BEF54B582
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357009AbiFNQLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiFNQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:11:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD81427D6;
        Tue, 14 Jun 2022 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655223102; x=1686759102;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AkQmBF76CtIkQi/TFwXemb2uXkG2WcKUZ9CQRohu4Tw=;
  b=YK3cEKt32WRvQ9DoxSAHYrBK/gfkngrnFfsju8bQB04wHk+ibk8JSYzd
   Flo/89DJYYekrdYMTveGvkH+C2x32mSBT0GKv9bG9lxb4FFBWd6sC9Kk+
   K2wjJLmxVt0aZeJh79xw9CVcrP/tr5gCqVXskC83eQgrL3PK3YBNoK8h+
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jun 2022 09:11:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 09:11:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 09:11:42 -0700
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 09:11:38 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v1] arm64: dts: qcom: sc7280: Update lpassaudio clock controller for resets
Date:   Tue, 14 Jun 2022 21:41:18 +0530
Message-ID: <20220614161118.12458-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
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

The lpass audio supports TX/RX/WSA block resets. The LPASS PIL clock
driver is not supported and mark it disabled. Also to keep consistency
update lpasscore to lpass_core.

Fixes: 9499240d15f2 ("arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index e66fc67de206..180cfd2765b9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2174,6 +2174,7 @@
 			clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
 			clock-names = "iface";
 			#clock-cells = <1>;
+			status = "disabled";
 		};

 		lpass_audiocc: clock-controller@3300000 {
@@ -2185,6 +2186,7 @@
 			power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+			#reset-cells = <1>;
 		};

 		lpass_aon: clock-controller@3380000 {
@@ -2198,7 +2200,7 @@
 			#power-domain-cells = <1>;
 		};

-		lpasscore: clock-controller@3900000 {
+		lpass_core: clock-controller@3900000 {
 			compatible = "qcom,sc7280-lpasscorecc";
 			reg = <0 0x03900000 0 0x50000>;
 			clocks =  <&rpmhcc RPMH_CXO_CLK>;
--
2.17.1

