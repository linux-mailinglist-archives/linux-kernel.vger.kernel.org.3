Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA978534843
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345824AbiEZBll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240750AbiEZBlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:41:37 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E6A5031;
        Wed, 25 May 2022 18:41:35 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id i66so603326oia.11;
        Wed, 25 May 2022 18:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F+JPAxTs3gGYuDktqiw/Mh4EKh8IPmJtNsO4y7/7FCw=;
        b=oG6NBxa7bFDAm30HbnRlicf0NQ0Uo2HNzeJneAs2cVsreHZCapxWES3abf2hvtNATL
         hR08TgMP9TG8Hb0VzBUbwhIvHj3xGQCvdPOoEFuRGMPdZ4DMvSikVO49l2Vj1SzY+X8q
         VJm//en96f/uxI4Oqmydaui2tFXoYa93CqbWxfH+6MBKVSGI9QdnG9veX1dK0V57InTo
         BO+wDNs7B8qYgjLtSbUoD37dCxsmIKXJEN8W7ud0HoMouLwsegu7HpiZU8SFem6G3eG2
         od+FmG4GhUd5FXqeWctGRPneFKP6lXxvfCXIiuey9UzW2HcmSJtRXwK+JTxF9Ok70EqJ
         Y+4Q==
X-Gm-Message-State: AOAM532A4LBrUDQDJ694fxW12F2/cI1eLNfMQe0br18fX991LRoK3515
        Io++ZHy/8evKhqGVQWJnkA==
X-Google-Smtp-Source: ABdhPJy3PzdlHkQKcyHFXOij/PsiSqwmD91DssTjABPxZ14g3ujTvYPGVo7+RVAlSnghG2aYIiB37g==
X-Received: by 2002:a05:6808:124f:b0:321:855d:5b19 with SMTP id o15-20020a056808124f00b00321855d5b19mr13287oiv.30.1653529294479;
        Wed, 25 May 2022 18:41:34 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id h16-20020a056830035000b0060b2972b503sm105573ote.64.2022.05.25.18.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:41:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: faraday: Fix typo in example 'timeout-sec' property
Date:   Wed, 25 May 2022 20:41:27 -0500
Message-Id: <20220526014127.2872254-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'unevaluatedProperties' schema checks is not fully working and doesn't
catch some cases where there's a $ref to another schema. A fix is pending,
but results in new warnings in examples.

The correct common watchdog property is 'timeout-sec', not 'timeout-secs'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/watchdog/faraday,ftwdt010.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
index ca9e1beff76b..6ecd429f76b5 100644
--- a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
+++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
@@ -55,7 +55,7 @@ examples:
       compatible = "faraday,ftwdt010";
       reg = <0x41000000 0x1000>;
       interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
-      timeout-secs = <5>;
+      timeout-sec = <5>;
     };
   - |
     watchdog: watchdog@98500000 {
-- 
2.34.1

