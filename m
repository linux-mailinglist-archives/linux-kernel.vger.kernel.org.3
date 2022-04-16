Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FCF50345B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiDPF6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 01:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPF56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:57:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396172E095
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kMcem6muCtTXNqsopWLyZ9KtYeViiCS3WXyDPoUdWSs=; b=UKlTIjTIyzTCh5gDYG05jRSGgn
        nGNuUohCebuE+1FjaDUL3PE86I81XGyqL4uIQX+0zxNDAwNdzbMk9zcW4dz22UbApaF1uQEBvdQ8+
        XfHA+IOamd3OnsAFjqn5womNmuyT2PqmRkJs+F6aSJkEm5Ml+Ef12PONPH8N1hJOejCbcJRGHo2TC
        jKWbZyQ6HEcqn5A8SPABExyHuPhCw/pOy4rs4iQs/g63gs2gAxojoCa533N/cuIRyoJqNaWZIU9d8
        xxAolr+BVIwMA+4ac7B4unGQZInjnUB3/QUWn8ECY0aEXbBXAtZ/0bca4S0Fi7dTmm3ZbJnytUUob
        Ne760+PA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfbP0-00CJWX-FV; Sat, 16 Apr 2022 05:55:22 +0000
Date:   Sat, 16 Apr 2022 07:55:18 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for Linux 5.18
Message-ID: <YlpaRgHee1NPl2XB@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4fe87e818ea492ade079cc01a31d088e445f8539:

  dma-mapping: move pgprot_decrypted out of dma_pgprot (2022-04-01 06:46:51 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-2

for you to fetch changes up to 9e02977bfad006af328add9434c8bffa40e053bb:

  dma-direct: avoid redundant memory sync for swiotlb (2022-04-14 06:30:39 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 5.18

 - avoid a double memory copy for swiotlb (Chao Gao)

----------------------------------------------------------------
Chao Gao (1):
      dma-direct: avoid redundant memory sync for swiotlb

 kernel/dma/direct.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
