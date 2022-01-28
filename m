Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A794549F4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347110AbiA1Hs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:48:28 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:20172 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347167AbiA1HsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643356094; x=1674892094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XEcjv+OGAo7k7gKx7fvL1f71mMDMDfNViF6jjZZupQw=;
  b=r679qygAQ+WDP0HtnYOF8OlyTi7dRhHe9NmqUSEwNoS0Vvvu7x5H1cyc
   0EccCdDCzNveFpsX36fBOBxzL8CQ+HBNSfygj5jO5soG2FEEyp32ZndyF
   K46VFMmWEVTVsvmS9TEfc6dDbRRgGjRrALNLhX44Zz1HsO1v5yemMr6Yi
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Jan 2022 23:48:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:48:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:48:12 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:48:08 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasad <quic_psodagud@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCHv2 7/9] dt-bindings: arm: msm: Add LLCC compatible for SM8350
Date:   Fri, 28 Jan 2022 13:17:14 +0530
Message-ID: <e3d200eb06949f7e216b7f82f5811b7addb7fdc8.1643355594.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1643355594.git.quic_saipraka@quicinc.com>
References: <cover.1643355594.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC compatible for SM8350 SoC.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 03882aac8d2d..c1eded3a3257 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -27,6 +27,7 @@ properties:
       - qcom,sm6350-llcc
       - qcom,sm8150-llcc
       - qcom,sm8250-llcc
+      - qcom,sm8350-llcc
 
   reg:
     items:
-- 
2.33.1

