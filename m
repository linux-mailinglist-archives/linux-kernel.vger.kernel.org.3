Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5925759075E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiHKUcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiHKUcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:32:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99428C00F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:32:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so22540855wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NRC10trzuqulg2mbWP7/9kZe6SgJG6yhrQ9QCsgz3RY=;
        b=XCutOpnPVVZAhqOaRWoHNzRAgMQx51l0/PCcMxYRlNOseA+OItbKcHJEKWbm+xLZ6Y
         1O3hD1vVHJ81uZVSSVt1e3UDPKJkaZS1SChDX43YOC61XGyLqDTk5IUVkJFcPLiLFdL1
         NvtfvEjj+pgrlyHICggcJiGSX6A7ubcIgUCSEE1VQyG76VLdbUYxgGMB5gpKj2gbwZa/
         nMdM4F3m7kJ7wIP7spW01DrV0sYRbHjF5mLuvv+GT5xwDiM1dyhYbyp9UzGHRdIB9RiB
         VOAVcTmrRjcjEY+F5lib/jjC21Rz+7G5QE2/aTsk/g8DKnF3iQxhtkP5+1kBsu2raXJb
         9bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NRC10trzuqulg2mbWP7/9kZe6SgJG6yhrQ9QCsgz3RY=;
        b=d6p3Lsmzo6SkTXC641ZHP9tSd6mB32nLNiCr+EN13V90FNhIbD9aYW7K74jXsGapQX
         9BGXFGbYU3RIxGyq7Y6OVC3mRauydGnz9/iCAg9/O8ncAJXcCuubuO5PN/aJhbELW0ED
         DBdLRIfkvufZk154RlOwI0R1jujEq21ZNr3AEZrLXtYj2YqFdkhrqwp06lEekHt8Wjlb
         mcHRDai0RpWeqxtZJgAQCy4dx8lNCK5z55apCmD9ga2P5d35KRDp1R7tDBxaRT+Vly13
         6FJW/sM7SdcsLfaPOcDxd9BsMnsNvzhLBb0GewuTxyeYZcaT6kxtUgPX9t5KFE4sYERY
         CO3g==
X-Gm-Message-State: ACgBeo3vwt8UAS/kzmQsty62yIkhp7QVA3/f5r8KFolWQ+3FwEsD1x0F
        zkEwD2i6Dv9+nChV6mZ3QAPyhg==
X-Google-Smtp-Source: AA6agR6GlDpUiPt5PzjH7aZTJbryfnMlgfg7zCpD/CJubC7Re1tH3mrv1P6fO36cNnFdc4wpXfFkbQ==
X-Received: by 2002:adf:e112:0:b0:21d:7195:3a8d with SMTP id t18-20020adfe112000000b0021d71953a8dmr333222wrz.371.1660249920196;
        Thu, 11 Aug 2022 13:32:00 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b003a1980d55c4sm8480521wmq.47.2022.08.11.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 13:31:59 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] dt-bindings: mmc: cdns: add card-detect-delay property
Date:   Thu, 11 Aug 2022 21:31:52 +0100
Message-Id: <20220811203151.179258-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
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

From: Conor Dooley <conor.dooley@microchip.com>

Upgrading dt-schema to v2022.08 brings with it better handling of
unevaluatedProperties, exposing a previously undetected missing
property in the cadence sdhci dt-binding:
arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: mmc@20008000: Unevaluated properties are not allowed ('card-detect-delay' was unexpected)
        From schema: Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Should this have a fixes tag? If anything, it'd be
Fixes: 84723eec251d ("dt-bindings: mmc: cdns: document Microchip MPFS MMC/SDHCI controller")
but idk.
---
 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 4207fed62dfe..99f89eb19356 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -112,6 +112,13 @@ properties:
     minimum: 0
     maximum: 0x7f
 
+  card-detect-delay:
+    description:
+      Delay in milli-seconds before detecting card after card
+      insert event. The default value is 0.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
 required:
   - compatible
   - reg
-- 
2.37.1

