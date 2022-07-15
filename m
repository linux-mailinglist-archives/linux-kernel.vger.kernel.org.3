Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F77575CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiGOHws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiGOHwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:52:44 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7335A7D1EE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:52:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E22A61E80D27;
        Fri, 15 Jul 2022 15:49:10 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sluIl3rqyAjs; Fri, 15 Jul 2022 15:49:08 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 2875D1E80D1B;
        Fri, 15 Jul 2022 15:49:08 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Dong Chuanjian <chuanjian@nfschina.com>
Subject: [PATCH] afs/dir: Fix typo in string
Date:   Fri, 15 Jul 2022 15:52:37 +0800
Message-Id: <20220715075237.4093-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated ',' from string

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index d98e109ecee9..a01a61fc4cf1 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -214,7 +214,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	loff_t i_size;
 	int slot;
 
-	_enter(",,{%d,%s},", name->len, name->name);
+	_enter(",{%d,%s},", name->len, name->name);
 
 	i_size = i_size_read(&vnode->vfs_inode);
 	if (i_size > AFS_DIR_BLOCK_SIZE * AFS_DIR_MAX_BLOCKS ||
-- 
2.18.2

