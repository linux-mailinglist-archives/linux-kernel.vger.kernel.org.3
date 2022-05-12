Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF932524D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354022AbiELMtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353981AbiELMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459424E00F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id be20so6040647edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ADwZV9MCiaFxJJZiEcHrqujdjNo6qrms2LEfpU/gHI=;
        b=PFvdrNnXwl9nu+KiX1MZiA60g3VI/3cgK9ffJXtnjoyIFo+aWWLqlIz2wEI+9IJXRH
         97NRon/PgO4wVUAPXK05W0WIa6koKhhMswOevkSzkn4EjcDHwtxZAmf969f4Mqzwxyf+
         PhLA7TFu5FXdzeeJ58/vswD+1aJ2lHrSID/06RocdNhLcMJ18Y/O4DKEUCm8EVx3Orc8
         4n9mZYvDQ5ucdBRsfI1Q05cCdEmJfF3q8a+d1dk3+qufg3vG6OqmAIfD8Jqv/R1+hb8j
         jxAKlofC8+Ayu+Pp1RdbQsoD96PBsQUH6dmZQOxVSZMQi6sQPw6iskM22R682za3bco5
         EUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ADwZV9MCiaFxJJZiEcHrqujdjNo6qrms2LEfpU/gHI=;
        b=765uc7Lib/5gaGD4iCJv6Q5hzLMEcoX2Z/Y3X0DPOVXfv8ilHhtWeXVFNHJSHDNT6X
         UMm4DB2w3Adv2O7Iy1W4Y1/dZ+vnApMT47e0aJA/t5ecTBmQfNr4ALOJS7r7sUOi8ypc
         5d4Kym3o+0Eomdrml9ZZNy4hGOJOLGY2POERovLLmQycSNyChiUVxjEdPV7HMxgjjWnd
         RFSbCWx98wbO2TOjYAx8xlds3vizk4wQwOCp7+tcyBN/bFRpYa7E3dHCaHzIlsihPIVL
         mO5kRjpBAoHybdrajuZ9SNF71xNNKYBYDk3QvFmUfvhCQ1y93FAdClvUiosxK5LyEJtT
         iv4g==
X-Gm-Message-State: AOAM530YeWezbBtQgXaRl/S+959UKNk7xjjLuFmooWKpKIgaVv2Q48CQ
        PNQ1CIYCaPnCQbtUbpw0SbXG6Q==
X-Google-Smtp-Source: ABdhPJwV6fpHJAGCTW7VjN1pW9I5wnImmn+B4Z9Rh5yb9zQU6kHaBPG7pnnrOtf9uM5Zo0DjER0AZw==
X-Received: by 2002:a05:6402:28b1:b0:425:c39e:b773 with SMTP id eg49-20020a05640228b100b00425c39eb773mr34284372edb.237.1652359761709;
        Thu, 12 May 2022 05:49:21 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-58.xnet.hr. [88.207.98.58])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906828300b006f3ef214dc2sm2109475ejx.40.2022.05.12.05.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:49:21 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 07/11] arm64: dts: marvell: uDPU: remove LED node pinctrl-names
Date:   Thu, 12 May 2022 14:49:01 +0200
Message-Id: <20220512124905.49979-7-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512124905.49979-1-robert.marko@sartura.hr>
References: <20220512124905.49979-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using pinctrl-names requires the appropriate pinctrl-0 property, otherwise
it is not utilized at all.

Since its not required, just remove it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index f216777acacc..b89c7455612d 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -28,7 +28,6 @@ memory@0 {
 	};
 
 	leds {
-		pinctrl-names = "default";
 		compatible = "gpio-leds";
 
 		led-power1 {
-- 
2.36.1

