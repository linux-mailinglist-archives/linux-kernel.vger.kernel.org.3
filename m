Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451984FAA4B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbiDISoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243104AbiDISnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:43:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC31E744D;
        Sat,  9 Apr 2022 11:41:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t13so10624677pgn.8;
        Sat, 09 Apr 2022 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZZys+byt8A8z4Y5BS456ZsNSjyY4dy9Zz5TFnhyRgg=;
        b=fhdvJPFjOVAOLdzjaf3o7eVafsrP+0eWrqVRjFa3U2zZpuM+5rw9e14TlVBgZRaHkh
         ZZnGZRvyTkTntgFpSRulnkaTRuoQ8nX9UuEjv4yZKE68ljz8Tr1p57bGkgQGSwOArqqL
         PL5vR1hklf3qNASerIZDoca4DU4uWwzyVH8t4Pz6IpGwn5L3PDZWgrnWLSGdrgqHTvry
         l+wAwNA2jhAQItX/oM2Ok/UofK0r4ia7DlkSszjF52mZ/hOGdh2EvfTo+9nNMCSBAIiI
         AamauRDBxPUB3nQCKx8GGBB1rBzNSC3ULbRF2mW7e2DBD2/l5L7+mBaK8jqSkJE1Sh+j
         X8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZZys+byt8A8z4Y5BS456ZsNSjyY4dy9Zz5TFnhyRgg=;
        b=cmFw/qSbqdd0hIZDh5I/FOlstZ2GdP/olY4yrukm6slfNZYk4SukPEalpLduQE0qsg
         FvThpW/bHU4l9CvVgzivtpB7ss5LDCqWZUbVVpLl0D6fSA5lUBeLMfA9Ci2vz7+Gn1pP
         y+tp33GVYMqnbNekI5RT9dHyryncYEhOGShJWECwb9OO/L/LI9jZf5Ev/4fmzyxSejVj
         djKhBMblExEjcEhS5RkWQbBN0t+zM+VD5ybry7VBEHd1zwgmznsUIrn7I71cKGlq0ny8
         LAuACbs2z3Byd5I4tiZuoP/QcZmZLQvbTxmrNvHC37swd/BgUweb8Mo9xOQn0Sz8uOIs
         txsQ==
X-Gm-Message-State: AOAM533fcI3AJzKX38qo1WpUJK8SiH+cjBbX3qooDmMN7rMo1delkXo7
        Alqn20HaE8iGDJvEl8Y331k=
X-Google-Smtp-Source: ABdhPJykXPnD9f02jC2nUs6ZWGp5XlngJ6YeP6Wibjf0759YjNh0L5Sy7KMPfkHhUr4VoGnG0+N1mQ==
X-Received: by 2002:a63:2f03:0:b0:398:b2fc:250c with SMTP id v3-20020a632f03000000b00398b2fc250cmr20119361pgv.75.1649529701943;
        Sat, 09 Apr 2022 11:41:41 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id g3-20020a63ad03000000b003821d0f0ef4sm25813933pgf.71.2022.04.09.11.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 11:41:41 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 5/6] ARM: dts: qcom: ipq8064: User generic node name for DMA
Date:   Sun, 10 Apr 2022 00:11:14 +0530
Message-Id: <20220409184115.15612-6-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409184115.15612-1-singh.kuldeep87k@gmail.com>
References: <20220409184115.15612-1-singh.kuldeep87k@gmail.com>
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
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 996f4458d9fc..8366310ca5e3 100644
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

