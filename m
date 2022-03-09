Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1E74D39F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiCITR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiCITQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47310EC76;
        Wed,  9 Mar 2022 11:15:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso2092491wmr.1;
        Wed, 09 Mar 2022 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aD2mMDchOEVFiGz+Z8VfXmntVMjBUu62m3+cOMYTI30=;
        b=aRr30hO/1QrH6SnavZ1Sn1kn50t30hjGIR167v1UJ1Owi9q/hYnBe45B62rYjgO5jU
         zzqvMANGuMPU7FPPoxIZhFLrLen43mEK2TfSV60uA5C5DJf3TrHwe7ANkzfMTywsFiMa
         yrQpgBok//bt24O6c4m8zQJi3x5k+7kl+RrgqGAI5zWG8IquitZUA3gcBKtV8LwXqsbh
         gGeqf51njigs0D58yX9h75M5MGJP6to7JWMHQov6oiYOjmb0jbli9Hqqn0GMZSuTEj3P
         UBOnsiwO0bEneVNpVaGOgoubryRzaWJVZ2Kt0U+lodDVCKyhjI2TZNWAy96LjQbg2sBo
         K2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aD2mMDchOEVFiGz+Z8VfXmntVMjBUu62m3+cOMYTI30=;
        b=KFEp0YrhFTK74AqzFBYpGO3nmCU43Cq54OcSjXJ9JyAj1cx+HafrtsX2w0z/bxPdzR
         TxBHSQPg2KCQ0aTQXLnZzP7KzppW1y3Lya8in3z3DPSrazWmjW5IGA++tHDxv8Iq5mMx
         hdaTu1v0FrRFA3cdMc1F5/daAas6Se4yBxCOOsufBGUwxdpb1sgPZEm9QLBaxgWZY656
         BmYxj9mQWlcNrm03X8U6EWtaf8u+3rGUdSjsl+gcydWnOgtf0yJ7eN+ES2t4jXS2kWHe
         lsUMvFve0jqeGgox9VKDNl/wWHog7A9sgc8GL4D2NRZH4cRGMA1SxpJueZskvoriw4l8
         f3tQ==
X-Gm-Message-State: AOAM531hfEsbglHT6fc8nIJko0X8u68pP8izBk/XSFczM/zoZ8R/olXG
        7X9OLXNRzKQ5SyHHhfqL4do=
X-Google-Smtp-Source: ABdhPJxBnDtfaUHPTWtquBlqv+5qYTK1vRMiVENoQn6EoYc28A/6CtDqYMo9coDoG/ROYVnyiAgRkw==
X-Received: by 2002:a05:600c:4f09:b0:389:cf43:eaf8 with SMTP id l9-20020a05600c4f0900b00389cf43eaf8mr681490wmq.201.1646853337789;
        Wed, 09 Mar 2022 11:15:37 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:37 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 16/18] ARM: dts: qcom: remove redundant binding from ipq8064 rb3011 dts
Date:   Wed,  9 Mar 2022 20:01:50 +0100
Message-Id: <20220309190152.7998-17-ansuelsmth@gmail.com>
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

Mdio0_pins are now declared in ipq8064 dtsi. Usb phy are enabled by
default.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 611a4a19631c..22a4fa8b5e2b 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -259,10 +259,6 @@ &gsbi7_serial {
 	status = "okay";
 };
 
-&hs_phy_1 {
-	status = "okay";
-};
-
 &nand {
 	status = "okay";
 
@@ -309,15 +305,6 @@ mux {
 		};
 	};
 
-	mdio0_pins: mdio0_pins {
-		mux {
-			pins = "gpio0", "gpio1";
-			function = "gpio";
-			drive-strength = <8>;
-			bias-disable;
-		};
-	};
-
 	mdio1_pins: mdio1_pins {
 		mux {
 			pins = "gpio10", "gpio11";
@@ -358,10 +345,6 @@ mux {
 	};
 };
 
-&ss_phy_1 {
-	status = "okay";
-};
-
 &usb3_1 {
 	pinctrl-0 = <&usb1_pwr_en_pins>;
 	pinctrl-names = "default";
-- 
2.34.1

