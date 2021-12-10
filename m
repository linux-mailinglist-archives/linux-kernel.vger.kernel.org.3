Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEEA470366
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbhLJPES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242562AbhLJPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:04:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0C2C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:00:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90BB0CE2B82
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76287C341CD;
        Fri, 10 Dec 2021 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639148434;
        bh=Pbz9u8rLTWkTjeevVw9SjnPsm1pLh7jc6BKApdh3UKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCayG3+C7rKdtuQ/dkWkKIq6gQrhAgtYkHDlUIpdgjyu68t1MgQigzJobp55NaHoW
         NwVhBYlpvLFZ6jv2e6Hg0VvjqA/a3GKGVxIg8B0mH+YvQSlNoWwnRyyQhQuchB2ncR
         n5iupDLLJwNVzXfFAIIUQq0nZOQGf0w5A3WpeiAYkVWoYOnFadjUIB8Va82sexbdFC
         sXcvmEHrukDh0vwp3CXUA7E7RdjToXeK5CkmgiW47irbolZFWbZlMIV95/A2orURXE
         xLzgVF+ft75fYjo2CbFqIqxf3EBLnAffDKbLTRMiJGWR4ttmex862mhavLsf+xhLRN
         BtBzJJucdKiqQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/6] Docs/admin-guide/mm/damon/reclaim: Document statistics parameters
Date:   Fri, 10 Dec 2021 15:00:14 +0000
Message-Id: <20211210150016.35349-5-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211210150016.35349-1-sj@kernel.org>
References: <20211210150016.35349-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds descriptions for the DAMON_RECLAIM statistics
parameters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../admin-guide/mm/damon/reclaim.rst          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index fb9def3a7355..0af51a9705b1 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -208,6 +208,31 @@ PID of the DAMON thread.
 If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.  Else,
 -1.
 
+nr_reclaim_tried_regions
+------------------------
+
+Number of memory regions that tried to be reclaimed by DAMON_RECLAIM.
+
+bytes_reclaim_tried_regions
+---------------------------
+
+Total bytes of memory regions that tried to be reclaimed by DAMON_RECLAIM.
+
+nr_reclaimed_regions
+--------------------
+
+Number of memory regions that successfully be reclaimed by DAMON_RECLAIM.
+
+bytes_reclaimed_regions
+-----------------------
+
+Total bytes of memory regions that successfully be reclaimed by DAMON_RECLAIM.
+
+nr_quota_exceeds
+----------------
+
+Number of times that the time/space quota limits have exceeded.
+
 Example
 =======
 
-- 
2.17.1

