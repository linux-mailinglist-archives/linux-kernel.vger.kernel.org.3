Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF36542429
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiFHERE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiFHEOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:14:54 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17FBC2D53AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:36:27 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 0E9271E80D76;
        Wed,  8 Jun 2022 09:36:02 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iTFddF4_Jfzo; Wed,  8 Jun 2022 09:35:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 6D2EB1E80D6E;
        Wed,  8 Jun 2022 09:35:59 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH] mm: Add blank line to make the layout of the program clearer
Date:   Wed,  8 Jun 2022 09:36:05 +0800
Message-Id: <20220608013605.6613-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add blank line to make the layout of the program clearer

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 mm/page_isolation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index d200d41ad0d3..b5ec13fcfacd 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -213,6 +213,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lock, flags);
+
 	if (!is_migrate_isolate_page(page))
 		goto out;
 
@@ -255,9 +256,11 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
 		__mod_zone_freepage_state(zone, nr_pages, migratetype);
 	}
+
 	set_pageblock_migratetype(page, migratetype);
 	if (isolated_page)
 		__putback_isolated_page(page, order, migratetype);
+
 	zone->nr_isolate_pageblock--;
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
-- 
2.18.2

