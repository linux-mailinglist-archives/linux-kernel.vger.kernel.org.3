Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154D3574E70
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiGNM4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiGNM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:56:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9CD4D4F5;
        Thu, 14 Jul 2022 05:56:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o8so988187wms.2;
        Thu, 14 Jul 2022 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbTEm3oI6IgJFHsJWIHl+dQRVX68qV+BiPO2Jb+Qzcs=;
        b=aYafQQptpaj/jiAhls31/DMXbevapRrMNC4lYXGqKMk+WxvJH4CEUhd337xJdMlAtx
         dJHTi98XvDkj7TcURAng17HC0quMVUlP4guZ9gldHQIpnwAqH8d6CHvn0BaVRg2Kie80
         /9NQn4Ip4tsAOi8c4oKzTnJJ5BTv6s62RrZCamuIl3IhaKwxhRJOdSVYLrYGa6zYNXk9
         Y31qtNkjgej7UuTcd39GDn082uEXjZFzbXGUvK9k9MQmLqr76xDYcrJiomvItGQzKcoD
         wQOuDUrVVwaLl8bE9c+W0GCJKuJHsxS9flAKqEUR8KZ79u0C647AhHF2znv9yZGaaQ+G
         7RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbTEm3oI6IgJFHsJWIHl+dQRVX68qV+BiPO2Jb+Qzcs=;
        b=HlRUxVU2FlGmsgf1Yx08qYLMENE1Pk1S+kcmu8yFzqPrt9vCRi60GCRUWBAbJP1tT0
         R+lN+kS0n/s3120pMiEQgOzXNA9dc5cMgJBCPszmALdqo2D3DntWTgPZ3Vjojugr/ogd
         acsC8p+KXCSdt8FPdy3lKp3Ac+6d+WwA/0kHiwpy3u2p+YLz79Vjhu1+L+bGqiQHwBjA
         VAk5ffh2EjhHTLgTGfNDfXzdJVjTv1GxGNUIfXDukinUiw1THBI7yPzo5hhHEHtFxKhv
         rcK/9gRgXsXpD2qbM97ikfTSBpOGB5wq7Ol5F9Gg+qXaOI6aSBcFqKIrBe4NTfLAhKAt
         kEjw==
X-Gm-Message-State: AJIora8Ws2zAcP1etNsQWQSMfBjF/chkJ8pQrGwbo6xk5T/w8Kfpui2T
        BuhsfviyqG7LlglaWU76lwc=
X-Google-Smtp-Source: AGRyM1vphDRTHe0FjntvAsam/bcOuRYiK+SBQJ5eie6byGyPW63ldZxb3fv3ZQMexvhYOitoK503uQ==
X-Received: by 2002:a05:600c:1c0e:b0:3a1:9a4b:28ee with SMTP id j14-20020a05600c1c0e00b003a19a4b28eemr14609203wms.203.1657803362957;
        Thu, 14 Jul 2022 05:56:02 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b0039ee391a024sm5733425wms.14.2022.07.14.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 05:56:02 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: flip-work: rename commited -> committed
Date:   Thu, 14 Jul 2022 13:56:01 +0100
Message-Id: <20220714125601.34812-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

There is a spelling mistake in the list head variable, rename it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/drm_flip_work.c | 10 +++++-----
 include/drm/drm_flip_work.h     |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_flip_work.c b/drivers/gpu/drm/drm_flip_work.c
index 060b753881a2..8efb5f2c5773 100644
--- a/drivers/gpu/drm/drm_flip_work.c
+++ b/drivers/gpu/drm/drm_flip_work.c
@@ -104,7 +104,7 @@ void drm_flip_work_commit(struct drm_flip_work *work,
 	unsigned long flags;
 
 	spin_lock_irqsave(&work->lock, flags);
-	list_splice_tail(&work->queued, &work->commited);
+	list_splice_tail(&work->queued, &work->committed);
 	INIT_LIST_HEAD(&work->queued);
 	spin_unlock_irqrestore(&work->lock, flags);
 	queue_work(wq, &work->worker);
@@ -122,8 +122,8 @@ static void flip_worker(struct work_struct *w)
 
 		INIT_LIST_HEAD(&tasks);
 		spin_lock_irqsave(&work->lock, flags);
-		list_splice_tail(&work->commited, &tasks);
-		INIT_LIST_HEAD(&work->commited);
+		list_splice_tail(&work->committed, &tasks);
+		INIT_LIST_HEAD(&work->committed);
 		spin_unlock_irqrestore(&work->lock, flags);
 
 		if (list_empty(&tasks))
@@ -149,7 +149,7 @@ void drm_flip_work_init(struct drm_flip_work *work,
 {
 	work->name = name;
 	INIT_LIST_HEAD(&work->queued);
-	INIT_LIST_HEAD(&work->commited);
+	INIT_LIST_HEAD(&work->committed);
 	spin_lock_init(&work->lock);
 	work->func = func;
 
@@ -165,6 +165,6 @@ EXPORT_SYMBOL(drm_flip_work_init);
  */
 void drm_flip_work_cleanup(struct drm_flip_work *work)
 {
-	WARN_ON(!list_empty(&work->queued) || !list_empty(&work->commited));
+	WARN_ON(!list_empty(&work->queued) || !list_empty(&work->committed));
 }
 EXPORT_SYMBOL(drm_flip_work_cleanup);
diff --git a/include/drm/drm_flip_work.h b/include/drm/drm_flip_work.h
index 21c3d512d25c..2e1342cdc568 100644
--- a/include/drm/drm_flip_work.h
+++ b/include/drm/drm_flip_work.h
@@ -67,15 +67,15 @@ struct drm_flip_task {
  * @func: callback fxn called for each committed item
  * @worker: worker which calls @func
  * @queued: queued tasks
- * @commited: commited tasks
- * @lock: lock to access queued and commited lists
+ * @committed: committed tasks
+ * @lock: lock to access queued and committed lists
  */
 struct drm_flip_work {
 	const char *name;
 	drm_flip_func_t func;
 	struct work_struct worker;
 	struct list_head queued;
-	struct list_head commited;
+	struct list_head committed;
 	spinlock_t lock;
 };
 
-- 
2.35.3

