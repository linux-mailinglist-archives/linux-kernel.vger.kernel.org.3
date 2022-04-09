Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63B54FAA39
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbiDISnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbiDISnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:43:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D50B1C8D9C;
        Sat,  9 Apr 2022 11:41:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n9so10670592plc.4;
        Sat, 09 Apr 2022 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddTuY51+NiyyyGu6kYjILoiFlTrP+EFOSDUDkBgM0uA=;
        b=Bw6O05KWIPpoOvgPLrBwYut1P8eKytQOweHxRYOnrXAVoH201OocsZOHz5S8KcgHae
         2EKq37AtUqK7R7rARt1bAoMSMKqUzZXQmAgDA/NYFMPtEEJ149Jbqd3qONhEfWY5rNR6
         DmWUXgATsMS0wxCr5CMHvTfEK+k+CPY15SeaCY7ybDqacjQr3rq7/r7iH+BveuZ7CXNG
         vBNHJwLpSpwrtr3YIjvoCi5c/qK4L6IBZGPLWEGZeZnir6UUrjqkAd7gv6fj85BnRIzf
         l01xhJdBlEO8PAi/KjW7SihqOzqME465eDLLNhE/WHJptE9ihfsq47wKi+myw4NoK4W4
         thKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddTuY51+NiyyyGu6kYjILoiFlTrP+EFOSDUDkBgM0uA=;
        b=4EFItigIMWzWEoDWfVaseF2jcXpcjh6nEBeKrLBVsf1Tj4PyNXmtyJ3FH+cVykubdN
         uRh+Ho1B3igCRMX2JstK2X1tJdlsvbEbPI2WKiqmoG8dnfA/uiRuDqmXQoOtVG9r8HxC
         v9hpaB4rkZHCB4gOFl6ZFyNe6r9aqewYBahwnjv6XTXb2MB9v5mmkc++Mfk3hHdO80ZO
         3HRjtmzEltKSNXAJrYrY4kxKK+k9XgeskxsrBU9DFi7r4F5amPBdD/ZKujTKCgQ2Fdh0
         3DaUsyVMgTibq9c3z+aoqbAFIVxCjqlUcXhw/HuAjv4SgNNOXTvkBvlNsiG+2jMH/4dE
         lzag==
X-Gm-Message-State: AOAM530gf/McP3mf+0M+6YjgkRdwXNbPrtpcwPIAASqsWKCGD58Ppu0m
        p6L/uhUJmSW/fWW6lGS/h7U=
X-Google-Smtp-Source: ABdhPJwzJurB/UUTXpYOJnd1TWVhD+nqxxZOlakfm+O2uCafxX4AvTnR5L0k43d3ZGwB1K4tvfRkSg==
X-Received: by 2002:a17:90b:3a92:b0:1c6:64a5:a403 with SMTP id om18-20020a17090b3a9200b001c664a5a403mr27883344pjb.89.1649529688853;
        Sat, 09 Apr 2022 11:41:28 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id g3-20020a63ad03000000b003821d0f0ef4sm25813933pgf.71.2022.04.09.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 11:41:28 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/6] ARM: dts: qcom: apq8064: User generic node name for DMA
Date:   Sun, 10 Apr 2022 00:11:10 +0530
Message-Id: <20220409184115.15612-2-singh.kuldeep87k@gmail.com>
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
 arch/arm/boot/dts/qcom-apq8064.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a1c8ae516d21..b2975be3ae04 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1040,7 +1040,7 @@ sata0: sata@29000000 {
 		};
 
 		/* Temporary fixed regulator */
-		sdcc1bam:dma@12402000{
+		sdcc1bam: dma-controller@12402000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12402000 0x8000>;
 			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -1050,7 +1050,7 @@ sdcc1bam:dma@12402000{
 			qcom,ee = <0>;
 		};
 
-		sdcc3bam:dma@12182000{
+		sdcc3bam: dma-controller@12182000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
@@ -1060,7 +1060,7 @@ sdcc3bam:dma@12182000{
 			qcom,ee = <0>;
 		};
 
-		sdcc4bam:dma@121c2000{
+		sdcc4bam: dma-controller@121c2000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x121c2000 0x8000>;
 			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

