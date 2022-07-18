Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E69577A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 06:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiGREvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 00:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiGREvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:51:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A4311170
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 21:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=; b=nBvaO59oeX5a7SMVYM/SbOx5JJ
        ZBvajKem9pipbsgpzqt1itELF/BEif2uqcVZ9hUkdzwyunb+0aVLM1NcptrIobXpDztlh6ZDNRLUE
        tfbwfdr+KrlBJWZYJdfpyws7LDbetDeWg5ifEFTQ0+QKU/sSS0E5dDCtrExWR6Wllfj9F6aCfSJHY
        OorfZYx+97coaWllh4iJjRkx/Wg4AYSRBDC2YhqmxCCD7CJ0mwNr+k3e4W0/Cxgbb1BWrvpKuAWzY
        3zK0bWBaHLirhNKaKPlAxaepoG4MCzKfLoXLBLSh3xWhc9xN9k7wUqrdk3pI9k9g6uT+seJSvBbdI
        rIHY3v9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDIim-00Avlp-1G; Mon, 18 Jul 2022 04:51:04 +0000
Date:   Sun, 17 Jul 2022 21:51:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Gao <chao.gao@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/3] Small fixes for swiotlb
Message-ID: <YtTmuOXkB7NJ8JYl@infradead.org>
References: <20220715104535.1053907-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715104535.1053907-1-chao.gao@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.
