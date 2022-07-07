Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE9056A107
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiGGL2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiGGL2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:28:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE832F00D;
        Thu,  7 Jul 2022 04:28:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u15so7441020ejx.9;
        Thu, 07 Jul 2022 04:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=m5PYfIp3y7G55Xw9BSK+oFXneOri6BhsxpMkd6GW0qo=;
        b=EJfOtU5spY6XTXJWNfaP8bnujKcmZDrO+oflo0+0LMfVyY1Ourz9zntnsO8dRuZn7V
         H9kmtAh7Uo7NLMYNgM1Ii0rr7cQDdxsax7F7VGMXL+VbG39gr5NmTQAwtbk1yXA9ezkV
         mgq42B1cYu087uk3NLRvh2Oe17lh05C+1muvr8EmETgJKXs0ujLBLM+cs6E4SNnWhljt
         nXalygWZ/czeoOjlkvi4w3zrZbWxZ1abhEgiN0klvEwUQIE7tOUI6UY5EIqI1dc+AP3G
         dMcMsTu5ZwUBcjULfaftwtLGzOfYeiv/iNZKWW2LSa2HFxC3SBEhcZlw1meMnMz3YCnL
         oxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m5PYfIp3y7G55Xw9BSK+oFXneOri6BhsxpMkd6GW0qo=;
        b=jcgxqr+WTKkzHkfQfqvbx0rKLLlJBHsZLAHd2piPIw3vk8W8GAW8R/j0zOpsLqhGDS
         6sCuRHJuEvQ843Gdsnd37y+uDLca93WjQVqPOU0pYTHuDZLpCSdS3a/PQeqANJ5Gd443
         zXHzZ7JyxlHsnch67fGlSZhatfCYbbFzOiYrgkZK7O3WOVNI0P4JKEr8Kg9dYuIMxZ+2
         XVBTc5eeuhFDxE1X41T4In6rNNT/3aSPCXmQW8f2xdelgt+XWyynnbBova6IV2N11XSY
         2Szrsvc91+yHiZAwCq0O2c/mN8x8Y3raFOJCvtxJcfpJrDA7ucUwNLwnPv30ACp/GE5e
         qZLg==
X-Gm-Message-State: AJIora/xArXqUdTUKfvGN+50fedAIwLEej4rXLbfh35lQA91lf49+vHn
        /JgN8dEcfBqRM8KB1b1fo9a+L3oI+2s=
X-Google-Smtp-Source: AGRyM1sCeMKb/87R0NYQT4DEJ42/TBDB2kYDNSIKTYv53GoGBgwRKFWdbEZx2gE4jszsucPFprN1VA==
X-Received: by 2002:a17:906:2001:b0:6f3:bd7f:d878 with SMTP id 1-20020a170906200100b006f3bd7fd878mr43048732ejo.133.1657193330498;
        Thu, 07 Jul 2022 04:28:50 -0700 (PDT)
Received: from felia.fritz.box (200116b826df3d00599ec68d191c47fa.dip.versatel-1u1.de. [2001:16b8:26df:3d00:599e:c68d:191c:47fa])
        by smtp.gmail.com with ESMTPSA id hz11-20020a1709072ceb00b00722fc014e8csm18574315ejc.104.2022.07.07.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 04:28:49 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: mark ARM/PALM TREO SUPPORT orphan
Date:   Thu,  7 Jul 2022 13:26:45 +0200
Message-Id: <20220707112645.5147-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The email address sleep_walker@suse.com and the url http://hackndev.com/,
provided in the ARM/PALM TREO SUPPORT section, are not reachable anymore.

Make this machine support orphan, and give somebody the chance to step up.
Move the maintainer into CREDITS to keep the attribution to his work.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
RFC patch: https://lore.kernel.org/all/20211229191828.21317-1-lukas.bulwahn@gmail.com/
  - received no comments

Russell, please pick this minor update to MAINTAINERS.


 CREDITS     | 4 ++++
 MAINTAINERS | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index 7e85a53b6a88..40d3c655b567 100644
--- a/CREDITS
+++ b/CREDITS
@@ -627,6 +627,10 @@ S: 48287 Sawleaf
 S: Fremont, California 94539
 S: USA
 
+N: Tomas Cech
+E: sleep_walker@suse.com
+D: arm/palm treo support
+
 N: Florent Chabaud
 E: florent.chabaud@polytechnique.org
 D: software suspend
diff --git a/MAINTAINERS b/MAINTAINERS
index 36a2c8a9aaea..ffe0c587f9d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2510,10 +2510,8 @@ F:	drivers/power/reset/oxnas-restart.c
 N:	oxnas
 
 ARM/PALM TREO SUPPORT
-M:	Tomas Cech <sleep_walker@suse.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-W:	http://hackndev.com
+S:	Orphan
 F:	arch/arm/mach-pxa/palmtreo.*
 
 ARM/PALMTX,PALMT5,PALMLD,PALMTE2,PALMTC SUPPORT
-- 
2.17.1

