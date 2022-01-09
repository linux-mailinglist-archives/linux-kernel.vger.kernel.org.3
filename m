Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66590488B15
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiAIRZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:25:41 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:35695 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236240AbiAIRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641749136; x=1673285136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=EnvrPKOuIQtpl1//N+EaanVpAc+IpA/a8qi/+Aj4z2M=;
  b=CTc3xgH/VIa7jL+fURGwdu0VB+9BOhZKb5LNScrAMGwEULiM6pM3Yo23
   Z59jf4e2M7iEQOP4vJUQN4oFPEmBAryWZo9On00WcVT4DoBzPb4XTHwJO
   ZEjnkqr6xmSEbe+tLMgshmpqYlnHwuNfTRM1fbMJJ2vWRwZct+ld1necF
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Jan 2022 09:25:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 09:25:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:35 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:32 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 04/10] arm64: dts: qcom: sm8450: Update cpuidle states parameters
Date:   Sun, 9 Jan 2022 22:55:01 +0530
Message-ID: <1641749107-31979-5-git-send-email-quic_mkshah@quicinc.com>
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

This change updates/corrects below cpuidle parameters

1. entry-latency, exit-latency and residency for various idle states.
2. arm,psci-suspend-param which is same for CLUSTER_SLEEP_0/1 states.
3. Add CLUSTER_SLEEP_1 in CLUSTER_PD.

Cc: devicetree@vger.kernel.org
Fixes: 5188049c9b36 ("arm64: dts: qcom: Add base SM8450 DTSI")
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 10c25ad..5e329f8 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -203,9 +203,9 @@
 				compatible = "arm,idle-state";
 				idle-state-name = "silver-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <274>;
-				exit-latency-us = <480>;
-				min-residency-us = <3934>;
+				entry-latency-us = <800>;
+				exit-latency-us = <750>;
+				min-residency-us = <4090>;
 				local-timer-stop;
 			};
 
@@ -213,9 +213,9 @@
 				compatible = "arm,idle-state";
 				idle-state-name = "gold-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <327>;
-				exit-latency-us = <1502>;
-				min-residency-us = <4488>;
+				entry-latency-us = <600>;
+				exit-latency-us = <1550>;
+				min-residency-us = <4791>;
 				local-timer-stop;
 			};
 		};
@@ -224,10 +224,10 @@
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
 				compatible = "domain-idle-state";
 				idle-state-name = "cluster-l3-off";
-				arm,psci-suspend-param = <0x4100c344>;
-				entry-latency-us = <584>;
-				exit-latency-us = <2332>;
-				min-residency-us = <6118>;
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <1050>;
+				exit-latency-us = <2500>;
+				min-residency-us = <5309>;
 				local-timer-stop;
 			};
 
@@ -235,9 +235,9 @@
 				compatible = "domain-idle-state";
 				idle-state-name = "cluster-power-collapse";
 				arm,psci-suspend-param = <0x4100c344>;
-				entry-latency-us = <2893>;
-				exit-latency-us = <4023>;
-				min-residency-us = <9987>;
+				entry-latency-us = <2700>;
+				exit-latency-us = <3500>;
+				min-residency-us = <13959>;
 				local-timer-stop;
 			};
 		};
@@ -315,7 +315,7 @@
 
 		CLUSTER_PD: cpu-cluster0 {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_SLEEP_0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_1>;
 		};
 	};
 
-- 
2.7.4

