Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0000653F245
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 00:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiFFWv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 18:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiFFWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:51:53 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81512AAD;
        Mon,  6 Jun 2022 15:51:52 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id y16so12990688ili.13;
        Mon, 06 Jun 2022 15:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vnL10i9b7RWVPFntTkTs63ETZHkZVU4m6YqQkxBLyPI=;
        b=Fo4V4TxJE8yaK58bV6lEQWEE+e5d6s6iIpWefgtcd35USpFJOPYRKkmC77JNqSjvQY
         j4Eocoa2i/PFX4LAy4f/ZVkgfl5zreqsb/nXp1fTSbhJjqwMnbSLNvn009hmRQDz2pOl
         NsctmPgw5sISeKxhk+q0IGaTGdcS7e1c/3dQRLdaB5R8OPhqTg2hcymem4olI+AfMj7W
         WNYnImjhvGCqZf3eUMbEcFKaMfHnS2oPcuG76KtN2i0+RVDqamvb+dDmsK47nhUgqdtO
         RQNUbFQInjd4MZ+vBQRi0MLDf7oWLDx1VMip5Jw56/kYP22z8L1wkVUaZah2mGHmpRf2
         MRqg==
X-Gm-Message-State: AOAM532/ktpMSWOKbWSN6imwKHLF749lnUMnJ/VddIVMOEcoXTb8RWNz
        ujX0sAumV9TNnZmO3euuIA==
X-Google-Smtp-Source: ABdhPJyAQUX2H8fc0GojDtjC87rM9lUE0xrU9ZS9ZA5TIL7KupIiDXA9szJb+jy1xUCWw/NBrpswhw==
X-Received: by 2002:a92:cf52:0:b0:2d3:afc7:2379 with SMTP id c18-20020a92cf52000000b002d3afc72379mr15153701ilr.310.1654555911895;
        Mon, 06 Jun 2022 15:51:51 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id d18-20020a056e020bf200b002cde6e352d4sm6644019ilu.30.2022.06.06.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 15:51:51 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] dt-bindings: Drop more redundant 'maxItems/minItems' in if/then schemas
Date:   Mon,  6 Jun 2022 17:51:36 -0500
Message-Id: <20220606225137.1536010-1-robh@kernel.org>
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

Another round from new cases in 5.19-rc of removing redundant
minItems/maxItems when 'items' list is specified. This time it is in
if/then schemas as the meta-schema was failing to check this case.

If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
same size as the list is redundant and can be dropped. Note that is DT
schema specific behavior and not standard json-schema behavior. The tooling
will fixup the final schema adding any unspecified minItems/maxItems.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/nvidia,tegra186-mc.yaml        | 3 ---
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 1 -
 .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml  | 1 -
 3 files changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index c7cfa6c2cd81..935d63d181d9 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -150,7 +150,6 @@ allOf:
           description: 5 memory controller channels and 1 for stream-id registers
 
         reg-names:
-          maxItems: 6
           items:
             - const: sid
             - const: broadcast
@@ -170,7 +169,6 @@ allOf:
           description: 17 memory controller channels and 1 for stream-id registers
 
         reg-names:
-          minItems: 18
           items:
             - const: sid
             - const: broadcast
@@ -202,7 +200,6 @@ allOf:
           description: 17 memory controller channels and 1 for stream-id registers
 
         reg-names:
-          minItems: 18
           items:
             - const: sid
             - const: broadcast
diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index c79639e9027e..7a2b22dd6d05 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -145,7 +145,6 @@ allOf:
           items:
             - description: Xenon IP registers
             - description: Armada 3700 SoC PHY PAD Voltage Control register
-          minItems: 2
 
         marvell,pad-type:
           $ref: /schemas/types.yaml#/definitions/string
diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
index cbcf19f51411..ed6c1ca80dcc 100644
--- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
@@ -64,7 +64,6 @@ if:
 then:
   properties:
     clocks:
-      minItems: 2
       items:
         - description: High-frequency oscillator input, divided internally
         - description: Low-frequency oscillator input
-- 
2.34.1

