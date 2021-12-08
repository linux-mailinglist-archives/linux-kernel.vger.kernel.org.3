Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1888146DB80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhLHSux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:50:53 -0500
Received: from ixit.cz ([94.230.151.217]:33394 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhLHSuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:50:52 -0500
Received: from localhost.localdomain (unknown [213.151.89.154])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 5A52E21F5E;
        Wed,  8 Dec 2021 19:47:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1638989238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hwrzPLL5SzauVvYQ1kSBw48oMc8sX9Kq7XOHEcZhJFo=;
        b=z50Sp5oTCAEZUkvsprVfcG5lwSXWsiMGTBEyVoPNZgoS/qOJfVdt4eTEGkHhqSNYSdAgy4
        b79wM4pKJ0g+b9qKeghs7O6d/d4yTGvPuGIVM8XbaWeb15ulV/AmKmBeHmMyEwY6P8fO/I
        gMTgujoznods0ZRTlQrjD4c4e8yu6yU=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: qcom: dts: drop legacy property #stream-id-cells
Date:   Wed,  8 Dec 2021 19:47:06 +0100
Message-Id: <20211208184707.100716-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property #stream-id-cells is legacy leftover and isn't currently
documented nor used.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - split qcom and xilinx
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 1 -
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 1 -
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 1 -
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 1 -
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 1 -
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 1 -
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 1 -
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 1 -
 8 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 1ac78d9909ab..91bc974aeb0a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -962,7 +962,6 @@ hdmi_phy: hdmi-phy@9a0600 {
 
 		gpu: gpu@b00000 {
 			compatible = "qcom,adreno-530.2", "qcom,adreno";
-			#stream-id-cells = <16>;
 
 			reg = <0x00b00000 0x3f000>;
 			reg-names = "kgsl_3d0_reg_memory";
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 408f265e277b..f273bc1ff629 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1446,7 +1446,6 @@ adreno_gpu: gpu@5000000 {
 			iommus = <&adreno_smmu 0>;
 			operating-points-v2 = <&gpu_opp_table>;
 			power-domains = <&rpmpd MSM8998_VDDMX>;
-			#stream-id-cells = <16>;
 			status = "disabled";
 
 			gpu_opp_table: opp-table {
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index faf8b807d0ff..2151cd8c8c7a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1952,7 +1952,6 @@ glink-edge {
 
 		gpu: gpu@5000000 {
 			compatible = "qcom,adreno-618.0", "qcom,adreno";
-			#stream-id-cells = <16>;
 			reg = <0 0x05000000 0 0x40000>, <0 0x0509e000 0 0x1000>,
 				<0 0x05061000 0 0x800>;
 			reg-names = "kgsl_3d0_reg_memory", "cx_mem", "cx_dbgc";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 40b409f279f5..937c2e0e93eb 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1753,7 +1753,6 @@ lpass_ag_noc: interconnect@3c40000 {
 
 		gpu: gpu@3d00000 {
 			compatible = "qcom,adreno-635.0", "qcom,adreno";
-			#stream-id-cells = <16>;
 			reg = <0 0x03d00000 0 0x40000>,
 			      <0 0x03d9e000 0 0x1000>,
 			      <0 0x03d61000 0 0x800>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index b75bb87ed290..9217c3a51f79 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1019,7 +1019,6 @@ sd-cd {
 
 		adreno_gpu: gpu@5000000 {
 			compatible = "qcom,adreno-508.0", "qcom,adreno";
-			#stream-id-cells = <16>;
 
 			reg = <0x05000000 0x40000>;
 			reg-names = "kgsl_3d0_reg_memory";
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 526087586ba4..ff344a9a81a6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4415,7 +4415,6 @@ dsi1_phy: dsi-phy@ae96400 {
 
 		gpu: gpu@5000000 {
 			compatible = "qcom,adreno-630.2", "qcom,adreno";
-			#stream-id-cells = <16>;
 
 			reg = <0 0x5000000 0 0x40000>, <0 0x509e000 0 0x10>;
 			reg-names = "kgsl_3d0_reg_memory", "cx_mem";
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 81b4ff2cc4cd..6012322a5984 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1785,7 +1785,6 @@ gpu: gpu@2c00000 {
 			compatible = "qcom,adreno-640.1",
 				     "qcom,adreno",
 				     "amd,imageon";
-			#stream-id-cells = <16>;
 
 			reg = <0 0x02c00000 0 0x40000>;
 			reg-names = "kgsl_3d0_reg_memory";
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 40f18d539d80..5617a46e5ccd 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2399,7 +2399,6 @@ data2 {
 		gpu: gpu@3d00000 {
 			compatible = "qcom,adreno-650.2",
 				     "qcom,adreno";
-			#stream-id-cells = <16>;
 
 			reg = <0 0x03d00000 0 0x40000>;
 			reg-names = "kgsl_3d0_reg_memory";
-- 
2.33.0

