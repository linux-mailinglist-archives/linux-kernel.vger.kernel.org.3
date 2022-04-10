Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F1C4FAF72
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbiDJRxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbiDJRxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:53:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35244B418;
        Sun, 10 Apr 2022 10:51:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso2184937pjf.5;
        Sun, 10 Apr 2022 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddTuY51+NiyyyGu6kYjILoiFlTrP+EFOSDUDkBgM0uA=;
        b=iwnAxDjmJ1vS6PUSd7MR8Ekp/APJVgQ14d49KgbNS00wDZQ9Duxha03gKADEtyg41W
         44aehX0d2nL8IcdFTifJTTxXIVQqKobmS9vpVP/eUlFdP86lsUCPswMtfyKHUuVHyqVP
         Vjymy/KXOMwepfAVpYV9T2SDXoh6XPXXNy0HfkjwEzDAcBdb9V3LEdX56XWI2pqzySlL
         6ZM9jx2/8j6IWFWoqEAhljoWg4wC4HNFDAHgz+dk3lvkZpcYq0pbsJ6Gb5+TOE7mitqz
         7LhP8oaV2A5flnsDrXQ4/3opUTEet19ykvQOv1LWjgXX3IWdhSAyJcKqfV9WOjeRNPEE
         n7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddTuY51+NiyyyGu6kYjILoiFlTrP+EFOSDUDkBgM0uA=;
        b=Pa7pFx1yE+dP1/MBOh1iJ5CJO53Y8aEKUcn8A59Z5E0odrXSV40R71yA0YHIXtOloP
         fDeVeVO8PN2pCXtnAWpiJK2uPra7lZQmqB36TJeEqg+xULircjzCaiPKeY1a4LOsG+BT
         3GNe1mMvM0EvjYTYXFONW1CIqf88YnIMv7Q0CFYglvOithVv+qpNfykosa7l5CNkefnB
         5bbq+IroXiIKNxJv+2Usold1XHoB5BrqiL1A7U5uSJQjfvEC7iIonwGlKaIaQuufl8af
         EjZyCckRj2y625OiVX8Ij8rCWHRhtIP/ZU9avmw8oRF44DEJvjDRvc5OIiWtHBn6Dqv+
         rCGg==
X-Gm-Message-State: AOAM533UGry5p+VN0LBdDW2NkjEzCCgVpcvrpO2eiyCYI8gvOGxBk66Z
        3qaTkDWUrZNKWUrw724b2Z0=
X-Google-Smtp-Source: ABdhPJziPCzciczn2y/4FTjz4x6mjJD+Gzy7mktHg9TwS9MMNAJzyTxUOJaOSBGMid8RoMFzNtD8/g==
X-Received: by 2002:a17:90b:3b4c:b0:1c6:d91f:fbf5 with SMTP id ot12-20020a17090b3b4c00b001c6d91ffbf5mr32457230pjb.81.1649613065342;
        Sun, 10 Apr 2022 10:51:05 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm32283286pfc.3.2022.04.10.10.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 10:51:05 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/6] ARM: dts: qcom: apq8064: User generic node name for DMA
Date:   Sun, 10 Apr 2022 23:20:51 +0530
Message-Id: <20220410175056.79330-2-singh.kuldeep87k@gmail.com>
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

