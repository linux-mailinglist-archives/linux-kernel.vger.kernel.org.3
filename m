Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F86C51F6BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 10:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiEIIOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiEIIAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:00:44 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B2D35A88;
        Mon,  9 May 2022 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652083006; x=1683619006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=eFMuIn13ITRB11gFrh16kf8Q4cWqkvYYuaQJOeYnmHU=;
  b=GJCJkGMr1QtLX/7sdqmiGRc6yipZpc+fGsZms3+z1yE7jyflp4MElCe3
   nA3hh8+8xHY9l+n3Y1w9h60KGh8iiRGDTnfq9BuIYcww9cy2F9gtc+Nwi
   eX/P7d8Fp7xZHR//BWGRJKFFRcqWX2wxaejSSY/64u+5laoEXGpW2V/Bp
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 May 2022 00:53:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 00:53:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 00:53:42 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 00:53:38 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>
CC:     <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <evgreen@chromium.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>, <mka@chromium.org>,
        <krzysztof.kozlowski@canonical.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Add proxy interconnect requirements for modem
Date:   Mon, 9 May 2022 13:23:18 +0530
Message-ID: <1652082798-5855-3-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652082798-5855-1-git-send-email-quic_sibis@quicinc.com>
References: <1652082798-5855-1-git-send-email-quic_sibis@quicinc.com>
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

Add interconnects that are required to be proxy voted upon during modem
bootup on SC7280 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
 * Drop incorrect interconnect names [Bjorn]

 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index 9f4a9c263c35..91aad86cc708 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -88,6 +88,7 @@
 	status = "okay";
 	compatible = "qcom,sc7280-mss-pil";
 	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
+	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
 	memory-region = <&mba_mem>, <&mpss_mem>;
 };
 
-- 
2.7.4

