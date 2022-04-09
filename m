Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDEB4FAA45
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiDISnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243089AbiDISno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:43:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29131D08F0;
        Sat,  9 Apr 2022 11:41:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a42so4642189pfx.7;
        Sat, 09 Apr 2022 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shhc4vVqv9l2wKwY0kN4Lkjnnu+qZsCnM2eNImBcqfg=;
        b=iZSijiySwMfAE7hJT5S4G0ImnvCP9t9jYMk17mCskyw2xogkmpGQPHoCcyJ26NZVgL
         BJBdJ2eMkPcR8HIScndhDdSDxWNxTeuI2i0UrPC92L93P5VKWH7waREbhBVjOk323kGu
         2mIXECyNTQbQztazHepnJFZti3/NN3+PFzYFZKJLUbUYkC4EsFZUwMbxhSPJnBWl/18N
         jxBT+wpxY3O62HyIm5M1aKZEOedrVsUtKofbrR9puiKr4vFrAludyaituvTDD68AuVLc
         iRkEETsI57wCjRUAz6mIWpKWPfvM4lZiye9YAkHOW1BaVv77DK7zXvb1aLNiS7pk7yTj
         CKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shhc4vVqv9l2wKwY0kN4Lkjnnu+qZsCnM2eNImBcqfg=;
        b=XGk3hfps+G3oCeSxd2PIL6sSak0yw+0PMvxpRjMPpoLzPbj4dInSW5xq9mP4yfY7Vt
         dfQ7Nday+FD6jkuBFkEvfVCtcWPBB3Afg4qZtUyu1WRngZxd3uNpLdsR7GSi+oGVsgJJ
         MfRfSQgNuSLk/Z69+dQyQb05bt2ts81DOkdhbNz40MZoHZtjL1yQMp5nYGUwb++gBpf9
         LFMngP9vhG0YyWgrY9qp0yg4AmTSz2btpP8DjEWtBeidUUfwNtz2sZLiyDymf+2FKpjq
         703hzrzL9tdU0TnVDwQtLMSSwW0Ufsh4Ct1ip4YmqVNk2gaDsxyVY68kZbjYwmZDVN4c
         QOrw==
X-Gm-Message-State: AOAM5338KrO8HBFTATRwo1fwKEkEaAv0ec7X5+ClbCOmkQIB//PLq6P5
        tIoPiUi7jEq6zjEUCKKtdwA=
X-Google-Smtp-Source: ABdhPJzxNKJtx7p/3OSvp583CZNP7EpTTJnlPbZ1GUvDN8gUSjIUcP2kF5IYG/dDYbc4Crmdr5X8wA==
X-Received: by 2002:a65:41cc:0:b0:380:6f53:a550 with SMTP id b12-20020a6541cc000000b003806f53a550mr20100322pgq.471.1649529695298;
        Sat, 09 Apr 2022 11:41:35 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id g3-20020a63ad03000000b003821d0f0ef4sm25813933pgf.71.2022.04.09.11.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 11:41:34 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: qcom: msm8996: User generic node name for DMA
Date:   Sun, 10 Apr 2022 00:11:12 +0530
Message-Id: <20220409184115.15612-4-singh.kuldeep87k@gmail.com>
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
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f0f81c23c16f..bbe677b9e5bf 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -707,7 +707,7 @@ tsens1: thermal-sensor@4ad000 {
 			#thermal-sensor-cells = <1>;
 		};
 
-		cryptobam: dma@644000 {
+		cryptobam: dma-controller@644000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x00644000 0x24000>;
 			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

