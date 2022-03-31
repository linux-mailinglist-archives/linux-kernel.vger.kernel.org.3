Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E654EDA09
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiCaNAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiCaNAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:00:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E036E1F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:58:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so2023576wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHj2yaKnS2M1KOdUTGiqnQ+9k0gkJHuJpJKOczjT4Hs=;
        b=Xbgbh+foEr2rAHw4Sr8Bfq8UUS3ZEb3koEM0QHWGI43FMcZA1mNn5JZofdILiXh921
         K41glotjEMpNwjS5ZjNMMdenGPwCBArY50eHWgD1Xc0jQbSXmf77g6irM1O6EfR6klgW
         nmHCF9hWbrtqOXjDQcH/5UGdrNwCYKrnavE94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHj2yaKnS2M1KOdUTGiqnQ+9k0gkJHuJpJKOczjT4Hs=;
        b=Yx+MMlSKKW+RqL4TuuYShFK6seUmPVy0Q08u1xTDfuFj4odPbxnkWSOMqImHTqheQ+
         p2q/LoypKOh63lrjVwLaqFRYoUus1CTN2ph/FSV6VfoB6wcO/zUtMcuzLKS3yXVm+dSa
         gpbiS05Pb0J07nQt7KB1xNW6pANniCXf0viWOLbHQ7DLNDZUJO6CzvCYnRJ5m0hhr7Oq
         TxneiQaA7wami4P+qz91qiCHBnT71gZJXn+/I7CST5Gbqm+rToiyvaRUKMZHqWhn0DBD
         jdJbXsCJR1fK3v8f0nQDFZHiXNwnUh3XgggBHdwW55xDQpJP91KaHK1p2zqpk3vlEofZ
         MSiA==
X-Gm-Message-State: AOAM5320S5kS2rFHb1M2XBe1kQOAQLB/p32FFoxAr8FX96cLTUI57IEc
        xvzv8C2LlvJ/9lr6n+oyv7gvDA==
X-Google-Smtp-Source: ABdhPJwXdAAL6wD9Ov1Hgzxy94Cl3sK1TvG300imQA6EIlQwLYDqW2ZbdNO+fZgCDkDLbW04xnRPmw==
X-Received: by 2002:a05:600c:3009:b0:381:194a:8cb5 with SMTP id j9-20020a05600c300900b00381194a8cb5mr4746639wmh.43.1648731504409;
        Thu, 31 Mar 2022 05:58:24 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038c9249ffdesm8230695wmq.9.2022.03.31.05.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:58:24 -0700 (PDT)
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
Subject: [PATCH v2 3/4] dt-bindings: update google,cros-ec-pwm documentation
Date:   Thu, 31 Mar 2022 12:58:17 +0000
Message-Id: <20220331125818.3776912-4-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
In-Reply-To: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
References: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 4cfbffd8414a..9c895c990ed8 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -19,6 +19,12 @@ description: |
 properties:
   compatible:
     const: google,cros-ec-pwm
+
+  google,use-pwm-type:
+    description:
+      Use PWM types (CROS_EC_PWM_DT_<...>) instead of generic channels.
+    type: boolean
+
   "#pwm-cells":
     description: The cell specifies the PWM index.
     const: 1
-- 
2.35.1.1021.g381101b075-goog

