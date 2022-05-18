Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05E752BE17
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiEROuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbiEROuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:50:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE6E1966AB;
        Wed, 18 May 2022 07:50:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k126so1287924wme.2;
        Wed, 18 May 2022 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XxzsoVj48zOzOROlVdTIcCV40gZjRv+E/wRXittuHe4=;
        b=M8keaq77DHaZACZ89t0WJ5aJXHNxjXr8DfdKgw5prDV/AJ6dGjCZ99LpbuxDJeGbwr
         cT/5BIvXDpBeql6kqW5R9O26KrsjW31fGmHmGeSbfLuDsE3xbqltfrIApWXWyktbhF0t
         QFMUtXIHl6AGxoOCIPHWJf/140lXzY+sQmLHE+OZwO2dXGeTOuBm2WuhCaQd6qUFCVqI
         7U9JkBaJ8rAD5zUTpNsl+9hkl7EmF3KXXbbBgnygeV+eJwLG84sV5hZCJlbtg+dvMEqj
         g3h7vtwny7vizcOKmaHLbykvDmaF4SZP+0nLE/iaD12cRqX6ZO3YTMy4b4zEqmrspws7
         SOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XxzsoVj48zOzOROlVdTIcCV40gZjRv+E/wRXittuHe4=;
        b=1G1aEn4G77hVeUr9k2QVA05Xo51WOwT1UTjDSbxwBeh72H+i5Q1ktIoSxkE+lviIZz
         K9ZTmeCc96vaOq2u1ANobmpt5npVYzYPKVIvy+HIImZHCv7jOrfdC9QCpC3cZdg9ApYO
         vnik1uDxQcI1j31Mg4KJls+gf+yP9E3EoU9cX+HisYVqa5U0bCDFR7CHj7sVzuHf7vvN
         gMDI1C7lM2M0k2cH4IleWOtY+tk8bKGA6zWezGMPhEdZAd3DGF/8w87d2DQgRDe4EoIj
         O/9o/5Nw3ltIN22BLe7hNcwukSF74xS0CVcu0/XoJNFBtNo2mUs/7/6kGukurZWlDrWD
         0kTg==
X-Gm-Message-State: AOAM5331rU1BEOuYsMXiSsD1tfJHHi7K/OC1UsiW7o/VaIIzButdr9CJ
        IIxHdPYEMg8+oN12XryrZ2W+LUuMsfw=
X-Google-Smtp-Source: ABdhPJyPeirV+O6ePckfRFQyYkdtF0Nqd0PjqudQTpn0z7oAoNaiuVbY8isEuFSg3lXQNXBgsV9vxg==
X-Received: by 2002:a1c:7414:0:b0:394:1d5d:27f2 with SMTP id p20-20020a1c7414000000b003941d5d27f2mr293580wmc.37.1652885410670;
        Wed, 18 May 2022 07:50:10 -0700 (PDT)
Received: from DESKTOP-URN0IMF.localdomain (cpc78047-stav21-2-0-cust145.17-3.cable.virginm.net. [80.195.223.146])
        by smtp.gmail.com with ESMTPSA id h15-20020adfa4cf000000b0020c5253d8d3sm2510356wrb.31.2022.05.18.07.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 07:50:09 -0700 (PDT)
From:   Oliver Ford <ojford@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ojford@gmail.com, kernel-janitors@vger.kernel.org
Subject: [PATCH] fs: inotify: Fix typo in inotify comment
Date:   Wed, 18 May 2022 15:49:57 +0100
Message-Id: <20220518144957.30761-1-ojford@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Correct spelling in comment.

Signed-off-by: Oliver Ford <ojford@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 54583f62dc44..bdd8436c4a7a 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -121,7 +121,7 @@ static inline u32 inotify_mask_to_arg(__u32 mask)
 		       IN_Q_OVERFLOW);
 }
 
-/* intofiy userspace file descriptor functions */
+/* inotify userspace file descriptor functions */
 static __poll_t inotify_poll(struct file *file, poll_table *wait)
 {
 	struct fsnotify_group *group = file->private_data;
-- 
2.35.1

