Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CAC55B193
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 13:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiFZLs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 07:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiFZLsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 07:48:23 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD1611C1B;
        Sun, 26 Jun 2022 04:48:21 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id BB9732007F;
        Sun, 26 Jun 2022 13:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1656244099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I/mAZDQYdv9m84vfS3Qv7/85j2cosVucoKTYVfbJ9zg=;
        b=gTZudDbaN9LlFqhKxNkc6Ij+/4hDOI2oef/cEmXhvh0xKfo9KkCv+Wa0pCQg+Y7mZF6ktX
        7gmMU6Xymaqp3lp+JiqXgDQ97lC5JlqSlJnYDOfSqhkWzdFe+eBkzfxMd2OMm5hIca9VVE
        Zfryy28GPWYHx30lIUJ9TLHxBwN2DDw=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ARM: dts: qcom: extend scm compatible to match dt-schema
Date:   Sun, 26 Jun 2022 13:46:32 +0200
Message-Id: <20220626114634.90850-1-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
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

Cc: Robert Marko <robimarko@gmail.com>
Cc: Guru Das Srinagesh <quic_gurus@quicinc.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi | 2 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 9120d10dcd9e..67e625e56e04 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -309,7 +309,7 @@ dsps_smsm: dsps@4 {
 
 	firmware {
 		scm {
-			compatible = "qcom,scm-apq8064";
+			compatible = "qcom,scm-apq8064", "qcom,scm";
 
 			clocks = <&rpmcc RPM_DAYTONA_FABRIC_CLK>;
 			clock-names = "core";
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index cb01faa23eb7..123c0c32d1df 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -95,7 +95,7 @@ memory {
 
 	firmware {
 		scm {
-			compatible = "qcom,scm";
+			compatible = "qcom,scm-apq8084", "qcom,scm";
 			clocks = <&gcc GCC_CE1_CLK> , <&gcc GCC_CE1_AXI_CLK>, <&gcc GCC_CE1_AHB_CLK>;
 			clock-names = "core", "bus", "iface";
 		};
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index c5da723f7674..4faf854aab9c 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -156,7 +156,7 @@ xo: xo {
 
 	firmware {
 		scm {
-			compatible = "qcom,scm-ipq4019";
+			compatible = "qcom,scm-ipq4019", "qcom,scm";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 804d094c4d79..4cbd8d91f7d0 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -96,7 +96,7 @@ CPU_SPC: spc {
 
 	firmware {
 		scm {
-			compatible = "qcom,scm";
+			compatible = "qcom,scm-msm8974", "qcom,scm";
 			clocks = <&gcc GCC_CE1_CLK>, <&gcc GCC_CE1_AXI_CLK>, <&gcc GCC_CE1_AHB_CLK>;
 			clock-names = "core", "bus", "iface";
 		};
-- 
2.35.1

