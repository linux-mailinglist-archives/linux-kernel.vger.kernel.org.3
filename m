Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0D54F5DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiDFMfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiDFMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:33:09 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0686B286A4F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:31:19 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-de3ca1efbaso2148376fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbQxzsG90z/JAl+WL+UN3YQnw6GKHPn4W6/z3zTcYNI=;
        b=bDK9rgrwMdYaTfZncsYLB1OVeHWvUHfcWrQ29VZ53/xLdP9LJ/OUGh0tLfPFxFFQai
         2xffbgBMJ0tckWZWmopgZS1PXHBHn8STAgZA4Hs0m3IGNqNDPd9u7tIzJ0mC3gVtrzbT
         yU6RIx91qw4kbbOcSni4Vy8hOCVbyKPnQZx5v1PghB8gkpf9A5z1WK7ZZOrOCNeeu2nS
         AolCaBhaYTvWEJOOVNa0ifJGteo17plWdV8adfWQGFzOq9ko1ZrnmYlwUuUxDZpdIEEo
         3AXQaLsqUVQwvNpxFVFLasmTbCIasrvyxMa/B9iwL+tZXrCyHXqYdc5456WvTaQx1T+V
         +o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbQxzsG90z/JAl+WL+UN3YQnw6GKHPn4W6/z3zTcYNI=;
        b=JAvmB04k+34K2KMfB4MYxNGs/MbG0qHR9QAETrUcDbU0QF2V9LtyrNDlEcuaynhOP/
         +cy+qnM6O68kqFj0LfdbMKyFsBEvNwFuzzNNotT1v1LsUk6QgCcGLErkhqdMqGQOYOVE
         JIEPXegyhDUMCyKhd5SoCqUiVc2C3E73D1/zqbO0rVYXd3FXX4UpVeIRau2Cn1l3AsBX
         Cv8lcRawZ6uaRyNknwh8DWIQlUzsWflpryc5Q2O5lhsa1ksUsUSM/i5dKOcsWZP8nar/
         qvzCb6LtENnN+82BxAoD7ov8o8hK8Ex1X0GfV82qwkaFcL/+dK6M3N7L3XpzFS+sV2xf
         xWlw==
X-Gm-Message-State: AOAM530A9xp8IyRvY+B+8c6Yp6n44w3nJqSNiXZbBnj9AeO05ATtzyzL
        Ta4ZR0YwCEP6mvl37Lt26XKc5WzIBO9yPw==
X-Google-Smtp-Source: ABdhPJzeu6rL8xM16P/CSl2BL/IvijdU41KyHbFI7UbHBlymYBFyb1IXHhHDomzTCEjCCDRTNA5u6Q==
X-Received: by 2002:a05:6870:610d:b0:e1:f70a:9e8a with SMTP id s13-20020a056870610d00b000e1f70a9e8amr3517070oae.120.1649233878429;
        Wed, 06 Apr 2022 01:31:18 -0700 (PDT)
Received: from bertie ([172.58.102.145])
        by smtp.gmail.com with ESMTPSA id n6-20020a9d6f06000000b005b266e43c92sm6534725otq.73.2022.04.06.01.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:31:18 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: format comments in drivers/net style
Date:   Wed,  6 Apr 2022 03:30:57 -0500
Message-Id: <bd7960acafb871c17ef733cd98b37294f38ad3fb.1649233201.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649233201.git.remckee0@gmail.com>
References: <cover.1649233201.git.remckee0@gmail.com>
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

Format comments according to the Linux kernerl coding style
for drivers/net so they do not need to be reformatted after
this driver is accepted into the drivers/net tree.

Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 9b53b92c6795..9f5ece52bd39 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -11,8 +11,7 @@
 #include "../include/rtw_mlme_ext.h"
 #include "../include/rtl8188e_dm.h"
 
-/*
- * Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
+/* Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
  * No irqsave is necessary.
  */
 
@@ -96,8 +95,7 @@ static void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
 	}
 }
 
-/*
- * Calling Context:
+/* Calling Context:
  *
  * rtw_enqueue_cmd can only be called between kernel thread,
  * since only spin_lock is used.
@@ -317,8 +315,7 @@ int rtw_cmd_thread(void *context)
 	return 0;
 }
 
-/*
- * rtw_sitesurvey_cmd(~)
+/* rtw_sitesurvey_cmd(~)
  *	### NOTE:#### (!!!!)
  *	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
  */
-- 
2.32.0

