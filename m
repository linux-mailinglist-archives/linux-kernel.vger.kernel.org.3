Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B95859525C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiHPGJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHPGJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:09:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F832F7F86;
        Mon, 15 Aug 2022 16:48:35 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i18so3458307ila.12;
        Mon, 15 Aug 2022 16:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=GnjYZoPrOvqe0tvfDPHrHG6WFLEYg63zoMdPDc+FwkQ=;
        b=pebHBj1Fh9oMsZP4JDQnEsell1or/JyvS/qrqEwn3tPv6bLnLeUktS1AQuN0/gvGrV
         xF8POsYz2iMVJVb/4vUmpV+B9TT6Ex9Ki4Qz8X+Jqzx+euVlmOTrZJ8BnKZWVy6kFiWQ
         G7QuM9Pr+EPYYokoLWQvr/gnFxgrm874Og0zi6hwYGI04C+jJPr73Lodjv1LELmLaGum
         7xcvcYvdENFe/HbDcUTzrkiXjz9BnnrxIGP2H7Hno3BHIeSzFPX2c0UgMqJpG3jX34FC
         xsUsF0VF0AZa84HKhV8SVcocW8lzU9qW6XNq0ieWU+uSxXfx70cde/5740FPybhwtJCB
         s6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=GnjYZoPrOvqe0tvfDPHrHG6WFLEYg63zoMdPDc+FwkQ=;
        b=YTeXBfiq76czicCtLeMLKDSwf2I2lfYTFkvGmO3/hhjTyf74ctIux18N0gLRivsB4D
         z11o5JZWmIX9CnNMdP94Ej2EDVr2Nc60srQa4D3KGRBS6s9CsnwSbpjHgDfEREEAQbmo
         OvcuG0UT+j5y3OZzF9dUZxXIujEESOmFuPgJU/CQ6Dq+FL59tmSNUUAIklZQPDSAmK0C
         v9T2453dVjZR519VDW3BEEWh8PjpwWFEmBkMZMAohsiX+5ufo6J8jPEsMF1saifMaxtN
         Y5zLTBreUKNjD4e+zriWb6skI0kzzf95eOePnYVhOfBCMP8iyC/5Pp2GK8n3upM/3eYG
         LfBg==
X-Gm-Message-State: ACgBeo1k+5SEbPHQcASUO1WO4fjXbEVFOh1fG+X6VlDzq/LAhuRT/QMZ
        YRVJFm5eGlvumlxCctW+lMY=
X-Google-Smtp-Source: AA6agR49+UWBtN/y8LyoFT9mWepPjC8TKlglg/6ksaHFoi/H320BSJVyfC6a9Z+/mVboLAcaMzYBgw==
X-Received: by 2002:a05:6e02:1a64:b0:2e5:cbab:bbdb with SMTP id w4-20020a056e021a6400b002e5cbabbbdbmr2494043ilv.268.1660607311351;
        Mon, 15 Aug 2022 16:48:31 -0700 (PDT)
Received: from hestia.gfnd.rcn-ee.org (208-107-176-7-dynamic.midco.net. [208.107.176.7])
        by smtp.gmail.com with ESMTPSA id c16-20020a92cf50000000b002e5f6199babsm439965ilr.38.2022.08.15.16.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:48:30 -0700 (PDT)
From:   Robert Nelson <robertcnelson@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Subject: [PATCH] dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
Date:   Mon, 15 Aug 2022 18:48:24 -0500
Message-Id: <20220815234824.772836-1-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This board is based on the ti,j721e

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Rob Herring <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 61c6ab4f52e2..ecb5fa9d4644 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -36,6 +36,7 @@ properties:
               - enum:
                   - ti,j721e-evm
                   - ti,j721e-sk
+                  - beagle,j721e-beagleboneai64
               - const: ti,j721e
 
       - description: K3 J7200 SoC
-- 
2.30.2

