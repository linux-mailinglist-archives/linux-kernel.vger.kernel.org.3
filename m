Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41F57E770
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbiGVTdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiGVTdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:33:06 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE14D4E5;
        Fri, 22 Jul 2022 12:32:58 -0700 (PDT)
X-QQ-mid: bizesmtp87t1658518368t5bo1ksf
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 03:32:13 +0800 (CST)
X-QQ-SSF: 0100000000000030C000B00A0000020
X-QQ-FEAT: MvcY5ctQrZ+448wqI7+R4ff8SABg5kVWa7DJFhHYAsqFlMxgsYb48aetd0HDs
        I6Bucy6liltHz4B+jgMxu29h06UvGmwvj0suzI529vddHW/e9PTxqPY9shER/Q3e8DvrZFg
        999rpyVtsTFVRDdL06ZQVzqZeokvPFxuQwgBzj1p9dascRLSaPJ/kMZFyb3tn0IIawau3FB
        EfRh8cgpNO3Ute6rBa8GVHF2kiTFIWQ5IBPLc0+UxL0NLcU/OoAisktnQjAvqt03TIc0mKg
        v3HKC7EPCwBxXYLgtrAwkF0RIz6wqjc6QEEC3pt5JBTuDJLWd9abto+fjxAfvCIYvTqh88U
        JQ7EWobh9Kw/omMZuQ=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] xfs: Fix comment typo
Date:   Sat, 23 Jul 2022 03:32:11 +0800
Message-Id: <20220722193211.17816-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `being' is duplicated in line 553, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 fs/xfs/xfs_inode_item.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 721def0639fd..d1c5d0658779 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -550,7 +550,7 @@ xfs_inode_item_push(
 
 	if (!bp || (ip->i_flags & XFS_ISTALE)) {
 		/*
-		 * Inode item/buffer is being being aborted due to cluster
+		 * Inode item/buffer is being aborted due to cluster
 		 * buffer deletion. Trigger a log force to have that operation
 		 * completed and items removed from the AIL before the next push
 		 * attempt.
-- 
2.30.2

