Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA747F6E5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 14:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhLZNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 08:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhLZNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 08:06:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9259CC06173E;
        Sun, 26 Dec 2021 05:06:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t26so26905082wrb.4;
        Sun, 26 Dec 2021 05:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Cc0CjAt77hIrunEfusdW8XCE2Kz0EnQST2kqPFD4/8=;
        b=hkuehNrLkNlamaaObvVxwE91OjpiRDKzTpC5AHrxNVxg5RtrOWn735clZN1P+DBNUf
         KMwF3/teR2lLKai6prC4hTdZBxjEt/hBYt1OTr0QA69JUc/aPjU+0Wfpr9Q3pZVy7/Mz
         vh9WbVA8V9Kznh/WbjNhquqPqn17reZLF4GuYaWLQ4yf0+Da6xrvpc2BSBp7Dv+3MNXL
         t4yaBRkLkdvmtxABekuB01cOaVZ78fauCStllqwRDWGBpBOewRIy5X4V4+AYCFEkWrf1
         IIaPdIKFq6faVUOxTQGgBCMw2Hb0xBQWtfvbFyehLMl3KjuiKmzttZ3gcOwLcnuJ5QlS
         ps9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7Cc0CjAt77hIrunEfusdW8XCE2Kz0EnQST2kqPFD4/8=;
        b=B5IJlQIdoFG66ihxWK1QFQHgj5FoMorpyPbFleDBuA33lEJNX4QlPYr4O1hF+1Vrjg
         oxKklovOeQgMNiYpKCwhZ+YcWTUjTnkO0sZTR7bWKl4bImNWbgBGhTtA7JLVeuOqEpym
         KhSxcZSG5gcagoqq88q28KLHBo06WzJBosT2m9p4vcjjWoB//NB5X3fbrm8tYgMdW7cY
         B0jX5e2wG9Vyz1DGZmRdvSCHXqfGrQdiRWm4kiyzgDrScik3d2Vxx7BR+w/BJST/tVEA
         7ZZsJTs32tXM234D/v5d5EN1UXFSs78i7iGhOyVs0+ubZk+S9wvq/dZ3atPAfZrkK26o
         0r7w==
X-Gm-Message-State: AOAM53305Gko7aZAJIVseVC2p4ZBt8RWVW1GtNfB451vfjT7g6W5jfBO
        dF6s1i9p0Fq46vlHl1DvsJNGchKBWUkCkA==
X-Google-Smtp-Source: ABdhPJwZeg7MAs0CODoeD043WrJd4Tfii7iPWwzKkbeturdZ3Axepgbkf8VunDsLNe3ZLvBpxsmWVw==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr10048591wrh.278.1640523969148;
        Sun, 26 Dec 2021 05:06:09 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:164:43d0::eb26:19d2])
        by smtp.gmail.com with ESMTPSA id v1sm14621235wru.45.2021.12.26.05.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 05:06:08 -0800 (PST)
Sender: Hugo Valtier <hugo.valtier@gmail.com>
From:   Hugo VALTIER <hugo@valtier.fr>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo VALTIER <hugo@valtier.fr>
Subject: [PATCH] drivers: fix space-pre-comma typo in leds/leds-bd2802
Date:   Sun, 26 Dec 2021 14:05:30 +0100
Message-Id: <20211226130529.2075963-1-hugo@valtier.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes a checkpatch error.

Signed-off-by: Hugo VALTIER <hugo@valtier.fr>
---
 drivers/leds/leds-bd2802.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-bd2802.c b/drivers/leds/leds-bd2802.c
index 8bbaef5a2986..21745c10ead2 100644
--- a/drivers/leds/leds-bd2802.c
+++ b/drivers/leds/leds-bd2802.c
@@ -241,7 +241,7 @@ static void bd2802_enable(struct bd2802_led *led, enum led_ids id)
 	if (id == LED1)
 		value = LED_CTL(other_led_on, 1);
 	else
-		value = LED_CTL(1 , other_led_on);
+		value = LED_CTL(1, other_led_on);
 
 	bd2802_write_byte(led->client, BD2802_REG_CONTROL, value);
 }
-- 
2.25.1

