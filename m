Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419AA4F9466
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiDHLpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiDHLpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:45:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F66190581
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:43:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n6so16688252ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 04:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=raH5DpDex1bgPcZoFCyedKcGROVs5pFi27VlM6LNPYA=;
        b=GFlx7yk12v5YU3SUNDx5RLKC0GrE89DeOEB2Kbob2oUm9EYytz6dR9ZHusIUShCIUo
         wdj3WIm0I9EtjEZ977kp/ZV2HIWZ9UcX1apttjph/YUCYdSbAxN5Q03QrhM5dM3ABjd+
         9ttsYk5guKCWFbf1Qw3T+gnQ7roux5fD6MMJng9TNS0FESwgBaf3sqSQPJVA+bOy/l5W
         PzWw903aPIriZpT0v7xqILHtbDmzLKkJfq3C7e28uX4irphPeuXK2EjTG0a4M+CuWloe
         xWBwsgJoxVhjsQCQJI7xgebb6htuW3PxSSDcVbiCPK/p/akMVyS4VXbzVq7pct6zzg+6
         VUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=raH5DpDex1bgPcZoFCyedKcGROVs5pFi27VlM6LNPYA=;
        b=WF1ShZJ+AAsBRu3v6NFYPP7YQzv1HS/hLuAG/8t+JBob25kSBXtkbNnBBRCdz4NmO9
         x4QWF5uTtgxuvq5H2/ruC9+nI+7W8bTRtoTtNZRMdYJLCgOADjtms6FMGzIDXo7ZF4EC
         H4aNU25yMO1E18+ogw/T7uKvs0rfUlrelxFRGTcEfkCOPnq9YG0qaSIMrVpXSk0RXnER
         dP/ZRoE2mVhCqaW1ecxfl3gOI5CkuAtw7jy7G3Q0oenl5W81YbKSDoQPl+i0r3g/Tq7A
         tXBRQP4pQuDIlvftI41jiCb0knXYGNGRmol4ybuAj5aWBeJl5gahZ9YwGsJChEz7UHX/
         WoEA==
X-Gm-Message-State: AOAM533KsxHVQDGf6NXWfEtfeqEfj+OVbMwySzAfduXiqDg5jzISUd94
        b22JwJdfjEagj/sYnwSiLtyEdNvUBrTo+g==
X-Google-Smtp-Source: ABdhPJwFpUDAxTBeuBmWCsucM8NLu6nqldKEGgHgskA+HiUp3XHmYsm9mv2Uf60OflPYtg2FD+0DcA==
X-Received: by 2002:a17:906:58ce:b0:6da:b548:1bbb with SMTP id e14-20020a17090658ce00b006dab5481bbbmr17815445ejs.14.1649418186511;
        Fri, 08 Apr 2022 04:43:06 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id h5-20020a170906718500b006e7edcda732sm5909557ejk.125.2022.04.08.04.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 04:43:04 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sm6350: Fix naming of uart9
Date:   Fri,  8 Apr 2022 13:42:04 +0200
Message-Id: <20220408114205.234635-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uart9 was previously mistakenly called uart2. Fix this.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi              | 6 +++---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d7c9edff19f7..ef43af39569c 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -529,13 +529,13 @@ qupv3_id_1: geniqup@9c0000 {
 			ranges;
 			status = "disabled";
 
-			uart2: serial@98c000 {
+			uart9: serial@98c000 {
 				compatible = "qcom,geni-debug-uart";
 				reg = <0 0x98c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&qup_uart2_default>;
+				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
@@ -974,7 +974,7 @@ tlmm: pinctrl@f100000 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&tlmm 0 0 157>;
 
-			qup_uart2_default: qup-uart2-default {
+			qup_uart9_default: qup-uart9-default {
 				pins = "gpio25", "gpio26";
 				function = "qup13_f2";
 				drive-strength = <2>;
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index adb6ca2be2a5..67d14bda3797 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -23,7 +23,7 @@ / {
 	qcom,board-id = <8 32>;
 
 	aliases {
-		serial0 = &uart2;
+		serial0 = &uart9;
 	};
 
 	chosen {
@@ -332,7 +332,7 @@ &tlmm {
 	gpio-reserved-ranges = <13 4>, <56 2>;
 };
 
-&uart2 {
+&uart9 {
 	status = "okay";
 };
 
-- 
2.35.1

