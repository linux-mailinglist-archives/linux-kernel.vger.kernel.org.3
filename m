Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28054E681
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377687AbiFPP73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378079AbiFPP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:59:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7760F443E5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:59:17 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g186so1644851pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgrwewMce2rCEAP+XlA9uqVT9sKMIcKrgNTnswDM33Y=;
        b=j1+LKGPK//opsez1h3IZYLmloo+4hPEoxEk8xMICOmbOhqlBLGAMND2zjOoFyug2EY
         5w+Wt5QkKbiSzcJfiUrlZXilCZK7CzVdOKye1m0P35pjQXxCnDRhlzva6yupERBJDrHJ
         N5pZ4c/wqoz867w4DqOPA5KqOEfbKkO/oGYIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgrwewMce2rCEAP+XlA9uqVT9sKMIcKrgNTnswDM33Y=;
        b=U6DPWCZ8JvDdRm53jgn/ZCw+BlVZ21nNseyc/QKBJwZkXwYRaO8LB9WL2RQZFaB6qJ
         nBTBR81sLVUY6ZJlHAQa3JEjsc0KYqUDssF9fT4+PNYWb7Md9VvskLLwDWwiMgnlJDG4
         87yqgJQduQ0aTaW7EypUYo9rNuDL+c+q9i+xGsKOBvN8ysjvq5ovsdmXrTGIJ6qt5df7
         CpfYTbKT7AZdLay/QXvfXP93SsAqsHdDiNheueRoDQfcc+xjXseYt+yqNr9PxqOhMjPU
         xo+xUnfniYM4hKli99sZ5QEJRWBAM5fDGUmT+aoHgrR85LyIvKZb38bemsT0g+mVrpYq
         9gZA==
X-Gm-Message-State: AJIora+Qvk73YDvnJyiGn5jcLGCxtPm9ynUhlh/iwnP107snVvWMNimV
        USVX+1oLdswFfy9JteudSyfl/Q==
X-Google-Smtp-Source: AGRyM1tJ4+JyFVVgPMz5uyUA7b8XnLeEV3bIK43Yl9Qo91NqaGe+fP3lYzpmcrF6e9DSJkwDcLQiGQ==
X-Received: by 2002:a62:b802:0:b0:51b:f4d2:65be with SMTP id p2-20020a62b802000000b0051bf4d265bemr5477983pfe.79.1655395156957;
        Thu, 16 Jun 2022 08:59:16 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b00161478027f5sm1779797pln.150.2022.06.16.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:59:16 -0700 (PDT)
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
Subject: [PATCH v2 3/3] ASoC: dt-bindings: rockchip: Document pinctrl-names for i2s
Date:   Thu, 16 Jun 2022 15:58:36 +0000
Message-Id: <20220616155836.3401420-4-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220616155836.3401420-1-judyhsiao@chromium.org>
References: <20220616155836.3401420-1-judyhsiao@chromium.org>
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
index 5ea16b8ef93f..af1069278623 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
@@ -61,6 +61,13 @@ properties:
           - const: tx
           - const: rx
 
+  pinctrl-names:
+    oneOf:
+      - const: default
+        - items:
+          - const: bclk_on
+          - const: bclk_off
+
   power-domains:
     maxItems: 1
 
-- 
2.36.1.476.g0c4daa206d-goog

