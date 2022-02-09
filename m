Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4FC4AF8AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiBIRqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiBIRqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:46:08 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CEFC0613C9;
        Wed,  9 Feb 2022 09:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644428771; x=1675964771;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=RB573mLF4TwBecPUuBH+gJ5hpoDLGZ3AL75rF6UQ/ok=;
  b=uvgBTses4fAR5Kar7ArZZ+0EPrKXW1Mmm2TilvUj0vzEENiG15IVFLu0
   9njiU1CMgCyR9xYGKrrA1lHvm0itLuxbH218PwdHJ0GxZ5xie7J5WHZRg
   Ujof7btHGMTQTspf1031pbDsWSc9SMYiwGSDxOy6EHqO26vw0Whsuogk/
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 09 Feb 2022 09:46:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 09:46:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 09:46:10 -0800
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 09:46:06 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <dianders@chromium.org>,
        <mka@chromium.org>
CC:     <viresh.kumar@linaro.org>, <sboyd@kernel.org>, <agross@kernel.org>,
        <robh+dt@kernel.org>, <rjw@rjwysocki.net>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v4] arm64: dts: qcom: sc7280: Add cpu OPP tables
Date:   Wed, 9 Feb 2022 23:15:57 +0530
Message-ID: <1644428757-25575-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

Add OPP tables required to scale DDR/L3 per freq-domain on SC7280 SoCs.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

V4:
 * Round up frequency labels [Matthias]
 * Add DDR/L3 bandwidth votes for the pro variant of SC7280 SoC

V3:
 * Rename cpu opp table nodes [Matthias]
 * Rename opp phandles [Doug]

Depends on the following patch:
L3 Provider Node: https://patchwork.kernel.org/project/linux-arm-msm/patch/1634812857-10676-4-git-send-email-okukatla@codeaurora.org/

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 230 +++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index c6d26ea805d8..f0b64be63c21 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7280.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc7280.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -163,6 +164,9 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
@@ -183,6 +187,9 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
@@ -200,6 +207,9 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_200>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
@@ -217,6 +227,9 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_300>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
@@ -234,6 +247,9 @@
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_400>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
@@ -251,6 +267,9 @@
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_500>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
@@ -268,6 +287,9 @@
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_600>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
@@ -285,6 +307,9 @@
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_700>;
+			operating-points-v2 = <&cpu7_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
@@ -384,6 +409,211 @@
 		};
 	};
 
+	cpu0_opp_table: cpu0-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_opp_300mhz: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <800000 9600000>;
+		};
+
+		cpu0_opp_691mhz: opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-peak-kBps = <800000 17817600>;
+		};
+
+		cpu0_opp_806mhz: opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <800000 20889600>;
+		};
+
+		cpu0_opp_941mhz: opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <1804000 24576000>;
+		};
+
+		cpu0_opp_1152mhz: opp-1152000000 {
+			opp-hz = /bits/ 64 <1152000000>;
+			opp-peak-kBps = <2188000 27033600>;
+		};
+
+		cpu0_opp_1325mhz: opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <2188000 33792000>;
+		};
+
+		cpu0_opp_1517mhz: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <3072000 38092800>;
+		};
+
+		cpu0_opp_1651mhz: opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <3072000 41779200>;
+		};
+
+		cpu0_opp_1805mhz: opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <4068000 48537600>;
+		};
+
+		cpu0_opp_1958mhz: opp-1958400000 {
+			opp-hz = /bits/ 64 <1958400000>;
+			opp-peak-kBps = <4068000 48537600>;
+		};
+
+		cpu0_opp_2016mhz: opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-peak-kBps = <6220000 48537600>;
+		};
+	};
+
+	cpu4_opp_table: cpu4-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu4_opp_691mhz: opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-peak-kBps = <1804000 9600000>;
+		};
+
+		cpu4_opp_941mhz: opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <2188000 17817600>;
+		};
+
+		cpu4_opp_1229mhz: opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-peak-kBps = <4068000 24576000>;
+		};
+
+		cpu4_opp_1344mhz: opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-peak-kBps = <4068000 24576000>;
+		};
+
+		cpu4_opp_1517mhz: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <4068000 24576000>;
+		};
+
+		cpu4_opp_1651mhz: opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <6220000 38092800>;
+		};
+
+		cpu4_opp_1901mhz: opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-peak-kBps = <6220000 44851200>;
+		};
+
+		cpu4_opp_2054mhz: opp-2054400000 {
+			opp-hz = /bits/ 64 <2054400000>;
+			opp-peak-kBps = <6220000 44851200>;
+		};
+
+		cpu4_opp_2112mhz: opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <6220000 44851200>;
+		};
+
+		cpu4_opp_2131mhz: opp-2131200000 {
+			opp-hz = /bits/ 64 <2131200000>;
+			opp-peak-kBps = <6220000 44851200>;
+		};
+
+		cpu4_opp_2208mhz: opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-peak-kBps = <6220000 44851200>;
+		};
+
+		cpu4_opp_2400mhz: opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-peak-kBps = <8532000 48537600>;
+		};
+
+		cpu4_opp_2611mhz: opp-2611200000 {
+			opp-hz = /bits/ 64 <2611200000>;
+			opp-peak-kBps = <8532000 48537600>;
+		};
+	};
+
+	cpu7_opp_table: cpu7-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu7_opp_806mhz: opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <1804000 9600000>;
+		};
+
+		cpu7_opp_1056mhz: opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-peak-kBps = <2188000 17817600>;
+		};
+
+		cpu7_opp_1325mhz: opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <4068000 24576000>;
+		};
+
+		cpu7_opp_1517mhz: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <4068000 24576000>;
+		};
+
+		cpu7_opp_1766mhz: opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+			opp-peak-kBps = <6220000 38092800>;
+		};
+
+		cpu7_opp_1862mhz: opp-1862400000 {
+			opp-hz = /bits/ 64 <1862400000>;
+			opp-peak-kBps = <6220000 38092800>;
+		};
+
+		cpu7_opp_2035mhz: opp-2035200000 {
+			opp-hz = /bits/ 64 <2035200000>;
+			opp-peak-kBps = <6220000 38092800>;
+		};
+
+		cpu7_opp_2112mhz: opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <6220000 44851200>;
+		};
+
+		cpu7_opp_2208mhz: opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-peak-kBps = <6220000 44851200>;
+		};
+
+		cpu7_opp_2381mhz: opp-2380800000 {
+			opp-hz = /bits/ 64 <2380800000>;
+			opp-peak-kBps = <6832000 44851200>;
+		};
+
+		cpu7_opp_2400mhz: opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-peak-kBps = <8532000 48537600>;
+		};
+
+		cpu7_opp_2515mhz: opp-2515200000 {
+			opp-hz = /bits/ 64 <2515200000>;
+			opp-peak-kBps = <8532000 48537600>;
+		};
+
+		cpu7_opp_2707mhz: opp-2707200000 {
+			opp-hz = /bits/ 64 <2707200000>;
+			opp-peak-kBps = <8532000 48537600>;
+		};
+
+		cpu7_opp_3014mhz: opp-3014400000 {
+			opp-hz = /bits/ 64 <3014400000>;
+			opp-peak-kBps = <8532000 48537600>;
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
-- 
2.7.4

