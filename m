Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D164FAF67
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiDJRxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243762AbiDJRxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:53:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC5E4B426;
        Sun, 10 Apr 2022 10:51:09 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s21so7693726pgv.13;
        Sun, 10 Apr 2022 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5Rv+dmEkw/2qllLfPwnoJL+bLGrLkW6dy1dyuOIpRM=;
        b=PAf1bKnJOZ+hLUscKQGGW7SE2fqyi7Z2Kgh2JVFIHFFOYoKvroFmTJZZF52kKWTkHy
         1t6k/wZHZu/yncLKC5nMQBjFwi8SiLAtgrQKjnqfuo7/zfedriDOcih45G0LZEwf2/H8
         sDkkhhQJg6PUUGRFhcXNQ+jWgPYxZRlNLX+SgZR0F2M3RRhZXucAqgx4TxoRn2+zvW2m
         tuY9fHAPjFuoiN8atYCt3R4N1r2cOPmocpkCo/iDkcCbxg1vtkHNIelBpEjrVdn0IdyL
         veDEJJvtukMRoo7agwF5yUmDMqPRkUUGAh0hD3tKS4OgQhksOW1SbGneYOSpYSIrLEn+
         R3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5Rv+dmEkw/2qllLfPwnoJL+bLGrLkW6dy1dyuOIpRM=;
        b=Q65yh/lSmRfc/+ygAr+aXz4U9NZ/1Z8jg0Lq+Pw+eldqMBD6zqGFnkLdePYQQxKBYK
         c+Tz6oepkG+CBy1RU4m6X4hwcXWPeUKfCSRYsEU7zt9IpIGkfU1qRjJIrx7pHzkR0aGP
         Wnw+jjhjxswfN+v8ZKbBoMU0aAfZnIrY8nhFvtpBkiWBWtFPoLKRUbLQsngi+vabkxDU
         bV466Km75mXqhetAZ474JQ6hOvstqjLFDO1zS0IXW8HAC0SpQzLsl77W0wcVg18qtlU8
         v0DdVr8L6HNIIL8uA+hYoxE3mI283DCU8z6nllGjiFZLw+a5rwB4SmpIQZ27rWBUU5WO
         5ESw==
X-Gm-Message-State: AOAM531xbdbChOyune+W5+tqvli3iaVPIsk7DWGT3AW1jEZYDW3MXT4V
        hKhWq94i1t4M9IMk+Kc3iI4=
X-Google-Smtp-Source: ABdhPJzk+7L+8RDNaREBrMnqNcGeiGQriLP1+P0u7XWR0N61TZ08jmAzNvH6SsijPnAY0e19z5CuiQ==
X-Received: by 2002:a63:fb01:0:b0:398:bb8b:5796 with SMTP id o1-20020a63fb01000000b00398bb8b5796mr23186379pgh.351.1649613068406;
        Sun, 10 Apr 2022 10:51:08 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm32283286pfc.3.2022.04.10.10.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 10:51:08 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/6] ARM: dts: qcom: mdm9615: User generic node name for DMA
Date:   Sun, 10 Apr 2022 23:20:52 +0530
Message-Id: <20220410175056.79330-3-singh.kuldeep87k@gmail.com>
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
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 4d4f37cebf21..8f0752ce1c7b 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -330,7 +330,7 @@ pmicgpio: gpio@150 {
 			};
 		};
 
-		sdcc1bam: dma@12182000{
+		sdcc1bam: dma-controller@12182000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -340,7 +340,7 @@ sdcc1bam: dma@12182000{
 			qcom,ee = <0>;
 		};
 
-		sdcc2bam: dma@12142000{
+		sdcc2bam: dma-controller@12142000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12142000 0x8000>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

