Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C955B391
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiFZSdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiFZScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:32:54 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE4AE005;
        Sun, 26 Jun 2022 11:32:53 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id C3A9E200FE;
        Sun, 26 Jun 2022 20:32:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1656268371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L5L8Wgw3+zJEKjNJdgtVqo8DZ3PKGM8/lbHZfVYX5eE=;
        b=HmsWNiq0/nXv4xIOXQxqOUFN7D/wCTatPDHim1O6sFNyXJ0Sq17c3KlknQ8YFiDbP6eIGl
        uiCzSErbfeuVU+JkiBkH5SxQ6yfJZ8L5kzTXLbFh3ykIcg5BnvB8A94j8Y7q874faNYylI
        INizzviB9WBk1KtUMqh76CNHH7z556M=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] arm64: dts: qcom: extend scm compatible strings
Date:   Sun, 26 Jun 2022 20:32:46 +0200
Message-Id: <20220626183247.142776-2-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220626183247.142776-1-david@ixit.cz>
References: <20220626183247.142776-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First device specific compatible, then general one.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 748575ed1490..19228e4f5313 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -125,7 +125,7 @@ opp-1800000000 {
 
 	firmware {
 		scm {
-			compatible = "qcom,scm";
+			compatible = "qcom,scm-ipq6018", "qcom,scm";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index ffc3ec2cd3bc..6fd361be0fe2 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -215,7 +215,7 @@ L2_1: l2-cache_1 {
 
 	firmware {
 		scm: scm {
-			compatible = "qcom,scm-msm8953";
+			compatible = "qcom,scm-msm8953", "qcom,scm";
 			clocks = <&gcc GCC_CRYPTO_CLK>,
 				 <&gcc GCC_CRYPTO_AXI_CLK>,
 				 <&gcc GCC_CRYPTO_AHB_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index ab95ec4a7491..7c854c9c2517 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -357,7 +357,7 @@ opp-2150400000 {
 
 	firmware {
 		scm {
-			compatible = "qcom,scm-msm8996";
+			compatible = "qcom,scm-msm8996", "qcom,scm";
 			qcom,dload-mode = <&tcsr 0x13000>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index d0760e6ec942..fc4a490add48 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -628,7 +628,7 @@ cpu7_opp20: opp-2841600000 {
 
 	firmware {
 		scm: scm {
-			compatible = "qcom,scm";
+			compatible = "qcom,scm-sm8250", "qcom,scm";
 			#reset-cells = <1>;
 		};
 	};
-- 
2.35.1

