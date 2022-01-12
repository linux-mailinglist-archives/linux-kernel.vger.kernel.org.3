Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6278B48CC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350303AbiALTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:50:55 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33170 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346225AbiALTuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:50:44 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A0736CDFEB;
        Wed, 12 Jan 2022 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016559; bh=plUllEBFH+UzM4kO/iTn2e3iL36IRQmST7f4iMeVofw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gDtHX/DmBt2V/0bqAvMGHjpJUcd7w2D6tr6o1g78WKZYIvKp6uFWS6CJwG5Zbm1be
         pRLxvisYL8Xz9lnKXYEG9CurC0lFCoyej8puMhQk99x9dTzAJ18Oa+Vrfy0dujjM7M
         4i4J6601O9lSCLAi5HwKfLk+/24kDREy9vtBeAMc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] arm64: dts: qcom: Add SDM632 device tree
Date:   Wed, 12 Jan 2022 20:41:01 +0100
Message-Id: <20220112194118.178026-13-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Snapdragon 632 is based on msm8953, add the devicee tree for that.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/sdm632.dtsi | 125 +++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm632.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm632.dtsi b/arch/arm64/boot/dts/qcom/sdm632.dtsi
new file mode 100644
index 000000000000..b80ba8a5ef3f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm632.dtsi
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
+
+#include "msm8953.dtsi"
+
+/ {
+	thermal-zones {
+		/delete-node/cpu0-thermal;
+		/delete-node/cpu1-thermal;
+		/delete-node/cpu2-thermal;
+		/delete-node/cpu3-thermal;
+		/delete-node/cpu4-thermal;
+		/delete-node/cpu5-thermal;
+		/delete-node/cpu6-thermal;
+		/delete-node/cpu7-thermal;
+		cpu4-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens0 5>;
+			trips {
+				cpu4_alert: trip-point0 {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu4_crit: crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_alert>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+		cpu5-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens0 6>;
+			trips {
+				cpu5_alert: trip-point0 {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu5_crit: crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu5_alert>;
+					cooling-device = <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+		cpu6-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens0 7>;
+			trips {
+				cpu6_alert: trip-point0 {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu6_crit: crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu6_alert>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+		cpu7-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens0 8>;
+			trips {
+				cpu7_alert: trip-point0 {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu7_crit: crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu7_alert>;
+					cooling-device = <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+};
+
+&CPU4 {
+	capacity-dmips-mhz = <1980>;
+};
+
+&CPU5 {
+	capacity-dmips-mhz = <1980>;
+};
+
+&CPU6 {
+	capacity-dmips-mhz = <1980>;
+};
+
+&CPU7 {
+	capacity-dmips-mhz = <1980>;
+};
-- 
2.34.1

