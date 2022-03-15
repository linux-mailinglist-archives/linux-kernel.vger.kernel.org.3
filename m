Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9014DA53F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352218AbiCOWYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352258AbiCOWYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:24:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F799DEF7;
        Tue, 15 Mar 2022 15:22:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so399230wmp.5;
        Tue, 15 Mar 2022 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NILLa8/Wqej3wpbHLLRCUXVc0e9MgSOU9rbFzOM+cHU=;
        b=quOnDda/OOeeWN3YStiDcYUbVyRzWRuWpZ8C0+0fjZztOi2hSl56aigBGUjV2nASpw
         h5yPRMgNwt7zob3HJ3HR3pxFBGvZ27Cvp1hvSL3ZgKWjcshoD8Px97wXLfY6IcnyxDh2
         9hs/YbD9AKYLZ78Efgtq+6qoepipGucMuhUMM/y9p02lT6kj6VelSECI67fpJL3W4p0V
         pK0z2teNdDaZjhMsr7sNMam9ccO2jssPZFG5UtsJ1OgfbDrw7qRylaLs2h6+rXYsVo6y
         qkzWsTKQlIi9BmT9qobQBwGiivia2aq8uv8BTZ0wbZnk26B4fHhSMaXAAtf1cstiRWSn
         bDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NILLa8/Wqej3wpbHLLRCUXVc0e9MgSOU9rbFzOM+cHU=;
        b=roAD/jkumpRsEROFWJ0IilLMXvPu8yqPG6oIifE6GiK9WA+FeGS7Y9cvGwHGKPlIOJ
         84A+JqOZtK2hLPhFt/mE3a7lJ01PkzU2Z1fxPj6BdXjtS5wkwW8wsgK5HkBFj7lBR0uL
         oYRqoPh9XKMeVd8LwKrov0b5IYvPuV3OEh/sOFad4hKig6aiJCGnVoaKHh1IvQ8P7udf
         tHfK5dfgfsVjZeBCzUWZg2wnAW7Fy3SGmFkfB6VHMEYNC5DILLFT8w5ExM1Rey4Eee2L
         Xat7Z4nHkQQCtxrK+aZliULJPZYhR43a1WDNhgFrRgt7GYcEMyaqyIm62zzP5OEsYb8f
         dEqA==
X-Gm-Message-State: AOAM533uaR/EGCiuvbwW4c9+64kU+14kvX9njL2LGfvy2Tb43xivBJdO
        2Kww8em3LSB2OV/dJEvCJ5Nk2Afb17NLjQ==
X-Google-Smtp-Source: ABdhPJzFkWpBSmRN+CmnmQDSA3JN3kuPjYC1/NBrERXWzD1EF78FQfkWkQTrHTKwvKJbU9zYU94Cdg==
X-Received: by 2002:a05:600c:378d:b0:38b:e12f:edde with SMTP id o13-20020a05600c378d00b0038be12feddemr3398093wmr.69.1647382974782;
        Tue, 15 Mar 2022 15:22:54 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b001f067c7b47fsm240710wru.27.2022.03.15.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:22:54 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: sgi-gru: Fix spelling mistake "unexpect" -> "unexpected"
Date:   Tue, 15 Mar 2022 22:22:53 +0000
Message-Id: <20220315222253.2960047-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/misc/sgi-gru/grukservices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index 0ea923fe6371..19dbdad8ad8a 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -1016,7 +1016,7 @@ static int quicktest1(unsigned long arg)
 			break;
 	}
 	if (ret != MQE_QUEUE_FULL || i != 4) {
-		printk(KERN_DEBUG "GRU:%d quicktest1: unexpect status %d, i %d\n",
+		printk(KERN_DEBUG "GRU:%d quicktest1: unexpected status %d, i %d\n",
 		       smp_processor_id(), ret, i);
 		goto done;
 	}
-- 
2.35.1

