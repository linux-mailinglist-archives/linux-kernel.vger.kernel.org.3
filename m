Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16F95AFA7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiIGDQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIGDQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:16:34 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86B777C754
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:16:32 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id A76F21E80D59;
        Wed,  7 Sep 2022 11:15:19 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h_29_JqVraBC; Wed,  7 Sep 2022 11:15:17 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id DAFAD1E80D57;
        Wed,  7 Sep 2022 11:15:16 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     masahiroy@kernel.org, ddiss@suse.de, akpm@linux-foundation.org,
        nicolas@fjasle.eu
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] usr: Remove unnecessary '-1' values from file
Date:   Wed,  7 Sep 2022 11:16:20 +0800
Message-Id: <20220907031620.4316-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First execute the open function and assign a value to file.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 usr/gen_init_cpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index dc838e26a5b9..ee01e40e8bc6 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -326,7 +326,7 @@ static int cpio_mkfile(const char *name, const char *location,
 	char s[256];
 	struct stat buf;
 	unsigned long size;
-	int file = -1;
+	int file;
 	int retval;
 	int rc = -1;
 	int namesize;
-- 
2.18.2

