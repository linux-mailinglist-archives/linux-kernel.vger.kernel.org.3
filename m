Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA014AB3E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiBGFtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351164AbiBGEET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:04:19 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD35FC061A73;
        Sun,  6 Feb 2022 20:04:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso2649260pjg.0;
        Sun, 06 Feb 2022 20:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71JHL6a4At1Gw4scubZ3vrvM30dBBl26C7Z0Kh+8KMw=;
        b=JgFvVSUyrc4s8+/yhgvq08dBEX8opQSZcU9y2Mp7yf6Z/xm3vWQUCT6COW3M9Ut7yf
         eD2NmndEzaevqynoXBcEkz8DX8UibIbYhyTsvf/2kXrdsk8LUIs2Qt2JY04Sjv8ChNPo
         7/gERHbDBmBB0me6M1+RsdCliP0RDzI3jVv5BG+GUim2MA2SYxsmSywLaOXYQMGs6g5A
         l4Wf5skkTGgjxPTf7cDqfoeZcptVBcGbXYWHjcQbM0MMhvI6/Yj8XyTyJTA3i2FWd/Zx
         9xlgDArbJmte3dFxh1N0yriNbjkuYnTesHGjucmT0B0vFnhneooHqbvsv7xWB+3dVffo
         XfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=71JHL6a4At1Gw4scubZ3vrvM30dBBl26C7Z0Kh+8KMw=;
        b=Y+6Fvo89DSW7IKooRUBQHqSSNek6vm1NfGUyF9h0ADPD2umTwEN7IjtPRXJSCwdQ31
         6qZpjxHvwssD8HdMMxEeJMpyj6+I1OEzpSy1OqB7kNFyYW3u0AuaNGL9J8Z2gPb6OCet
         M/DIGFajxp/wjyfcJyKE+53KEKXJXR5lxHOf5DRNvq6UnjULLMuEILq1mHwwEjg/D4Kk
         n4Qs7tith4MKTw6/vIpzBZiwC5recxe4CVoggMllob+Bt5aBrjxVjWnkFTNNewIYjkXy
         vX2vmO3pkkPCVTkLSczT4qUyxTHeuF4gVFl0GeE8rnbRW0nSmJeLUIx8L9SCisf224F3
         4SUw==
X-Gm-Message-State: AOAM530rsHcTLqrvuiqIHUlZXs3i9hVOVUtKkBNOUMukhM9J2xUkObia
        NyD49RDp1s2MKOA8UiMDzlw=
X-Google-Smtp-Source: ABdhPJxPoeIwrDwtcRhCXvGWQe9wTN5VSQbOvd7Pn8oneXzD/hzjsb5YCBsAmNp9nRu0KG+MVGA5Bg==
X-Received: by 2002:a17:902:ced1:: with SMTP id d17mr8366803plg.42.1644206656389;
        Sun, 06 Feb 2022 20:04:16 -0800 (PST)
Received: from localhost.localdomain ([27.7.146.135])
        by smtp.gmail.com with ESMTPSA id j18sm10601234pfj.13.2022.02.06.20.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 20:04:16 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices
Date:   Mon,  7 Feb 2022 09:34:07 +0530
Message-Id: <20220207040408.4273-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220207040408.4273-1-jagathjog1996@gmail.com>
References: <20220207040408.4273-1-jagathjog1996@gmail.com>
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

