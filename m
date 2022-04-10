Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D074FAF6A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiDJRxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243781AbiDJRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:53:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBB15E75C;
        Sun, 10 Apr 2022 10:51:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n9so12024201plc.4;
        Sun, 10 Apr 2022 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRP6qGpLfk1EoIVbDeJczyMIQsvjN+g26oB/RP0aaGg=;
        b=m7+fj8bR2inooztSXdWw2tRFR7mnASS84JTvNfYgd8Zw+Mnz7yU6zKHOp76ugZBYM2
         PX2xeaYEciDQgmK8PlQvjWRu2ZlFkRz4m0TuOguzXM46ln4sMMnDopiCDCdrHVzq1XzI
         P8Vyi2B3DMzlAo4xfgOzWnUwQkp5S1DOA3Y1N6/f+VBf3xMGsvlHgF+qUY+wdDMiVmJC
         VltxghRwZHaAt3joQCjvyp1665c6e2ywLkc+CW7QWjgncvwrUuOAIkW8ieLpKMCLJvuv
         m8BORucAKlnWYUJNes2Pblm1J2uSDAex2kM+jFYTFcuNmIedRlclRstOapWGgOHIOYMb
         YszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRP6qGpLfk1EoIVbDeJczyMIQsvjN+g26oB/RP0aaGg=;
        b=3cDTOMpzFMsFNzLFxicsi+X9WFa6kmlwfu8uQcbCUFDEJKY13hQb2i2l9X+nu5pCoy
         RPgv849RUt7iTwjp5z2+iVioQpxRHify9qIa+lSj4T3cG9aRTMEPi6ZKUXXLvH6wF8mz
         GavXWlNL8OoCyexfkrrIXcIfBIOtxIarju02FcXsF1cJJa9RdSRRtFexFBrl+AL51tUf
         gyyUmeD8EJ9KdiAYuQyqolAiIqQEgEyWnGju27LbvdnDrpGuXTW+cjXg61KlHXvWJWIQ
         err314GZ+KeTamTMb8CQYjCSNQLQv/Z+c4ArUFiH1Iz40Qi0yc/OCuQwgFBLLeresxNk
         h55Q==
X-Gm-Message-State: AOAM533xvpQSbdj/JYNxHVOTttZqR0JekErG4VcnznPUrK6yX+68k7DE
        hCz1f50azy32AULPEtkNU30=
X-Google-Smtp-Source: ABdhPJxGvwaZOGLg62Jtat960150HzJD9n+aNfLWaQDg5jyvwNhm9xudJ4+SXN9Jxb62CFb9+Gnhlw==
X-Received: by 2002:a17:90a:558b:b0:1cb:7cf7:7536 with SMTP id c11-20020a17090a558b00b001cb7cf77536mr5464334pji.168.1649613074780;
        Sun, 10 Apr 2022 10:51:14 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm32283286pfc.3.2022.04.10.10.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 10:51:14 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/6] ARM: dts: qcom: ipq4019: User generic node name for DMA
Date:   Sun, 10 Apr 2022 23:20:54 +0530
Message-Id: <20220410175056.79330-5-singh.kuldeep87k@gmail.com>
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
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi   | 4 ++--
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts | 2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi   | 2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi   | 4 ++--
 arch/arm/boot/dts/qcom-ipq4019.dtsi             | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

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
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
index a7b1201dd614..79b0c6318e52 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
@@ -8,7 +8,7 @@ / {
 	compatible = "qcom,ipq4019-dk04.1-c1", "qcom,ipq4019";
 
 	soc {
-		dma@7984000 {
+		dma-controller@7984000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
index 7a337dc08741..2a43367692fd 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
@@ -79,7 +79,7 @@ serial@78b0000 {
 			status = "okay";
 		};
 
-		dma@7884000 {
+		dma-controller@7884000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
index 94872518b5a2..0107f552f520 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
@@ -52,7 +52,7 @@ serial@78af000 {
 			status = "okay";
 		};
 
-		dma@7884000 {
+		dma-controller@7884000 {
 			status = "okay";
 		};
 
@@ -62,7 +62,7 @@ i2c@78b7000 { /* BLSP1 QUP2 */
 			status = "okay";
 		};
 
-		dma@7984000 {
+		dma-controller@7984000 {
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

