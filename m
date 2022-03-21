Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18F4E2AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349395AbiCUOek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350125AbiCUOeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:34:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F6A5DA4C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:32:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j13-20020a05600c1c0d00b0038c8f94aac2so4236634wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XM3tuLIOLKuoFOGCnY9ldxq/B57btEuYeuN4M8XmqsQ=;
        b=k3TzaFkW2ITtzM+ipWQmPH7EIvZpjfq8tQXSnSYfYtORSg9E1JlqkSn52OEEY+PrGJ
         eJ51kHd9HhC8ydWL2YRSl6myblzxJc11I8wWFookSRr6345W6G4DRfORu+06YiMWO7x4
         q0tK2xPNaw9DlfxE1j10+xFxC8SHLabyQDjXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XM3tuLIOLKuoFOGCnY9ldxq/B57btEuYeuN4M8XmqsQ=;
        b=YdvhIhjIBMvzascYKHr0YYN59mReAta/khGoBZFFVXCmF5AT3jOiw2PUSgmi+0Zl60
         9+sFoAtwLYANZEGeQGJjAI5JrQ8vck4YxXIhYcTaYPq0Cia3gCuPJ4SPruyMZ7R5aLK1
         uM/SIAJexdqrJ5OLF6tdyPngBgB/dAyj5p+XoTiPJmW43ctc/fWaHfvel6B+GkNWfzzI
         CMTxvFa/Py/hlptK0xkijQ9jDePNbpUuuY3mNG3qGWr9LW1H2khvixbXdqGfJcx4gvzX
         6+upvQ6uTVbwXKXVAf9iIGxjfPGpvne3EtirT941/ZnFPCfe/9vXPgU4re96oI9Mzvk4
         sxtw==
X-Gm-Message-State: AOAM5324wd1Wnc/q/wuEn/hn0ZW0BcGQwbRyoxTbD9zAEEZ7bdVHmn+G
        d1xxdR183u0Q4u8w7XnZcjIgAg==
X-Google-Smtp-Source: ABdhPJzW2HXM8hROOAKovH/CzhxqdjaB32lrjzpcegwTpr9JvugZ7L0ibXz6TMnHAH/T+i8p9t2LsA==
X-Received: by 2002:a05:600c:5029:b0:38c:9768:b4c with SMTP id n41-20020a05600c502900b0038c97680b4cmr9940150wmr.123.1647873156559;
        Mon, 21 Mar 2022 07:32:36 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b00389efe9c512sm19092793wmq.23.2022.03.21.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:32:36 -0700 (PDT)
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
Subject: [PATCH 3/4] dt-bindings: update google,cros-ec-pwm documentation
Date:   Mon, 21 Mar 2022 14:32:21 +0000
Message-Id: <20220321143222.2523373-4-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
References: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update google,cros-ec-pwm node documentation to mention the
google,use_pwm_type property.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---
 .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index 4cfbffd8414a..2224e8e07029 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -19,6 +19,12 @@ description: |
 properties:
   compatible:
     const: google,cros-ec-pwm
+
+  google,use_pwm_type:
+    description:
+      Use PWM types (CROS_EC_PWM_DT_<...>) instead of generic channels.
+    type: boolean
+
   "#pwm-cells":
     description: The cell specifies the PWM index.
     const: 1
-- 
2.35.1.894.gb6a874cedc-goog

