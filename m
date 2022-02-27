Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDD54C5DFB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiB0SMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiB0SMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:12:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B4C5AA66
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VA6kacKbPKbiivcIZRmKZi1KNf7ZiEsud7xUBH92hHs=; b=xoVbEInD64+Y2TUVFpYcyxSQ2d
        HQ7q/UtZQ6eVgtNB/LbYL+/LUTO3meYnhi35iqza4tT1mr2Pc0JTsSaEl3rm9EL8bx77SdJb8ipdL
        Zvw4Aymq72oYjH0u5fM68AEeGdSMD7mX8JOrcOmOIWbyuoFSmjkea2pG4su1pVByjxQMcFc3zvDQN
        WegKyNcVDZbIlxNd8E8yFqdpmpF2DbUtOlTwvE4gWI5XHrMz05t4MfHSFapyHAd67680/LoKRxyb5
        Wdf3oKAnZwBieF6ZQdI6f8nYwkrY4LDc0Dbf+kAqiJKYZ/yXgdbVSaqt3kiAetpdU+J4RFU726d1v
        StFAcOeA==;
Received: from 91-118-163-82.static.upcbusiness.at ([91.118.163.82] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOO1e-009upo-4g; Sun, 27 Feb 2022 18:12:06 +0000
Date:   Sun, 27 Feb 2022 19:12:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fix for Linux 5.17
Message-ID: <Yhu+8trQqqmYLid3@infradead.org>
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

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.17-1

for you to fetch changes up to ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e:

  swiotlb: fix info leak with DMA_FROM_DEVICE (2022-02-14 10:22:28 +0100)

----------------------------------------------------------------
dma-mapping fix for Linux 5.17

 - fix a swiotlb info leak (Halil Pasic)

----------------------------------------------------------------
Halil Pasic (1):
      swiotlb: fix info leak with DMA_FROM_DEVICE

 Documentation/core-api/dma-attributes.rst | 8 ++++++++
 include/linux/dma-mapping.h               | 8 ++++++++
 kernel/dma/swiotlb.c                      | 3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)
