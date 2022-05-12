Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353DF524228
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiELBjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiELBj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:39:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1661BD730
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:39:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso6474951pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7JY5OzjYLJW7Rr2xhfmPsDoAWZorsrA3jl8llvrg60E=;
        b=CkbH1Acr8lJ87fJOrQbgEx6SXYUoJXQllKefeIvEIVc9ckF4mlXxwIg7sw5ZIFZlSe
         KPJjJIAqpwQbuH7l4JyD2iVzLh5bvZm9hjLt26yPw3vUAfgk2aLAZbY8wpy01RPQ/lEc
         F8tgykp8v+d9SqCWc7+78bNTntl3w3Fp5AdDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7JY5OzjYLJW7Rr2xhfmPsDoAWZorsrA3jl8llvrg60E=;
        b=RT0KwGzCXmZBX7/zbid4ThS6BoYfMRT2ywBmf3bVFnnxL7QeCandL3PfiOeWEwI8ju
         D10MOCsInIIV7vln13g+x1kCpZ2PmFzHj3yi71nu6vF8rMfvmIcv+62D2VWmAitIr9cN
         vOWMDwyv1KcI79Q71l15eCY6qoHNgmHXmkUp86BpTMfqOJkrzCVRWGL6tjZbPvBVUrp9
         40c+/EQ18yChTyRyEILGpkX5TYeZ7Pn+2yx5fQlK+mIiFjP7/7A/eAUwqcPYxvi0HYn0
         8VrWQXP8V6vqSGplxznxemGESijXJ8dgC61pe84Iraqz4bjP7ZExIvY7rVtu7N3ct30b
         PSlA==
X-Gm-Message-State: AOAM530vX4VNIP/Ug9g/FoYKDiEfaScr9euK/ZbVRDXMXLx/K0ej8BPK
        jORpgkTpXjiC88ygCDwn4NKopQ==
X-Google-Smtp-Source: ABdhPJyMdRve7kEm91mSg9IVhIAWNGEF5IkkT0N0gEDCWsFRkKDNGC0YEfyDiZM6EpOoVX3qLxOpTA==
X-Received: by 2002:a17:902:f68a:b0:15e:b12d:f4a1 with SMTP id l10-20020a170902f68a00b0015eb12df4a1mr27586276plg.166.1652319564440;
        Wed, 11 May 2022 18:39:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:193f:f17a:ab0d:1f83])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b0015e8d4eb2cfsm2614766plg.281.2022.05.11.18.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 18:39:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: cros-ec: Fix a typo in description
Date:   Wed, 11 May 2022 18:39:19 -0700
Message-Id: <20220512013921.164637-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220512013921.164637-1-swboyd@chromium.org>
References: <20220512013921.164637-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 's/pf/of/' on rpmsg-name description.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: <devicetree@vger.kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Craig Hesling <hesling@chromium.org>
Cc: Tom Hughes <tomhughes@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index d1f53bd449f7..99eda9ab0651 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -61,7 +61,7 @@ properties:
   mediatek,rpmsg-name:
     description:
       Must be defined if the cros-ec is a rpmsg device for a Mediatek
-      ARM Cortex M4 Co-processor. Contains the name pf the rpmsg
+      ARM Cortex M4 Co-processor. Contains the name of the rpmsg
       device. Used to match the subnode to the rpmsg device announced by
       the SCP.
     $ref: "/schemas/types.yaml#/definitions/string"
-- 
https://chromeos.dev

