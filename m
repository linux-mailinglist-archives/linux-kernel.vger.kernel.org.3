Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32907583F27
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbiG1Mps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbiG1Mpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:45:41 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED4A0248C3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zFbZL
        17nGL4pVWSrFgSLqXgwNxxFONbEFRuzb2D+CqY=; b=RE32iP5dk4SPFMxv31Pou
        +Zd7v4nBa0j6gn+o7uKHHgqDuh7JwoyptrF0p803DNSO6OlwEFhI/tl4J8fDKkjZ
        fL/8EHZ3PO1TGwa/1RJ4+Bo8Xmef1A1ipQnKWSelAMI7xy+PPDZAN8Jwe6rLB1MQ
        0l2Mmj4vMWiCnGdFtJI59g=
Received: from zd-ThinkPad-X390.kernelci.com (unknown [175.9.180.245])
        by smtp14 (Coremail) with SMTP id EsCowAC31bG0hOJihOXfPg--.2209S2;
        Thu, 28 Jul 2022 20:44:38 +0800 (CST)
From:   zhangduo <zduo006@163.com>
To:     zduo006@163.com
Cc:     anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        naveen.n.rao@linux.ibm.com, zhangduo@kylinos.cn
Subject: [PATCH 1/2] kprobes: fix the comments error
Date:   Thu, 28 Jul 2022 20:44:27 +0800
Message-Id: <20220728124427.59746-1-zduo006@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAC31bG0hOJihOXfPg--.2209S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrAFyfKFW3uw4UZw15Xr17GFg_yoWxGwb_Cw
        18KrW29r4Y9rW0vrn0kw4Fqrs2kry3WF4rC34UGFZ7tw43Jry5tFs8Wr1qqa93W34DGFWD
        Aw15Wr4qqF43ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRNeoUUUUUU==
X-Originating-IP: [175.9.180.245]
X-CM-SenderInfo: p2gx0iiqw6il2tof0z/1tbiYxZMc1aEKMWpJwAAs7
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

fix the comments to 'Copy the insn slot of ap to p'

Signed-off-by: zhangduo <zhangduo@kylinos.cn>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c08..4f3e84343 100644
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

