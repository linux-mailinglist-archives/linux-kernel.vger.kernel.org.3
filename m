Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F1C50804D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359355AbiDTEwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbiDTEwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:52:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086F1275D4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:49:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l127so855807pfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=785BQAgQ/fmXmnK7LN9iPs9KhRHeXeAbtde080rNxiU=;
        b=dkaik8UizHe3S9fhvxry7osL6TYV8tA93uoKj+sy5Zw8YYLEBUDS3mnJ8lj6qovuq/
         pDIOumiZgkLEnpdI59TVi3rWAc9fNIhFbflyVS1rMYFZwQU1aT4dsHM2Sif8qpgzPnmy
         e+iNx8ptfhTtEaNXOKXDyQxgKpCYzadm8Zd6Lr/O/kSCgcK09x4+wvUnsm1W+pYb09Yj
         pSRV7LJGy2sq5qrsO+h6PhiyHb55YzGi3A9X1wGHwjvHq48d1pjmycCTEM99pT5Rog0o
         qKj8zs9TmRShaSPpzkby4N8qWpelIdI4QLItNoPoN+NenV2Q+DgWIF0LpWwi1DYneskJ
         T0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=785BQAgQ/fmXmnK7LN9iPs9KhRHeXeAbtde080rNxiU=;
        b=q4FF0TXYYgab0EBTBurTVaCCz/Ew0bhftaPeqlaXedMLppS19lupZHw30gKeqRgjiX
         96O5tUjR4DX+F9ABBPXeszWMEFRzUE1HoPHOmrWo6tvCoOend0UKHNw3WTVHzOfLv1lZ
         WuCPOOWA4Md8pCs87FTQbILfU6V0bpCj2XahQz/7LzI14l3OqV9v+shkGkyJSQZSxl/d
         mHTZ/X+ShoQ81F30pIEF5d1dnWVOovWVFdN3K2N4UyJhw277fRNQDN9duliZ5Y2ccWwV
         e0ITURVGr0J99AZsMNo2ZJFtZDSQHmojxbq/C71JJmyKyDXMMSiKKy4ZXq7iZf807H6a
         dQ2g==
X-Gm-Message-State: AOAM530vZVZVVR8GlcCwy/h98wAox4J3ljwJT8qhEaJGixwXsfhJg+nk
        KWmLRAcqR1dEYvWxMlXMfog=
X-Google-Smtp-Source: ABdhPJxbzkBDUxr3dcGMJn74akRdabzXE1dMP8yCFLgxFEz3tAZGP4CYW+bD/OwbTdegAOFK9yyJWQ==
X-Received: by 2002:a63:fc05:0:b0:3a9:f17d:3f4f with SMTP id j5-20020a63fc05000000b003a9f17d3f4fmr12360427pgi.590.1650430166574;
        Tue, 19 Apr 2022 21:49:26 -0700 (PDT)
Received: from localhost.localdomain ([211.212.143.131])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a001bc300b0050a7b7257b2sm7957225pfw.25.2022.04.19.21.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 21:49:26 -0700 (PDT)
From:   Steve Lee <steve.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     krzk@kernel.org, nuno.sa@analog.com, ryans.lee@analog.com,
        Steve Lee <steve.lee.analog@gmail.com>
Subject: [V4 2/2] ASoC: dt-bindings: max98390: add reset gpio bindings
Date:   Wed, 20 Apr 2022 13:49:00 +0900
Message-Id: <20220420044900.2989-2-steve.lee.analog@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420044900.2989-1-steve.lee.analog@gmail.com>
References: <20220420044900.2989-1-steve.lee.analog@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the reset gpio binding.

Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/maxim,max98390.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
index fea9a1b6619a..deaa6886c42f 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
@@ -29,6 +29,9 @@ properties:
     minimum: 1
     maximum: 8388607
 
+  reset-gpios:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -37,6 +40,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -45,5 +49,6 @@ examples:
         reg = <0x38>;
         maxim,temperature_calib = <1024>;
         maxim,r0_calib = <100232>;
+        reset-gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
       };
     };
-- 
2.17.1

