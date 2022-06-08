Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7046543E64
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiFHVM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiFHVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:12:20 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB853DF14B;
        Wed,  8 Jun 2022 14:12:18 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id q76so15042036iod.8;
        Wed, 08 Jun 2022 14:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzwWuVv9AqTLWVtStbX2LS3E3fgHtoXib1oocMgrURQ=;
        b=F604PbYyNtTl89Am0wPO6CcE418aEGHzrc6WtFuNBNKagsc4wyBPfijZVnldHXKmDe
         m7aMFWiSt3RI7VWBm3SZ8PeN1X8NAR6F92RhHJMFpHTwn+OadVUWlug7huqyWoRKtheF
         KfyCyeN8ukxvcwlMCh2pNuRnOHvwLqt9huyH7cv2i2Ts7hOVN2r386Paxu/0BZnAHlWR
         7/FvFwmyeDvCg9qZrtdxXJVk+8Bd8+8uk6NiJKUMrwvpxyr2TZqgUJLgkjF50WmEGUQn
         Dh/1Kc4qwcbtQKmIgWIuQxG9p411NS9xzeqJmEhOD8Hht076JBtbLdvNQBPlcXExHFIN
         tc3A==
X-Gm-Message-State: AOAM533YpoaSaiue/AtQAEcnmcBogC/5VwvOo+HlOyS+XcFY9Do9EvER
        I4m9+UWHBx84+0TfnnoFBQ==
X-Google-Smtp-Source: ABdhPJwpRj0zZiou8o8oWuNJqEjO6BbP/VHHHjZl9JpcxeVpWwMPbvZIW0VEVvdcaNttthsKMvQ4Uw==
X-Received: by 2002:a05:6638:3289:b0:331:f7ff:b908 with SMTP id f9-20020a056638328900b00331f7ffb908mr1481718jav.48.1654722738100;
        Wed, 08 Jun 2022 14:12:18 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id v11-20020a02cbab000000b00331bd537addsm3295264jap.102.2022.06.08.14.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:12:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: input: Use common 'linux,keycodes' definition
Date:   Wed,  8 Jun 2022 15:12:05 -0600
Message-Id: <20220608211207.2058487-4-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220608211207.2058487-1-robh@kernel.org>
References: <20220608211207.2058487-1-robh@kernel.org>
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

The common input schema, input.yaml, already defines 'linux,keycodes'
property. Update the users to use it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/iqs626a.yaml     | 2 +-
 Documentation/devicetree/bindings/input/iqs62x-keys.yaml | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/iqs626a.yaml b/Documentation/devicetree/bindings/input/iqs626a.yaml
index e645521da8ba..008959f2d425 100644
--- a/Documentation/devicetree/bindings/input/iqs626a.yaml
+++ b/Documentation/devicetree/bindings/input/iqs626a.yaml
@@ -510,6 +510,7 @@ patternProperties:
 
   "^trackpad-3x[2-3]$":
     type: object
+    $ref: input.yaml#
     description:
       Represents all channels associated with the trackpad. The channels are
       collectively active if the trackpad is defined and inactive otherwise.
@@ -678,7 +679,6 @@ patternProperties:
           Specifies the raw count filter strength during low-power mode.
 
       linux,keycodes:
-        $ref: /schemas/types.yaml#/definitions/uint32-array
         minItems: 1
         maxItems: 6
         description: |
diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
index e677e31fe8fe..0aa951f0ab92 100644
--- a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
+++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
@@ -9,6 +9,9 @@ title: Azoteq IQS620A/621/622/624/625 Keys and Switches
 maintainers:
   - Jeff LaBundy <jeff@labundy.com>
 
+allOf:
+  - $ref: input.yaml#
+
 description: |
   The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function sensors
   feature a variety of self-capacitive, mutual-inductive and Hall-effect sens-
@@ -30,7 +33,6 @@ properties:
       - azoteq,iqs625-keys
 
   linux,keycodes:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 1
     maxItems: 16
     description: |
-- 
2.34.1

