Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072EC489377
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbiAJIfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241092AbiAJIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:33:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51813C061212
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6dYgsq4MWyxkYewfKLy9LuzoG1ROTcw3pV/PhkFkIiA=; b=jAjD766OOAdSIdsRY6pKWNL0s1
        FkUp7UUukVTQtAJuqo7MwtJFJR16ucLqP/nlC/Hhb7TXj1mhcqByrsnBc/XHMKYqwzIZbE2iE+zAz
        qkihVCPGE7/BFHogdxcY9C0K/phuOOfaV7CjAmKtP1HFiCUNYCqjpoe0lWC0vvc0dgUMCNaIoDkSb
        bxzd7J8SCdVaQSeDtgfZC2Hm049K1EqLWly9p6qgY+7CAxNWYb1vPqzwPLQKk3RKX+OyabU/p/B02
        7xAzYUvjYSVPzhyQQtyFFHXeg5DASXFaYZiAROhxNdZ7ZNM7miB8VulEEi6Jt71yKXd29xSiMdcfd
        vUZd40Xw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q7c-009tv4-Nm; Mon, 10 Jan 2022 08:33:44 +0000
Date:   Mon, 10 Jan 2022 00:33:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 14/28] mm: Convert page_maybe_dma_pinned() to use a
 folio
Message-ID: <YdvvaP1weSjgsuDj@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-15-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:52AM +0000, Matthew Wilcox (Oracle) wrote:
> Replace three calls to compound_head() with one.  This removes the last
> user of compound_pincount(), so remove that helper too.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
