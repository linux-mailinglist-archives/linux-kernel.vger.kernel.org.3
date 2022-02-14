Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D254B4063
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiBNDgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:36:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbiBNDgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:36:43 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0A554A7;
        Sun, 13 Feb 2022 19:36:36 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso14534512pjg.0;
        Sun, 13 Feb 2022 19:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71JHL6a4At1Gw4scubZ3vrvM30dBBl26C7Z0Kh+8KMw=;
        b=mZ49mRwWfDmp3iYBkllMhJUkVa5kQuZpd+tynyl22CyLrHhIC3fx64g/1Q7S2g7lEc
         eLpsWpkuqT4sdLWBzIFqTWd64JfL4lMr3hSR3Zwar4fkMlMHDcqaQZJkFOg0yXFrvox2
         d4X96a9ngFGaJ1pVKLuUY4QMnJU/Rkjolg+gZjaCrPwkfaq2Ao7q/GTD4wE3ByHmmoVS
         C5ELJ1k2FngJwFF7JL/kS4Un1dOevBvgCwPNJi8tw/ECedIh0gArM/5OuWxVUocwEcot
         3zj0exIZnjEkX0LObu9DPwORJiWEOyivpnRiLPb+KpvAwHYfZf9XQUCCVoAwoqdhN+yh
         H81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=71JHL6a4At1Gw4scubZ3vrvM30dBBl26C7Z0Kh+8KMw=;
        b=Td5jr+uhABpKdxcrl6KoH8ZDmfHtuS81TjniYYHjOjm4N68nem2OUsmHer/Mo1maH8
         PRQ08RxOtEjA24PQeck76nTE14mrxTQz+n3EIuMrQYYa+YzuwJG5m7ny//FLIPg/3MiS
         9yryBbSsUsjbjC0bKOFYhCympivNvxgfI0YZht0+8FJ9li0wHihvcOqeRn8zRZUlUBsu
         89Pjb/5+k5DgM+oyHAO561WxoUqwk+ckagWfQCYnmiq/19RQmGrauKWKD6o1Yda0ECkr
         nkt760DfykBdNxGQIGFUgG5l+FaRexYmCsEQUMSqNtWGn+dmP0vhI33oEZF3yzvemS5v
         FuYA==
X-Gm-Message-State: AOAM532L8ohaILunrkRxPp6bZ6kJpPYWIGy8QlL3FJsmmdGllbH4LMdX
        8Z3ynM8cDRGNaaTLFv+eM3Y=
X-Google-Smtp-Source: ABdhPJx/R5tfH6vto0gngrbOJJ/rpDiBT4GsalobpJjtB0kxAQ+xAf5xQ1Ma314sAFn2pJWPguNKHw==
X-Received: by 2002:a17:902:db07:: with SMTP id m7mr7217884plx.107.1644809795730;
        Sun, 13 Feb 2022 19:36:35 -0800 (PST)
Received: from localhost.localdomain ([27.7.103.158])
        by smtp.gmail.com with ESMTPSA id me14sm36012pjb.41.2022.02.13.19.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 19:36:35 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices
Date:   Mon, 14 Feb 2022 09:06:20 +0530
Message-Id: <20220214033620.4059-5-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214033620.4059-1-jagathjog1996@gmail.com>
References: <20220214033620.4059-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim DS3502 is a 7 bit nonvolatile digital potentiometer.
Add DS3502 binding into trivial-devices.yaml

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 091792ba993e..b6187603317a 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -157,6 +157,8 @@ properties:
           - maxim,ds1803-050
             # 100 kOhm digital potentiometer with I2C interface
           - maxim,ds1803-100
+            # 10 kOhm digital potentiometer with I2C interface
+          - maxim,ds3502
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
           - maxim,max1237
             # Temperature Sensor, I2C interface
-- 
2.17.1

