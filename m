Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1E148932F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbiAJIXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiAJIXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:23:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02708C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HByQQgdzrtq2ySrNBQgDVZRz9DGg+45aYvoX+q/KwQg=; b=Psvh9fsfxP4ilDks+0OKvghrGv
        n/YkVX2eoF0HM087VOTU0iJ6NmSH9oAs+lIgIAg7PBftevLjedLIr9E+/+X71NpYFq4oEPurg0R7W
        L4QeTFfE3gZInh2fv9EHpiVOtpXzBu+fMo8qSmpjnryY8+//0MmNIShxbxIi+q5SCyjEnBTU1gDy/
        nh1ESZc/uCuUdSXruRHIkCh8bLnNWUTdGhkxZ4os+kXRsU1OWrK3w1rvBAyjMoC1Km1Hx6vGTMe9z
        DwIudnLdVpjpO/gxTNEDbZYQcmxswKJD8r2xQzK+lcMWi3LW0f4ZWLylyg6cPOX7dVTVa70odDDQK
        OSNMF4sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6px9-009plD-MP; Mon, 10 Jan 2022 08:22:55 +0000
Date:   Mon, 10 Jan 2022 00:22:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 01/28] gup: Remove for_each_compound_range()
Message-ID: <Ydvs369hB/qagqbD@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:39AM +0000, Matthew Wilcox (Oracle) wrote:
> This macro doesn't simplify the users; it's easier to just call
> compound_range_next() inside the loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
