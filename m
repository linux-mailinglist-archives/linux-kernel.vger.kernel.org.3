Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811944FAA3F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbiDISnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243078AbiDISnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:43:40 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828531D7887;
        Sat,  9 Apr 2022 11:41:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 125so10599918pgc.11;
        Sat, 09 Apr 2022 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5Rv+dmEkw/2qllLfPwnoJL+bLGrLkW6dy1dyuOIpRM=;
        b=H9+MzW0mKY3xj41NdLLTEQ/q6evrrtdciLWM7d/A2Z589XCCWO6E9HtENhjLFrKHcz
         L9/26SZp7Y+wm7FioFNzgXBdt9f+08indGkuLIM4OOebjTfY3UawhLzJcZnJQLTGvxDe
         K9JU4YwCL5Wk5x3ShPCtqfB2KjDCnZqEneS9so/mb6/qPajxRt3NGuWUd/EHgvfCkruP
         F9HfEoPZcea2/gtxIKK321qINAVv2Kff99y0xuNioyuI9ncpUhHJrE1fHlxDsK0Xqo5R
         7dUOQ33WwsY3oXh39I3OghmhhRYTMWunvwDGQ+n1WIAQftrGv4PX1LtjaAuY9jZvyJLd
         b/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5Rv+dmEkw/2qllLfPwnoJL+bLGrLkW6dy1dyuOIpRM=;
        b=djT/NWDIkY2XWms65LyqTmG3jv0VmZtKIo9zPAyQ6tSND3T/6RJTz37S/yRRYVwS5s
         LnvkOjzep02JuDXO1ArxELETfSon7s+NrFXHeC9Y1mxdEvLAgqwnyU7z827c5U/bd7xg
         Ae4DblQO8WP7cZyZIetCKc4LZ4jLfndqSv9KmcOlZZ99p3J9m8+fafu/ZTrXblm/GiAc
         +n/ECHujBbZoGztTPT6qaM8czOmWci+m0AJOzIrUXcVkpkiLGlM58iFgK6I8o/vdLr+T
         J4037YywQh9fVthmqPbXWQlRdNy+fw/dLXX/NWqkN50C8N3TjEisTvjmdAy1ySzfNpso
         Ca9w==
X-Gm-Message-State: AOAM531DzXNAadHfoCBTh6Qer8YR+suUWo2y785S/27naJAX7BoGvtCO
        HA8UZVCfPoB4f95iuGnYk9Q=
X-Google-Smtp-Source: ABdhPJxDXxDG52tEEIdO0TJllV3NIGMV/FgXYy1k5aUJybBSwgFC7iBIKdzkzPoSbl6OkwSyNUQ1Tg==
X-Received: by 2002:a05:6a00:1589:b0:4fb:e7c:7c53 with SMTP id u9-20020a056a00158900b004fb0e7c7c53mr24879164pfk.78.1649529692021;
        Sat, 09 Apr 2022 11:41:32 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id g3-20020a63ad03000000b003821d0f0ef4sm25813933pgf.71.2022.04.09.11.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 11:41:31 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/6] ARM: dts: qcom: mdm9615: User generic node name for DMA
Date:   Sun, 10 Apr 2022 00:11:11 +0530
Message-Id: <20220409184115.15612-3-singh.kuldeep87k@gmail.com>
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

