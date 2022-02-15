Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255FA4B7AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244650AbiBOWy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:54:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiBOWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:54:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8ED90FCD;
        Tue, 15 Feb 2022 14:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cy6WPdZMA9l2BgasvuI1ZaOiHf2s7RnLuTqPjLlb6gs=; b=e7vH84PC4EyLdUBN3BFS0Sza5E
        /VkztsyTKqd5qmcuW4PVdL4NLZuq/d98JLw5jOdb4iy+BmdowqIBU/Njcgb8SWhsZuGONiZbEsHOY
        3rRyrsOaVwdufX48Ig63kMUWRIAf6EbF/uUe2Nrnska06GuzKYKJvTmaUGa2/hmcStpEqnWH0LhaR
        LSsafASrZGWEt4R8qgg8kBd8MN3rB+hn2g6sQcXVJjky6QunDmNXtpKdWGpAsENFh3J0W+zK7G7Fm
        ZVstpmeX6zdM16oVurmb0ifx0GV/3XAHDq1AHyE5rcKumf/7J66Be/q9yosGlgtLxl2rY0yRMdE/s
        xRz11cdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK6iU-00EElw-MU; Tue, 15 Feb 2022 22:54:38 +0000
Date:   Tue, 15 Feb 2022 22:54:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the folio tree
Message-ID: <YgwvLi3+p7Olo2uH@casper.infradead.org>
References: <20220216082951.4bffb750@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216082951.4bffb750@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 08:29:51AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   9864078ecbb0 ("mm/thp: shrink_page_list() avoid splitting VM_LOCKED THP")
>   6a04fcd09a18 ("mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)")
>   52322c19db3b ("mm/munlock: page migration needs mlock pagevec drained")
>   fc43a522c2b6 ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
>   b60d40429fe9 ("mm/munlock: delete smp_mb() from __pagevec_lru_add_fn()")
>   d1dfa0133d1d ("mm/migrate: __unmap_and_move() push good newpage to LRU")
>   27649a0ad4f2 ("mm/munlock: mlock_pte_range() when mlocking or munlocking")
>   a098b3660d99 ("mm/munlock: maintain page->mlock_count while unevictable")
>   4aefb923cead ("mm/munlock: replace clear_page_mlock() by final clearance")
>   8a2bfd6e9bc1 ("mm/munlock: rmap call mlock_vma_page() munlock_vma_page()")
>   0942176186ca ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")
>   190136f4d2e7 ("mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE")
>   9833b8ff6c78 ("mm/munlock: delete page_mlock() and all its works")
> 
> are missing a Signed-off-by from their committer.

oh, git-am -s.  I'm not used to doing this ;-)

Fixed now.  And I fixed sparc32 (differently from the way you had it).
Pushed c306078715cb.


