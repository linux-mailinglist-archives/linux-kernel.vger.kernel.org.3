Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA62B4B96F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiBQDtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:49:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiBQDtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:49:01 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB8C5DA4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:48 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id m185so2182884iof.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/iB17natQD1MoZXV2qkvWvbusYAfF8+WZi2MjQWQu/w=;
        b=qTiK1jRdbDaFcQDx4cC+rxVcCZ8P6wZaDMePsvS5oqxzwhZzFsPen2E3O6rCOSxtiA
         DessncBQIZpwkAo1jwFHEpBRUQcGQnZT43gcngp/B8U5FSKO0ZddtRZQMM3LjLjHqNep
         LEoPZz3WvGyMJi1ikGUAIH4vGeMDAnyGlbLgB3iA+hGgK4WwVgbeSDeEHWoEm0NNGq2m
         jHhdwz8+UoyFVLVXJHDqJsFfBqOWCr4Cio0d+nnldQlSY/xWYMoFTt8VfNNAjwXryYvC
         IPVepN0QxjTudnVEUuK3Do+0p5JhpLLYNizjiCFkrbRHwAs142s4qaQi3OapvpHue2eI
         ALRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/iB17natQD1MoZXV2qkvWvbusYAfF8+WZi2MjQWQu/w=;
        b=CloEuUvyf4SWM/WiOXtFUlUHfWozrnUylveoWQG8YMGHod+xaSYuZE1mxv9L+r1p1O
         pBgkDOnRdnHX48AqCvGYB9sDuOVU3axuQdvFxFzQE0RFPnzTX6RPT+vSiHR3y9+yGJ8T
         +VR7NlUXMLTOPiOT3muSuwQchYceGKbew70nVBaYQyLUyfAzifoWTxFZVqAquaYoBNTL
         yEJR0UDlYheu6mvr1iFTBrymYZ7Fqk7ktuTB7TIOs/b0b3JBIdbf7XJZ4YSzGFsodHYq
         qGWdT0V3R/5ebSLaO4HDCJ+z3dwqlTXHQg1+mpqg4hx4t8AxfMUzgId9F+DSC4OaOYgu
         17TQ==
X-Gm-Message-State: AOAM53289sRSLc1yXUSiGz39jb6fCCZVacI55FKJDuJzmbWN/oiE75O7
        OhwRywXEJOIt+e+pDZIELPY=
X-Google-Smtp-Source: ABdhPJxOywT+Bw4mOSbi+xuyE29k5QgNi8ekJ3xSmi3CrQ8bBxZkdSh03E3QGwSUqfaeD1zoTLwAxA==
X-Received: by 2002:a05:6602:2e87:b0:60e:9b40:cd62 with SMTP id m7-20020a0566022e8700b0060e9b40cd62mr647311iow.204.1645069727595;
        Wed, 16 Feb 2022 19:48:47 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::1b19])
        by smtp.googlemail.com with ESMTPSA id l16sm1127874ilc.54.2022.02.16.19.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:48:47 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 06/13] dyndbg: abstract dyndbg_site_is_printing
Date:   Wed, 16 Feb 2022 20:48:22 -0700
Message-Id: <20220217034829.64395-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217034829.64395-1-jim.cromie@gmail.com>
References: <20220217034829.64395-1-jim.cromie@gmail.com>
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

Hide flags test in a macro.
no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 664bb83778d2..106065244f73 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -56,7 +56,7 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
-
+#define dyndbg_site_is_printing(desc)	(desc->flags & _DPRINTK_FLAGS_PRINT)
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 
-- 
2.35.1

