Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639CD50498A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiDQVHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiDQVH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:07:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994F7F4E;
        Sun, 17 Apr 2022 14:04:49 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q12so15443083pgj.13;
        Sun, 17 Apr 2022 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1yUODW8R7vlRlvRAcHZQS32EzjAunE8SKvTkzPUAf0=;
        b=YY5BA6s1k8bMmQzDlq/TabbGBZtJCMawmGAQuh5gWftU3hjKSHu28slGo7aQC4ACnv
         68NMS9JAwrbMED1ESGuVyAX5YzlUa8TAspvmO71ZXLBuWhyPz/Kc3UhlUvDc5jQuBKP9
         5mhxbV2i9zCyWzZTUY8F59EADT7OKf5PlEQborP/tZOjBPh23vcvhVRoP2ydBSH9qLEr
         GkHhCGlZwIVgrVK6+yiqN7anPKrmpLQJpmm3Dzv7JrVQzXeUp3x7zAOPcEbAto19OJUg
         RTMcE//I75Le/mlRlnHKOB1v2dtJGBd7gnop0BIqhQ3GcyH+0ATHPL2S0wqO2loa+m/u
         4iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1yUODW8R7vlRlvRAcHZQS32EzjAunE8SKvTkzPUAf0=;
        b=eoeBi33j4f2u0ZI44S1jn5hB884XABTKrCRRsN6NPsnAdLrRzhGxoxwDBGvk4X+KG0
         M3cXOGvlRG47eXtM69LmAvBTB2zrXk60pMXHwsCJtD4QqMs+2f30ZROtAh+/r+N28S0e
         LubHmSvWAGN95rutdxVtS5xhpKSPHv4oUOf+PScPsaSV2fv+AZrERXLtFn/uBYC2lGt9
         um+8F3yIhzAefaLv+hH6ssA2BfmlgoQ617kwrinZh3QQ4bsfHAdb9lqJ5YjoP47fDXPL
         LVRSuIvO6b1EGSgjp6bJ71xU8vIdCBBmR05S4QKtI5uqBTuLDHM+BH2jMlCRZnZvd9mV
         0sOg==
X-Gm-Message-State: AOAM531gZG8O/HntsfJ++6bXDZzj9Cz4VG9n7L1z1BQlNPmo0eL4ROLJ
        idyyNPnTZKL3Di/2fAXMbA8=
X-Google-Smtp-Source: ABdhPJyP71P63kYUS+cEqAov1rHNiy+XgX1dzWJWGr95YM1/QdU5oO9OznbwYc+fuHAJYXUlFyP/8Q==
X-Received: by 2002:a05:6a00:1d19:b0:50a:3e40:d89f with SMTP id a25-20020a056a001d1900b0050a3e40d89fmr8855793pfx.61.1650229489088;
        Sun, 17 Apr 2022 14:04:49 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id 137-20020a63078f000000b0039d9c13cd39sm10547711pgh.67.2022.04.17.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 14:04:48 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/6] ARM: dts: qcom: mdm9615: User generic node name for DMA
Date:   Mon, 18 Apr 2022 02:34:32 +0530
Message-Id: <20220417210436.6203-3-singh.kuldeep87k@gmail.com>
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
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 4d4f37cebf21..8f0752ce1c7b 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -330,7 +330,7 @@ pmicgpio: gpio@150 {
 			};
 		};
 
-		sdcc1bam: dma@12182000{
+		sdcc1bam: dma-controller@12182000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -340,7 +340,7 @@ sdcc1bam: dma@12182000{
 			qcom,ee = <0>;
 		};
 
-		sdcc2bam: dma@12142000{
+		sdcc2bam: dma-controller@12142000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12142000 0x8000>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

