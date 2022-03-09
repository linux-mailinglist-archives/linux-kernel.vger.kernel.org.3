Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9B4D39EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiCITRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiCITQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA781107ED;
        Wed,  9 Mar 2022 11:15:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e24so4562499wrc.10;
        Wed, 09 Mar 2022 11:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLDmPA5aYPf6HW2iGF7P6X1focqrWhxUx4u2SFHvrtw=;
        b=chweFq1KW6JbTYPzrmXBEponbNvlxKQq8Crk2X3CtA06zk854MeuchhY5HCRpvSNNt
         oOzzmSkHj4zHoLGHDOU8R7HxurZN5CUjbYwwa78libNk0bvoX2yQmG11/26Yw18g1y+q
         dMFvRWu3y/D9148+UokFxXJu2FGlAiqm+e4MuWqaZdYfasrWxmgLFSprH0d0P3dffDfA
         C7KEp6+xFhzKQxzusqfsUaAPywlpekcNO3K8X0OBFnIALvxFIWQRFW81I3VkfXAzd2ec
         Y3Li5qTQaU5Irldg4hBvQ8oFp5E8WdS8pQ6oc017L7Rk9ZjPb0c3P98Pa32nWKc0t10C
         qfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLDmPA5aYPf6HW2iGF7P6X1focqrWhxUx4u2SFHvrtw=;
        b=VDDxZJnTeQzlrFSVnpLSmgVWVFZl3eXf+JV4rYetJwgxf/XJgQ833XNGHKS9DL3bbx
         oBfHa1dt/9lPWjHHmPXtbLd9+7wVShlDlHn2AzDPYB7ZqkN082mWxn+CxJx2DX99Abyk
         mYF3EOSFXynm6LHztifZzLcj4GaUPOonQkxeKh+7jaQRmf8thg9SUFYWnaWCW3JlIqO+
         z/RyuYUIruEIsUuo6mapWqcoH6V+eGcIeE+H2xZHY2uq1G/GCTixXqVjgh5oOnSMvWxa
         drhZIFdraJG8M5GOuqH6l7MOtZLwYfvVON8eOotpgCJY3ln9/x90ZFqrPTwHUC6E3g49
         fqYg==
X-Gm-Message-State: AOAM533zbDdxd83JbUFGgHwP3OcPnSDU7kANn+gLRhQexYcPDRBX4ln9
        FIq1aS1Kkm7FrIGsrc7JmBw=
X-Google-Smtp-Source: ABdhPJxxVmM9QRxCRtTKQFzoqBsP8L2rxvUO13uhTsNZUayNVsgNURrvtdq0fNtNEO6KpyPI9AzzKQ==
X-Received: by 2002:a5d:62cd:0:b0:1f0:23d2:b38c with SMTP id o13-20020a5d62cd000000b001f023d2b38cmr892007wrv.82.1646853329043;
        Wed, 09 Mar 2022 11:15:29 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:28 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 10/18] ARM: dts: qcom: add saw for l2 cache and kraitcc for ipq8064
Date:   Wed,  9 Mar 2022 20:01:44 +0100
Message-Id: <20220309190152.7998-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add saw compatible for l2 cache and kraitcc node for ipq8064 dtsi.
Also declare clock-output-names for acc0 and acc1 and qsb fixed clock
for the secondary mux.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 34 +++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index c579fb09e768..7df1c1482220 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -298,6 +298,12 @@ smem: smem@41000000 {
 	};
 
 	clocks {
+		qsb: qsb {
+			compatible = "fixed-clock";
+			clock-frequency = <384000000>;
+			#clock-cells = <0>;
+		};
+
 		cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -504,11 +510,19 @@ IRQ_TYPE_EDGE_RISING)>,
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu0_aux";
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu1_aux";
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		adm_dma: dma-controller@18300000 {
@@ -532,17 +546,23 @@ adm_dma: dma-controller@18300000 {
 		};
 
 		saw0: regulator@2089000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,saw2", "qcom,apq8064-saw2-v1.1-cpu", "syscon";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
 		saw1: regulator@2099000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,saw2", "qcom,apq8064-saw2-v1.1-cpu", "syscon";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
+		saw_l2: regulator@02012000 {
+			compatible = "qcom,saw2", "syscon";
+			reg = <0x02012000 0x1000>;
+			regulator;
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
@@ -899,6 +919,16 @@ l2cc: clock-controller@2011000 {
 			clock-output-names = "acpu_l2_aux";
 		};
 
+		kraitcc: clock-controller {
+			compatible = "qcom,krait-cc-v1";
+			clocks = <&gcc PLL9>, <&gcc PLL10>, <&gcc PLL12>,
+				 <&acc0>, <&acc1>, <&l2cc>, <&qsb>;
+			clock-names = "hfpll0", "hfpll1", "hfpll_l2",
+				      "acpu0_aux", "acpu1_aux", "acpu_l2_aux",
+				      "qsb";
+			#clock-cells = <1>;
+		};
+
 		lcc: clock-controller@28000000 {
 			compatible = "qcom,lcc-ipq8064";
 			reg = <0x28000000 0x1000>;
-- 
2.34.1

