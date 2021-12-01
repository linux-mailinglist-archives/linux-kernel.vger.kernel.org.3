Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCDB464B57
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbhLAKPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:15:31 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:19115 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237392AbhLAKPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638353530; x=1669889530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ISvQMr4NHEgaLOoAiiXqNRRFalK9tyLvCnJGqtS7NIY=;
  b=cJWUFoJAedsjq+RxSw5B7xhgKNlpEdEsGYLtPKdjUwKvYzFAq4NxBQhG
   WHmKnQbizXE7IUHwjFCUZT4vjUXziAT//+hwX96fEkMMxeIdPJNmvtZni
   Mb/eAGcP8DliHygRIv/MaPPSBGNodDdajFdsen1yHIeSCSHLkiHnL9ir8
   A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Dec 2021 02:12:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 02:12:09 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 02:12:08 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 02:12:04 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, <kgodara@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v3 1/4] dt-bindings: arm: qcom: Document qcom,sc7280-crd board
Date:   Wed, 1 Dec 2021 15:41:39 +0530
Message-ID: <1638353502-23640-2-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638353502-23640-1-git-send-email-quic_rjendra@quicinc.com>
References: <1638353502-23640-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the qcom,sc7280-crd board based off sc7280 SoC,
The board is also known as hoglin in the Chrome OS builds,
so document the google,hoglin compatible as well.
While at it, sort the compatibles in alphabetical order.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index c8808e0..73ff06f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -201,10 +201,12 @@ properties:
 
       - items:
           - enum:
-              - qcom,sc7280-idp
-              - qcom,sc7280-idp2
+              - google,hoglin
               - google,piglin
               - google,senor
+              - qcom,sc7280-crd
+              - qcom,sc7280-idp
+              - qcom,sc7280-idp2
           - const: qcom,sc7280
 
       - items:
-- 
2.7.4

