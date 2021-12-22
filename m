Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905F947CE13
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbhLVIXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhLVIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:23:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09022C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yCKFrFKF7Vuw4wleZFantaSzNpNvWrWC62nu2LjDawE=; b=zwiLqyHJ8YjH3ItyJiTITRKs3/
        4MNGRtpdfgq3VOfNwzfWpqZJC6xkSpeBbuNea8WcQ2KMPEjos8WbIcz/83m3KrG0YRhdk758OSvWx
        p7tdUj6mrdJ0WRB7c/SzSlHvOqvJLD/bvIUMRzwPBdUdRglqLOvfh5TpVdy/ROn+VqggTu3aiRC0X
        Fy3X1MZCG65iP64qp0YEvJdBk8JfbiohCiljB5+OpUwvhNDCPv0rKygcOgmcPv2qvsxyCvY6QH1aY
        QmN1R+YRQLZe0tiLRNjZi01iw8iYArCmelw4nzNJZYqESbFZG3U4QzHtwjqmWp1w6oxooQhVQ10MY
        +uiPmzBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzwuI-009eYF-8w; Wed, 22 Dec 2021 08:23:30 +0000
Date:   Wed, 22 Dec 2021 00:23:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] Swiotlb: remove a duplicate include
Message-ID: <YcLgggVZn4pATxEo@infradead.org>
References: <20211222025416.3505-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222025416.3505-1-guozhengkui@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:54:16AM +0800, Guo Zhengkui wrote:
> Remove a duplicate "#include <linux/io.h>". The deleted one in line 43
> is under "#ifdef CONFIG_DMA_RESTRICTED_POOL". However, there is already
> one in line 53 with no conditional compile.

This doesn't apply to the dma-mapping for-next tree.  Also please don't
capitalize the subject line.
