Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D20E47D89F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 22:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhLVVPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 16:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhLVVPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 16:15:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3824C061574;
        Wed, 22 Dec 2021 13:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JinkcA8eBr/TSVBGiLUkMKqrNJ00IO7KthEpRw1rJs4=; b=iC/OtRboDlGIGXRTlOPBjWUOTl
        L5DTSvB6FwYv1lMy2d6/jFwImHClHRa4lUXSW3zIMUy9YrjVFUOtZnCc7fYmQN9zxuB3aEqLU2DG4
        QybynduIvuCQn25iSTmNBkjM/4qL3qsN5DXTgmrZ1Tc7AjxtTJ2vZmRQcd9MPvB+a/8Ww9Y1nWjW2
        wrJ66ddP9YPaiz3tLtyPrIWCZrlFN2c7TTLRazW8d7Rxz7SsWIMcp969GeMOSnHFYGoTIoTmi2pjC
        EnCG0LaI3nKZciUdpbyTX803BugB9Gq02ZUDRNXst3biyeMBznC4zFhkxh2PRXdzjhlvSPLlOYvSI
        hdE9CxWQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n08xR-00BKzB-3x; Wed, 22 Dec 2021 21:15:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH -next] bio.h: fix kernel-doc warnings
Date:   Wed, 22 Dec 2021 13:15:32 -0800
Message-Id: <20211222211532.24060-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all kernel-doc warnings in <linux/bio.h>:

include/linux/bio.h:136: warning: Function parameter or member 'nbytes' not described in 'bio_advance'
include/linux/bio.h:136: warning: Excess function parameter 'bytes' description in 'bio_advance'
include/linux/bio.h:391: warning: No description found for return value of 'bio_next_split'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 include/linux/bio.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20211222.orig/include/linux/bio.h
+++ linux-next-20211222/include/linux/bio.h
@@ -124,7 +124,7 @@ void __bio_advance(struct bio *, unsigne
 /**
  * bio_advance - increment/complete a bio by some number of bytes
  * @bio:	bio to advance
- * @bytes:	number of bytes to complete
+ * @nbytes:	number of bytes to complete
  *
  * This updates bi_sector, bi_size and bi_idx; if the number of bytes to
  * complete doesn't align with a bvec boundary, then bv_len and bv_offset will
@@ -383,7 +383,7 @@ extern struct bio *bio_split(struct bio
  * @gfp:	gfp mask
  * @bs:		bio set to allocate from
  *
- * Returns a bio representing the next @sectors of @bio - if the bio is smaller
+ * Return: a bio representing the next @sectors of @bio - if the bio is smaller
  * than @sectors, returns the original bio unchanged.
  */
 static inline struct bio *bio_next_split(struct bio *bio, int sectors,
