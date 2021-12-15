Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CE64751E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbhLOFSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:18:18 -0500
Received: from foss.arm.com ([217.140.110.172]:43204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhLOFSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:18:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B585D6E;
        Tue, 14 Dec 2021 21:18:17 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.68.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CD603F774;
        Tue, 14 Dec 2021 21:18:15 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: Modify the comment section for alloc_contig_pages()
Date:   Wed, 15 Dec 2021 10:47:58 +0530
Message-Id: <1639545478-12160-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just clarify, that the alloc_contig_pages() allocated range will always be
aligned to the requested nr_pages.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..0d74ea524dd4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9214,8 +9214,8 @@ static bool zone_spans_last_pfn(const struct zone *zone,
  * for allocation requests which can not be fulfilled with the buddy allocator.
  *
  * The allocated memory is always aligned to a page boundary. If nr_pages is a
- * power of two then the alignment is guaranteed to be to the given nr_pages
- * (e.g. 1GB request would be aligned to 1GB).
+ * power of two, then allocated range is also guaranteed to be aligned to same
+ * nr_pages (e.g. 1GB request would be aligned to 1GB).
  *
  * Allocated pages can be freed with free_contig_range() or by manually calling
  * __free_page() on each allocated page.
-- 
2.20.1

