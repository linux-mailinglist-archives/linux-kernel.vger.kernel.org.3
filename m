Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A2450F1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbiDZHEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiDZHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:04:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D365D37;
        Tue, 26 Apr 2022 00:01:36 -0700 (PDT)
Date:   Tue, 26 Apr 2022 09:01:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650956493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTCRMU626wUXdIQdsZJqxEPJIS21IoevEG8EtyqRngs=;
        b=G1YYFC7b9CA25F5dqZ9G3lB1okaKxhr7ktdUOimKsz4r416XIpu7aqXalKH35lsqmIgocG
        XtnjaBEKDpwPiIwmZ3fqNBM4Isdnl7FJnPAOj5hbHYVoY9ZT7UGNNBtszOi7+U1+bD3qY2
        JbPL0FSSpvsfAFkiTeZjCs8vf/Y4gHkdfqNe0H4fGOaJeICEWrx8K9Lm1YR4qwsugidY17
        8nOAUb5Ztub8G9FAhMj0cG0HjotfyV1EenDdoeb/yfGrwwjV7Ibg1v9PtHo4Er8/V5TBJS
        uwvSZ3E4pof+F3558WLSX6kvhxZl1Eq6LoisSWDhKx1G8QlD2Gi9TZ344r1a6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650956493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTCRMU626wUXdIQdsZJqxEPJIS21IoevEG8EtyqRngs=;
        b=lYRgzZbkyghTMsuisYtZfHyNE6sUa/c2MsYt3zCtiyMmsqyoJQbiuBx91lqudW4h3ffaQ1
        9nxLtOnBF63hLXDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev,
        "Acked-by : Mike Rapoport" <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Message-ID: <YmeYzKT8Ikq5SfdE@linutronix.de>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com>
 <20220425162400.11334-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425162400.11334-2-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-25 18:23:57 [+0200], Fabio M. De Francesco wrote:
> index a77be5630209..aa22daeed617 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -236,9 +236,17 @@ static inline unsigned long totalhigh_pages(void) { return 0UL; }
>  
>  #endif /* CONFIG_HIGHMEM */
>  
> -/*
> - * Prevent people trying to call kunmap_atomic() as if it were kunmap()
> - * kunmap_atomic() should get the return value of kmap_atomic, not the page.
> +/**
> + * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> + * @__addr:       Virtual address to be unmapped
> + *
> + * Unmaps an address previously mapped by kmap_atomic() and re-enables
> + * pagefaults and preemption. Mappings should be unmapped in the reverse

You mind adding "Deprecated!" like kmap_atomic() has? The part about
disabling/ enabling preemption is true for !PREEMPT_RT. The part that
worries me is that people use it and rely on disabled preemption like
some did in the past. 
I've been told this API is about to be removed (or so I have been told)
so I hope that it will be gone soon ;)

> + * order that they were mapped. See kmap_local_page() for details.
> + * @__addr can be any address within the mapped page, so there is no need
> + * to subtract any offset that has been added. In contrast to kunmap(),
> + * this function takes the address returned from kmap_atomic(), not the
> + * page passed to it. The compiler will warn you if you pass the page.
>   */
>  #define kunmap_atomic(__addr)					\
>  do {								\

Sebastian
