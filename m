Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E5A4613F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhK2Lhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:37:35 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:1635 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234645AbhK2Lfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638185533; x=1669721533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dYuNhYv5xUm7KBwMfzXqITa0sDuY/NmYNE9BaX9YTm0=;
  b=wk5SeXd97QZy27+rfIdBwIFz1VCWH7V27knLfNgwdidArYYAtvv39EJN
   mmDMqevfKUkOiNADdcU2okWPtF0p+A1nKpwQrPM8U1jQZY53bbCpj1ago
   PYYgaFWV2t7haC1A59HVzk1V4DI57jmK1BQ+1EUQK91nFNGARAbAr+qdJ
   E=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Nov 2021 03:32:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:32:12 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 03:32:12 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 03:32:09 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, <kgodara@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 1/4] dt-bindings: arm: qcom: Document qcom,sc7280-crd board
Date:   Mon, 29 Nov 2021 17:01:34 +0530
Message-ID: <1638185497-26477-2-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638185497-26477-1-git-send-email-quic_rjendra@quicinc.com>
References: <1638185497-26477-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the qcom,sc7280-crd board based off sc7280 SoC,
The board is also known as hoglin in the Chrome OS builds,
so document the google,hoglin compatible as well.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index c8808e0..91937ab 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -203,6 +203,8 @@ properties:
           - enum:
               - qcom,sc7280-idp
               - qcom,sc7280-idp2
+              - qcom,sc7280-crd
+              - google,hoglin
               - google,piglin
               - google,senor
           - const: qcom,sc7280
-- 
2.7.4

