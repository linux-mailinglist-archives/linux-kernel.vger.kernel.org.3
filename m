Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA32753D4BE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348648AbiFDB5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiFDB5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:57:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FBC20F70;
        Fri,  3 Jun 2022 18:57:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso8374029pjg.0;
        Fri, 03 Jun 2022 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5hGdIU3RTq9rNarbSsXAVqYEW+DV77xSmfZJg12PYQ=;
        b=EPjhqUYh4/vtYhYTO99L50D61QACPFudZTbqJcy6ykzVGGMsI6T+HnfatT+lKWMEh0
         pj9NkXC8IqsgqGjG2wVkJtTAUDVck8mpCYF2tO5PsZ/0NeH/0Q/MxVaxRFtFeVep7CPp
         OvKCULTVQLctzg04rNjzQDascX8W5RpRrnM1tcnRPgHyQPDVyny+HMtoTFgUpZhZhG4l
         J4iIwC9DndxgK8E+a10mb4JY3ym8iaOqcVLYkmXwgdJkt7ZpH7ljIcfaAe/XVktXmzcQ
         pxaMYC4oTBaJHhz/gciL7SemoeRI9XGVvTeVqiiQzFOWxtQAZPb/mqo7URPAGLJiFJD8
         Voiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5hGdIU3RTq9rNarbSsXAVqYEW+DV77xSmfZJg12PYQ=;
        b=38Ow+uint+M7Ah6CE5YAfc6pF8GencfcOm7drZAbIjlLFeD3Db/JdJo8aDSeXQmG0l
         PjJwlbUnilS0l+nkKhQweGWZZAnyPYM7pmsjhpLLy5gyv4FnXQcaZgCdqh9j0Q/kTniY
         4Pf97/I0rBtWvqbHHnErbnxy2qFB98M4iVGNtWLqQXDqLRLrOeSsBKOHphh4WDxUQl7s
         GzqIh68C3bjjcsleIANfb7aicfIrscTtWUVqoke+ECfjxFltP+Vl0Xw693qDBkX1uwup
         8AcxKWjafinT2gOfVEQv4vcWKyVhFpnZn7Rizifcg/xUafLffEuDGyWecZCx4ND1dEuI
         Q54Q==
X-Gm-Message-State: AOAM532aWkCoUpYt2n5sVB66JBDL3rn7hDiHMFyDO643Cuf1Of7MOOEr
        7m9T2dgkQmdIBK6+U73w+hsr27aAU/U=
X-Google-Smtp-Source: ABdhPJz2TwV5LhKdZz+uWbYPjCf2IZSysv/0di1ulfqoBm7BJc4ngnlPE31btPUgnPQvEQssdi6KKg==
X-Received: by 2002:a17:90b:1646:b0:1e3:15ef:2871 with SMTP id il6-20020a17090b164600b001e315ef2871mr28504519pjb.105.1654307868626;
        Fri, 03 Jun 2022 18:57:48 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-10.three.co.id. [180.214.233.10])
        by smtp.gmail.com with ESMTPSA id k38-20020a635a66000000b003f667cb15d6sm5973257pgm.37.2022.06.03.18.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 18:57:47 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] leds: Add leds-qcom-lpg entry to documentation table of contents
Date:   Sat,  4 Jun 2022 08:57:35 +0700
Message-Id: <20220604015735.249707-1-bagasdotme@gmail.com>
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

Fixes: 24e2d05d1b6898 ("leds: Add driver for Qualcomm LPG")
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-leds@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]:
   - Correct commit pointed by Fixes: tag (suggested by Jonathan Corbet)
   - Collect Acked-by: from Pavel Machek

 [1]: https://lore.kernel.org/linux-doc/20220603025735.17953-1-bagasdotme@gmail.com/
 
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

