Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94B48934E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiAJI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240738AbiAJI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:27:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AEEC061763
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XguF+aztxgNT0rBYdwwwA3zJ1GosA/YJHt/QRh6W5/M=; b=ZapgPiyLDq4beLxPAMi5qVUKa7
        QebCkLKr6yt/UI6kjpPGzGqvEYGnvRIE8IvIB8smeIsztWGRegYcKzgtYlQwDELMtFoJdtbgCA0YT
        aECsOa8wsJQidLGwQz6vwu+cbGD5lQEqAwVsCUAzZWtGyvFWZ9PlCtQKUGigjBCaKTCflZ9WrRMsP
        07WdrhqYgSgqukuejuaHsFDa8JRIvnyiuth9VokUArge+GXFjJNpTL22cJ5xHbgWWhLjCRmTw5Rwm
        fedziu8XdYkGlduH4GU7FYKVwXkjxHb2HNsHD/21qmHtLbVXErbIuIn7EFFcvXCcsP0LSI3CghA21
        SMmSOquA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q1Z-009qfz-Is; Mon, 10 Jan 2022 08:27:29 +0000
Date:   Mon, 10 Jan 2022 00:27:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 05/28] gup: Change the calling convention for
 compound_next()
Message-ID: <Ydvt8TwenyRFClWG@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:43AM +0000, Matthew Wilcox (Oracle) wrote:
> Return the head page instead of storing it to a passed parameter.

Looks good, but same comment about maybe passing list and npages first.

Reviewed-by: Christoph Hellwig <hch@lst.de>
