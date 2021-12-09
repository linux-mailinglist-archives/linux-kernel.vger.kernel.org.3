Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1246E903
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhLINWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:22:04 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43808 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbhLINVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:21:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3AF41CE25C6;
        Thu,  9 Dec 2021 13:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D6EC341CC;
        Thu,  9 Dec 2021 13:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055897;
        bh=9y13d4UGVte5kVTshQHjYNu0Pvs+CgZxzC/70rI3BNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n24cV9uSApZ0x1t+Y3NW1RtTEtQ7UKbI9RPdc+2hYAh/VekpFo9L+cghjOz5e70B4
         sDfNp0r6Tg9wMJWjXHViRCfJOHy/N9MbF15q0LFEyt77bK2p2wYTpL1HCiUKPMNGRj
         k8KKB01OoOgIk+MPjoh7U9djNnLlAlvjL3hlnnked0dkveyDOom20wSvG8jXSE2VuV
         J8ZD8vshn36sIfJFq7dPmTivzp3riEzkwgItYWF0DwMgL4bAN/qkPzXWmfxKfakUHs
         +uU0czXojcnhMNfLM7e9+Pt2+ET2swg9BQO6rlqnjJid97VHyxfvognO4NYaMj1vKE
         OhawgWj7FsZHg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 6/6] mm/damon: Remove a mistakenly added comment for a future feature
Date:   Thu,  9 Dec 2021 13:18:06 +0000
Message-Id: <20211209131806.19317-7-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209131806.19317-1-sj@kernel.org>
References: <20211209131806.19317-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a mistake in patches reordering, a comment for a future feature
called 'arbitrary monitoring target support'[1], which is still under
development, has added.  Because it only introduces confusion and we
don't have a plan to post the patches soon, this commit removes the
mistakenly added part.

[1] https://lore.kernel.org/linux-mm/20201215115448.25633-3-sjpark@amazon.com/

Fixes: 1f366e421c8f ("mm/damon/core: implement DAMON-based Operation Schemes (DAMOS)")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2dbc1f545da2..97f4a224e950 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -281,7 +281,7 @@ struct damon_ctx;
  * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
  * DAMON-based operation scheme is found.  It should apply the scheme's action
- * to the region.  This is not used for &DAMON_ARBITRARY_TARGET case.
+ * to the region.
  * @target_valid should check whether the target is still valid for the
  * monitoring.
  * @cleanup is called from @kdamond just before its termination.
-- 
2.17.1

