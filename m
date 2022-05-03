Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FEC518A90
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbiECQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbiECQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:58:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A2937BD5;
        Tue,  3 May 2022 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651596902; x=1683132902;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2tJavwEtKWe6GCBkRLZmvzB9DBNg1v7NNp2CLVvT7d8=;
  b=vJIYQgt5RUeIAIohpnyIDyEhBXdTULMrMGp27dE3GOcvjkG7DiA/lSpj
   IhHMTuJw3t2uhGqpF+LvPJAqWdZ3sGipTs1IAXXCaQNSVqqn1y1rm7CzK
   4vGIJb0m+c6VdId14Zg+SPHq/ld8AUgI+1S/gbsJdVAHW9EE4gZmc6ug4
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 May 2022 09:55:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 09:55:02 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 09:54:21 -0700
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 09:54:18 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v1] arm64: dts: qcom: sc7280: Add the reset reg for lpass on SC7280
Date:   Tue, 3 May 2022 22:24:05 +0530
Message-ID: <20220503165405.25698-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
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

Add the reset register offset for clock gating.

Fixes: a3afe2a969cd ("arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers").
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
[v1]
 * This patch has a dependency on the patch under review:
  https://lore.kernel.org/lkml/20220503113246.13857-1-quic_tdas@quicinc.com/T/#u
  https://lore.kernel.org/lkml/20220503164635.23876-1-quic_tdas@quicinc.com/T/#t

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 477a754741a1..d5c4ffcf6546 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1985,13 +1985,15 @@

 		lpass_audiocc: clock-controller@3300000 {
 			compatible = "qcom,sc7280-lpassaudiocc";
-			reg = <0 0x03300000 0 0x30000>;
+			reg = <0 0x03300000 0 0x30000>,
+			      <0 0x032a9000 0 0x1000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 			       <&lpass_aon LPASS_AON_CC_MAIN_RCG_CLK_SRC>;
 			clock-names = "bi_tcxo", "lpass_aon_cc_main_rcg_clk_src";
 			power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+			#reset-cells = <1>;
 		};

 		lpass_aon: clock-controller@3380000 {
--
2.17.1

