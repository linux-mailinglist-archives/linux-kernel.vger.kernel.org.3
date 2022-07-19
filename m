Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5110857A97F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbiGSVwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbiGSVwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:52:09 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12DF64E18;
        Tue, 19 Jul 2022 14:52:08 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id v185so12937862ioe.11;
        Tue, 19 Jul 2022 14:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mroLFifN0SuvCBf9OxTLXerBEW1pjfpPjFqUEPZmNrg=;
        b=2NBe09ac1Hrnh4qQLince3X5PgByggUBj/3poHp2oj3lFZR9c+A5+df9K2fXmvoKX/
         aOMes2P5mqrEio0G5+/4CriXEWfU6b0/VaLpDr1hGk1zxZ7eRMB1ovfokz6HdRCw1pBI
         y9BWZWsOp+/a1ICIoJJYlq3bufkbca0NXKogOU/i1jVe22F8c6zP/Ny7YSbcWvswWN1A
         6kAjj01GUXtTsLJmhDJ2uLPHxlwfPCqN8DKff1NSeaX2DZYFa9OyLdhfO5GTFVKGFx8t
         K/gMqI9ctpa2fvdRQIpJelnmwzDaaoDSejWR8AIc1fIb6uBlKclpKKUGmlgEgwuWBhJc
         o9ZQ==
X-Gm-Message-State: AJIora+RWPAS30MEnUJzHTW2I/hHJksxuHuRJ1DA9LSL0yAGWhJ7DsOs
        eLrS0uScPgHwhoA0RFZcSA==
X-Google-Smtp-Source: AGRyM1svemBsZn7xTQKlMXN78k/BH2idVDolBBdErL1IzE+EV4rpEff56gul9pMR648c2f8r4nQESQ==
X-Received: by 2002:a05:6638:22c9:b0:341:56cf:c447 with SMTP id j9-20020a05663822c900b0034156cfc447mr9866603jat.244.1658267527990;
        Tue, 19 Jul 2022 14:52:07 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id w7-20020a92d2c7000000b002dd0b0adee1sm95770ilg.24.2022.07.19.14.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:52:07 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Robert Chiras <robert.chiras@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: panel: raydium,rm67191: Add missing type to 'video-mode'
Date:   Tue, 19 Jul 2022 15:52:01 -0600
Message-Id: <20220719215201.1877997-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'video-mode' is missing a type definition and is not a common property. The
type is 'uint32'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/raydium,rm67191.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
index 617aa8c8c03a..d62fd692bf10 100644
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
@@ -38,6 +38,7 @@ properties:
       0 - burst-mode
       1 - non-burst with sync event
       2 - non-burst with sync pulse
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2]
 
 required:
-- 
2.34.1

