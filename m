Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCADC4D8752
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbiCNOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbiCNOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:48:33 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083CB419A4;
        Mon, 14 Mar 2022 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647269244; x=1678805244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DpYvGVvANvcAxVAuc1fNDCp++ylblh/A9jcUhmQEzvY=;
  b=MoQiyCLnTzABFC5kU46FDRpYKtaItjwnagT14q6va9M0Hxl538/1N/BY
   02V/D2vZU7rrnnSOJu+/LhdOvlhYBOtB1qdXAmxV9ZCFVgEKxyT8N3pg1
   lHSUeSpBrhyixXAPO2HR54i8A23Z3I1SBk6P+4ahHdiqUUSTz5zbdMdxy
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 14 Mar 2022 07:47:22 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Mar 2022 07:47:21 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 14 Mar 2022 20:17:02 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 62D624E34; Mon, 14 Mar 2022 20:17:01 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, dianders@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v6 3/5] arm64: dts: qcom: sm7180: remove assigned-clock-rate property for mdp clk
Date:   Mon, 14 Mar 2022 20:16:55 +0530
Message-Id: <1647269217-14064-4-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647269217-14064-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1647269217-14064-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the assigned clock rate property and vote on the mdp clock as per
calculated value during the usecase.

This patch is dependent on below patch
https://patchwork.kernel.org/patch/12774067/

Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index e1c46b8..eaab746 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2900,9 +2900,6 @@
 				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
 			clock-names = "iface", "ahb", "core";
 
-			assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
-			assigned-clock-rates = <300000000>;
-
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
@@ -2932,12 +2929,10 @@
 					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
 				clock-names = "bus", "iface", "rot", "lut", "core",
 					      "vsync";
-				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
-						  <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
+				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
 						  <&dispcc DISP_CC_MDSS_ROT_CLK>,
 						  <&dispcc DISP_CC_MDSS_AHB_CLK>;
-				assigned-clock-rates = <300000000>,
-						       <19200000>,
+				assigned-clock-rates = <19200000>,
 						       <19200000>,
 						       <19200000>;
 				operating-points-v2 = <&mdp_opp_table>;
-- 
2.7.4

