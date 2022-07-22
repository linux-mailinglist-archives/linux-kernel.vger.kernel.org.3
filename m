Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5336757DF55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiGVKHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGVKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:07:11 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93C8C6F7D3;
        Fri, 22 Jul 2022 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UL7zA
        C14RlOv/0MPaH26FFgCncWrwy6gp+B6w4ruLOY=; b=po9aQwRaYtVvF4pNdd8+E
        rwF9avqwCA+udjvTzhI7BkH75oD4Vvu5zP1RhjhoDZS4dmttM/TkHcZRhh3bhcvq
        rtPY+h/EnDYld8iJrtWGhxCp0B89lpOaYLdBt3AvEc5WxSacKDikc0c7R2IdHaxc
        AiKP9n/EhBn6aQ1ADCcETU=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp2 (Coremail) with SMTP id GtxpCgA3Sre_dtpiAM9oQg--.5395S2;
        Fri, 22 Jul 2022 18:06:57 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     djwong@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] xfs: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:06:54 +0800
Message-Id: <20220722100654.80002-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgA3Sre_dtpiAM9oQg--.5395S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF18Kr1UXF45WrWxtFW5Jrb_yoW8Wry7pr
        Zak3W5CF4kWF18Zr47Jw1vvw1rC393uF1jvr1vq3yavr15JF4SvrW2yr1xXw1UXFs3XFs0
        qF98tr47ZFW3WaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi0zu9UUUUU=
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQpGZGBbEb2utwAAsT
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
 fs/xfs/libxfs/xfs_alloc.c | 2 +-
 fs/xfs/xfs_dquot.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 41557c430cb6..e2bdf089c0a3 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -84,7 +84,7 @@ xfs_prealloc_blocks(
 /*
  * The number of blocks per AG that we withhold from xfs_mod_fdblocks to
  * guarantee that we can refill the AGFL prior to allocating space in a nearly
- * full AG.  Although the the space described by the free space btrees, the
+ * full AG.  Although the space described by the free space btrees, the
  * blocks used by the freesp btrees themselves, and the blocks owned by the
  * AGFL are counted in the ondisk fdblocks, it's a mistake to let the ondisk
  * free space in the AG drop so low that the free space btrees cannot refill an
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 5a6c3c3c4de2..8fb90da89787 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -549,7 +549,7 @@ xfs_dquot_check_type(
 	 * at the same time.  The non-user quota file can be switched between
 	 * group and project quota uses depending on the mount options, which
 	 * means that we can encounter the other type when we try to load quota
-	 * defaults.  Quotacheck will soon reset the the entire quota file
+	 * defaults.  Quotacheck will soon reset the entire quota file
 	 * (including the root dquot) anyway, but don't log scary corruption
 	 * reports to dmesg.
 	 */
-- 
2.25.1

