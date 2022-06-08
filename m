Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9434543E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiFHVMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiFHVMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:12:14 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC53DD444;
        Wed,  8 Jun 2022 14:12:13 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id 19so934089iou.12;
        Wed, 08 Jun 2022 14:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HaRWD8z4gtiDR+UJAlIS1Mths2quPGJl0a0O+AepzY=;
        b=qmQZB+VAtcqVJaA0zZ2zOAtjuI6o711He+7BQ9/QR4XnGiF4W7If+DEyHAQBR/8oKp
         qRZ4mjftufX7BkEDyTZmblV8kmLUZgDCWprfNF6wasOcv1E4/5MeoYozuAQ9Qs7UT6yP
         1Eks9igWt+MnNzBu8KY5QMm17+WlxeeDDmYpwRFJeEoqq6NRsiZUxbsECcNmEC0Y55Wg
         GcfsEk4MnGtVO1IZnK9/JM88fwhzngeyy1MnfQJB5x7miYPixlAxUduc17sJ+iTTd0NM
         JofE3LGmBIEtX5ijbnYBkBpmaav/sK75rE4iaoY1GHWubnT2PfZ0qC6svLPX4/ZGyZZv
         oiRA==
X-Gm-Message-State: AOAM530YIgce5boHcJXOQQUaEKyaSYYoYjSueswJj9mI/DCicv6/q/ul
        lg/n1tsfeZa/6ImaKDBT0A==
X-Google-Smtp-Source: ABdhPJyXTLq+RexBvmNn5/tWEsemPYz8jExcg1hDInixdrgLysfL/1ZAdt6iK7KyNNsMuDw9WMeSIw==
X-Received: by 2002:a05:6638:3474:b0:331:ca81:602a with SMTP id q52-20020a056638347400b00331ca81602amr6287186jav.88.1654722733159;
        Wed, 08 Jun 2022 14:12:13 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id v11-20020a02cbab000000b00331bd537addsm3295264jap.102.2022.06.08.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:12:12 -0700 (PDT)
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
Subject: [PATCH v2 1/5] dt-bindings: input: Increase maximum keycode value to 0x2ff
Date:   Wed,  8 Jun 2022 15:12:03 -0600
Message-Id: <20220608211207.2058487-2-robh@kernel.org>
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

The maximum keycode value for Linux is 0x2ff, not 0xff. There's already
users and examples with values greater than 0xff, but the schema is not
yet applied in those cases.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/input.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index d41d8743aad4..43d2f299c332 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -21,7 +21,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     items:
       minimum: 0
-      maximum: 0xff
+      maximum: 0x2ff
 
   poll-interval:
     description: Poll interval time in milliseconds.
-- 
2.34.1

