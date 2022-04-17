Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46C5504994
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiDQVHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiDQVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:07:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920421A9;
        Sun, 17 Apr 2022 14:04:59 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q19so15480013pgm.6;
        Sun, 17 Apr 2022 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5jlF+guEA4R11q6WYIvaSFVMwN+QiHnqDtm7tCAsoM=;
        b=CfDkfZ2VKuvb4epu2/7nn7W4mz86EHtxLnpmaNZ0nP8R7QcaDCMrnABz+xT4lEN2Dh
         QQ6dwf0RQwCYsjhD25TGTJp29byThyskv0MSmZVsmoB9DkdBfDDp2BZU8ooE2PxuvX0T
         XlP7qJxXWfIj1yLgtA/qckTjTWBuBzggPOc2h/JmHuH+dcKFEhXFHyYGw6Pi5cr6V7eD
         4KEznjEjsxv+Z1ZIIb2ID9SbJurMsqLcjjaFCxMPta8sGd6a+N9DCyGBr88MhaIJptCn
         Sin3cUvWdt//ENIlpOr86qy+1sxebK9sRc8AYDf9H1iRduX+h/Q/o6ya0Pn8guiEpzI1
         Uexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5jlF+guEA4R11q6WYIvaSFVMwN+QiHnqDtm7tCAsoM=;
        b=YVbj2YAIsKs8kQYAcZEMjd7zBFXPnF8Hha/3keanxq0medhyOn0mPzXbbbqPmA1Ngd
         IyboC6g6BxI0YODa7S8hd+AJwq3072/hiOQqoqYalQJN8YQIPlBxLNOiISxz9Ofaw5ME
         FatdSYE0fPnWNHq3nZf/9YFL0DJB74DoLNkS3VU2cg9G1rZmmw9012aEoZMN3JNyDLvc
         Mumd88Yq3xDjxJ4GCmzmmxCHfe6JxHbFX72QAukwbKPZnnbN3uzlCGW852vs4LeCCo3y
         ZGfz/1pvyRfk+su0EtAKEtZd7VEtS89lQmf9y1KkUx+ZE8qU1hkHvfRieXJQ5ISXg59m
         R0HQ==
X-Gm-Message-State: AOAM5309fwEiaTe6gdtiyZrju740LK4RvRlA/OTntRh+BQSUtlOGoD1V
        K4QhUMDVccGiCab32xx9V3o=
X-Google-Smtp-Source: ABdhPJwPo3iVsNY1nZ6CU0wWMU3vlIupS0Y09BFFRPK8n+GdNLCiiwZ8ZnOZr6LgfFnwNhrYCjkRwQ==
X-Received: by 2002:a05:6a00:c8f:b0:50a:77a3:e7b with SMTP id a15-20020a056a000c8f00b0050a77a30e7bmr1080986pfv.41.1650229498893;
        Sun, 17 Apr 2022 14:04:58 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id 137-20020a63078f000000b0039d9c13cd39sm10547711pgh.67.2022.04.17.14.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 14:04:58 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 5/6] ARM: dts: qcom: ipq8064: User generic node name for DMA
Date:   Mon, 18 Apr 2022 02:34:35 +0530
Message-Id: <20220417210436.6203-6-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
References: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
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

Qcom BAM DT spec expects generic DMA controller node name as
"dma-controller" to enable validations.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3: Add Krzysztof R-b tag
---
v2: No change
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 8cb04aa8ed2f..7e68d4b1527f 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1155,7 +1155,7 @@ vsdcc_fixed: vsdcc-regulator {
 			regulator-always-on;
 		};
 
-		sdcc1bam: dma@12402000 {
+		sdcc1bam: dma-controller@12402000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12402000 0x8000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -1165,7 +1165,7 @@ sdcc1bam: dma@12402000 {
 			qcom,ee = <0>;
 		};
 
-		sdcc3bam: dma@12182000 {
+		sdcc3bam: dma-controller@12182000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

