Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FFE4885E1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiAHU1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:27:24 -0500
Received: from ixit.cz ([94.230.151.217]:51310 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbiAHU1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:27:23 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 1138C2243C;
        Sat,  8 Jan 2022 21:27:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1641673641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fjH0yJpQnOWvRENavKziHpYbwtIbfjzj2UkigOV66yM=;
        b=SLus/xCvAuLCo07W8eOuNnAktQXQCA/G80Clb9f6fkETZKOYPP/gzveuBneMEWXZW0yUeK
        Gc/iXSowBRXnMGY6COL0B4PTi/Ozp17iwwtMw19qMFsY2s61l4ul6ZOb4nRQWu/fAwsiP6
        0WWAL+mtk8hmln9hDAEloqgBaHmykzg=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: fill missing power-domain-cells for gcc controllers
Date:   Sat,  8 Jan 2022 21:27:18 +0100
Message-Id: <20220108202719.82424-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing #power-domain-cells to the clock controllers.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
deprecates patch:
ARM: dts: apq8064: fill missing power-domain-cells for clock controllers
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 ++
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 1 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 1 +
 arch/arm/boot/dts/qcom-msm8660.dtsi | 1 +
 arch/arm/boot/dts/qcom-msm8960.dtsi | 2 ++
 5 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 7c105c0044ca..8d7ae3b41b3a 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -846,6 +846,7 @@ gcc: clock-controller@900000 {
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
 			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 			#thermal-sensor-cells = <1>;
 		};
@@ -861,6 +862,7 @@ mmcc: clock-controller@4000000 {
 			compatible = "qcom,mmcc-apq8064";
 			reg = <0x4000000 0x1000>;
 			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 7dec0553636e..000720c51a87 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -186,6 +186,7 @@ intc: interrupt-controller@b000000 {
 		gcc: clock-controller@1800000 {
 			compatible = "qcom,gcc-ipq4019";
 			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 			reg = <0x1800000 0x60000>;
 		};
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 13e0f6f1c376..55653a0e9cb4 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -138,6 +138,7 @@ msmgpio: pinctrl@800000 {
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-mdm9615";
 			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 			reg = <0x900000 0x4000>;
 		};
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index f144f76b4558..45d944fdaa87 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -125,6 +125,7 @@ tlmm: pinctrl@800000 {
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-msm8660";
 			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 			reg = <0x900000 0x4000>;
 		};
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 7e566f41f7ec..e008b6df108f 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -126,6 +126,7 @@ msmgpio: pinctrl@800000 {
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-msm8960";
 			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 			reg = <0x900000 0x4000>;
 		};
@@ -141,6 +142,7 @@ clock-controller@4000000 {
 			compatible = "qcom,mmcc-msm8960";
 			reg = <0x4000000 0x1000>;
 			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 		};
 
-- 
2.34.1

