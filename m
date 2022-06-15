Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62A454CB74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245344AbiFOOhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFOOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:37:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615113B567;
        Wed, 15 Jun 2022 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=saG5sDrVw9Zr0xvtzKbdVeuNnQ3Z6A05xiDq4AzD6dg=; b=bj1K2vKmeUI35w3WQw2RkLX1ip
        QCEaDPfkJlTI0mlAWH5qdVUCTCBvOh2OgJPA/Qa2CT7CPAj1Q5XMiFlSSiWVG14WOOF8TBkW9C8DB
        smp0xoEry+r3xyzto66f5nl3HyiSHbc0k8xZYj5h3FUvwCfsfaTk7bkzWV7D47207xO7HNu5g4FiG
        R0fNxeFhwAmmLmrKbEPXG5brlpPDUOBQfVgtPTNRYEV2l21il8F42ETOfD+HoC/5qjClPhEbDsQSM
        7I8v8lhqeRHkRZEvifGEzh3KJY4kpRdBL11eBdkZnqmC/4L86Lt6dmyhY2QRPhCjV60mCS/pK7EVK
        pqDqcbCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1U8j-0017Zi-CF; Wed, 15 Jun 2022 14:37:01 +0000
Date:   Wed, 15 Jun 2022 15:37:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: highmem: Use literal block for
 *kmap_local_folio() example
Message-ID: <YqnujWdTA+QSdMHJ@casper.infradead.org>
References: <20220615101509.516520-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615101509.516520-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 05:15:10PM +0700, Bagas Sanjaya wrote:
> These warnings above are due to comments in code example of
> kmap_atomic() inside kernel-doc comment of *kmap_local_folio() are enclosed

You still seem to think this has something to do with kmap_local_folio().
It has nothing to do with kmap_local_folio().  Your next version of this
patch should not mention kmap_local_folio() anywhere.

> by double dash (--) instead of prefixed with C comment symbol (//).
> 
> Fix these warnings by indenting the code example with literal block
> indentation and prefixing comments inside the example with C comment
> symbol.
> 
> Fixes: 85a85e7601263f ("Documentation/vm: move "Using kmap-atomic" to highmem.h")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v1 [1]:
>    - Point that the code example is for kmap_atomic() (suggested by
>      Matthew Wilcox)
>    - Use C comments instead of Unix shell comments prefix (suggested by
>      Ira Weiny)
> 
>  [1]: https://lore.kernel.org/linux-doc/20220614123115.522131-1-bagasdotme@gmail.com/
>  
>  include/linux/highmem.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 3af34de54330cb..56d6a019653489 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -149,19 +149,19 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
>   * It is used in atomic context when code wants to access the contents of a
>   * page that might be allocated from high memory (see __GFP_HIGHMEM), for
>   * example a page in the pagecache.  The API has two functions, and they
> - * can be used in a manner similar to the following:
> + * can be used in a manner similar to the following::
>   *
> - * -- Find the page of interest. --
> - * struct page *page = find_get_page(mapping, offset);
> + *   // Find the page of interest.
> + *   struct page *page = find_get_page(mapping, offset);
>   *
> - * -- Gain access to the contents of that page. --
> - * void *vaddr = kmap_atomic(page);
> + *   // Gain access to the contents of that page.
> + *   void *vaddr = kmap_atomic(page);
>   *
> - * -- Do something to the contents of that page. --
> - * memset(vaddr, 0, PAGE_SIZE);
> + *   // Do something to the contents of that page.
> + *   memset(vaddr, 0, PAGE_SIZE);
>   *
> - * -- Unmap that page. --
> - * kunmap_atomic(vaddr);
> + *   // Unmap that page.
> + *   kunmap_atomic(vaddr);
>   *
>   * Note that the kunmap_atomic() call takes the result of the kmap_atomic()
>   * call, not the argument.
> 
> base-commit: 018ab4fabddd94f1c96f3b59e180691b9e88d5d8
> -- 
> An old man doll... just what I always wanted! - Clara
> 
> 
