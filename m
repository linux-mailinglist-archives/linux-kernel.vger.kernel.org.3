Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692885570EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377806AbiFWCM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377675AbiFWCMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:12:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2976220F3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:12:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jb13so3329729plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LO7XuaEC/0vDNLbgeDoJilJKS3NWSolp4n621az3TKo=;
        b=YTdodIHecq0rIHPbOUNfMDsBOBFCCQZTpt8Mae1FUo/OzFM6XdXMJqT6FAiu7e9CXF
         PxEgtptDJcI0oMyWCxN8NsK8HX4VKQAnnRy7sEUIStaqxwAiGptBSPMulN6V+Gcit6n2
         NDv7VnHGcSOV1n6yNb6uEy6L+zlw+RJ1HHkXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LO7XuaEC/0vDNLbgeDoJilJKS3NWSolp4n621az3TKo=;
        b=m+4pcqRZjbFkc5U8VYrrsY6y220v5rP5GAnmpS/GS0SxcTmmpBW9jC8aE5zNmLbKJ3
         tm6udUUWTfpysGnhNrpVOFFDZOFftjOffKKU8bh5iH10POL/CUg6dtMCW60oOuPe1PU0
         LSfqotlewWQD2ogGojJCvBbihCGOGm6RnTQdZYOvOtM+vgm8vQsfUwO5CkcEIQ6HyRr6
         g0AOaDYB3iD4LlUR4PvbFfnIOatYRJqSOQAMbQX/uggm76sW7fGfEmYV32aBXOJnuHG7
         HJX9AGzeRpCDr8w9CUPAPuAKdaytIexs5VHsOOh1lnC/JWV38SDak18CDKwFAndRc7yG
         oMjQ==
X-Gm-Message-State: AJIora827/EkthGY65NnfRS5Gc4oCtSBnaoH+S093CpsRtxAc9LUgk+F
        osKe9lWlhMfUl92XUp13H9mZ7Q==
X-Google-Smtp-Source: AGRyM1vyoRc4GfoYYaOKyQJWI5gEHK7cxz3myYUl/C/h7waRa2CFuT2tcdE9FdsAox69KLspbd1rCg==
X-Received: by 2002:a17:902:ee55:b0:16a:5e4:26b with SMTP id 21-20020a170902ee5500b0016a05e4026bmr29350254plo.29.1655950337415;
        Wed, 22 Jun 2022 19:12:17 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902768600b0016196bd15f4sm6194000pll.15.2022.06.22.19.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 19:12:16 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v5 3/3] ASoC: dt-bindings: rockchip: Document pinctrl-names for i2s
Date:   Thu, 23 Jun 2022 02:11:53 +0000
Message-Id: <20220623021153.587423-4-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220623021153.587423-1-judyhsiao@chromium.org>
References: <20220623021153.587423-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents pinctrl-names for i2s.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
index 5ea16b8ef93f..7e36e389e976 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
@@ -61,6 +61,13 @@ properties:
           - const: tx
           - const: rx
 
+  pinctrl-names:
+    oneOf:
+      - const: default
+      - items:
+          - const: bclk_on
+          - const: bclk_off
+
   power-domains:
     maxItems: 1
 
-- 
2.37.0.rc0.104.g0611611a94-goog

