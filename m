Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC494D39B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiCITQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiCITQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5519E811B9;
        Wed,  9 Mar 2022 11:15:23 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p9so4556303wra.12;
        Wed, 09 Mar 2022 11:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=giCcBvx2lbo0mKnfguv6SI99GvdvBJesRoU/g/VVqrU=;
        b=gefApEAROwKIXh7Vq4cHqfGjEZSrhtaQj5MoA4W8BVVxFnwe1xiPNqxRW50Kzy9jC1
         rg9+nkfTSQI3bAo/U4fRgPrpcF+KIqxWG9YXOSCds/OrRivRg+UZ1bwfX7BkKMNbpXY/
         WkIdQ90N2SzgcdeJuR84oIj7oDPMQxb2T2KSrrTCsDwbkW3tygIQ5ZkVq2Bs8tj/BQwg
         2VawBXXsRJ65vHBVOkWx5uiFLgukp/O/zyTfHFEsJjkKC4hQaPLeR8CufJlx2cNJFQPd
         +MPA97przQVEyMnbWZO+Yrl0P1dmkRUI9j7nXstfnaid0G4PH9vip97WW+IjQTDU6IMV
         dTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=giCcBvx2lbo0mKnfguv6SI99GvdvBJesRoU/g/VVqrU=;
        b=F9O1axCrvNQnOZ9h0A8lbKo+m+qCsl/1CBmQ/ObVDOvaYrJ48yikPMpjWpC79Bf1B0
         VFLsgkMszKiTNZjIcetoWhH51ofrDijqKAVsKFT6crCMDMNpQcKgFpC73n10if1+eemx
         ldq3vWeoCxe/e51qvsXVNihbeJIBsm9DpQqifrr1CPG2wGL3hnF6th3jjErFH44CbRjY
         O4PudhyTu2wVQ7unQ03FWQ+USiWP8ZbTPcxuC1fh7ANntNZ5rl5tVkzBUPQsfIlSsIN2
         Sx4VrFstXZQ/X+hdbf/kWEKdj43WDSHRgfeQNv74nvA+pxmJZ1bVnS3sRGfL0VqDuJqm
         RO0A==
X-Gm-Message-State: AOAM530Vfv8vS8l2yuwPI7qSBewbhmrPcSUHuGX5mMzYM5hWr2L3l0Wg
        vo+NaxVWdqC1gFNC6X1+7CTLCrvYT9k=
X-Google-Smtp-Source: ABdhPJxeSe+cfj5KlBD+hoLRLVnxYGkeHUTTkh6zMEtwL0RdE/AAE+GuNhZFVxsLreqY4RvFR3/qMg==
X-Received: by 2002:a5d:47c8:0:b0:1ef:8e97:2b8c with SMTP id o8-20020a5d47c8000000b001ef8e972b8cmr849521wrc.545.1646853321798;
        Wed, 09 Mar 2022 11:15:21 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:21 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 05/18] ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
Date:   Wed,  9 Mar 2022 20:01:39 +0100
Message-Id: <20220309190152.7998-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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

Add missing snps,dwmac compatible for gmac ipq8064 dtsi.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 0938838a4af8..9d658fcc1f12 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1075,7 +1075,7 @@ stmmac_axi_setup: stmmac-axi-config {
 
 		gmac0: ethernet@37000000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37000000 0x200000>;
 			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1099,7 +1099,7 @@ gmac0: ethernet@37000000 {
 
 		gmac1: ethernet@37200000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37200000 0x200000>;
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1123,7 +1123,7 @@ gmac1: ethernet@37200000 {
 
 		gmac2: ethernet@37400000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37400000 0x200000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1147,7 +1147,7 @@ gmac2: ethernet@37400000 {
 
 		gmac3: ethernet@37600000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37600000 0x200000>;
 			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-- 
2.34.1

