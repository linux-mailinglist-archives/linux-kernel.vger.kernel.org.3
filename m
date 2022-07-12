Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A01572578
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiGLTP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbiGLTOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:14:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75514D5140;
        Tue, 12 Jul 2022 11:54:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y9so8218340pff.12;
        Tue, 12 Jul 2022 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K1IKCfZW89XQvo85Z8BhSh0884PYpNxI9KGLgL48HhU=;
        b=mONWmWg9j5WWAGQnDhb6lMqqVC1nGf+CbhThgBUbRkwpwdhBTiHtddhsRDyShUVy6V
         cMwn/8SH2HLSYs4td6iqqq4CHS9hciHjKY1El6t/DOl8ITfQ7bJnL/T3agcPf1nFdJ2i
         dwVtLSeN6WoO7TztYLDuhVOUc5Kv/UL/LL1kNUZDWwMh+2/lz1vB411wsbUllsg8F26B
         4iFi2ueShWaCXdokHRrD8EeOodNxBUOmUlWOKWE5ue+ilcpLKRuK4D5tK2Fyb6RK3KlA
         T8b+H217RGCmpryowWSfEH8yYPeygWIrvKTcFvgCqPBGwqzV/a6OdKCdBCDnz5/XNisk
         bKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K1IKCfZW89XQvo85Z8BhSh0884PYpNxI9KGLgL48HhU=;
        b=KuKS1IDN6grFWFJR1TP66NkjBLLk45qSH8jbrPrmKQyyScvex0HCySgQqOgtztwERy
         OE5z0Z0Ll0sIVGUHnLP1xNf5HtXkvXPoMlh8G1fZqnfyFoj2Vrp9q5sv5rfdX+XfknEv
         OzN8YdAR8U9Bck34xkw5hG+O43j5sRIksoaOALwb6o9E35rcQZIBlQ9x+cl+RVpHzS3c
         uses1mm5yRdjFcsK8vBdVGeVfud2CuGc+vyyAe6Iib7jr+Q5VYScK4vYvej5KGw19tBt
         e+qubg5G07L4DOvBcY6jgvr2FYcPtDrbhtdiZ6Z36+9DSZYBeXTw+ZSIRDqGer43PSbC
         StCw==
X-Gm-Message-State: AJIora/Olg4Vlc6IQFZmRdCiKmophuRGuUMbISC4JbjJvdywi4Mt3VGX
        4/lrb/ZQjBuhhnHuT9Es1unvx8jHQM8=
X-Google-Smtp-Source: AGRyM1tijtHmJAYOsuSQDbbEVFzF0OvZrIYUyBGfKAZp6IEQzl6/TAkU1kCiKsbOgqNXU+SB7aRHSQ==
X-Received: by 2002:a63:104f:0:b0:40d:2293:f1d6 with SMTP id 15-20020a63104f000000b0040d2293f1d6mr21274190pgq.167.1657652062552;
        Tue, 12 Jul 2022 11:54:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b8-20020a6567c8000000b0040de29f847asm6575539pgs.52.2022.07.12.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 11:54:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     olivia@selenic.com, u.kleine-koenig@pengutronix.de,
        paul.gortmaker@windriver.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        gregkh@linuxfoundation.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MAINTAINERS: Change mentions of mpm to olivia
Date:   Tue, 12 Jul 2022 11:54:19 -0700
Message-Id: <20220712185419.45487-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following this mercurial changeset:
https://www.mercurial-scm.org/repo/hg-stable/rev/d4ba4d51f85f

update the MAINTAINERS entry to replace the now obsolete identity.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
This was first submitted by Uwe:

https://lore.kernel.org/lkml/20210920080635.253826-1-u.kleine-koenig@pengutronix.de/

but the discussion derailed into whether the EMBEDDED LINUX entry ought
to be there or not, meanwhile we still have a bouncing entry with an
obsolete identify.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f679152bdbad..b1ce4b84f99f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7404,7 +7404,7 @@ F:	Documentation/admin-guide/media/em28xx*
 F:	drivers/media/usb/em28xx/
 
 EMBEDDED LINUX
-M:	Matt Mackall <mpm@selenic.com>
+M:	Olivia Mackall <olivia@selenic.com>
 M:	David Woodhouse <dwmw2@infradead.org>
 L:	linux-embedded@vger.kernel.org
 S:	Maintained
@@ -8787,7 +8787,7 @@ F:	include/trace/events/hwmon*.h
 K:	(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
-M:	Matt Mackall <mpm@selenic.com>
+M:	Olivia Mackall <olivia@selenic.com>
 M:	Herbert Xu <herbert@gondor.apana.org.au>
 L:	linux-crypto@vger.kernel.org
 S:	Odd fixes
-- 
2.25.1

