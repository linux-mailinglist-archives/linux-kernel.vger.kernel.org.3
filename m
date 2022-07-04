Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB95564BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiGDCiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiGDCiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:38:06 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2D4764D8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 19:38:05 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 296EA1E80CCF;
        Mon,  4 Jul 2022 10:36:12 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i1NA-UW8mOBP; Mon,  4 Jul 2022 10:36:09 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 620CE1E80C90;
        Mon,  4 Jul 2022 10:36:09 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Li zeming <zeming@nfschina.com>
Subject: [PATCH] afs/_enter: Fix typo in string
Date:   Mon,  4 Jul 2022 10:37:39 +0800
Message-Id: <20220704023739.3523-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated ',' from string

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/afs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 56ae5cd5184f..0628e843949f 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -574,7 +574,7 @@ static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
 	struct afs_lookup_one_cookie *cookie =
 		container_of(ctx, struct afs_lookup_one_cookie, ctx);
 
-	_enter("{%s,%u},%s,%u,,%llu,%u",
+	_enter("{%s,%u},%s,%u,%llu,%u",
 	       cookie->name.name, cookie->name.len, name, nlen,
 	       (unsigned long long) ino, dtype);
 
@@ -643,7 +643,7 @@ static int afs_lookup_filldir(struct dir_context *ctx, const char *name,
 		container_of(ctx, struct afs_lookup_cookie, ctx);
 	int ret;
 
-	_enter("{%s,%u},%s,%u,,%llu,%u",
+	_enter("{%s,%u},%s,%u,%llu,%u",
 	       cookie->name.name, cookie->name.len, name, nlen,
 	       (unsigned long long) ino, dtype);
 
-- 
2.18.2

