Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA46465ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354499AbhLBA0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:26:09 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:63479 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354337AbhLBAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638404520; x=1669940520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hoO0q3ATVpGGZ1434HlNAZKnycCcIbY6l6L181yYYRU=;
  b=duneY5dgcv1XPOSsMPBnSl8A4QNejiFR6Yshj/PwG9CuI2GIzFSuBfHv
   GAxEjs8nR9qVowLMh0O26WzMVhO5y6cVay3qhH+mEj0XuWoKAwKFbZzZx
   Wu49ZZDJeDGMryJHhQKUJXCO8LNUj/9BnmvGID0ZR1nGI6tC5UyFGXTZ/
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Dec 2021 16:21:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:21:59 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:21:59 -0800
Received: from hu-vamslank-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:21:58 -0800
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        Vamsi krishna Lanka <quic_vamslank@quicinc.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 4/5] dt-bindings: clock: Introduce RPMHCC bindings for SDX65
Date:   Wed, 1 Dec 2021 16:21:34 -0800
Message-ID: <91c10dde568098027833dfcc310748a92a90387e.1638402361.git.quic_vamslank@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638402361.git.quic_vamslank@quicinc.com>
References: <cover.1638402361.git.quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi krishna Lanka <quic_vamslank@quicinc.com>

Add compatible for SDX65 RPMHCC.

Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 72212970e6f5..0e7e05e38bb2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -22,6 +22,7 @@ properties:
       - qcom,sc8180x-rpmh-clk
       - qcom,sdm845-rpmh-clk
       - qcom,sdx55-rpmh-clk
+      - qcom,sdx65-rpmh-clk
       - qcom,sm6350-rpmh-clk
       - qcom,sm8150-rpmh-clk
       - qcom,sm8250-rpmh-clk
-- 
2.33.1

