Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F1B4D38BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiCISZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiCISZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:25:10 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A94F260B;
        Wed,  9 Mar 2022 10:24:11 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q29so1693703pgn.7;
        Wed, 09 Mar 2022 10:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7o4bcq84ORiYQ44P3Igppv3qOw9Xfy++n8UKnpQvdoE=;
        b=FIqZORydqW+du2tV7iJy9KcKJKmbVP9y3NhVPbxpZ1rDGvWZ1tlHLuH0mgJmy3v1cN
         0j+dliGB4/itlgK38LCp4mERQk8uVDiLuFUWptm3A06F7+MP5u2f7HIge89Xw48VR9/Q
         PI3Fte8B/RRE54HP5tpf+tmuluXLkL29mBUrrVcAFtGYFjhpz/dhHMoVh8JxJ4L4Kdes
         Q3nxJnN429ESCvQgW9yvjnF4iPUGzin2ZFWyGUcYWDLIX/kuoJkdcOYnwJvcB7xiuLj/
         oAMLyAKU8Oo+Wrqro3NH9sRC7WdyhVyyxeFG+iYWO2uRJu4+Z+FN0/rTXcARWJDWKVfr
         2AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7o4bcq84ORiYQ44P3Igppv3qOw9Xfy++n8UKnpQvdoE=;
        b=P4vbPy5olajf3soEzeYaHZMsj4TKkcdeXTuZP82z9Iz5RDOzhMB9QvMD0R9p+FTkQO
         VFPsqSNnunlzCc6IehEKG70xlz1GPnM8TKBn5+lgF2Z1AuFXJVHp4EfBOH42C8OQBiGW
         919EkBdIqwi9C6jtTypp4w2GZgRz+YG/07N4sIDA8cSSt6z63pEOcaR3tXlZMBVrpcWO
         fepIQUgcSr2YGN1CXzbQJu7/W1gZPF7pXffSfCqL7f/xT1qwihfuUL+ifK5qSS0E0tqH
         Cf8BWUa9D6LjmpRJzk+3JPit96/1WyTcIxZq7mGwvCeZaZdAy/on2NzDWqD53mVzGx5x
         LQyQ==
X-Gm-Message-State: AOAM533moX8slg72rBAhCnQsI09gylYBlc8xcAl7hUUz7PicPfvGEss9
        C3oQT36TCpV+GJRkEZNxQAI=
X-Google-Smtp-Source: ABdhPJx+O/3dozyigTWZ7VTnoUbMeobLLlIDN6vSGIdftyJoPbnLjaYXdG2ByuCAHGBltrxl2fh92w==
X-Received: by 2002:a63:3c10:0:b0:380:37f0:7067 with SMTP id j16-20020a633c10000000b0038037f07067mr861192pga.254.1646850250958;
        Wed, 09 Mar 2022 10:24:10 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004f754dd3d4csm3950988pfc.3.2022.03.09.10.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:24:10 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Chanho Min <chanho.min@lge.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 1/2] arm64: dts: lg131x: Update spi clock properties
Date:   Wed,  9 Mar 2022 23:54:02 +0530
Message-Id: <20220309182403.12968-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309182403.12968-1-singh.kuldeep87k@gmail.com>
References: <20220309182403.12968-1-singh.kuldeep87k@gmail.com>
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

PL022 binding require two clocks to be defined but LG1312 and LG1213
platforms don't comply with bindings and define only one clock.

Update spi clocks and clocks-names property by adding appropriate clock
reference to make it compliant with bindings.

CC: Chanho Min <chanho.min@lge.com>
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm64/boot/dts/lg/lg1312.dtsi | 8 ++++----
 arch/arm64/boot/dts/lg/lg1313.dtsi | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index 081fe7a9f605..fa44e0b67400 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -172,15 +172,15 @@ spi0: spi@fe800000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe800000 0x1000>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		spi1: spi@fe900000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe900000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		dmac0: dma@c1128000 {
 			compatible = "arm,pl330", "arm,primecell";
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index 604bb6975337..b61b5e20189c 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -172,15 +172,15 @@ spi0: spi@fe800000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe800000 0x1000>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		spi1: spi@fe900000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe900000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		dmac0: dma@c1128000 {
 			compatible = "arm,pl330", "arm,primecell";
-- 
2.25.1

