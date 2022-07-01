Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12E856372A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiGAPr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGAPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:47:26 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA192E6AB;
        Fri,  1 Jul 2022 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656690445; x=1688226445;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=xlf5iwkm5ZIVRbPserQ1tG3Brk4bpulzIeQVMIFm3W0=;
  b=g/wo+PyDWoNKPgcpZM+i4cSruhbfSPWaYrICEvfgVjAnJWrf8+haBwok
   UIdqanL5nWisdbLrX7adWIxyve8setVzSAPZDDj6APnSJsVlAz13oL0ch
   ra2z99d4ACLINqcDn8ZDNWQzhIdKwzHvEm8q7NniAA8sPOUOLJaxqzJSr
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Jul 2022 08:47:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 08:47:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Jul 2022 08:47:24 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Jul 2022 08:47:24 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_khsieh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <quic_mkrishn@quicinc.com>, <quic_kalyant@quicinc.coml>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dta: qcom: sc7180: delete vdda-1p2 and vdda-0p9 from mdss_dp
Date:   Fri, 1 Jul 2022 08:47:16 -0700
Message-ID: <1656690436-15221-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

Both vdda-1p2-supply and vdda-0p9-supply regulators are controlled
by dp combo phy. Therefore remove them from dp controller.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 732e118..824a98c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -813,8 +813,6 @@ hp_i2c: &i2c9 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hot_plug_det>;
 	data-lanes = <0 1>;
-	vdda-1p2-supply = <&vdda_usb_ss_dp_1p2>;
-	vdda-0p9-supply = <&vdda_usb_ss_dp_core>;
 };
 
 &pm6150_adc {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

