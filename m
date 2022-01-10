Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547A84893BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbiAJIiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbiAJIgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:36:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3EAC034000
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eB11XFakVhlCK/dTLKPVKUovWrOV7iJOxzFzNgcRP/w=; b=lVwDyWQ4RoZ5Ny31vBycE1p/Su
        u3BSTIrWcccO/fnZT30VCjFMGdv4JisDE5B8TgbREx8KmfdMLmZdzkOLH1RfwWjca4eC3RhVQdnO3
        6zr4O0wvOQA84rjf5mwPGH5f67pJbqALCmGospoDL4AH97C2ajoubrBreohFpSiPifnML3l2oOmyY
        cAk2Zpse/O73ll43fUO+lETlSnCAAjBFrgLEbxOeTAkDU1NDfz7lQ+p6NGbPkXzXq4nM4Cpwwpy5m
        3f3Rn3ET2DqzsjYF43HzVKx0gA00czoqDxQtvdKE+YIrDGVKWb1A0pEaBd0zttycqzKv85TcBIL0R
        LdbIlb9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qAH-009vHA-4w; Mon, 10 Jan 2022 08:36:29 +0000
Date:   Mon, 10 Jan 2022 00:36:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 18/28] hugetlb: Use try_grab_folio() instead of
 try_grab_compound_head()
Message-ID: <YdvwDSCzUkaPksbE@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-19-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:56AM +0000, Matthew Wilcox (Oracle) wrote:
> follow_hugetlb_page() only cares about success or failure, so it doesn't
> need to know the type of the returned pointer, only whether it's NULL
> or not.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
