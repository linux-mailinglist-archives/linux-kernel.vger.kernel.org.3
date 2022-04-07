Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162E04F7FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbiDGNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245570AbiDGM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:59:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DB6F4B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:57:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k23so10687204ejd.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAbL113tfzbSrZT0XIqHZFep7heNx+dqGSVmNtGYqRs=;
        b=UMVN1xB+UdBE8fc3zyorV1jCpKBKC6f2L/efUg4ohiVhTHljCV1cu/hJYpxAjx6po2
         NQ8fS9CYan4jTcMRvtM2rWdrxTJE0eYQlHIHEmd0OW5Z3SY5k935DaODlMcFhmD6QhA+
         8OJ+q0M7siA2xWjMm945BpNcjIMb1PCt0kyyKqXRJQESsEERhI0H3wPs5mTeDZeqMBxc
         bnw6FnVSHa/sNSSqkguGZnXRUjNWzyw5aCZcVeI6VWYMpvlTOBIjuvNkpW+ozwO/ZRrx
         5vkUrLrfeVcXvI/q7YrLGfHvmdEHhJmS83n6uOdtDr/n2/mo+h6+inilsFzyP3vEZ98H
         UAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAbL113tfzbSrZT0XIqHZFep7heNx+dqGSVmNtGYqRs=;
        b=x+RDDpuJFIgcebXc8BExb6u4Kc7PWyRMwuF+7k2f5ip6ZRI2iX1s2xJ5OlS50en2GP
         4vKAuR0CDGUSzMNJLI8VnZONWCFvB5qroiW79Ga1mMXpXUUqzbWnKgQIdshTA8Bj0zmC
         SkDr2KPRvZwUbPXYtTP6UnhkoV4aUl5hxuQGYS2kts4tnT6iglV/5X5x3dUJ7bKQ4WxB
         LTJh8dGn3w5hzWIeBVvJHAblsvKzC8Fzes9/lEMX8dpnWCUzHB2ifmFw15juYn4P1Z4z
         xN6Qm0+E6uMNxeIhXVsmRN6Uj6+jlD4pR+33pSMw46m+gCW8SoRIjip9rJMfaH7RYuEM
         hPYA==
X-Gm-Message-State: AOAM531ANwssg7jaCOPmBTQ0JScQf/HEmx9Dlh8XQke0wPY6rnjVUoIF
        HwAJjBmqCvwdunxMIT2JYfQ=
X-Google-Smtp-Source: ABdhPJw+HsL9g2fPW7zwwWyLXKgXQSRJ2hG3VD9fLi4M0GZHCAczq2NSNiyRx8LyNk8NNOxHcNbwRg==
X-Received: by 2002:a17:906:49d4:b0:6d6:e5ec:9a23 with SMTP id w20-20020a17090649d400b006d6e5ec9a23mr13076582ejv.79.1649336271467;
        Thu, 07 Apr 2022 05:57:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm7676764ejk.119.2022.04.07.05.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 05:57:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 5/5] staging: r8188eu: remove unused _RND* from osdep_service.h
Date:   Thu,  7 Apr 2022 14:57:42 +0200
Message-Id: <20220407125742.7814-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407125742.7814-1-straube.linux@gmail.com>
References: <20220407125742.7814-1-straube.linux@gmail.com>
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

Remove the unused macro _RND() and the unused functions _RND256(),
_RND512() from osdep_service.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3: no changes
v2: no changes

 .../staging/r8188eu/include/osdep_service.h    | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index f6c55f6c9e1a..f1f3e3ba5377 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -94,24 +94,6 @@ static inline void flush_signals_thread(void)
 		flush_signals(current);
 }
 
-#define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
-
-static inline u32 _RND256(u32 sz)
-{
-	u32	val;
-
-	val = ((sz >> 8) + ((sz & 255) ? 1: 0)) << 8;
-	return val;
-}
-
-static inline u32 _RND512(u32 sz)
-{
-	u32	val;
-
-	val = ((sz >> 9) + ((sz & 511) ? 1: 0)) << 9;
-	return val;
-}
-
 struct rtw_netdev_priv_indicator {
 	void *priv;
 	u32 sizeof_priv;
-- 
2.35.1

