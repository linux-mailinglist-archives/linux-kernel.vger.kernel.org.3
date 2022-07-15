Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797E9575B23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiGOGBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiGOGBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:01:49 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A8B077490
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6rXo2
        CCKIMG2UcoJX7POKCeJo8h6LGhNBiII3ZbO6nA=; b=pCRl8VqE15TRb+BHZsILT
        h/a70ANAS6k2WJDqj8JcoloYef9frknuBf7V/XifCicOmfSWLegLvvLWnR9gZlVz
        eJggMW6v0Z07ErFHkn4dmbsBvqQb229DRhEekmiBgUlKZgMgv6gy3zLzai++kCwq
        dGHoydNLwulHmMOFdYZZck=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp9 (Coremail) with SMTP id DcCowADH3h2XAtFi0KELPg--.52137S2;
        Fri, 15 Jul 2022 14:00:56 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        akpm@linux-foundation.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] fs/ocfs2: Fix spelling typo in comment
Date:   Fri, 15 Jul 2022 14:00:35 +0800
Message-Id: <20220715060035.632903-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowADH3h2XAtFi0KELPg--.52137S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5Jw1DtF1kKrg_yoW3trgEkw
        4xt3y09r4UZF4Sy3s5u3yftF4Fg3yrCF1UWr17XF98Gw1qga1DJryvyrySy34qgrW7tFW5
        Z3s8t3yYkr4xZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0niSJUUUUU==
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbizR4-+1c7NgYCdAABs8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/ocfs2/quota_global.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 0b6f551a342a..dc9f76ab7e13 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -412,7 +412,7 @@ int ocfs2_global_read_info(struct super_block *sb, int type)
 	goto out_err;
 }
 
-/* Write information to global quota file. Expects exlusive lock on quota
+/* Write information to global quota file. Expects exclusive lock on quota
  * file inode and quota info */
 static int __ocfs2_global_write_info(struct super_block *sb, int type)
 {
-- 
2.25.1

