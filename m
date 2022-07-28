Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF520583F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiG1Mmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiG1Mmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:42:44 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDDEA4F6AE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zFbZL
        17nGL4pVWSrFgSLqXgwNxxFONbEFRuzb2D+CqY=; b=e4lCcbz0clVGteA+fq8dp
        YhNSxKN/gUIvdyDJHZ7BOlKmkq+OgVJrEsGh0TuVjgBtQpBdkL4E3J6vUSHOtzdT
        nuVjZDndN6vQtD8eWC8lYIvmfrMSLpy/WlEq3pwFpNSVExBPdV+rCyXWQIz9VjSD
        3xQtUnFoFQ/OoZ3Qvl1MZs=
Received: from zd-ThinkPad-X390.kernelci.com (unknown [175.9.180.245])
        by smtp8 (Coremail) with SMTP id DMCowAA3wQ_0g+JiV8n_QA--.2429S2;
        Thu, 28 Jul 2022 20:41:25 +0800 (CST)
From:   zhangduo <zduo006@163.com>
To:     zduo006@163.com
Cc:     anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        naveen.n.rao@linux.ibm.com, zhangduo@kylinos.cn
Subject: [PATCH 1/2] kprobes: fix the comments error
Date:   Thu, 28 Jul 2022 20:41:16 +0800
Message-Id: <20220728124117.56528-1-zduo006@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722062505.20309-1-zduo006@163.com>
References: <20220722062505.20309-1-zduo006@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAA3wQ_0g+JiV8n_QA--.2429S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrAFyfKFW3uw4UZw15Xr17GFg_yoWxGwb_Cw
        18KrW29r4Y9rW0vrn0kw4Fqrs2kry3WF4rC34UGFZ7tw43Jry5tFs8Wr1qqa93W34DGFWD
        Aw15Wr4qqF43ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRib18tUUUUU==
X-Originating-IP: [175.9.180.245]
X-CM-SenderInfo: p2gx0iiqw6il2tof0z/1tbiThVMc1UDQsSjkgAAsF
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

