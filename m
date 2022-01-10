Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA794893AF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241761AbiAJIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbiAJIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:35:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DE2C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pwXNrUv0UZs8siJQlbihEV1HU713jh8nfynS6ueSAT4=; b=wOeUKqZr8hfvVIYN/6SRi2rS+0
        eK9ZesWtOkT/GDIksg2c/fRLYHR4ez1uh4f7p5kodRSmQK2S+PxUljO/AVrDA1f1II/IAd/TaBGC0
        m6yrRWRZOMW5gTqBKwJ/3mroBhBuaLE/EeyzaDEP8P85Y+DljaMrUHTO11GFQghrOtejJy1jb8GqR
        BJ+wDs27KqyOmN53Kqzg13J9EmNZ2jUWk5SGNVty3QSadkLUkmorPWx5SOiLpe5Vu+fKzwQiXgWad
        JKqGRa7gDVabmVtAOL0H93+1IIh3Ff03LSEsl/Mav1+t4SJGq5SUOk5WnPC43x2OBL8iGKffXRUmh
        4tPjf19w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q8t-009uQQ-LY; Mon, 10 Jan 2022 08:35:03 +0000
Date:   Mon, 10 Jan 2022 00:35:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 16/28] mm: Remove page_cache_add_speculative() and
 page_cache_get_speculative()
Message-ID: <YdvvtxMxcjIL+Ggj@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-17-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:54AM +0000, Matthew Wilcox (Oracle) wrote:
> These wrappers have no more callers, so delete them.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
