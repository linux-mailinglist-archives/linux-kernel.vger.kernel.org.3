Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE7487ECD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiAGWLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiAGWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:11:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6F3C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 14:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x1P1ikROrsrJYAlBAu4qcy+bxN2jAZKkyx0yGhgbvwo=; b=rMrbvJ9owfpc10SLX6MfmXkfsa
        PYlFpF4xua8JfRSJJ39kXQ9b+Cj2ck3xhxyHD0SiZM0Q2fBxuVglS9Le5oSxkVBNm1rqjS1yPw4R6
        tM8uKPGqABPN0R7e21W41ASOl0LqcvcQJoApeFHGx7JP5mBys4uyWFY6xIG8I+h/SBjEfujk9CMRB
        qNuVCCKXvnaf/tuGBql6yShH9enUPfCdiK03nOb8uofWL2mU6X0baMAsbM64/XcPImko77u2VOUqh
        lZYDqBZFAa4PTr4thDC1uHtuMNliwS9hdJK26v5hO/D9rHzVAUVXbTxh+0BUtQx486I94xpFBDTjC
        m9C9+bJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5xSC-000DYN-50; Fri, 07 Jan 2022 22:11:20 +0000
Date:   Fri, 7 Jan 2022 22:11:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     peterz@infradead.org, akpm@linux-foundation.org, vbabka@suse.cz,
        will@kernel.org, linyunsheng@huawei.com, aarcange@redhat.com,
        feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-ID: <Ydi6iMbSZ/FewYPT@casper.infradead.org>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107134059.flxr2hcd6ilb6vt7@master>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 01:40:59PM +0000, Wei Yang wrote:
> On Fri, Jan 07, 2022 at 03:59:01AM +0000, Matthew Wilcox wrote:
> >On Thu, Jan 06, 2022 at 11:52:54PM +0000, Wei Yang wrote:
> >> FOLIO_MATCH() is used to make sure struct page and folio has identical
> >> layout for the first several words.
> >> 
> >> The comparison of offset between page->compound_head and folio->lru is
> >> more like an internal check in struct page.
> >> 
> >> This patch just removes it.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >
> >No.
> 
> Hi, Matthew
> 
> Would you mind sharing some insight on this check?

It's right there in the comments.  If you can't be bothered to read,
why should I write?
