Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44209596BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiHQJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiHQJVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:21:48 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 930C81836F;
        Wed, 17 Aug 2022 02:21:47 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id D91EC1E80CD3;
        Wed, 17 Aug 2022 17:18:50 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UTjpDWClvZ_n; Wed, 17 Aug 2022 17:18:48 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 130A21E80C8B;
        Wed, 17 Aug 2022 17:18:48 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] md/raid5: Fix spelling mistakes in comments
Date:   Wed, 17 Aug 2022 17:21:40 +0800
Message-Id: <20220817092140.4252-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling of 'waitting' in comments.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 drivers/md/raid5-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index f4e1cc1ece43..058d82e7fa13 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1327,9 +1327,9 @@ static void r5l_write_super_and_discard_space(struct r5l_log *log,
 	 * superblock is updated to new log tail. Updating superblock (either
 	 * directly call md_update_sb() or depend on md thread) must hold
 	 * reconfig mutex. On the other hand, raid5_quiesce is called with
-	 * reconfig_mutex hold. The first step of raid5_quiesce() is waitting
-	 * for all IO finish, hence waitting for reclaim thread, while reclaim
-	 * thread is calling this function and waitting for reconfig mutex. So
+	 * reconfig_mutex hold. The first step of raid5_quiesce() is waiting
+	 * for all IO finish, hence waiting for reclaim thread, while reclaim
+	 * thread is calling this function and waiting for reconfig mutex. So
 	 * there is a deadlock. We workaround this issue with a trylock.
 	 * FIXME: we could miss discard if we can't take reconfig mutex
 	 */
-- 
2.18.2

