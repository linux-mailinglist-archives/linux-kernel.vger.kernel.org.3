Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBB513215
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbiD1LI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbiD1LIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:08:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F42F4;
        Thu, 28 Apr 2022 04:05:24 -0700 (PDT)
Date:   Thu, 28 Apr 2022 13:05:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651143922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnxllsTcAyZYtkavIh31owKoz9rJdYEtxB5QbrLOk3k=;
        b=UGJNInDBPSxA5iy6App+FFqkZE4flLJQY8+rk28YwbJ9klfs7ZSzorXAs9eSBFVfB/7Zwg
        AXzmj8T2D3pvGVYrTRB65GPr3Cays9X+igoYKxJpOQ6C7JU6szReOzcaAoxl+EXFX2wCB+
        PvrAqZ07eM6cY6FyH8kXF8uTzw8KWUN15fNXQtPmwNHlGZgvuwf3RBtRQKbFHYAkfX6EsT
        DksWdXCyDYDbfpnV1i5/HkLLLYTuhFabqGHvg3oaXU49FfzTVy+QS6kBwrQ1S88Uy3GAZW
        GH/UTAzrXlO8x1ZmLK4wl91t5KkjqrN5DfSiWZe/GlzwNHTnbDmPa0acLALlrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651143922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnxllsTcAyZYtkavIh31owKoz9rJdYEtxB5QbrLOk3k=;
        b=seOCzzM5JH2712g7j/mcC/gzYbbNjXx8Or9WsjyDPI1JoCtzFz/hB2js/Mlnsj0CFf+s2N
        XKv8UdRY3I6eo0BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Message-ID: <Ymp08dSdeDjvwF9b@linutronix.de>
References: <20220427183821.1979-1-fmdefrancesco@gmail.com>
 <20220427183821.1979-2-fmdefrancesco@gmail.com>
 <YmpaUgxIk0rrwt2G@linutronix.de>
 <2598013.X9hSmTKtgW@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2598013.X9hSmTKtgW@leap>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-28 12:54:14 [+0200], Fabio M. De Francesco wrote:
> No, it's not sufficient because Matthew Wilcox said that something like "It 
> is the counterpart of kmap_atomic() for unmapping" (or anything similar) is 
> _not_ what he wants to see. 
> 
> Furthermore, a large part of this text has been written by him (I'm talking 
> of a couple of weeks ago, when this patch was not part of this series - it 
> was on its own until Ira Weiny asked me to gather 4 patches in one only 
> series).

Sure.

> > This indicates the "migration" is disabled for
> > !PREEMPT_RT which is not the case.
> 
> I read again how kmap_atomic() is defined. There are lots of 'if' 
> statements. Only if the code gets to __kmap_local_pfn_prot(), users can be 
> assured that it unconditionally calls both migrate_disable() and 
> preempt_disable(). 

Right, that part. Then keep it.

> > So maybe something like
> > 
> >  * Unmaps an address previously mapped by kmap_atomic() and re-enables
> >  * pagefaults, CPU migration (CONFIG_PREEMPT_RT) or preemption
> >  * (!CONFIG_PREEMPT_RT). Mappings should be unmapped in the reverse
> > 
> > will make it clear.
> 
> I'm starting to think that this level of detail is too much for users who 
> just need to understand how to use this function as well as  
> kmap_local_page().
> 
> I prefer something like the following:
> 
> + * Unmaps an address previously mapped by kmap_atomic() and re-enables
> + * pagefaults and possibly also CPU migration and/or preemption. However, 
> + * users should not count on disable of migration and/or preemption as a 
> + * side effect of calling kmap_atomic(). Mappings must be unmapped in the 
> + * reverse [...]
> 
> I'd also like to write the same paragraph for kmap_local_page().
> 
> What do you think of being less detailed and instead using the text I wrote 
> above? 

Sounds perfect.

> Thanks,
> 
> Fabio

Sebastian
