Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4753C35B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiFCC5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 22:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFCC5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 22:57:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E05C140E5;
        Thu,  2 Jun 2022 19:57:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q123so6236211pgq.6;
        Thu, 02 Jun 2022 19:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x820pLXCsqkyIOD33ZRcyDFQsozHdZWLRbOvlupxM6Y=;
        b=NDVs7le7eCjhAMs5Buj4u9LWNHEViT99BY68+RNb6hrQOt8/o1pD/MCcbbvF09GdkS
         66lGkrAL9ZiLRIHQmjARe976DldUtD40tGRHxlQL6k+0ZZgYZxZs/2MQV742rWF3X4sU
         0717vVygxtarruhlweMGXd+844loIrYlW5FuBgs2DixPa6wAsN4BnZxszR4Ll8AVU7Vs
         iUTW8hmtdfl5dzTTaOMCXegaPLVjVqt/dyd9SfOJaw/7eemo8BCCKYKjxY6Ox0BnqPlr
         WsHXPYyjXenSjUImK5mLlCrBkz8YZ4jNcWqRUwBZj07jIyYe0NOzatAT3N1Y9vyM6o7k
         Utwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x820pLXCsqkyIOD33ZRcyDFQsozHdZWLRbOvlupxM6Y=;
        b=lTf+Fz5oUNx5RH4OOXvfWjV8VjtQm0RSg6KUowIlhXYVt/VlQjj0dBFVDMFUkT/Re6
         ejqHwKKoOXi7ow9hr83mI7vvOv1l9dArRSSZ0/uOOGX7CyI+mxAJlaZDTPB/VObZkJkA
         Js25lh1ewsJwUMzHcnDpo1apVMesM6yR/6IvDz7SuG22uEM8nL03TtW1ftCMAJtm//Po
         emytQGM++MstvwHBDhhYjUhOFATTgZGhe2GoZ/43B9PRrHsWtjqzQR6kunq4yRStkHwg
         K0GwWuqxeQZwhG2WtuobNPD4cq+Dzh/UQwfBkKeZaWUPaAHJyLo9+GB6D0D51csEtQo3
         l4HQ==
X-Gm-Message-State: AOAM531/+WnHO2783A6RvMynJ3iX5kVOT4r/3ZUmu7UqikhSZ9MJSs8t
        C2xYGBQp1gpoMinzMuJURo9xLzS2X1a5HA==
X-Google-Smtp-Source: ABdhPJzd4bR4jGaSMzsYqTsWFkC6YiPrkFfEEtA93z+N5w9JNYeCWlgrqyD3vdIQRzSGf4nj3kKfxQ==
X-Received: by 2002:a65:6e9b:0:b0:3fc:587a:6dcd with SMTP id bm27-20020a656e9b000000b003fc587a6dcdmr6833105pgb.200.1654225065976;
        Thu, 02 Jun 2022 19:57:45 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709026f1000b00166496ba268sm1393055plk.285.2022.06.02.19.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 19:57:45 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: Add leds-qcom-lpg entry to documentation table of contents
Date:   Fri,  3 Jun 2022 09:57:35 +0700
Message-Id: <20220603025735.17953-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging linux-leds tree to the mainline [1], htmldocs build produces
a new warning:

checking consistency... /home/bagas/repo/linux-stable/Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included in any toctree

The warning above is because leds-qcom-lpg.rst is missing in the table of
contents.

Add the missing entry.

[1]: https://lore.kernel.org/all/20220531200619.GA8906@duo.ucw.cz/

Fixes: e98a860f65428a ("leds: qcom-lpg: Require pattern to follow documentation")
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-leds@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/leds/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index e5d63b9400459c..014e009b076159 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -25,4 +25,5 @@ LEDs
    leds-lp5562
    leds-lp55xx
    leds-mlxcpld
+   leds-qcom-lpg
    leds-sc27xx

base-commit: 50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc
-- 
An old man doll... just what I always wanted! - Clara

