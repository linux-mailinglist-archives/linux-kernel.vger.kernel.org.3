Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A289F57DF5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiGVJ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGVJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:56:22 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 893DA31202
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YuM9i
        QSV99KgvNdiAyZaRQNkY4uiQh90vZgxqUMbeLg=; b=KQf71fERAWrCnimsTddIH
        CcfsROTWIaEGnyCpKdcBHacfaHw9tjBXbZe9AC2uF9zygsHWgD3YNnxFppixhiy7
        LVUsMCCMk4TVeTUOwZW8M18xyJXpf9TiaOzNzVTFPlyGgWT2R5OX4zpwSTNadvkD
        fIo75iS43zAv6s1Vef25R8=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp5 (Coremail) with SMTP id HdxpCgC3QigJdNpigYu3Pg--.21445S2;
        Fri, 22 Jul 2022 17:55:22 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] afs: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 17:55:19 +0800
Message-Id: <20220722095519.79124-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgC3QigJdNpigYu3Pg--.21445S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrJr1rtF1Dury5tr1ktF4Utwb_yoWxXFg_GF
        4Ut3y8Cw1Fyw1F93yq9FySyFWIgw4kWFnxJr4rKF1qgryUZr4xCw1DAw18AF1S9a98ta43
        WFyvgry7tr1UKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtcTP3UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAwFGZGB0LoTPLAAAs9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 fs/afs/flock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index c4210a3964d8..801fe305878f 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 }
 
 /*
- * Kill off all waiters in the the pending lock queue due to the vnode being
+ * Kill off all waiters in the pending lock queue due to the vnode being
  * deleted.
  */
 static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
-- 
2.25.1

