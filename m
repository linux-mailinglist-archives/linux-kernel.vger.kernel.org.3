Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4A250B0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444563AbiDVGx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354331AbiDVGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:53:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E2D50E1B;
        Thu, 21 Apr 2022 23:51:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i63so6601579pge.11;
        Thu, 21 Apr 2022 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4Wc8Q98GrLH2JXm1ijz0bJeEzM27gF1q86nt7x/XBLM=;
        b=ASqmtlDD/KkKoadlyOYAlU/GLfAkQQ41jNZy5WzV9yZG8Zex500C8IESu3O5O2VGx6
         ty+dmsslXkdyuh8ExxybTGiyOkpkl3BOZA4/7ZSaFBXTimkQ7WB8ioygfmMRQJVL7RML
         x+a5STN1uc6j2QndLGpc9rIkTFfVaiBDHhHZqHgemmCjbXmgF8btkjHj76jSqduaZScL
         7UH0LIN9FGqKvab3e0XXbFTrgXOi6RqQNjAQr4d9f/TgD/ipUOMsZt1ZXOltfJEYU6hM
         aBNCs+Og51JIAY9l2xnLCtoYAizg+0cBZXyJlQVulD8eepTzeLzC7IAAw5SVr1NvFM71
         yIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Wc8Q98GrLH2JXm1ijz0bJeEzM27gF1q86nt7x/XBLM=;
        b=kHo6KB3D0k8P1NNVD4J9eliGZMY5aAFVTfo+vU72czFBlzqz9Y7wd588lTqqG+gzZC
         ofNlXIpJweRc1zUZwUAQ2yA8xCLKDQlHaq/EO5PYgl02eagLh+0v9/4saq76sYp/foNN
         sbplVDyNkl4vJJzqQWMWokb+DxgMYeOeMfn9KkWO6waRiRT2CDzxrIClqinK/uzAY7Jb
         IVrekirNcNsTlthr7n3wRpboMtl+cHmQ0tD+apIqComLC8KHyxzee41QfHQd0Y6nLIuc
         sIxLmZXAqqiX03WQNozgIvDkGUj++K/rmbarqy2TVphakOWSYk3aO88VMykfhppcW6UU
         3hiw==
X-Gm-Message-State: AOAM533BtvothVwAGYVF6t2HBquKrgtTwRNq5ghXSSpW+Z7Hkrhse11w
        UItGVGZlMoxKf67b3vQVRwU=
X-Google-Smtp-Source: ABdhPJyTJ880OXGmAIQvY/NrO4RuNN659KKt394gk47rGbE53NnuDc77t2ly61CGqf4px6zLCJ93fw==
X-Received: by 2002:a63:d30e:0:b0:39d:ade9:ab0d with SMTP id b14-20020a63d30e000000b0039dade9ab0dmr2789836pgg.51.1650610263037;
        Thu, 21 Apr 2022 23:51:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:477:11a5:b8c8:12d2:abba:7a5c])
        by smtp.gmail.com with ESMTPSA id o11-20020a62cd0b000000b0050ce8f98136sm1251102pfg.149.2022.04.21.23.50.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 23:51:02 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org, cy_huang@richtek.com,
        alice_chen@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: Revise the rt5190a buck/ldo description
Date:   Fri, 22 Apr 2022 14:50:55 +0800
Message-Id: <1650610255-6180-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Revise the rt5190a bucks and ldo property description.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
index 28725c5..edb411b 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
@@ -58,7 +58,7 @@ properties:
         type: object
         $ref: regulator.yaml#
         description: |
-          regulator description for buck1 and buck4.
+          regulator description for buck1 to buck4, and ldo.
 
         properties:
           regulator-allowed-modes:
-- 
2.7.4

