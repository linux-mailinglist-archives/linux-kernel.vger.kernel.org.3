Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65249DAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiA0Glm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiA0Gl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:41:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D57C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CL2DPlTymWvg8k46Q+fsZPvqB++x5kaUBvBSpoLYaj0=; b=yY1XwjO/5AogrNFYWXNZT1sWHb
        V1iy/i8YCQ6AjvLIdZvOXQ9KKWrW1BteP/Yj3HO+VYdsCLg59VpAPkQecuWsdM51GZpJmelv0ZH7s
        TglpxBotZNMpup0vKSxrHO0/g2KHmEQ/JGqghBUiZGhLsJS4W0fkTD/xRiRGlNi8UKMZ8xSVtXWO9
        McsrlAU71Z0y+sXOpNrG4Wg452o0jfRH4GHBZq5zV3XQMG5pA5tqa5BxFO9xiYovDyVykzOcsxYbq
        GViCR8bv763+E4s2/NYQxLt5Pu02kYalfVu8kSab4+4vB7Dff6bxkA9c1ycnmu5fHs0HmaaLdtyC6
        THaZb8Kw==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyTI-00EZ0P-9T; Thu, 27 Jan 2022 06:41:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] block: fix the kerneldoc for bio_end_io_acct
Date:   Thu, 27 Jan 2022 07:41:25 +0100
Message-Id: <20220127064125.1314347-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the actually existing parameter name.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f4b662f246747..85c38c3a89c35 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1527,7 +1527,7 @@ void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
 /**
  * bio_end_io_acct - end I/O accounting for bio based drivers
  * @bio:	bio to end account for
- * @start:	start time returned by bio_start_io_acct()
+ * @start_time:	start time returned by bio_start_io_acct()
  */
 static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 {
-- 
2.30.2

