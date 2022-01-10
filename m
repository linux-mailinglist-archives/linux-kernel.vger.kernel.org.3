Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC44148936F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbiAJIeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240825AbiAJIcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:32:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AF3C034003
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=itfUOLOlTc0EXXDuSrIyDvniWh8F+MeG3nQ/olPPtDM=; b=oIKww1jytYLF9zUufM7B0/j4FG
        5SulQH0P8EIiA+15EmB06nfgy7Fkugp4gnRYhg49CHx4NQlM8aAb1HABeD4vHiPFNrK4ax4rMgJFC
        zMKmbvw0h4fOhbyMNnagyN205cvcxRTHLly/BwNsKYNhpyJrMh9pJNpJRneQ9Sr9vgf/ZSk2FTCHe
        0RsNeMv6B1zBnciUWnJiygLyzq92XU+tpYKgthKx4BgPCbkNK2pke2g7dB5K7a+3+zWgg3z/6lFGo
        FaFFkuUl5qbIn1Rv1PYzW3s0lxSN7oRZzDXurVaIAZcUQaKi8SwFENfmuvIweXNtvw3ttVqDkuIpk
        b7cht5VA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q6j-009tVU-6q; Mon, 10 Jan 2022 08:32:49 +0000
Date:   Mon, 10 Jan 2022 00:32:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 12/28] mm: Add folio_put_refs()
Message-ID: <YdvvMcBAQ7USUvlm@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-13-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:50AM +0000, Matthew Wilcox (Oracle) wrote:
> This is like folio_put(), but puts N references at once instead of
> just one.  It's like put_page_refs(), but does one atomic operation
> instead of two, and is available to more than just gup.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
