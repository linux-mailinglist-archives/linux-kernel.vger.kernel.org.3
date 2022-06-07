Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD76A53FB4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbiFGKd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbiFGKdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:33:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529015D5C5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:33:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n28so22385084edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8P/Utz+qwtMmeLsHCu4UtqnQA7wOV2udDxlc3dKNwHo=;
        b=WRTgwXgoM9JsYjQJPCGDKOw4FBmvu4IqF0X/VQ7v8g2wdYagSNMDyFt95YfQvEQyKh
         0dhxUwmXNAoTe6wivVReuWoiZUC5Z0zohOl+4slD2nbPbkVRZewOeRJss+rXSAy54AlE
         VqgHseOwbdZkonnVSUeivvAFSLNpAuD3trePQAydFvxsueHBugXMUDpI5JEbwcG/rqte
         LDtcDJkpcH8xxQny+HnlfiQuNUrwhx4IShB/9xrFz0hv8h2P7dR2OVJlG3wMDCQEf/Xu
         U7GPsM4x++k4IeqI+aOANRTqkWMVy9UvbWk2mGigUlKvBxiSdcD6wyaxbtv+WrFWVOdO
         dHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8P/Utz+qwtMmeLsHCu4UtqnQA7wOV2udDxlc3dKNwHo=;
        b=6VQLbRM7rKshIQo4I3r2ufJyjeuFGFzxdamE051635lYQ6/p7ipdVuWk3iKj2KtWep
         PpvlC3JhXRg7ncYhOKNAjIY+eDLBNc5rqgXMMoOWpTRDxnugNgkeau9CCOZHrlqJr0jI
         CS0NXdjxhuwg/ve6Iaq14jIdstXXK4/D95jIauf5Zsitlbo90vns6Bdi0g7STbjTXJ2n
         ubBHueEl0OZ40DQPJywPaamlDAx8R0/blELNY8mKJtU0MW7/SxLlxGTDGGxtsoQtXanP
         gI2sz6islmiXvxNumA7NDXG966ARYjjSW00Tg0aCNsg3LAJ6f9imunTWb/8VKIx+rPXI
         Ksjw==
X-Gm-Message-State: AOAM532BpnivR8iZqr1WcHn9GJclnnLh7l+5vthodpOyH2sbRv6eAAuq
        QYJsaDsb3HSD07p6RaqT48BBOw==
X-Google-Smtp-Source: ABdhPJx97W7wrNNfp8Y0I80YoSqVgA37FCnFdVSHeklX5Q45ucTEloIiuYUoKifQuLENj5pGN9jVMA==
X-Received: by 2002:a05:6402:4241:b0:431:574a:d74b with SMTP id g1-20020a056402424100b00431574ad74bmr12413182edb.374.1654598030866;
        Tue, 07 Jun 2022 03:33:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709065ac400b00704fa2748ffsm7505359ejs.99.2022.06.07.03.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:33:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/10] ARM: dts: qcom: apq8060-dragonboard: add function and color to LED nodes
Date:   Tue,  7 Jun 2022 12:29:22 +0200
Message-Id: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common LED properties - the function and color - to LED nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 138d6478ac84..9a4aedc5f3ea 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
 #include "qcom-msm8660.dtsi"
@@ -416,6 +417,7 @@ led@131 {
 					compatible = "qcom,pm8058-led";
 					reg = <0x131>;
 					label = "pm8058:red";
+					color = <LED_COLOR_ID_RED>;
 					default-state = "off";
 				};
 				led@132 {
@@ -426,6 +428,7 @@ led@132 {
 					compatible = "qcom,pm8058-led";
 					reg = <0x132>;
 					label = "pm8058:yellow";
+					color = <LED_COLOR_ID_YELLOW>;
 					default-state = "off";
 					linux,default-trigger = "mmc0";
 				};
@@ -433,6 +436,8 @@ led@133 {
 					compatible = "qcom,pm8058-led";
 					reg = <0x133>;
 					label = "pm8058:green";
+					function = LED_FUNCTION_HEARTBEAT;
+					color = <LED_COLOR_ID_GREEN>;
 					default-state = "on";
 					linux,default-trigger = "heartbeat";
 				};
-- 
2.34.1

