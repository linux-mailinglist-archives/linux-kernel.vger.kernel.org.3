Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BC654F05E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380047AbiFQEnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380007AbiFQEnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:43:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B04D5B8A6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:43:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g8so2922926plt.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fjP9Be4hnegvsgOyWKGbkMNBDmKFNmzp11PphlEg+I=;
        b=IZdqemgjM011t7qSaeazGC5ggc3b5p1NDSvXtc+PuYsJrlv/olkGHyV8kaSghNi7KW
         9TzKTQfhxWc31HVBifhIwFyTieKiEnksb0h9otWk5FFg9Xky6MpqgNSfBT8Am+60SFNX
         N/FsTDI5dlR673K0ktxd/t1h8azx7yqqJpME4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fjP9Be4hnegvsgOyWKGbkMNBDmKFNmzp11PphlEg+I=;
        b=JKc83O/3K7pundpNXKkUMlk1VECbEdmLjgEhqmOE+oARfKlyVWcNtowUPZBx/Iw2kP
         k/11TURZjWy+UinyJYr8bqwq9z61aOoe6JFomc5jFMCre46/YDNweXc32qQQ8Pf64MtI
         EAXa9sfJVvdBMONALT4h7oaaTEYAn7v5GU3WXqxvgmpirXXZ+h0iq89GXLB769yjpuj0
         1syCHAwD7cL5sUaE1THFoE95q0LkkmiA1OWSKWRe4wDU8pA+YIUH4UFmMGFTrXw5dN9E
         niPSZj3SG0PU3sIOLvid6ChCFzgE86JPWBAy0b7t3i/Ew6tzlGoSaL8pjmE2NYU8b6sc
         TVmw==
X-Gm-Message-State: AJIora+XwraJfnxFq9bdWFvk9xw8zueIJsYKi7nRSzmYqx4oipizr1j3
        ux3llUZaBPM/uM6Pq8JiQVZMlb6oASljwdKu
X-Google-Smtp-Source: AGRyM1vLs55QXCgklZT2ekRxVqDn+icjviHTpjMZkA9w+4RQE27UUTrD8lRbDtZ8X4JwMc8QXD9xGQ==
X-Received: by 2002:a17:902:9b83:b0:164:59e:b189 with SMTP id y3-20020a1709029b8300b00164059eb189mr7540998plp.91.1655440988545;
        Thu, 16 Jun 2022 21:43:08 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a778800b001eab0a27d92sm4491030pjk.51.2022.06.16.21.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 21:43:08 -0700 (PDT)
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
Subject: [PATCH v3 3/3] ASoC: dt-bindings: rockchip: Document pinctrl-names for i2s
Date:   Fri, 17 Jun 2022 04:42:51 +0000
Message-Id: <20220617044251.4029697-4-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220617044251.4029697-1-judyhsiao@chromium.org>
References: <20220616155836.3401420-1-judyhsiao@chromium.org>
 <20220617044251.4029697-1-judyhsiao@chromium.org>
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

