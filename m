Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A748936A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiAJIdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbiAJIbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:31:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739F3C06118A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OfXH7HuA9nnmU4LMS967gWPUmYbFP+jE6Cczd4vRZXQ=; b=A0toOgDZ/7tlodAkcTYqYrCJ+G
        oMha2mvB9ojaHKjRdf2iBCy+WyO3gEZwyN1G1FhtY2vxukiT9xMP0hatIeLHRRaXsYS8euIKXXZDC
        Tmph31BEHsULn8/XL27zi4kj7STNC5VjsTi9nI8VQ7y0hisIf2x61aNJAIpWeTKvEGqQEBE3pkdxa
        KG2Di90YQXGGtEJ0cjmWi6rR/cY2d3FpGWFHWDwyk97tpH0qZCIo1EDtLKULWlXLxA/GRKgbl5fB3
        czPvl0talEq6ehY6Sclkfj42gS2QIkX4oSAidyG4IOe7uCOTDq4umD4hh1LTRrqcf54yCSzxaU8+b
        emUxJvHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q5b-009t3P-W8; Mon, 10 Jan 2022 08:31:40 +0000
Date:   Mon, 10 Jan 2022 00:31:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 09/28] gup: Turn hpage_pincount_add() into
 page_pincount_add()
Message-ID: <Ydvu61c/6+DikC0/@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:47AM +0000, Matthew Wilcox (Oracle) wrote:
> Simplify try_grab_compound_head() and remove an unnecessary
> VM_BUG_ON by handling pages both with and without a pincount field in
> page_pincount_add().

Nice:

Reviewed-by: Christoph Hellwig <hch@lst.de>
