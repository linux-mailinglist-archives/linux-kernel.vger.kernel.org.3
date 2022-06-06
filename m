Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A335C53E37B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiFFGix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiFFGiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:38:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1A1FD30
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tRr/IyS5yVw2e8JXaU35If9uX4O7GfKp3j39oOo0Cpg=; b=KwBLUPq8vs8E5AnLx9C1kXW11g
        I5uotKYbP5mYvDDy/zMETQGhpAL5lw8NWf/NxpBCQDzxaXwzyOtB72L6e4HIdz/uZ82ed/WWQEFmr
        yPVstNZaBdUVxHzhjoegJrUQ+lQKQxEZcbmGDzuA0kHpWUNVxiCA55ypz/OONkllawTJAOPMQKogo
        riKZBKs+P7yhWPfTkn0LZ4q1T3bqwpiwd3pn4VBX9/lJ8JWfgpm8izHb9itU777L1Nc0iZWZKDlCq
        tBSfEZxUpT4XhBstKCS07KJUD98xs2CZh6zG0Bkz5jRpO6MFduPlfArbqQjWlUnwhWMXftMjkj+el
        F6vso72A==;
Received: from [2001:4bb8:190:726c:bbd1:d45d:a235:6422] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ny6O0-00HKGt-0F; Mon, 06 Jun 2022 06:38:48 +0000
Date:   Mon, 6 Jun 2022 08:38:45 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for 5.19
Message-ID: <Yp2g9SGrXn0eSvnA@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I really wanted to send these before -rc1, but the fact that today is
 a public holiday here really confused me and messed up my schedule]

The following changes since commit 4a37f3dd9a83186cb88d44808ab35b78375082c9:

  dma-direct: don't over-decrypt memory (2022-05-23 15:25:40 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-06-06

for you to fetch changes up to e15db62bc5648ab459a570862f654e787c498faf:

  swiotlb: fix setting ->force_bounce (2022-06-02 07:17:59 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 5.19

 - fix a regressin in setting swiotlb ->force_bounce (me)
 - make dma-debug less chatty (Rob Clark)

----------------------------------------------------------------
Christoph Hellwig (1):
      swiotlb: fix setting ->force_bounce

Rob Clark (1):
      dma-debug: make things less spammy under memory pressure

 kernel/dma/debug.c   |  2 +-
 kernel/dma/swiotlb.c | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)
