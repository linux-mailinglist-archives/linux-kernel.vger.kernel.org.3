Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489F557DA38
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiGVGX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVGXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:23:55 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30905237F6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=d3046
        daowSbgRqY2l3cIRrOy3/qPsT9inVOWMV6InH4=; b=g9cYZok2TELRBNpn8U78T
        3RpjJ2ZcYRv+pcQoLNQLX+I5mRu3HDk4677UY9j7RmXcq1HSr6LJkBvJBy6KLIO3
        zcgpjT8rZ06FLzthorRfwOCtovcxgVUQ1nH1IvF33yTCTfb+4w4vHwBHKBhkWzHZ
        +qdJ5XxORit7YnerDohwe4=
Received: from zd-ThinkPad-X390.kernelci.com (unknown [106.19.210.167])
        by smtp14 (Coremail) with SMTP id EsCowAAXZOBFQtpiiuy4OQ--.203S2;
        Fri, 22 Jul 2022 14:23:07 +0800 (CST)
From:   zhangduo <zduo006@163.com>
To:     naveen.n.rao@linux.ibm.com
Cc:     anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        zhangduo <zhangduo@kylinos.cn>
Subject: [PATCH 2/2] kprobes: fix the comments error
Date:   Fri, 22 Jul 2022 14:25:05 +0800
Message-Id: <20220722062505.20309-1-zduo006@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAAXZOBFQtpiiuy4OQ--.203S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrWr13JFy7uryxGry7Xw1DJrb_yoWxGFg_Cw
        18KrWI9r4Y9rW0vrn0ka1Fqrs2kry3WF4rC34UJFZ7Jw43Jry5tFs8Wr1jqa93G34DGFZ8
        Ary5Wr1qqF47ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8n2-5UUUUU==
X-Originating-IP: [106.19.210.167]
X-CM-SenderInfo: p2gx0iiqw6il2tof0z/1tbiVgxGc1qzswvXMAAAsZ
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangduo <zhangduo@kylinos.cn>

fix the comments 'Copy the insn slot of ap to p'

Signed-off-by: zhangduo <zhangduo@kylinos.cn>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f1dddc8fe..8bcef7d3c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1349,7 +1349,7 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 			    | KPROBE_FLAG_DISABLED;
 	}
 
-	/* Copy the insn slot of 'p' to 'ap'. */
+	/* Copy the insn slot of 'ap' to 'p'. */
 	copy_kprobe(ap, p);
 	ret = add_new_kprobe(ap, p);
 
-- 
2.25.1

