Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDEF4893BF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbiAJIjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbiAJIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:36:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C471C03400A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OJSjHN65nlGg+U/iNgU8GoUCcDZpJKnJahxOEMAFNXE=; b=Un+aYWmr1vviPqISIhoZ5dyHzO
        enQvQowFK36MohI/hg/n/QW4EPHN5uem5QOXlmBBZ4ZWDjYs8CVQkF7qVi9q0V/y51ZDYUDCq3Wm+
        6+1tFF0AQ0+4saWMUWNYUyDs7EIEF3j77YeZu5ffZTlXGevpvulRP/yAocd+B0lV57eI2hIHGgWuE
        p97Mdvn4hlPhXIyRqL8u6iiiy96q1N0Vp7IBb82XixrcLMzYbcAp6V02ks4LTrWl6EEhkXpb+ztPJ
        /gLhrUNvrRMnsPJDdxbIyTyjRkUBKU35W7tOkeNqR/K6zGswKggjav8jJec2uJ43qnGq6t3yJwmRi
        vtHAbYzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qAZ-009vUY-Rf; Mon, 10 Jan 2022 08:36:47 +0000
Date:   Mon, 10 Jan 2022 00:36:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 19/28] gup: Convert try_grab_page() to call
 try_grab_folio()
Message-ID: <YdvwH/Jx3K/KuD8L@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-20-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:57AM +0000, Matthew Wilcox (Oracle) wrote:
> try_grab_page() only cares about success or failure, not about the
> type returned.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
