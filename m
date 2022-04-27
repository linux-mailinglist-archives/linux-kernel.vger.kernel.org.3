Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088E75111B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358405AbiD0Gy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358561AbiD0GyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:54:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246A4F47D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:51:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z19so796698edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9tXY7FD2xlJXeOyqnkyBzs+L6RjZzs4jMiP6VRkCYU8=;
        b=NrUAonw/vsFOjLJ+1Y+dvE4aXHpnoVxDX1cG3C4Uyk5LZln3yXe4wR/a22SVSzWlT0
         V370AvYav97L3XVdDvYtA8O70DCcEj4pCrdmvOplKW9YM1y/RB4hsPHh/Zo4GPaQLn8U
         wLCIJ2+GsPLh8o3YgcWtXN/OrmnVUJL+d2QEAHcZKVsdHTEZm2ADI6sN/3iehbYv76eN
         yp/O6YZH5WbP31GgaELb2ZGGbg4fZP6//WGnyzejqr5GJWy7N3EHzGlchyEqVOdfq2Xp
         VzPsEnY9gN/TEd4zC/qPyhfGGi92/cHwQxF+aiG+tctl6AdSmkTTZ70DgFaBcwiguCxm
         Gdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9tXY7FD2xlJXeOyqnkyBzs+L6RjZzs4jMiP6VRkCYU8=;
        b=Hlp/v9HXhybx/dkyd5HezVPl7z64VcvJTmhKMdpigi8iyh8nibgb5vsfvPw39pPuUm
         ZQjppxG3eRu+sGxSUjnmosoqhgR62Wz3tiQv0MwKeruGeaOMPFcdw1BqDzKxWW/s4Jyr
         M9vNSdb02vTVed/GiG5/frtTglAVbQAAVQ1nD69e+hoLHw0TwQz+E2cAR5rgcuXaIpNr
         9pQyHKWN/ggYDwrAb0rm/KLHmGD86oz7ox8/IpECmP0qbIQyerY/eeCFGLTtSF2L5506
         8CzgT5N1zogLnydpkaL3FCldu2z5Zyp/Bo+pDdrPGDmwXJ/+t8QYtph8lBZMqKEb8J8F
         F3dg==
X-Gm-Message-State: AOAM531yRAulEm9/Qh1doU1l9MSqs74n1KabGrTCHx/NpaKgm0cjNaiN
        jX1fEZbTI2QRJZ8+DKO/w+YzP11t53inmA==
X-Google-Smtp-Source: ABdhPJyGCnUiduZivOC1w+7W4FQfSyalfBDvYgNvHlMISTw50/MAjuqBwBinEq3sd88Xhclhi67tnw==
X-Received: by 2002:a05:6402:2214:b0:425:d6ed:de5d with SMTP id cq20-20020a056402221400b00425d6edde5dmr19544230edb.383.1651042271590;
        Tue, 26 Apr 2022 23:51:11 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709062a9a00b006e7ee7ad20bsm6303094eje.149.2022.04.26.23.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:51:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: mfd: wlf,arizona: Add spi-max-frequency
Date:   Wed, 27 Apr 2022 08:51:02 +0200
Message-Id: <20220427065102.109046-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wolfson Microelectronics Arizona audio can be connected via SPI bus
(e.g. WM5110 on Exynos5433 TM2 board), so allow spi-max-frequency
property.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/wlf,arizona.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml b/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
index 9e762d474218..0d1835c657a2 100644
--- a/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
+++ b/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
@@ -193,6 +193,8 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  spi-max-frequency: true
+
   wlf,reset:
     description:
       GPIO specifier for the GPIO controlling RESET
-- 
2.32.0

