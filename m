Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499A458D3E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiHIGgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbiHIGfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:35:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB02205D1;
        Mon,  8 Aug 2022 23:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1660026942; x=1691562942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4wMwSe7QmPLeAfnAg9r5jQIIozAKquymAAMILjnSp4o=;
  b=w25jjKcpsFSsN+5Jl1wpwewNmAu9L6p91iEv0ygYP3fkzasd9XoqPWcQ
   NqsfGaFkYqfM6IlzKyK7fHG3gbgQIMHWDwzGE8VSaeHed38S26VUvBhLc
   fTbU0OAw5Dkrr7uUa9umHnxXXc3czJqRP0OnYLtBDXaZu22Rz05flZQuP
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Aug 2022 23:35:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 23:35:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 8 Aug 2022 23:35:41 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 8 Aug 2022 23:35:37 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>
Subject: [PATCH V4 3/3] arm64: dts: qcom: sc7280: Update lpasscore node
Date:   Tue, 9 Aug 2022 12:05:09 +0530
Message-ID: <1660026909-7365-4-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660026909-7365-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1660026909-7365-1-git-send-email-quic_c_skakit@quicinc.com>
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

To maintain consistency with other lpass nodes(lpass_audiocc,
lpass_aon and lpass_hm), update lpasscore to lpass_core.

Fixes: 9499240d15f2 ("arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes since v3:
 - This is newly added in v4, inorder to update the lpasscore node in a
   separate patch.

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 634f15e..c641f0b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2192,13 +2192,13 @@
 			reg = <0 0x03380000 0 0x30000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 			       <&rpmhcc RPMH_CXO_CLK_A>,
-			       <&lpasscore LPASS_CORE_CC_CORE_CLK>;
+			       <&lpass_core LPASS_CORE_CC_CORE_CLK>;
 			clock-names = "bi_tcxo", "bi_tcxo_ao", "iface";
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
 		};
 
-		lpasscore: clock-controller@3900000 {
+		lpass_core: clock-controller@3900000 {
 			compatible = "qcom,sc7280-lpasscorecc";
 			reg = <0 0x03900000 0 0x50000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
-- 
2.7.4

