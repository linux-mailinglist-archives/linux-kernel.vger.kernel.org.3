Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE94F5AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiDFJjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573069AbiDFJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:34:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F1B125CB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:19:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bq8so2063659ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 23:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRSeg/Lx0QJPiA9N9HHqOiU0JUD3WFJS5KpLC8e8al8=;
        b=hAlKLpwqlxQfWYv8WAtYio5MqemQ+ZxJp68y8dLhZnbhPVsvdI5OwQ8eH8e2TLqsB/
         K+0pv/feOiCVp44t+pTuKjMELYjGkkYB91tC//gM+bMZbVOXcxIyBlE7xEIF7ZSKIkxA
         nIkIjRFvuAhoW86ZvcE5VDgYsa1z/J08GNO9OJQ1h7L7oS54oHCLUbT04ibs/BZJiaVK
         emQAa1w0yRPxwJHvZSdhi12NiuS650Nlv3FJ7tmtv/+Nnl1cgiMGSJwuS/0ltx+HC+RW
         8DChNYEgRgQvSYcKdUNqnSmGyMMcUDqT6GbOyJ6tiWrOencTJo7uJHoVPkfpiZ0/ut4z
         mTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRSeg/Lx0QJPiA9N9HHqOiU0JUD3WFJS5KpLC8e8al8=;
        b=zo3VhGvg+0Rgo4Ac8BDy16HkyGhwvGQM5prNdBVfYHHsT18r85d6pI/+ttXf5rd4A7
         3dSndhzQBoDOpINid3YNOseQVwmDnymEgY88w4hes48HfiVlcIAzrq+yUAAm3uyqRlDC
         dem8GUpWNI8x9UR+rmHASCcfeZRedV6U+BNvVcDK2cmkYbs2Wa5+nJNrpw1le3Cqh/gW
         NjJoIRpzthvkMr9IEzDNkX0Axk/WX6ZPm8jaVb12dRz1RoEOGmtzY+KC9RN8MF1hOrVQ
         hNk5yBTi39O0U8Dn/LCCoIbn/YtPSkFuPoolmQ64ObBW8b3eiwBU35jWwk/lPu2LVaKr
         3Z4w==
X-Gm-Message-State: AOAM532D8MnbPObeeoSirgbjxm9Vkwj2F8lA4I7E/OAnmtuE3WKAFKAG
        uy/rK605ZvTtJGZWw3kNQQA=
X-Google-Smtp-Source: ABdhPJzVASTH+rw+vBWafl7Vx3lSBIUK0lzuB9Wzg1uKkED1RFkQZt+lw06cgao2WU3AdEDbF7/sMQ==
X-Received: by 2002:a17:906:a046:b0:6b9:20c:47c1 with SMTP id bg6-20020a170906a04600b006b9020c47c1mr6779846ejb.615.1649225956258;
        Tue, 05 Apr 2022 23:19:16 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id q3-20020a50da83000000b0041cdd6e92b1sm2475251edj.27.2022.04.05.23.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 23:19:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: remove unused _RND* from osdep_service.h
Date:   Wed,  6 Apr 2022 08:18:59 +0200
Message-Id: <20220406061859.9011-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406061859.9011-1-straube.linux@gmail.com>
References: <20220406061859.9011-1-straube.linux@gmail.com>
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

