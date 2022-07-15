Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA2575CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiGOHse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiGOHsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:48:31 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 290777C1B0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:48:30 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 646A51E80D11;
        Fri, 15 Jul 2022 15:44:57 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3I6Jw3BDA2vP; Fri, 15 Jul 2022 15:44:54 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 987C81E80D19;
        Fri, 15 Jul 2022 15:44:54 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] afs/file: Fix typo in string
Date:   Fri, 15 Jul 2022 15:48:22 +0800
Message-Id: <20220715074822.57403-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated ',' from string

Signed-off-by: Zhou jie <zhoujie@nfschina.com>

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 26292a110a8f..19202e7f400b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -287,7 +287,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 {
 	struct afs_operation *op;
 
-	_enter("%s{%llx:%llu.%u},%x,,,",
+	_enter("%s{%llx:%llu.%u},%x,",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
-- 
2.18.2

