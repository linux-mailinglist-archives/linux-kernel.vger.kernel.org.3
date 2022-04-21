Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365B050A441
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390139AbiDUPd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389017AbiDUPdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:33:51 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00C44B1FF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:31:01 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id 91A241E80D0B;
        Thu, 21 Apr 2022 23:28:29 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SMWWhuIuyy2Z; Thu, 21 Apr 2022 23:28:27 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.255.56])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id AF6E51E80CF9;
        Thu, 21 Apr 2022 23:28:26 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] mm/damon: remove unnecessary type castings
Date:   Thu, 21 Apr 2022 08:30:56 -0700
Message-Id: <20220421153056.8474-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5ce8d7c867f0..5fe42e47c57b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1042,7 +1042,7 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
  */
 static int kdamond_fn(void *data)
 {
-	struct damon_ctx *ctx = (struct damon_ctx *)data;
+	struct damon_ctx *ctx = data;
 	struct damon_target *t;
 	struct damon_region *r, *next;
 	unsigned int max_nr_accesses = 0;
-- 
2.25.1

