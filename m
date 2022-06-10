Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1070546BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350212AbiFJRvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244289AbiFJRvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:51:11 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE7A23099D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:51:08 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id a9so44356qvt.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gbzkjjTxvQf4VVDFnHZw7tp+40yLDsNszIZC27jGgaA=;
        b=ktDjDmimUdUaSLqq9VN1NgNId+TpNPROHpml/KlyG+F6S9rMMfY9ehr/CYwSyRILoF
         MbRv1YlflAT+fgJqRWN/+D5Si2kxNKjtByj/8bzA1Tk8v3XRX4KzCCePL8tP8NdjsTRR
         Y91XfkLqH1x4vzP7F+NHuI2a+MYEBSgmrEIGuhnAegKGzJsUOe2j8SIg90MYZetuRBLk
         82Vql+9kAxtea9tQebI7xIrjBlWxXRQQXAjVthnbklOsDTGWHAk79q1+w99RiZBTG1vw
         e1P6AmOFlUHKxUbC90Jm7OJGLMKuYknAHc/FJ3q+YtLs5mWbjI+p0KZgnB58wdeFIa4d
         vfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gbzkjjTxvQf4VVDFnHZw7tp+40yLDsNszIZC27jGgaA=;
        b=cY6c7yuGsej/LEmjjwk8Se3TbKgg/yevG7ZN0FBrZBsRQWWffcgtaDv+3182hKjIHq
         iwGqSma4A+OypezHOSY8SWG1AzxeI8v7UbIP5EV5WARIS+u/xtN3WFFKWt71dtcnkKnr
         i2OpodZFoz24J35tV0p1V301UCXGszE9cyOBG6BgKh2uityuRkUiTeGCim1Rb5luJUk8
         XujxICgVmYvD+DP7vY01OMGpAacLWKj6Ni/HBTzic46v6kXDSN5WPcM92W9bZ57P0Scg
         38w8ruyMk/fp1jB7pWEhDy65EuVIYQfUMUVRXyy7gagQWplZd1L6imbQlqO8c3nwbUl2
         9dOg==
X-Gm-Message-State: AOAM531dj3Gol3kZAjx3c0L374WcNUohQHCRcvale1Z0oE6/1l2Ms77G
        V2HK+JPurUdGKy8dIEpeEEM=
X-Google-Smtp-Source: ABdhPJx4rDyDDK3vDJhZOpN5hYHq3TZkUJW/4cBBOD8ofuj01peRmrXhXVRJX7IRjj/8ykznevrgfw==
X-Received: by 2002:a05:6214:2304:b0:438:458e:eafc with SMTP id gc4-20020a056214230400b00438458eeafcmr89193869qvb.118.1654883467506;
        Fri, 10 Jun 2022 10:51:07 -0700 (PDT)
Received: from Agam.hsd1.mi.comcast.net ([2601:402:4500:22e0::e952])
        by smtp.gmail.com with ESMTPSA id s137-20020a37a98f000000b006a6c230f5e0sm51631qke.31.2022.06.10.10.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 10:51:06 -0700 (PDT)
From:   Agam Kohli <agamkohli9@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Agam Kohli <agamkohli9@gmail.com>
Subject: [PATCH] drivers: android: binder_alloc: Fixed include warning
Date:   Fri, 10 Jun 2022 13:50:48 -0400
Message-Id: <20220610175048.79446-1-agamkohli9@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed include from asm/ to linux/

Signed-off-by: Agam Kohli <agamkohli9@gmail.com>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 5649a0371a1f..4c10c4f9573a 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -19,7 +19,7 @@
 #include <linux/sched.h>
 #include <linux/list_lru.h>
 #include <linux/ratelimit.h>
-#include <asm/cacheflush.h>
+#include <linux/cacheflush.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 #include <linux/sizes.h>
-- 
2.36.1

