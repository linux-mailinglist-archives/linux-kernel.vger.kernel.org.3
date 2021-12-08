Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96C046CE91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbhLHH6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbhLHH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:58:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93783C061574;
        Tue,  7 Dec 2021 23:54:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so3572858pjb.1;
        Tue, 07 Dec 2021 23:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4Osc3q+VBWbQkYh7l8AUOiu9D9jC931YuaG+3vWxJI=;
        b=S0YBVlZoNy50MSGaguNVlkwl6JZ9/jJ8PE8I+EzGrzP/G9yJzWkC3gKohYvrb4nSdm
         E275b7huDkqUn2BnlYjqwKvD7V200W8d9Fq8ADWVTcTV7/sMnYOo8oh9fT+C77X5Tryq
         dRGLfcYuDiqYdxEEuAaiQ+a8DY2q7o9rOJRc63acE6QIbJd4nLCNmiGPJF85+l58Fat5
         JqV96uKzWQSXYc6KcPLvW5y8HrRFfHVzWGxHOO0hLZrI4zoLnFt+w2Tz7GlNzIYGefHF
         +78jKxPhlACczkXW/O9+KUiisNqTvkneaV5LHbe6HgRqsZJASsDgOBc1Vzkq7YAbt6Ue
         EPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4Osc3q+VBWbQkYh7l8AUOiu9D9jC931YuaG+3vWxJI=;
        b=mFcCKDYlMGb/PEnthxl3J1TZ2fKd55QxNYR+Y41OU71ZyT9kLelHCGHG6HdL8zEm1z
         kih8O9FyAoU/72bGWFNGaqiyQnFwmDCnSis21Xy8wcmjaa2ZbIgOR8wbKULKsmHRk4To
         F5Ddo/wvFog2X5HeCfMel92gWOud9PQX3iO7+y/zKlDd3a12Ffrbsb3vnZnpe+6CJ2Rt
         qlTaKwTa5pYxm58ddeGQiedXe1ghjdSqIbr6O7kxyb7h23WIsC4pIqocHvW8AlXeKsSj
         S/pn1YmauyZaC0SQXNxjFOsNINzughJIrqSFPUo4o7/s4HgV5UnFpaV5nZbmngn10tto
         5vEw==
X-Gm-Message-State: AOAM533w9qexlxIGHzemDm028aqEPoEpia3/2esT6/Fc5oOFHIrR5bTw
        +AOj5Q7tlpoarY0xltTSVlA=
X-Google-Smtp-Source: ABdhPJz8m6DjDz9mzLD1b6n3QNRvChd8+Ms915++fQFXWshCyjx5qaNHaFhdLmKYAnUW3QMxHKW82g==
X-Received: by 2002:a17:902:c713:b0:141:bbb2:1ec7 with SMTP id p19-20020a170902c71300b00141bbb21ec7mr57721343plp.57.1638950096205;
        Tue, 07 Dec 2021 23:54:56 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m13sm1710195pgt.22.2021.12.07.23.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 23:54:55 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] loop: Remove redundant assignments and parentheses
Date:   Wed,  8 Dec 2021 07:54:52 +0000
Message-Id: <20211208075452.404867-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The assignment of node has been done during initialization, and
the parentheses are meaningless according to the priority.

drivers/block/loop.c:1001:19: warning
Value stored to 'node' during its initialization is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/block/loop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index dfc72a1..0b74cbe 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -985,7 +985,7 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
-	struct rb_node **node = &(lo->worker_tree.rb_node), *parent = NULL;
+	struct rb_node **node = &lo->worker_tree.rb_node, *parent = NULL;
 	struct loop_worker *cur_worker, *worker = NULL;
 	struct work_struct *work;
 	struct list_head *cmd_list;
@@ -995,8 +995,6 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	if (queue_on_root_worker(cmd->blkcg_css))
 		goto queue_work;
 
-	node = &lo->worker_tree.rb_node;
-
 	while (*node) {
 		parent = *node;
 		cur_worker = container_of(*node, struct loop_worker, rb_node);
-- 
2.15.2


