Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739D458ECB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiHJNCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiHJNCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:02:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D00D6CD00
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:02:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f20so21102738lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=K0mvUFS7V/RwPSh8F9kCJdOLQG8VGYNUewMvM4jhxKg=;
        b=przzxeN2c7jELSdIKjzEbd8C/UMZ/RjsCCTNwSja7CrRuObcj5Zi/R6OzOBjB7WEli
         pwYCCnVj/fE8+n3UPO8u3z8goG17bvTNWSseywJ6Seukzmi1xtSpvDO4CjkSQhjg2EEK
         bNGZxT2rs4YiRFtuTxV1rcf3L7DTeXlwQnR+yoBhZ6dn/6VSqb+15U85rsKH/wKgVz9t
         L7v2EUMgX/Jcl/8mxPrF69mBrgeRkK/3lQBYgjyJV2YYreaOvWVarLbScZ7XK0ondgNm
         Lw8k395ca/x63sXiP+EHVgQ6WGiAUTSGMf+88X/jvSKI+fPkZ8Lf4vQwdjBDA3ckZ+rd
         oPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=K0mvUFS7V/RwPSh8F9kCJdOLQG8VGYNUewMvM4jhxKg=;
        b=yO+wyAMdIUoaivDWpl7yo+Wr8RzrsLBpKC1Dp4HryEyl5JV1eidlQH86bx1T2pmewh
         YKzsrLfN1fZDYYp09pde2IXJTylrToU9/Jd4Hc2Zr6sDi/mYVX5DBgapAEHUkCL585+r
         CwewDx2ykdyh2Co00peARH71CFLGmEXt4+x9qTbeGxZdHiNk5vuY/t6NCF5GedDamnWY
         n6Nr8e1RHYySca92m6ExFNo5Kxuh8hIZh/KyZq920lb0STTkSG2GsrfOtlI/w/SIpQit
         SDb4kq9IRKHdp/mDSPaydWWdp5Cb78JoTfjugMkc5KhsuxoUUp/BZ43ev5/kJT8Y7A5F
         dFeg==
X-Gm-Message-State: ACgBeo0qdKu8lRadVCOnuy22J8Shf266zeLn0biXa1kGWaU7dwwOmj9r
        N9eOBrvqa69E1ITZ5Lp4Bh+P9Q==
X-Google-Smtp-Source: AA6agR53EctAfzH4J/soVyFmQmTw2vMLCNjKxJtPTHJd8y867AhsPFgowZipY1nCphjXCROS4enBMw==
X-Received: by 2002:ac2:4ac8:0:b0:48d:13c1:a8c9 with SMTP id m8-20020ac24ac8000000b0048d13c1a8c9mr2196654lfp.269.1660136534946;
        Wed, 10 Aug 2022 06:02:14 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id n24-20020a05651203f800b00489da512f5asm340694lfq.86.2022.08.10.06.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:02:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: am335x: drop panel endpoint unit address
Date:   Wed, 10 Aug 2022 16:02:12 +0300
Message-Id: <20220810130212.400371-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The endpoint in panel port node should not have unit address:

  am335x-evmsk.dtb: panel: port:endpoint@0: 'reg' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/am335x-evm.dts   | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 25c6ac9913d2..6e34161d327b 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -126,7 +126,7 @@ panel {
 		backlight = <&backlight>;
 
 		port {
-			panel_0: endpoint@0 {
+			panel_0: endpoint {
 				remote-endpoint = <&lcdc_0>;
 			};
 		};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 9c458e5a95b7..5b3278c0c46a 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -191,7 +191,7 @@ panel {
 		backlight = <&lcd_bl>;
 
 		port {
-			panel_0: endpoint@0 {
+			panel_0: endpoint {
 				remote-endpoint = <&lcdc_0>;
 			};
 		};
-- 
2.34.1

