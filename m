Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93D3483AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 04:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiADD2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 22:28:43 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:57397 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbiADD2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 22:28:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V0oYcpc_1641266920;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V0oYcpc_1641266920)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jan 2022 11:28:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     paolo.valente@linaro.org
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] bfq: Fix __bfq_lookup_next_entity() kernel-doc comment
Date:   Tue,  4 Jan 2022 11:28:38 +0800
Message-Id: <20220104032838.95748-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @in_service to remove warning found
by running scripts/kernel-doc, which is caused by
using 'make W=1'.
block/bfq-wf2q.c:1399: warning: Function parameter or member
'in_service' not described in '__bfq_lookup_next_entity'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 block/bfq-wf2q.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index b74cc0da118e..ab05e973342e 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1375,6 +1375,7 @@ static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st,
 /**
  * __bfq_lookup_next_entity - return the first eligible entity in @st.
  * @st: the service tree.
+ * @in_service: Check whether an in-service entity exists.
  *
  * If there is no in-service entity for the sched_data st belongs to,
  * then return the entity that will be set in service if:
-- 
2.20.1.7.g153144c

