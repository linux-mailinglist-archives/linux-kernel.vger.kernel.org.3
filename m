Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D52D50FBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbiDZLH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiDZLHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:07:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F7F28E2A;
        Tue, 26 Apr 2022 04:04:46 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:04:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650971084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjyU9NvofkV276yYd3L7iXZQQ0QFvFSNByjHU0uq55c=;
        b=Gk0yHJbv2aGJ/2l1nIkLLvqz5HrQO/PDPUfAftVbi8s6Pognk8pqJSusRuinaNcx9PpVne
        BvO49UaWcszJJeLPZXrKe6fsthVJb4qKWfMHX+5PBu8mJm22mABoRt+nVL4ALXXN1MrSNI
        4DvH3WinatcPub7cgQJPm1IFwbeOwEa0nitf4Nxx1Bfen753d7PDI/2lmXWnlw6rx6uCrL
        yUVQszsXwdT6wQ4V/QM+1hauVHfnizUJv7/qdkhLMQcTDD6vZKipF0s/0sQPuTnaWYi8EH
        6MavcUNGD6G5k0uv81GqURnJZsWo9dQNoqH9k9Fd9+CLBcBnWhNTeTTlzH19+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650971084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HjyU9NvofkV276yYd3L7iXZQQ0QFvFSNByjHU0uq55c=;
        b=+b8zV0yo/mXtz/93HGWqiMRgkSpPuzqlcsWqHHG8/yhDsUpHdRxcogSO3dx/Mbs5WnV6Oa
        x+JjmR6t3PENpcBg==
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
Message-ID: <YmfRynAhuSWz9H+e@linutronix.de>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com>
 <20220425162400.11334-2-fmdefrancesco@gmail.com>
 <YmeYzKT8Ikq5SfdE@linutronix.de>
 <4396926.LvFx2qVVIh@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4396926.LvFx2qVVIh@leap>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-26 11:43:03 [+0200], Fabio M. De Francesco wrote:
> I might add "Deprecated!", however Ira Weiny asked me to rephrase an 
> earlier version of one of the patch which is is this series. I wrote that 
> "The use of kmap_atomic() is deprecated in favor of kmap_local_page()." and 
> Ira replied "I'm not sure deprecated is the right word. [] This series 
> should end up indicating the desire to stop growing kmap() and
> kmap_atomic() call sites and that their deprecation is on the horizon.".
> 
> What Ira suggested is exactly what I'm doing in v2. 
> 
> @Ira: what about adding "Deprecated!" for consistency with kmap_atomic() 
> kdoc?

I would prefer to keep the documentation symmetric.

> > The part about
> > disabling/ enabling preemption is true for !PREEMPT_RT.
> 
> To me it looks that this is not what Thomas Gleixner wrote in the cover 
> letter of his series ("[patch V2 00/18] mm/highmem: Preemptible variant of 
> kmap_atomic & friends") at 
> https://lore.kernel.org/lkml/20201029221806.189523375@linutronix.de/
> 
> For your convenience:
> 
> "[] there is not a real reason anymore to confine migration disabling to 
> RT. [] Removing the RT dependency from migrate_disable/enable()".
> 
> Is there anything I'm still missing?

Hmm. We had migrate_disable() initially limited to RT for a few reasons.
Then Linus complained about this and that and mentioned something about
Highmem is dying or not used that widely anymore (or so) and then the
local interface came up which required the migrate_disable() interface
to work for everyone. Back then the atomic interface should go away and
I remember that hch wanted to remove some of the callers from the DMA
API.
That is just on top of my head.

Looking at kmap_atomic() there is this:

| static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
| {
|         if (IS_ENABLED(CONFIG_PREEMPT_RT))
|                 migrate_disable();
|         else
|                 preempt_disable();
| 
|         pagefault_disable();
|         return __kmap_local_page_prot(page, prot);
| }
| 
| static inline void *kmap_atomic(struct page *page)
| {
|         return kmap_atomic_prot(page, kmap_prot);
| }

as of v5.18-rc4. As you see, pagefaults are disabled for everyone. RT disables
migration only and !RT disables preemption. 
Internally __kmap_local_page_prot() ends up in __kmap_local_pfn_prot()
which uses migrate_disable() for the lifetime of the mapping. So it
disables additionally migration for the life time of the mapping but
preemption has been also disabled (and only for !RT).

We _could_ only disable migration in kmap_atomic_prot() for everyone but
we can't easily proof that none of the kmap_atomic() user rely on the
preempt-disable part. RT never disabled preemption here so it is safe to
assume that nothing on RT relies on that.

> > The part that
> > worries me is that people use it and rely on disabled preemption like
> > some did in the past. 
> 
> This is something I'd prefer to hear also from other developers who are 
> CC'ed for this patch :) 

Eitherway, according to the code kmap_atomic() does not always disable
preemption and the other comments around indicate that it is deprecated,
see commit
   f3ba3c710ac5a ("mm/highmem: Provide kmap_local*")
   https://git.kernel.org/torvalds/c/f3ba3c710ac5a

> Thanks for your review,
> 
> Fabio

Sebastian
