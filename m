Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E949357C4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiGUGvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiGUGvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:51:08 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4FD742ADA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:51:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id DCD871E80D78;
        Thu, 21 Jul 2022 14:46:41 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Iq6k0cfySi7V; Thu, 21 Jul 2022 14:46:39 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D52151E80D40;
        Thu, 21 Jul 2022 14:46:38 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     dhowells@redhat.com, edumazet@google.com, fmdefrancesco@gmail.com,
        christophe.jaillet@wanadoo.fr
Cc:     linux-kernel@vger.kernel.org, kernel@nfschina.com,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] kernel/watch_queue: Delete a semicolon
Date:   Thu, 21 Jul 2022 14:51:00 +0800
Message-Id: <20220721065100.3332-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated ';' from code.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/watch_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 8b28fad1319b..bb9962b33f95 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -227,7 +227,7 @@ void __post_watch_notification(struct watch_list *wlist,
 
 		if (lock_wqueue(wqueue)) {
 			post_one_notification(wqueue, n);
-			unlock_wqueue(wqueue);;
+			unlock_wqueue(wqueue);
 		}
 	}
 
-- 
2.18.2

