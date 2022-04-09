Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E94FA5A5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiDIHzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbiDIHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:55:03 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519E932FDE6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 00:52:57 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p135so7226131iod.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9mD/yV8z2vnJwKkyc2vW5H7BXGV5SMHDI/OBudkqAE=;
        b=gxM5BMk81CwQ33kmlfo4Aaqny7Y/pxaKUBrKsH2SpDVnHvz0Cm3qUJ29yhXJhvNNuX
         +0n/Wvb0uH0U3ynXRTM1IQQtQdtDf+uXTsFnJ+JZIEB9hBPRVapaFDrZlnEFLDo89whI
         1e9tA68EFeneSRZTAIBvOUHltFaXq9OW7XWqOZEkU7rIKfsuZwE8uJen9eSR9kQ6JrLM
         B1+4Cw0AT8kGLALyDh40648uhzKP7YYajvBMa65tuR1IXBPP3TlyCF+cPtc8tV5HrKnO
         fzq3O7wY5P5kkZ87GQmMhk6qdBIMowlN9Zqvw8B3P48HGcLTWnCfDWLst5z3h8e4Wm9M
         vyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9mD/yV8z2vnJwKkyc2vW5H7BXGV5SMHDI/OBudkqAE=;
        b=3hmAi+hl8qX7dy9vatoqpClwM3NlsrSme1mR4+e5D21QS0PZsdask62lzUbT+GKQjG
         ZYDIDDBabACMm1MgvyUasPKXmKU1oojI6AvGzWuD4zCbTD7Ljktjqh6MnBKebq9eIzXZ
         zVD+MswKhxqGALG1hGeVap9IbJdnCTdTlcq8S9GBYTBYf4MucBD2DDCwCHdnyHmJiOvL
         qofFE76k28mVsiL7tzKdzgcIOWWUzNM6ZMtJrKpWyP4oIcGkaxY+/JYJouuEA2+z0lYC
         aV5XoqPWmQ0QtW5st1hIKxNr7suz4NQL+ubkH1x68FME0mblAasCQ2olSUruabByUrNH
         JNmQ==
X-Gm-Message-State: AOAM533P+u6KyJk6pUiGvWTp7o1lDn7QrlBcOxwoRyrqk3q0PVJRd47z
        B1QYF+JrQvRwmYqfjhO3L0A=
X-Google-Smtp-Source: ABdhPJzVQYlyY5ewWXmUyrOkjHU/+ABr0Ewjk3epV3on6lkSmvm8OUBFdEP+v229Ql8JLoRfUah4yg==
X-Received: by 2002:a6b:8e91:0:b0:645:c11f:e322 with SMTP id q139-20020a6b8e91000000b00645c11fe322mr10074519iod.162.1649490776641;
        Sat, 09 Apr 2022 00:52:56 -0700 (PDT)
Received: from localhost ([240e:390:a28:12c0:449c:329d:d29b:9026])
        by smtp.gmail.com with UTF8SMTPSA id p7-20020a92d487000000b002caa066f9e4sm335787ilg.88.2022.04.09.00.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 00:52:56 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     schspa@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] lockdep: doc: fix function documentation
Date:   Sat,  9 Apr 2022 15:52:45 +0800
Message-Id: <20220409075245.62628-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

Correct the struct description to correct position in the comment.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 kernel/locking/lockdep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c06cab6546ed..f4782564d710 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -353,13 +353,13 @@ struct pending_free {
 /**
  * struct delayed_free - data structures used for delayed freeing
  *
- * A data structure for delayed freeing of data structures that may be
- * accessed by RCU readers at the time these were freed.
- *
  * @rcu_head:  Used to schedule an RCU callback for freeing data structures.
  * @index:     Index of @pf to which freed data structures are added.
  * @scheduled: Whether or not an RCU callback has been scheduled.
  * @pf:        Array with information about data structures about to be freed.
+ *
+ * A data structure for delayed freeing of data structures that may be
+ * accessed by RCU readers at the time these were freed.
  */
 static struct delayed_free {
 	struct rcu_head		rcu_head;
@@ -1666,6 +1666,7 @@ static inline struct lock_list *__bfs_next(struct lock_list *lock, int offset)
  * @source_entry: the source of the path we are searching for.
  * @data: data used for the second parameter of @match function
  * @match: match function for the search
+ * @skip: skip function for the search
  * @target_entry: pointer to the target of a matched path
  * @offset: the offset to struct lock_class to determine whether it is
  *          locks_after or locks_before
-- 
2.24.3 (Apple Git-128)

