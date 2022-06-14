Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A744254B207
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbiFNNIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245344AbiFNNIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:08:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E362F6;
        Tue, 14 Jun 2022 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hjgW1iVXZwSWULLtmSFms/AqBauzk37V6ns/4dxDDjI=; b=jmJfBvabs8zrDcqXgR47H6WTLC
        hbp6ErmGcui9GKIjs6TWZL9BwwV9y/0ipBgSSE0z2MHMe+m2pFgK2x+rxLDzmpArZw8LjgO1iHOIO
        r4gQCEUIVnsdGe7NYtOkc0PXrebPwqtr4mgwgHRS6REjbnfE20htIu7igG6u7UWJQq32AaqzXF5pP
        7zKlwhqpLaqhED4i5QjPGfjHvsN2O29JdSZ09Wcs7+NlKx+jnltsw99fFpUxpNnGBbNNJf2y3AQvu
        QA5dqvGwJqfIy6t1Os6biKIqd6AH9N8FoyCAZHjco13X0Ru+qwSKJEpxCi36BDRvyKfOwER3fg/Sr
        svMzhP/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o16HM-000BCG-8E; Tue, 14 Jun 2022 13:08:20 +0000
Date:   Tue, 14 Jun 2022 14:08:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: highmem: Use literal block for
 *kmap_local_folio() example
Message-ID: <YqiIRONzn5t1v8yq@casper.infradead.org>
References: <20220614123115.522131-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614123115.522131-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 07:31:16PM +0700, Bagas Sanjaya wrote:
> When building htmldocs on Linus' tree, there are inline emphasis warnings
> on include/linux/highmem.h:
> 
> Documentation/vm/highmem:166: ./include/linux/highmem.h:154: WARNING: Inline emphasis start-string without end-string.
> Documentation/vm/highmem:166: ./include/linux/highmem.h:157: WARNING: Inline emphasis start-string without end-string.
> 
> These warnings above are due to comments in code example of
> *kmap_local_folio() are enclosed by double dash (--) instead of prefixed
> with comment symbol (#).

That's clearly the code example for kmap_atomic(), not
kmap_local_folio().

> Fix these warnings by indenting the code example with literal block
> indentation and prefixing comments inside the example with #.
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
>  include/linux/highmem.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 3af34de54330cb..a244e0345c87ca 100644
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
> + *   # Find the page of interest.
> + *   struct page *page = find_get_page(mapping, offset);
>   *
> - * -- Gain access to the contents of that page. --
> - * void *vaddr = kmap_atomic(page);
> + *   # Gain access to the contents of that page.
> + *   void *vaddr = kmap_atomic(page);
>   *
> - * -- Do something to the contents of that page. --
> - * memset(vaddr, 0, PAGE_SIZE);
> + *   # Do something to the contents of that page.
> + *   memset(vaddr, 0, PAGE_SIZE);
>   *
> - * -- Unmap that page. --
> - * kunmap_atomic(vaddr);
> + *   # Unmap that page.
> + *   kunmap_atomic(vaddr);
>   *
>   * Note that the kunmap_atomic() call takes the result of the kmap_atomic()
>   * call, not the argument.
> 
> base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> -- 
> An old man doll... just what I always wanted! - Clara
> 
