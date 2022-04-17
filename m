Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCFC50498E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiDQVHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiDQVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:07:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E2A642C;
        Sun, 17 Apr 2022 14:04:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s14so10940304plk.8;
        Sun, 17 Apr 2022 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGAdiw65qzqJ1cwqgdfIhJjHOn5lTAvFaMzNi9jxQWE=;
        b=c8dOI8WZJI1QLe5gFptxUeWsSmdsmivIJD/SE9bO9ZPneMvwtDq3D9fFQ1jXsBP+Yq
         TMePEcA1BIbsUq1eYGOz+cGy5Ll6tZl8Py/r5yHLpFAF1Y+ExkYZttmErjX7ZKVTugPi
         Y3dXElnrE5ySHWAyh7h6JItUdjmSGrXYQUVIhEY5F6OjAsCwZCAFop+sFqKKnk6pN0FS
         /5iN1wG6oab/XzyipMQk2P9tw8fr8Q5Hlf2gXlh2+WuF28ULv0xIAddL1zEknx29vjwV
         PNABkoMnZCTyihzmtzPBJyRgQVZt+ArN2w7VHV1KSHP9o5g8qlYURcmL7BCWAiEVXPod
         Uz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGAdiw65qzqJ1cwqgdfIhJjHOn5lTAvFaMzNi9jxQWE=;
        b=qjQxCwsZZ4ALwg2wKFpzdBZWDCa+VBjdSWnKkTwBR94ZyJ+4avmetxt5COQCcFZ9gZ
         tPOXD19D7dYDSjtOD6SdJJTM6/cSqp4jmjOTohfRkhUBqGf7X6X3h1X1orV2nJmZO78M
         rQnqWA6ncdjhHepSHS3VLOxOe9aTiX/DT+6GUXiy6G7BL1yCvc2ys85eTFl5uoT6GA63
         bshMVDu36JGoahOTfLUipp4PWkolUuX0OkzG0WoUq+b0gKjouUmMenyyLtE+pPiSOV0I
         yG6cDhM3Wq2kPQqvwx2W/0JI81bUk1IxpPYa34eOzvdPQqe/lXg01H11n4WYSp6pPsTr
         NZQQ==
X-Gm-Message-State: AOAM533RHG42fNhUetKI44GP28UjAL7vnzvttDPK5tGiE5wUSjC/NZDa
        YKMxdmf/Yl3A0rgFuUn6DotbvU3X/f8=
X-Google-Smtp-Source: ABdhPJzqgBmDvALDXkuv5N/lzNy4J2h+stmzs5Oj13GX/Nkezo4QkuhFe8m1MCWdikOHnjkqpFuMmw==
X-Received: by 2002:a17:902:bf09:b0:153:99a6:55b8 with SMTP id bi9-20020a170902bf0900b0015399a655b8mr8080887plb.142.1650229495689;
        Sun, 17 Apr 2022 14:04:55 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id 137-20020a63078f000000b0039d9c13cd39sm10547711pgh.67.2022.04.17.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 14:04:55 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 4/6] ARM: dts: qcom: ipq4019: User generic node name for DMA
Date:   Mon, 18 Apr 2022 02:34:34 +0530
Message-Id: <20220417210436.6203-5-singh.kuldeep87k@gmail.com>
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
v2:
- Add more variants of ip4019-ap/dk-{01/04/07} for dma node rename
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

