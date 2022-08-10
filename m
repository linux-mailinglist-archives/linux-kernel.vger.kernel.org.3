Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0726D58E613
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiHJEOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiHJEN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:13:58 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CD676467;
        Tue,  9 Aug 2022 21:13:57 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x5so2676209qtv.9;
        Tue, 09 Aug 2022 21:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc;
        bh=7Z8E1tRy8DEO4L44K4+rES+Wo27HhEwi3F5Zd1Y62lo=;
        b=Omh2cHOc9YzBsiCv5UIi/fmV5MSwotRu0fgS64CeaZn640zaZByRqtRgW1f8abDe4S
         YgWmwwY6PwlhMaQTBNwnWlqtY4fNBYBGTe5cGKoezSij+hO0fXW+2Fo8I+kJxMTTlH6f
         vEcXI8VOpV6NwveWlSmXvaLHBATKJEL9yFuuyjbGdI1uNzH6MfI/TRh1ejIKEIGGTlPF
         NdZzskbkoT1zHMSiI0pJpujBvXKqE7PgG8CU7uGkpIhBjoip26ix6RBTULQM4z4PV0v6
         sTEjG41ZIlt4dU7gBXtqT63Jk1FovO4eUpzKFxn8fIIP9FBL7+bB+dPwEun79f2BKJ0q
         MMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=7Z8E1tRy8DEO4L44K4+rES+Wo27HhEwi3F5Zd1Y62lo=;
        b=GAXCJ3VKC1Lr/ACwGtP/PLH+18/SAIXJoj0DhcsVhnYGw9iyL9zqgWkLaUm3uKZYln
         /ahok3fVLGqG+yBWpVFNs2hyvukpbIm62lbhAkIsGQT/pjBLlNGEvlbrO2v2hN+Jy2zg
         9JfozyyKgX7j145VuCxuX7rhiRktkUdhmhJmBgGdQfPx01AgWnqqexBTeyPG6mZthnZI
         mx0k896bC71ZS8hrX2HrPqupIEs/5krsGuysfcVJdTUONBP3TpFA7saQlT0sibPr4u0/
         ZflnalZU9rueyWOtj0kA29gtdGFPVOxhTrggRF7oSWGwTz3y9t4NhB9Lq/I0kVqpcAvp
         4sNQ==
X-Gm-Message-State: ACgBeo2BAoI6qOAKOsuZctZMy2bvRFqQjGnSMSfx/t0+0Y5kansbTZm/
        OXhMgqD6tpvsXBpT80Yzpx6z6JOFYIQ2iw==
X-Google-Smtp-Source: AA6agR6waT3oAVnaEr8qa9BZnbHjoNMUkqD1Co1VFcDx22E7UewBgzLHIlEvdmIgk8KAATEoUYGsbQ==
X-Received: by 2002:ac8:5891:0:b0:342:e991:e89b with SMTP id t17-20020ac85891000000b00342e991e89bmr17813674qta.406.1660104836808;
        Tue, 09 Aug 2022 21:13:56 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-6802-6005-37b9-aa24-2dc4-90c5.inf6.spectrum.com. [2603:9001:6802:6005:37b9:aa24:2dc4:90c5])
        by smtp.gmail.com with ESMTPSA id bl9-20020a05620a1a8900b006b905e003a4sm13741422qkb.135.2022.08.09.21.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 21:13:56 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v4 1/2] dt-bindings: panel-simple-dsi: add Tianma TL057FVXP01
Date:   Wed, 10 Aug 2022 00:13:53 -0400
Message-Id: <20220810041354.691896-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Adds the bindings for the Tianma TL057FVXP01 DSI panel,
found on the Motorola Moto G6.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
v4:
Fixed makefile entry.

v3:
Fixed kconfig dependencies.

v2:
Fixed accidental whitespace deletion.
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index 2c00813f5d20..1b3d5e5acefd 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -57,6 +57,8 @@ properties:
       - samsung,sofef00
         # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
       - tdo,tl070wsh30
+        # Tianma Micro-electronics TL057FVXP01 5.7" 2160x1080 LCD panel
+      - tianma,tl057fvxp01

   reg:
     maxItems: 1
--
2.34.1
