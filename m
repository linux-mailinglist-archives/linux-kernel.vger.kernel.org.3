Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270DC529758
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiEQCYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiEQCYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:24:04 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B9E53D1FC;
        Mon, 16 May 2022 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lTBhx
        p2EfVojczwDke4E/Onuf36SXf/m+vxj1MMdS2Y=; b=K6NlZ9QpriWOehObiwcCW
        pE3iFoBEuRVoIUNkpmAnABQTWS8xwo6jXXfDwuQ5jbHAhPGifkxC5uTlGvPQuGiy
        kUsAAnQ9eT0171ARPVgOufstlCt9tFJLy0bZgjlR45aNrDd9IDvSeFkNoFonE878
        KrJ3CCaBcKTwmrhIejxA8A=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.20])
        by smtp9 (Coremail) with SMTP id DcCowAB3USwR_IJiF3ohDQ--.61255S4;
        Tue, 17 May 2022 09:36:19 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v5 2/3] ARM: dts: sun8i-r40: add opp table for cpu
Date:   Tue, 17 May 2022 09:36:06 +0800
Message-Id: <20220517013607.2252-3-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517013607.2252-1-qianfanguijin@163.com>
References: <20220517013607.2252-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAB3USwR_IJiF3ohDQ--.61255S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrWxXF1UKw4xur17Xry5urg_yoWrZFy8pw
        17Zr4kGrs7Wr1Yq342gry8KF18uFWv9F4Yyry5C348Jrn7X34DJr97tr9akrWDXr43X3yI
        9Fs5Xr9rtw1DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ubo7tUUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiQhQE7VaECXNrTAAAsw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

OPP table value is get from allwinner lichee linux-3.10 kernel driver

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  1 +
 arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi      | 52 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-r40-feta40i.dtsi      |  1 +
 arch/arm/boot/dts/sun8i-r40.dtsi              |  8 +++
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts      |  1 +
 .../boot/dts/sun8i-v40-bananapi-m2-berry.dts  |  1 +
 6 files changed, 64 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 4f30018ec4a2..28197bbcb1d5 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -43,6 +43,7 @@
 
 /dts-v1/;
 #include "sun8i-r40.dtsi"
+#include "sun8i-r40-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
diff --git a/arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi b/arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi
new file mode 100644
index 000000000000..4faa22d3bac8
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi
@@ -0,0 +1,52 @@
+/{
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1000000 1000000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1100000 1100000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1160000 1160000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <1240000 1240000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1300000 1300000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
diff --git a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
index b872b51a346d..9f39b5a2bb35 100644
--- a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
@@ -5,6 +5,7 @@
 //  Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
 
 #include "sun8i-r40.dtsi"
+#include "sun8i-r40-cpu-opp.dtsi"
 
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 291f4784e86c..ae2a5ebd9924 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -84,24 +84,32 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
 		};
 
 		cpu1: cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
 		};
 
 		cpu2: cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
 		};
 
 		cpu3: cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
index 0eb1990742ff..9f472521f4a4 100644
--- a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
+++ b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
@@ -45,6 +45,7 @@
 
 /dts-v1/;
 #include "sun8i-r40.dtsi"
+#include "sun8i-r40-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index fdf8bd12faaa..434871040aca 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -42,6 +42,7 @@
 
 /dts-v1/;
 #include "sun8i-r40.dtsi"
+#include "sun8i-r40-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
-- 
2.25.1

