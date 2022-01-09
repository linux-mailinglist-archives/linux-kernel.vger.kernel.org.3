Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC6D488B17
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiAIRZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:25:43 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:35695 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236239AbiAIRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641749140; x=1673285140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Z4eKqQYGl0kH1DNF1rBzvVSnii5PAAf39Ji9ab0afkk=;
  b=O0rTM8sauLtwdskBxFFa7cFP9BUj+oO0eu622WDXB+JTbDAktFlWK6Rx
   XFVSkPPCNtCGyf2nzAx+75BN/RCiF2yvRMqxM8HUDh8WkxbSCieF6VM5Z
   LOgGKsisdBRx1E677WjQdSxfGm5W6CF23QlEJSo8Kql3CTJ514hMPHGwP
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Jan 2022 09:25:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 09:25:39 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:39 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:35 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 05/10] dt-bindings: soc: qcom: Update devicetree binding document for rpmh-rsc
Date:   Sun, 9 Jan 2022 22:55:02 +0530
Message-ID: <1641749107-31979-6-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change documents power-domains property for RSC device.
This optional property points to corresponding PM domain node.

Cc: devicetree@vger.kernel.org
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
index 9b86d1e..85b9859 100644
--- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
@@ -78,6 +78,11 @@ Properties:
 	            CONTROL_TCS
 	- Cell #2 (Number of TCS): <u32>
 
+- power-domains:
+	Usage: optional
+	Value type: <prop-encoded-power-domains>
+	Definition: Phandle pointing to the corresponding PM domain node.
+
 - label:
 	Usage: optional
 	Value type: <string>
@@ -112,6 +117,7 @@ TCS-OFFSET: 0xD00
 				  <SLEEP_TCS   3>,
 				  <WAKE_TCS    3>,
 				  <CONTROL_TCS 1>;
+		power-domains = <&CLUSTER_PD>;
 	};
 
 Example 2:
-- 
2.7.4

