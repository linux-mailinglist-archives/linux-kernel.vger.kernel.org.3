Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AE474378
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhLNN2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:28:03 -0500
Received: from ixit.cz ([94.230.151.217]:50230 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232253AbhLNN2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:28:00 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 09F6A24AF0;
        Tue, 14 Dec 2021 14:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639488477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bv9IMdk7PirNLUGfvz44l53MYOu+yMfaHuir8Nj0crw=;
        b=tq6vc/DlnhqweQukweehbE68N8VmWn1McPvEbICZ2Xj/5VcoRxvxu0FFgNtMzPZ2GHKzxg
        YMZ2Qx7U4xKqXAaH0j5S62nhI1MfQTPiG9nq316vnVs0oupx0gC097Pjnx953UfcllpX02
        opvOAbanFHv6g7znMHxfmNP/017AGJU=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: fix thermal zones naming
Date:   Tue, 14 Dec 2021 14:27:49 +0100
Message-Id: <20211214132750.69782-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename thermal zones according to dt-schema.
Fixes multiple `make dtbs_check` warnings about name convetion.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi |  4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi |  4 ++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi  |  4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi  |  4 ++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi  |  4 ++--
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 16 ++++++++--------
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 01643a1f574d..7eff331572f2 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3273,7 +3273,7 @@ cpu3_crit: cpu_crit {
 			};
 		};
 
-		gpu-thermal-top {
+		gpu-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -3295,7 +3295,7 @@ map0 {
 			};
 		};
 
-		gpu-thermal-bottom {
+		gpu-bottom-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f273bc1ff629..453a049f693d 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -674,7 +674,7 @@ cpu7_crit: cpu_crit {
 			};
 		};
 
-		gpu-thermal-bottom {
+		gpu-bottom-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -689,7 +689,7 @@ gpu1_alert0: trip-point0 {
 			};
 		};
 
-		gpu-thermal-top {
+		gpu-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5d1d38eb1dfb..5fac82f026fd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5258,7 +5258,7 @@ cluster1_crit: cluster1_crit {
 			};
 		};
 
-		gpu-thermal-top {
+		gpu-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -5273,7 +5273,7 @@ gpu1_alert0: trip-point0 {
 			};
 		};
 
-		gpu-thermal-bottom {
+		gpu-bottom-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 6012322a5984..c1067b31b299 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4265,7 +4265,7 @@ cluster1_crit: cluster1_crit {
 			};
 		};
 
-		gpu-thermal-top {
+		gpu-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -4445,7 +4445,7 @@ modem_scl_alert0: trip-point0 {
 			};
 		};
 
-		gpu-thermal-bottom {
+		gpu-bottom-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 2272efd1506b..93570a61c2af 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -5172,7 +5172,7 @@ cluster1_crit: cluster1_crit {
 			};
 		};
 
-		gpu-thermal-top {
+		gpu-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -5307,7 +5307,7 @@ npu_alert0: trip-point0 {
 			};
 		};
 
-		gpu-thermal-bottom {
+		gpu-bottom-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 7323ed74f41a..eb5c5bd9909c 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2991,7 +2991,7 @@ aoss1_alert0: trip-point0 {
 			};
 		};
 
-		gpu-thermal-top {
+		gpu-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -3006,7 +3006,7 @@ gpu1_alert0: trip-point0 {
 			};
 		};
 
-		gpu-thermal-bottom {
+		gpu-bottom-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -3096,7 +3096,7 @@ mem_alert0: trip-point0 {
 			};
 		};
 
-		modem1-thermal-top {
+		modem1-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -3111,7 +3111,7 @@ modem1_alert0: trip-point0 {
 			};
 		};
 
-		modem2-thermal-top {
+		modem2-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -3126,7 +3126,7 @@ modem2_alert0: trip-point0 {
 			};
 		};
 
-		modem3-thermal-top {
+		modem3-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -3141,7 +3141,7 @@ modem3_alert0: trip-point0 {
 			};
 		};
 
-		modem4-thermal-top {
+		modem4-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -3156,7 +3156,7 @@ modem4_alert0: trip-point0 {
 			};
 		};
 
-		camera-thermal-top {
+		camera-top-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -3171,7 +3171,7 @@ camera1_alert0: trip-point0 {
 			};
 		};
 
-		cam-thermal-bottom {
+		cam-bottom-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-- 
2.33.0

