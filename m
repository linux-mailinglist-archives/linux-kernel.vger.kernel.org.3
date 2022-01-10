Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A8648936D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbiAJIdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbiAJIcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:32:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0723AC061751
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yMjG0MO8uve4Q8bknorzIEyXbkOAI9X93aj135DF1W0=; b=lO3XdbhOcfj9hU1fxBfkAzr0Pz
        Suw2szJm6i+IRLRTJD29IVsf5EyMe0zgKnogUibONVa+vaCmI6y2qaZvlZOaqQACYmik/dL0Y3g1/
        XIiy6FRmHfTUc4PwpG2u5h1CMwOIJLL3BeGXnurg4M4zpCwSVOIWhPVCTcn3fb2hSh3UJPt4g6gQi
        75KkgZ5+gkhWrYFZ0zGVJMcH8H8QU+JOxn83+w+Wpper3vr5xs02JsIv53uI31BJu4ePG+HFEZ/pv
        zXM5dsZ0FUyFUbN1wQwXTa5JEOkEVPO1YTdd+gH/WHuOec459CVf/OSrsxQoeklCJl1PUSk6MajKy
        dQxsbyLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q61-009tDJ-Iy; Mon, 10 Jan 2022 08:32:05 +0000
Date:   Mon, 10 Jan 2022 00:32:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 10/28] gup: Turn hpage_pincount_sub() into
 page_pincount_sub()
Message-ID: <YdvvBffXTIn9ei/v@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:48AM +0000, Matthew Wilcox (Oracle) wrote:
> Remove an unnecessary VM_BUG_ON by handling pages both with and without
> a pincount field in page_pincount_sub().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
