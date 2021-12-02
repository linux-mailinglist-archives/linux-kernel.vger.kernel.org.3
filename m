Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB45465AC3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354372AbhLBA1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:27:14 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:50968 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354323AbhLBA1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638404627; x=1669940627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rVKxxW8escAWGjDvZ3PQTQoufKQ+9WSZXrY7pPexULU=;
  b=UCcEhv09H9SiTAKxAywER9XOXKnBWUGel6CtEUcyTXqkl4i3eQFUl46N
   DpZkmCihH20nprVk3EAUC/AuZNMn+qlAnWaxiEPKALX7OCfImWtV1V91t
   BbPE/ulmp1pRXyYZNUPZ905fbtJHn5i2e9+fF5GoG96dvGVsx0HkyfwaQ
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 16:23:47 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:23:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:23:46 -0800
Received: from hu-vamslank-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:23:46 -0800
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <maz@kernel.org>, <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 1/1] dt-bindings: qcom,pdc: Add compatible for SDX65
Date:   Wed, 1 Dec 2021 16:23:30 -0800
Message-ID: <6cef8213e25582fd1f0ea5bf82661d726bf8830b.1638403797.git.quic_vamslank@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638403797.git.quic_vamslank@quicinc.com>
References: <cover.1638403797.git.quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>

Add compatible for SDX65 pdc.

Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.txt        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
index 98d89e53013d..ce631d853db4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -23,6 +23,7 @@ Properties:
 		    - "qcom,sdm845-pdc": For SDM845
 		    - "qcom,sdm8250-pdc": For SM8250
 		    - "qcom,sdm8350-pdc": For SM8350
+		    - "qcom,sdx65-pdc": For SDX65
 
 - reg:
 	Usage: required
-- 
2.33.1

