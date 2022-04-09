Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D14FAA48
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbiDISn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243083AbiDISnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:43:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1791E5328;
        Sat,  9 Apr 2022 11:41:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r66so10638810pgr.3;
        Sat, 09 Apr 2022 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bMmIQPCL5e+l7dlDIOHx2g7GlKBqwKdndE18CxyLT8=;
        b=oPV8cZ3dugqJvTm8GE56LvsPeG4IQKT9RYFmjrseVt09UuNHn9aZm2YquLiNnthFVw
         2mVspMctMvN3koP4ievop0wNjDFiuR56EAcPJ1ThjWyqetZkQjV4xEJ4iyTxRxU9+llN
         cGPQeSqUJtj/7twFIWJVc/7N/8YTcN3GprrSolGmJDsgzptiBYXS3Ut81AC8PHKdBTT2
         X8EEfU+JPY9zMKySN6JoIABaHJCSY9h6B+ErixPUUGj5kaM3xAfEN+9LNT/zMh08VaAb
         GzsaX0tTmDXxa4DSYa/yj68hzouSAzv50BFq6n8Ze6I+Dymeqpaze03x/YZVdghxENEr
         BL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bMmIQPCL5e+l7dlDIOHx2g7GlKBqwKdndE18CxyLT8=;
        b=gt1SL9FstEIjcRbedub5DCBP+6uJZabvg5fCyE8SHH9bOVnh+6hWmjfunWgUWOoUDB
         Th2SWf57UBxEi9h1ElBBt1eCLw0WRMqvkp21eRsoyhQdFE07EHsR8c0xeBRDVamln3pT
         BgGBQrCXrjF7WiXUi2mWE/zMijoAkr5pb+RoT+NQX6jDNt0LYU2i210QtqLTrEQ7da6Y
         PCPcEugzQLRVOlfqHzBfyL1iRxvpMJgJKxCduwcc3IufcgwMbMFOvabwrMF4WB75iYaK
         1Ngq1kCHgDSVZHhO93zvSFyLlxiYF6vW4bC3ANwEfyN+41zDCqXE9Ln7weJHwqfNFy0g
         SoYQ==
X-Gm-Message-State: AOAM533xgB1860YNt2Zmjp/dxgwXwrGFQjrFgNROIbQkk1/tSnT+PosA
        WnMYLdD3TRI5rfiZMNfrkJI=
X-Google-Smtp-Source: ABdhPJzBBqG49i2yOD6q8h9v3tCvR/5GwxbtzG5jxlMHyxosfNSNYpJkPnqEYK45cTy4tsRM5IDCUw==
X-Received: by 2002:a63:5710:0:b0:399:365e:5dde with SMTP id l16-20020a635710000000b00399365e5ddemr21082538pgb.192.1649529698639;
        Sat, 09 Apr 2022 11:41:38 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id g3-20020a63ad03000000b003821d0f0ef4sm25813933pgf.71.2022.04.09.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 11:41:38 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/6] ARM: dts: qcom: ipq4019: User generic node name for DMA
Date:   Sun, 10 Apr 2022 00:11:13 +0530
Message-Id: <20220409184115.15612-5-singh.kuldeep87k@gmail.com>
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
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 4 ++--
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index 0c10d9e096db..03bb9e1768c4 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -64,7 +64,7 @@ pinconf_cs {
 			};
 		};
 
-		blsp_dma: dma@7884000 {
+		blsp_dma: dma-controller@7884000 {
 			status = "okay";
 		};
 
@@ -89,7 +89,7 @@ serial@78af000 {
 			status = "okay";
 		};
 
-		cryptobam: dma@8e04000 {
+		cryptobam: dma-controller@8e04000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index a9d0566a3190..258510eb30fc 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -233,7 +233,7 @@ sdhci: sdhci@7824900 {
 			status = "disabled";
 		};
 
-		blsp_dma: dma@7884000 {
+		blsp_dma: dma-controller@7884000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x07884000 0x23000>;
 			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
@@ -300,7 +300,7 @@ blsp1_i2c4: i2c@78b8000 { /* BLSP1 QUP4 */
 			status = "disabled";
 		};
 
-		cryptobam: dma@8e04000 {
+		cryptobam: dma-controller@8e04000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x08e04000 0x20000>;
 			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
@@ -471,7 +471,7 @@ pcie0: pci@40000000 {
 			status = "disabled";
 		};
 
-		qpic_bam: dma@7984000 {
+		qpic_bam: dma-controller@7984000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x7984000 0x1a000>;
 			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

