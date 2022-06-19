Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E999550991
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 11:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiFSJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 05:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiFSJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 05:53:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6141BFD07
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 02:53:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a15so596761pfv.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 02:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fjP9Be4hnegvsgOyWKGbkMNBDmKFNmzp11PphlEg+I=;
        b=TyGlyA6041iqq3nmsynOTfJ21vEfUvDYCG4nSwbrENb4R/wm4mKgHSJhZomtxv5MwJ
         vEC3hgZrSrypBzETpsbBjyhi+gFB50/DBY5Iwp0MB2kUmSPXxiU2I0B8UesLx61Nd7Gj
         +/kHxoFNHBpp0VyXgbT0IdwmPtCUm+uijFxBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fjP9Be4hnegvsgOyWKGbkMNBDmKFNmzp11PphlEg+I=;
        b=cAXEJl+84RKuR1LYqo5ekOBo0E8Hc6Wra1q0ZancrQf5PLa5BtK78wY4PQP/e0w82V
         ZgaIl57/lh0zy54yzly8EUFeyKChp3j4ZMadrh4Iu9XQJApon7v+BwtycSFk40mvj5H8
         5fxZO0QGdAwHj/1mYUQdepA9mgRp7HB0hq+rJoFG4g+OWyNR2wq1WW0XEK4qB4vj+J3I
         U2Su+d+m91nUNUbkBf8N/95gfED62ShminEuNCW5QZ1l8L4Rk5twwskVrqxgNJu5w9qR
         BT6xvjjrTUgan8ONRbxD5i1iWeeY8J5l31/MbtTwMKP+Z3X9A04+aXiim2ANt21C0Msj
         skdA==
X-Gm-Message-State: AJIora/mm3+pEHbeTb/1KW0WKQbPqu/Mjvv6F2F+xLInPC32V7cHIW8J
        2rSMxxeh02cOcjxrz0tWsA5NDA==
X-Google-Smtp-Source: AGRyM1sE4ddG0U8OSTKG5E7HfKRJdGT18RC0WV6uVpoOpoAIl/cjFPO7PDHNBgm+VZoiSBuDSBih7g==
X-Received: by 2002:a63:d94e:0:b0:408:9aeb:c55f with SMTP id e14-20020a63d94e000000b004089aebc55fmr16482677pgj.287.1655632422791;
        Sun, 19 Jun 2022 02:53:42 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id 135-20020a62178d000000b0050dc762817esm6799971pfx.88.2022.06.19.02.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 02:53:42 -0700 (PDT)
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
Subject: [PATCH v4 3/3] ASoC: dt-bindings: rockchip: Document pinctrl-names for i2s
Date:   Sun, 19 Jun 2022 09:53:24 +0000
Message-Id: <20220619095324.492678-4-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220619095324.492678-1-judyhsiao@chromium.org>
References: <20220619095324.492678-1-judyhsiao@chromium.org>
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
2.36.1.476.g0c4daa206d-goog

