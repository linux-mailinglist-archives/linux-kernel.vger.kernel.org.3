Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC9508A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379521AbiDTOUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380288AbiDTOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:18:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B45243AF0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:16:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c10so2490965wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VyFi3RjbNFKUo3ZLxTfgMzz806nFEyIt4P5XIW1sGc=;
        b=IwG4NwUNCPEDcMyIiQGUNlp6AiG5pqO+Qg27bSMpYfTT5GzQRyvAlaqbje61DHmBlk
         gjp4eCEGuyoZrFZufrMBb5lWs4IaehRzLg4Vz0O0swGOimwQKFQIcvvB53q9estyVu61
         YlwViewlGuBDgDQVlnKZ89Y+i5ziTz+fk6yC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VyFi3RjbNFKUo3ZLxTfgMzz806nFEyIt4P5XIW1sGc=;
        b=7beItB4XsdFzYD6WFT6LS0QVhQNx3ysJtAc7HWv+tRyVZ+YCJgvfvxDkcutGcjoCCx
         Fx2uvVAUr6+g9lwwc7EdjxMzs1zep712ISj8lXrU3wKRYl2PqksIVxPfm07j8ehwS1fO
         0v36xyIh8XbCxdbMHnHoWdLZDNqVLlbKUs5qFvUf2H5oFhTj1i7R7dPpEidm5V5DQY5j
         JK1/S5LR0b8h4MzRlU1kXs86dT8/qrLmfxN3rJiU62d3AOOnIiB7W/mKIaklP7K7OyZj
         t4C4/MaA3JmaM+ZbucEs+EsIVJXYSaFXPsAXbnWYiSBDi2fy5iavoZkXbX+yDJx1XGnK
         wyUw==
X-Gm-Message-State: AOAM5316rNrAZTXDjwoZz+j5rRiG94hZyMlKQ3SDgtgpg7ZYen3OkEhb
        A6/Yq/smnjNZfWRW6uEyuJEfPQ==
X-Google-Smtp-Source: ABdhPJwCPpU4h5O7ryUiZqPZo8a1m5XhV46nhkBy6UgMYfIAySWynMQVolOrMBh4C5OnIPP4ylpAtg==
X-Received: by 2002:a05:6000:1863:b0:20a:988f:e0ad with SMTP id d3-20020a056000186300b0020a988fe0admr11529721wri.572.1650464161908;
        Wed, 20 Apr 2022 07:16:01 -0700 (PDT)
Received: from localhost.localdomain ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b0020aa790a258sm12447wra.8.2022.04.20.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:16:01 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH v5 3/4] dt-bindings: update google,cros-ec-pwm documentation
Date:   Wed, 20 Apr 2022 14:15:55 +0000
Message-Id: <20220420141556.681212-4-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220420141556.681212-1-fabiobaltieri@chromium.org>
References: <20220420141556.681212-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update google,cros-ec-pwm node documentation to mention the
google,cros-ec-pwm-type compatible.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---
 .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml      | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index 7ab6912a845f..c8577bdf6c94 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -21,7 +21,14 @@ allOf:
 
 properties:
   compatible:
-    const: google,cros-ec-pwm
+    oneOf:
+      - description: PWM controlled using EC_PWM_TYPE_GENERIC channels.
+        items:
+          - const: google,cros-ec-pwm
+      - description: PWM controlled using CROS_EC_PWM_DT_<...> types.
+        items:
+          - const: google,cros-ec-pwm-type
+
   "#pwm-cells":
     description: The cell specifies the PWM index.
     const: 1
-- 
2.36.0.rc0.470.gd361397f0d-goog

