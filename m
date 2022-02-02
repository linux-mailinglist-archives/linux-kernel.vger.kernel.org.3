Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8634C4A75FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbiBBQff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:35:35 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:38165 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229538AbiBBQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643819732; x=1675355732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+XdSwTNXNebBP83WxMz8IMaWok0C1fCrRVOJWgzxIWw=;
  b=zohYXticJHaPeieIS6PA4IeWSik5y+TFcGZQ+mjpKF8PtU8c2ytpLKAa
   LfGbIUi22ImLQ8erUsELN3HaU49axGsSWg8pSe86aOSQXX/hQ4t3PfAn1
   y4VwxelKDBdmEdAHYlrJakRJP5/KD2oqTkIkWCQwOBsMXJx1gm5ZkVn7U
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Feb 2022 08:35:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 08:35:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 2 Feb 2022 08:35:31 -0800
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 2 Feb 2022 08:35:28 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 1/2] arm64: dts: qcom: ipq8074: drop the clock-frequency property
Date:   Wed, 2 Feb 2022 22:05:08 +0530
Message-ID: <1643819709-5410-2-git-send-email-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643819709-5410-1-git-send-email-quic_kathirav@quicinc.com>
References: <1643819709-5410-1-git-send-email-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the clock-frequency property from the MMIO timer node, since it
is already configured by the bootloader.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 26ba7ce9222c..a0ff4de8ea75 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -647,7 +647,6 @@
 			ranges;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0b120000 0x1000>;
-			clock-frequency = <19200000>;
 
 			frame@b120000 {
 				frame-number = <0>;
-- 
2.7.4

