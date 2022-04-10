Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2AA4FAF73
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbiDJRxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243794AbiDJRxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:53:32 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B2956C31;
        Sun, 10 Apr 2022 10:51:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 66so12191455pga.12;
        Sun, 10 Apr 2022 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZZys+byt8A8z4Y5BS456ZsNSjyY4dy9Zz5TFnhyRgg=;
        b=gBbJSu3ztpc+mqvi7315GuTQALJx9XtTDRXEPzX43/1iufrS7eVD0Do7tgRtpwTjMf
         Y3YXMH2Umgd+h18GIeGXxWw9Vb7AWflduf0g+DRKVItF84R8qf7Dpj4DNB39EwXckWqb
         K2SiUGh9MlMh/LVoRPajZcmcnD+Ono3DNnQdeMMjUoJ+oAjrJS3+gXkdFfp3/gscaKZy
         fWSCTJW1vXd+slKz5Q27D3qGBKYVikw7R06yGbDPp1M4PjXpliQjUoeUnuG6l6TvXYMk
         C0vOezykWvq6KClvd7c7eYLFUlk2RZkh9WCUj/2o5xXZRhF9Pv4nPI5wzugcW+otv7cQ
         GbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZZys+byt8A8z4Y5BS456ZsNSjyY4dy9Zz5TFnhyRgg=;
        b=k51saZacuG5vQeBCANMKY/pf3sA2/gX6NKdfZ4deGAPRKNp7wPOcBbdlYzmGS9ndPw
         tQPsTEaWFHzHJksHDJR+4NMHPuz6IoSLYzPR3lR8nbAybUpqx163UYer5G/khSocYyP2
         OXgbC+wWa78giGPvl4YL2xRmkOwN5ZMWcvrsswVTKOIKiXF3wJ9+crSIaMskE2AFZiuu
         OEzu18uSw4hlNIPsm9+/ol2apo9cN11JFJhtQ0Gn3rKuqdn540iQSZ1lAE/MNOO5QzNa
         bLwbtYhZebVqGwp4hNVAGU4SghTvgudtNk2Xw1rlLS4j1cFYB7+3nyWztjdDRdhqczA0
         T6ZA==
X-Gm-Message-State: AOAM5338F1wEaQGHPI4LduQxP+1WR+/IUOGLEddwz4/LJszJo1M0QC2B
        eQ4S9pWeDn75R7YCcLrd51QQ5Jm5BK0=
X-Google-Smtp-Source: ABdhPJzBe/qQ9mtJ8SacujFm/UceYkkbWjQO6AC9k7M6EiNQ4wTxownlhEUnqbDK7274JWxFXMr8fQ==
X-Received: by 2002:a63:5520:0:b0:399:8cd:5f62 with SMTP id j32-20020a635520000000b0039908cd5f62mr23436187pgb.12.1649613077790;
        Sun, 10 Apr 2022 10:51:17 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm32283286pfc.3.2022.04.10.10.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 10:51:17 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 5/6] ARM: dts: qcom: ipq8064: User generic node name for DMA
Date:   Sun, 10 Apr 2022 23:20:55 +0530
Message-Id: <20220410175056.79330-6-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
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

