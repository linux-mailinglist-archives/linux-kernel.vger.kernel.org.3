Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBB4E3789
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiCVD3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiCVD26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:28:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ABCE6160;
        Mon, 21 Mar 2022 20:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647919652; x=1679455652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GBCchohdMxPmdCyHwZJ3vkgN2swoKj239vTmkcRZUrE=;
  b=l0zmM5YzDKztZSnXKjyiK4WCjAKU1qR3HJjrpFRPi+y/areLZRvu/a8f
   5/Z9sADnVO49GqGdsyDv0Yh5OmrGApeoV/o3QoAezq79/ruWOCYGvZyeN
   xtceGoYIdC2DNpql/nAMFAe0eyDvU6D92jAXbZoA2D8ozom8c3mYF7POU
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Mar 2022 20:27:31 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Mar 2022 20:27:30 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 22 Mar 2022 08:57:13 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 38BD85422; Tue, 22 Mar 2022 08:57:13 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, dianders@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v7 2/5] arm64: dts: qcom: sm7280: remove assigned-clock-rate property for mdp clk
Date:   Tue, 22 Mar 2022 08:57:08 +0530
Message-Id: <1647919631-14447-3-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647919631-14447-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1647919631-14447-1-git-send-email-quic_vpolimer@quicinc.com>
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

This patch is dependent on the patch ("drm/msm/disp/dpu1: set mdp clk
to the maximum frequency in opp table during probe") [1].

[1] https://lore.kernel.org/r/1647269217-14064-2-git-send-email-quic_vpolimer@quicinc.com/

Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index c07765d..a3c768c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3086,9 +3086,6 @@
 				      "ahb",
 				      "core";
 
-			assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
-			assigned-clock-rates = <300000000>;
-
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
@@ -3122,11 +3119,9 @@
 					      "lut",
 					      "core",
 					      "vsync";
-				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
-						<&dispcc DISP_CC_MDSS_VSYNC_CLK>,
+				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
 						<&dispcc DISP_CC_MDSS_AHB_CLK>;
-				assigned-clock-rates = <300000000>,
-							<19200000>,
+				assigned-clock-rates = <19200000>,
 							<19200000>;
 				operating-points-v2 = <&mdp_opp_table>;
 				power-domains = <&rpmhpd SC7280_CX>;
-- 
2.7.4

