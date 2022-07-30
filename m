Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5058599A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiG3JbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiG3Ja6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:30:58 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5A86422C8;
        Sat, 30 Jul 2022 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VtLxG
        YUKsqRZmAMfWFSey+7oyYUHvAChpaj5Z7Ci4iQ=; b=JlLaTs5J7otdLFcrsrUmg
        5zXXpn+tt1FbLEZtWtuPr2jrhMdleZC2D+8BX8dnaCWdQQt1Sdqw5xU28Zl2tViM
        /pKxk93WA621XfRsVvaradyuoAW7t0civHczZxA0kCooi9pAGcSwsHU8RUb1Pnva
        YGdy17HSoE4SN+PLvCKsPs=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp1 (Coremail) with SMTP id GdxpCgBXNLYb+uRip9TTRQ--.60279S2;
        Sat, 30 Jul 2022 17:30:05 +0800 (CST)
From:   studentxswpy@163.com
To:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     djwong@kernel.org, Xie Shaowen <studentxswpy@163.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH -next] xfs: delete extra space and tab in blank line
Date:   Sat, 30 Jul 2022 17:29:59 +0800
Message-Id: <20220730092959.3103627-1-studentxswpy@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgBXNLYb+uRip9TTRQ--.60279S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW3Jr43uw1kWF43ZF13Arb_yoW8KrWxp3
        s2k3s8Gw1fGFyjkr9ayr4jqw15Can5Gr1UGrZ7J3W2qa47Gr17Zrs3t34jvas5WFZ7Zry0
        vFWvyF1DX3Z5CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0SoXUUUUU=
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xvwxvv5qw024ls16il2tof0z/xtbBER1OJFaEJ332cwAAsr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie Shaowen <studentxswpy@163.com>

delete extra space and tab in blank line, there is no functional change.

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: Xie Shaowen <studentxswpy@163.com>
---
 fs/xfs/xfs_extfree_item.c | 12 ++++++------
 fs/xfs/xfs_log.c          |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 765be054dffe..08b0c8b553fc 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -187,12 +187,12 @@ xfs_efi_copy_format(xfs_log_iovec_t *buf, xfs_efi_log_format_t *dst_efi_fmt)
 {
 	xfs_efi_log_format_t *src_efi_fmt = buf->i_addr;
 	uint i;
-	uint len = sizeof(xfs_efi_log_format_t) + 
-		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_t);  
-	uint len32 = sizeof(xfs_efi_log_format_32_t) + 
-		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_32_t);  
-	uint len64 = sizeof(xfs_efi_log_format_64_t) + 
-		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_64_t);  
+	uint len = sizeof(xfs_efi_log_format_t) +
+		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_t);
+	uint len32 = sizeof(xfs_efi_log_format_32_t) +
+		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_32_t);
+	uint len64 = sizeof(xfs_efi_log_format_64_t) +
+		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_64_t);
 
 	if (buf->i_len == len) {
 		memcpy((char *)dst_efi_fmt, (char*)src_efi_fmt, len);
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index ae904b21e9cc..6f661fadb755 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -2000,7 +2000,7 @@ xlog_calc_iclog_size(
 }
 
 /*
- * Flush out the in-core log (iclog) to the on-disk log in an asynchronous 
+ * Flush out the in-core log (iclog) to the on-disk log in an asynchronous
  * fashion.  Previously, we should have moved the current iclog
  * ptr in the log to point to the next available iclog.  This allows further
  * write to continue while this code syncs out an iclog ready to go.
@@ -2042,7 +2042,7 @@ xlog_sync(
 	xlog_grant_add_space(log, &log->l_write_head.grant, roundoff);
 
 	/* put cycle number in every block */
-	xlog_pack_data(log, iclog, roundoff); 
+	xlog_pack_data(log, iclog, roundoff);
 
 	/* real byte length */
 	size = iclog->ic_offset;
-- 
2.25.1

