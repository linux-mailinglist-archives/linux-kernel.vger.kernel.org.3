Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330A64F89D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiDGUjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiDGUif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:38:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92944986CC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:25:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l7so7803592ejn.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5DcEA8Z0O2xixy7S+Gv+babh7z8J+LX9GCrQBr6h0U=;
        b=DlB0ROMvXM2dZGF+yoBoSFO3s5uuSbLV8zc/1NhqvKuYlX7z/jDU33Yfgo7NAeXH08
         FXnefyJz5mTFNl4md96p4U6kF/X5RRuC1ZXWgDWvQKSd70nJPBhMMLu5Nl+tVoR42X/n
         FX9d/t+Y7/HGLaXjyChiZKyXsxnkqiP3BuOa7xYEnscdlDVEWxKD9C8Ef/m1Mqp8m6Ty
         ExMvWZs19U7KQLK5ji/N8WRQskcKHZ/IlXwCjObekv5l11XTT7yic8elw3qZbhXJwDCU
         AHiBRZYwqj+3oaYTogkihsdJ2QVdc6fua10qnsfSP4+Ynj4BMBncH47OK7MVLjetRwGS
         Ka7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5DcEA8Z0O2xixy7S+Gv+babh7z8J+LX9GCrQBr6h0U=;
        b=GstZdXJHPMprPSlYjFa2AJQ1FaVly0wAxVeAKw51ICZ9ilG3uSoVg08fRg0MhYjlVw
         BDViQxXtFbykU64nSY0OEvq60pi5jdjUGqCRAKr5luvMfCbHYk2Ebgd8nflzkZinFOpL
         CkLtVMAEpN8/Fm5FykeAsqHRGiYoSTcVmFcxmD01gzUHToa33zrc+gRk5N3zystV98sg
         r1F85M3L0IRWd/MZVk/0HGrXlGPKJ/MK/id0Bzw9YDlmdh8IqOA/d+CcGnwKGc9fbyAE
         PUXVY0Wp5DC4JTJoZVta+shlk6EkYa0rVFjfrZXupWihg9HPZIMOWViFwJHHbAK5X/gl
         kHcw==
X-Gm-Message-State: AOAM531bcA2Tm9Aa5CGQ6mPwV4YqoXbJwrqZbYNfkNx6bwpxXbdfu0aQ
        ypsDL9u1ZYqnI0+gJGoBntkc7w==
X-Google-Smtp-Source: ABdhPJySFWuAOomrFtAf8GkaK6FTLwIionDZt0PoDHUQaKsrZabjm7SqIvbJZZE9f5tcb08qDmyEow==
X-Received: by 2002:a17:907:2a53:b0:6ce:e4fe:3f92 with SMTP id fe19-20020a1709072a5300b006cee4fe3f92mr15034361ejc.389.1649363112192;
        Thu, 07 Apr 2022 13:25:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ka6-20020a170907990600b006ce54c95e3csm7971189ejc.161.2022.04.07.13.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:25:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] pinctrl: max77620: drop unneeded MODULE_ALIAS
Date:   Thu,  7 Apr 2022 22:25:09 +0200
Message-Id: <20220407202509.23228-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/pinctrl-max77620.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-max77620.c b/drivers/pinctrl/pinctrl-max77620.c
index 1ee94574f0af..ab723ab4ec1d 100644
--- a/drivers/pinctrl/pinctrl-max77620.c
+++ b/drivers/pinctrl/pinctrl-max77620.c
@@ -668,5 +668,4 @@ module_platform_driver(max77620_pinctrl_driver);
 MODULE_DESCRIPTION("MAX77620/MAX20024 pin control driver");
 MODULE_AUTHOR("Chaitanya Bandi<bandik@nvidia.com>");
 MODULE_AUTHOR("Laxman Dewangan<ldewangan@nvidia.com>");
-MODULE_ALIAS("platform:max77620-pinctrl");
 MODULE_LICENSE("GPL v2");
-- 
2.32.0

