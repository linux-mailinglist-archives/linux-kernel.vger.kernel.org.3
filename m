Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5516956BB07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbiGHNjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbiGHNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:38:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41FA2BB21;
        Fri,  8 Jul 2022 06:38:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id k30so18785848edk.8;
        Fri, 08 Jul 2022 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAqZrnSh0jfK0LLUnYpJumK2YJTHAZakB+MOOLiwb1E=;
        b=qTAkjs0kVjAAymmJCjSX4J2vmljnLyYcmlOXHQVQn2Fxqwt6KKRkteXrNzXATnFfEv
         m0DTfnS4GK7//pTEZ4KWYcBkBoNNe0hvG78GUlXo20Q84Xrk++zSQiss8o03+De70uAh
         YaogOiH3wbPpmYVyl++NqI8XY7fL/Y1utlSa2VJaOCzZ3rUshikRvCipT4nuAvvhsdUz
         Tk0U8Euoxw/MmGakUOoLtrG1EIfBlKGPyreYy9ilZL6gWhcPP664CHfZihEei7u24JOS
         ZXaXtCjxoG8dMsY0OGvNR1WOKoDSOpqDFlDqEKQ3qN+1F0v1pGxnUHslmsVCftSrG9JV
         BeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAqZrnSh0jfK0LLUnYpJumK2YJTHAZakB+MOOLiwb1E=;
        b=la7ioUnEmO7oXMX4vzQZx/8ojuQUMW4JrE/r4oVMf8E98p3ywuHPBDh0eR5elesemR
         n/y0O/d7GpX1DIMEuZ1B43L9pD7iiT0Dzsl+J48szAvxnOLSIqk4DWbk5Osy1dxy70CJ
         hmW0/BluuIpgvGqtCdwvIY1BEqtwsue8V/8kWQOgTfZf1IBZx1vMII4LDs9uA/b8BcwX
         m10c5d55V6LzQHSwyMB2owj8uwwMLGgORLBTvILkf1KveapTd86nUSiLonpR0cOQwGF3
         nLHXhFV74Bj4wNJy0kiLScRTylwaQSpvckGKc5ifeMiJVANQJjxsFJQTtoC2LwYmEFB/
         19fg==
X-Gm-Message-State: AJIora9sspAJwIZfUNonorwfxIQ85Ff42+eEBfzpULXoKQpZlq6Zr9YB
        pvH77w03ezez5ZbT3z+xy3b14ns6ZblzXQ==
X-Google-Smtp-Source: AGRyM1te1UekoZ265JltFHL8NaJrPkjaM3+R9oxrHh1QBzOxt9jn/M8TJntQ9R2KNhYmrJiBIU2Clg==
X-Received: by 2002:a05:6402:4144:b0:431:6ef0:bef7 with SMTP id x4-20020a056402414400b004316ef0bef7mr4732556eda.151.1657287530176;
        Fri, 08 Jul 2022 06:38:50 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id d8-20020a056402000800b0043a71c376a2sm9583016edu.33.2022.07.08.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:38:49 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq8074: add interrupt-parent to DTSI
Date:   Fri,  8 Jul 2022 15:38:46 +0200
Message-Id: <20220708133846.599735-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708133846.599735-1-robimarko@gmail.com>
References: <20220708133846.599735-1-robimarko@gmail.com>
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

Add interrupt-parent to the SoC DTSI to avoid duplicating it in each board
DTS file.

Remove interrupt-parent from existing board DTS files.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts  | 1 -
 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi | 2 --
 arch/arm64/boot/dts/qcom/ipq8074.dtsi      | 1 +
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index 9dfa2eefef29..b788e1605476 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -8,7 +8,6 @@
 / {
 	model = "Qualcomm Technologies, Inc. IPQ8074-HK01";
 	compatible = "qcom,ipq8074-hk01", "qcom,ipq8074";
-	interrupt-parent = <&intc>;
 
 	aliases {
 		serial0 = &blsp1_uart5;
diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
index c67181b173ca..40415d988e4a 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
@@ -7,8 +7,6 @@
 #include "ipq8074.dtsi"
 
 / {
-	interrupt-parent = <&intc>;
-
 	aliases {
 		serial0 = &blsp1_uart5;
 	};
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 73e7e9aad194..a38b4f21ab9b 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -13,6 +13,7 @@ / {
 
 	model = "Qualcomm Technologies, Inc. IPQ8074";
 	compatible = "qcom,ipq8074";
+	interrupt-parent = <&intc>;
 
 	clocks: clocks {
 		sleep_clk: sleep_clk {
-- 
2.36.1

