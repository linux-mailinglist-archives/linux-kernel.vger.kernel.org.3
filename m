Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EBA4B5880
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357083AbiBNR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:28:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiBNR2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:28:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC43A1AC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rnqMU4kUstXK04BkfmDD9MNLe54Eb2WuFgh7mzop/BQ=; b=hdkQ7y4cYeWUj3ba1bdAfdI+XM
        hu2lF1ZazE1LcJiVDO56CXYllFi7iosCiIe45S0PhAVtJpceWoav5nDk3VEGQJ0hUo8rPTp4GtNy/
        KvmWmfjI5lWnigjvvpXXJ54gFNihAqWlef6eOGUKtQPAeMAiZfvYh4ZZyUnR05tGBDaKpvkIsWLIi
        N6VArq1VdFZDiiZb8AnXIK1y539AvtSZSa8T9Cd8+4QAKO1ae4pur2H6+Zamz5hs+jWc38yVdq3Ja
        NlRQZunzVhVAs1vZ7ujp96cd/mLfSNgK65VmJLOOTyE8fqUpRp8/jPedzUzwuZ9TkYRz7VgWrWIeP
        AWeyDnUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJf9O-00D7VY-KI; Mon, 14 Feb 2022 17:28:34 +0000
Date:   Mon, 14 Feb 2022 17:28:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [willy-pagecache:for-next 58/85] mm/folio-compat.c:181:9: error:
 implicit declaration of function 'folio_mlock'; did you mean 'folio_lock'?
Message-ID: <YgqRQtFh0qnenzJg@casper.infradead.org>
References: <202202142352.7A4VgqBz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202142352.7A4VgqBz-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:19:26AM +0800, kernel test robot wrote:
> commit: 2cefeaf011db4a95ecb515cc2ca61d091a792ac1 [58/85] mm/rmap: Turn page_mlock() into folio_mlock()
> 
>    mm/folio-compat.c:169:6: warning: no previous prototype for 'clear_page_mlock' [-Wmissing-prototypes]
>      169 | void clear_page_mlock(struct page *page)
>          |      ^~~~~~~~~~~~~~~~
>    mm/folio-compat.c:174:6: error: redefinition of 'mlock_vma_page'
>      174 | void mlock_vma_page(struct page *page)
>          |      ^~~~~~~~~~~~~~
>    In file included from mm/folio-compat.c:11:
>    mm/internal.h:503:20: note: previous definition of 'mlock_vma_page' with type 'void(struct page *)'
>      503 | static inline void mlock_vma_page(struct page *page) { }
>          |                    ^~~~~~~~~~~~~~
>    mm/folio-compat.c: In function 'mlock_vma_page':
>    mm/folio-compat.c:176:9: error: implicit declaration of function 'mlock_vma_folio'; did you mean 'mlock_vma_page'? [-Werror=implicit-function-declaration]
>      176 |         mlock_vma_folio(page_folio(page));
>          |         ^~~~~~~~~~~~~~~
>          |         mlock_vma_page
>    mm/folio-compat.c: At top level:
>    mm/folio-compat.c:179:6: warning: no previous prototype for 'page_mlock' [-Wmissing-prototypes]
>      179 | void page_mlock(struct page *page)
>          |      ^~~~~~~~~~
>    mm/folio-compat.c: In function 'page_mlock':
> >> mm/folio-compat.c:181:9: error: implicit declaration of function 'folio_mlock'; did you mean 'folio_lock'? [-Werror=implicit-function-declaration]
>      181 |         folio_mlock(page_folio(page));
>          |         ^~~~~~~~~~~
>          |         folio_lock
>    cc1: some warnings being treated as errors

All fixed in an update I pushed about two hours ago ;-)
