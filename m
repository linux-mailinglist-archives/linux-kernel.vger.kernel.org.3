Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B906E4893D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242086AbiAJImP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242082AbiAJIjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:39:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FEDC061751
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=I537yTMLLIzT1OpSzpAiHrOR/+
        R0xLaL8yZUG9wYC0KF+nUm62zKDRsIeIPHqDwz4hupdWfJBBX+slsw4rreyLGj3589/Agn2nKZFXT
        0KvoI3aIA6mA0fnellZsZZAE9v4zO3w2iNBG7Ulkx7oOqygLZ15KVQTv+sTOgUtG2OGX7DAZRiDCA
        N7/DrVhmKlDYbe7diI1uKHt+U43Ny08jjJOCpbgrrnBihYFa4xgyQjpeiSyN92EQJxz40gO+ZDyoI
        cWCQMk58r/Pzvk+v2DdIQehV24E50Xiud1dozPUcFkY8bATeof0G/FsOf1VYb+SXaajviCUKlbLTG
        6RNhzWWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qDU-009xHX-1X; Mon, 10 Jan 2022 08:39:48 +0000
Date:   Mon, 10 Jan 2022 00:39:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 25/28] gup: Convert compound_next() to gup_folio_next()
Message-ID: <Ydvw1NK1F7bYgEjE@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-26-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-26-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
