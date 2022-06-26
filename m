Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D1A55B183
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiFZL2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 07:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiFZL2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 07:28:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC312609
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 04:28:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fi2so13447327ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 04:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8+VYdQEsK9oOtVXodXHKHdWUFgAqKfNzP3Ab6GKk74=;
        b=NL5FIXKco+X7S1NGDtKwspPT3yDIPYsP5uuLTpejMFqQ30eFm/xXjJkNGCmjtzRDzi
         iUdAPFAlxDVL2ncVC29gXlc3m8lLtzy3tMlEH4fJ0B8JpB4jh0Tqh0/U6Cq1N+Yf+Caj
         BuaEZOzJhCY1uZqnt07yIRbyv0GuFL7zRgSwxbAirdTfrnASg5Al43VvyKTuz4RkvmE1
         J1+ZIz+zNT2teonAu2biFylKu0X/5APlNVsSgPsiuxA5OoHs3X1vaU5yVD8RVDU3aGHJ
         szCG6sltUQbz3F57hA/SnaTBOs5iXyq4b+k2lir55ZYgKJV2g42HguPoO5y+XAgGOFcO
         8qYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8+VYdQEsK9oOtVXodXHKHdWUFgAqKfNzP3Ab6GKk74=;
        b=L5HT9Il1pVernyNv7RV/dEXDRHPB0CrgVxEOf+Pue4NcA2EIHH1LS34CupXXIJWnWr
         W/KYmgBMrkw28YcJWYXTmoMPe4iYsWGLxcsTfP4cqRmSd9WxIZWg4slN/KFskeb5N/wT
         QZWbGJjnIFxPWjEvP+O/An5U/cMB1JLqutRwBGZ4RrbYWGsAT042dODH198OCPcr/9kU
         gF2WLup5RhWa6JQkeItElNoMegHPdK08eQuY1I22Lnu8qQNz9BdCKrh3/CztQIl0jnfe
         0T8+GFnRb8FDc5+cIKLfoHdcKDS4R2MKvCN9wFY06l0mSFsLMd5IZKVTefQW16vzNNOK
         T5iw==
X-Gm-Message-State: AJIora/mjGY4wyvWn7E6d4aqPBAWIG4uRWe5Y63P1QAHJHI6pAJSvFTy
        4RPnln110x51qjkWag7XJgowwA==
X-Google-Smtp-Source: AGRyM1swA7uRM6xN6H4QKad+1J4WMM1j0vRKwu+IwjMqIEGGBtItsY5zv+jk9FY/ZywX2fDZOIbSIw==
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id nb13-20020a1709071c8d00b006f20eb21cd6mr7498326ejc.568.1656242921917;
        Sun, 26 Jun 2022 04:28:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w2-20020a170906384200b00722f8d02928sm3721082ejc.174.2022.06.26.04.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 04:28:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: samsung: Add Exynos4210 SPI
Date:   Sun, 26 Jun 2022 13:28:38 +0200
Message-Id: <20220626112838.19281-1-krzysztof.kozlowski@linaro.org>
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

Document samsung,exynos4210-spi compatible which is already used on
several Exynos SoCs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index a50f24f9359d..ef59ff62e88d 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -20,6 +20,7 @@ properties:
           - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
+          - samsung,exynos4210-spi
           - samsung,exynos5433-spi
           - tesla,fsd-spi
       - const: samsung,exynos7-spi
-- 
2.34.1

