Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBA4FADD3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbiDJM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiDJM2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 08:28:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4BC326D6;
        Sun, 10 Apr 2022 05:26:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so20245457ejn.2;
        Sun, 10 Apr 2022 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrVjh0v7eyUha8NLGu08fv9hbISVTSpHgFj2vhTVT5E=;
        b=YtoXBYxKcKPvDhefulGfma1Zo1bDAzjpHf2TWEtPMGa5Bq3kNycUjtRqC5uc9zWMJM
         ZjeIwrZT21voVvVZrzz6LKQLsV8BmdM6wQjUcMdUNDV6AuziLCUyop2zbTKPaj1Ts8+d
         BjMeieoGO8JHFRjNze39mksh1O3WmSwiCzXDFezrEqQY6xtdXpmXYW98m/BZQK7N5SiS
         Rki6J0SYRhjfhbI0goSi8B/a9AloQbiMM0QMX0OryoGTnl04xoQ/6+RqkwecUm7EhS2n
         n6V1JDWvMKSiifZnV+xZsE/zEXnZQfzO4INSEc3jTvKKWRTeXW9Fb79lvcZpdHcA1ajC
         O0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrVjh0v7eyUha8NLGu08fv9hbISVTSpHgFj2vhTVT5E=;
        b=VBnEhISAZBQgfyNPH9ScnFJJTBFgS7DbyPDn/85hyVcXSZeyCwaSwq8KBTi9hPAcjc
         NH8YDey0rJQsMT/q8MwHdc3OeHmkpJ0dbuUN72jZqLJuQ3PiRuUIvBMW0lnMEr2KQ5Aj
         AOXtuUgoCXF/7TlWdXr2RtDngJyosdtbeV5UFuIQ16IEsgHLL2eFD3Pkk7UvlLHU7j/v
         7vXWxmqF/fXqIVvQoe42w+kuHGzSJmEm+3P7VQX9NoNN7twzeYJla0CiTJy7ro4IZwAi
         +FagobhGQAE2J+zc3GWr03h7yIqlE1FvtuC6Ggwl9K7/k6e6QNNfL1ueKjaWIH2Du8UA
         X6Bg==
X-Gm-Message-State: AOAM533T1F8IyUqmz6IOQnzhfvMf6JN5qAmMZQYSVBMPb+cfI2LfUZAy
        jmhXPumpLpfb99/fYtdjhOSQzfMBVvc=
X-Google-Smtp-Source: ABdhPJx23xzGdSoaggDeGrOD7hqVTSLZ57ctcuWTCORiMr5EKMocSW9sHenju8TGfjxGUDJe5f1h3Q==
X-Received: by 2002:a17:907:6e87:b0:6e7:f655:3b41 with SMTP id sh7-20020a1709076e8700b006e7f6553b41mr25358691ejc.704.1649593602255;
        Sun, 10 Apr 2022 05:26:42 -0700 (PDT)
Received: from leap.localnet (host-82-60-208-254.retail.telecomitalia.it. [82.60.208.254])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906521000b006d58773e992sm10823359ejm.188.2022.04.10.05.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 05:26:40 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org
Subject: Re: [PATCH] Documentation/vm: Extend "Temporary Virtual Mappings" in highmem.rst
Date:   Sun, 10 Apr 2022 14:26:38 +0200
Message-ID: <2129241.NgBsaNRSFp@leap>
In-Reply-To: <YlJNI7c9pwq5R0RB@casper.infradead.org>
References: <20220409184907.25122-1-fmdefrancesco@gmail.com> <YlJNI7c9pwq5R0RB@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew, 

Thank you for this review.

On domenica 10 aprile 2022 05:21:07 CEST Matthew Wilcox wrote:
> On Sat, Apr 09, 2022 at 08:49:07PM +0200, Fabio M. De Francesco wrote:
> > @@ -52,25 +52,65 @@ Temporary Virtual Mappings
> >  
> >  The kernel contains several ways of creating temporary mappings:
> >  
> > -* vmap().  This can be used to make a long duration mapping of multiple
> > -  physical pages into a contiguous virtual space.  It needs global
> > -  synchronization to unmap.
> > +* vmap().  This can be used to make a long duration mapping of multiple physical
> > +  pages into a contiguous virtual space. It needs global synchronization to unmap.
> 
> Did you change any words here?  If so, I can't see them.  Please don't
> gratuitously reformat paragraphs; it obscures the real changes.  Also,
> 75 characters is a good limit for line length, and you're well past
> that.  If in doubt, use `fmt`.

No, I did not change any words. I'll restore it back as it was so that 
the real changes won't be obscured.
 
> > -* kmap().  This permits a short duration mapping of a single page.  It needs
> > -  global synchronization, but is amortized somewhat.  It is also prone to
> > -  deadlocks when using in a nested fashion, and so it is not recommended for
> > -  new code.
> > +* kmap().  This can be used to make long duration mapping of a single page with
> 
> kmap() really isn't for long duration.  But the pointer returned from
> kmap() is valid across all CPUs, unlike kmap_local() or kmap_atomic().

I think that I used the wrong words because "long duration", in my mind, 
should have meant that there are no restrictions on preemption or migrations 
across CPUs (differently from the other functions for mappings). I decided 
to express these concepts as "This can be used to make long duration 
mappings []".

Now I understand that this is not technically accurate and that it is not 
what the Author wanted to convey. Therefore I'll restore it to how it was 
before my changes.
 
> > +  no restrictions on preemption or migration. It comes with an overhead as mapping
> > +  space is restricted and protected by a global lock for synchronization. When
> > +  mapping is no more needed, page must be released with kunmap().
> 
> kunmap() doesn't release the page, it releases the address that the
> page was mapped to.

It's just a mistake in expressing the correct semantics which I think I know 
properly. I should have probably read it once more and notice this mistake 
before sending my patch. 

I'll use the proper wording in v2.

> > +  Mapping changes must be propagated across all the CPUs. kmap() also requires
> > +  global TLB invalidation when the kmap's pool wraps and it might block when the
> > +  mapping space is fully utilized until a slot becomes available. Therefore,
> > +  kmap() is only callable from preemptible context.
> >  
> > +  All the above work is necessary if a mapping must last for a relatively long
> > +  time but the bulk of high-memory mappings in the kernel are short-lived and
> > +  only used in one place.
> > +
> > +  This means that the cost of kmap() is mostly wasted in such cases; therefore,
> > +  newer code is discouraged from using kmap().
> >  
> > -* kmap_atomic().  This permits a very short duration mapping of a single
> > -  page.  Since the mapping is restricted to the CPU that issued it, it
> > -  performs well, but the issuing task is therefore required to stay on that
> > -  CPU until it has finished, lest some other task displace its mappings.
> > +* kmap_atomic().  This permits a very short duration mapping of a single page.
> > +  Since the mapping is restricted to the CPU that issued it, it performs well,
> > +  but the issuing task is therefore required to stay on that CPU until it has
> > +  finished, lest some other task displace its mappings.
> >  
> > -  kmap_atomic() may also be used by interrupt contexts, since it is does not
> > -  sleep and the caller may not sleep until after kunmap_atomic() is called.
> > +  kmap_atomic() may also be used by interrupt contexts, since it is does not
> > +  sleep and the caller too can not sleep until after kunmap_atomic() is called.
> > +  Each call of kmap_atomic() in the kernel creates a non-preemptible section and
> > +  disable pagefaults.
> > +
> > +  This could be a source of unwanted latency, so it should be only used if it is
> > +  absolutely required, otherwise the corresponding kmap_local_*() variant should
> > +  be used if it is feasible (see below).
> > +
> > +  On 64-bit systems, calls to kmap() and kmap_atomic() have no real work to do
> > +  because a 64-bit address space is more than sufficient to address all the
> > +  physical memory, so all of physical memory appears in the direct mapping.
> > +
> > -  It may be assumed that k[un]map_atomic() won't fail.
> > +  It is assumed that k[un]map_atomic() won't fail.
> > +
> > +* kmap_local_*().  These provide a set of functions similar to kmap_atomic() and
> > +  are used to require short term mappings. They can be invoked from any context
> > +  (including interrupts).
> > +
> > +  The mapping can only be used in the context which acquired it, it is per thread,
> > +  CPU local (i.e., migration from one CPU to another is disabled - this is why
> > +  they are called "local"), but they don't disable preemption. It's valid to take
> > +  pagefaults in a local kmap region, unless the context in which the local mapping
> > +  is acquired does not allow it for other reasons.
> > +
> > +  If a task holding local kmaps is preempted, the maps are removed on context
> > +  switch and restored when the task comes back on the CPU. As the maps are strictly
> > +  CPU local, it is guaranteed that the task stays on the CPU and that the CPU
> > +  cannot be unplugged until the local kmaps are released.
> > +
> > +  Nesting kmap_local.*() and kmap_atomic.*() mappings is allowed to a certain
> > +  extent (up to KMAP_TYPE_NR). Nested kmap_local.*() and kunmap_local.*()
> > +  invocations have to be strictly ordered because the map implementation is stack
> > +  based.
> 
> I think the original layout of all this is flawed.  We should start by
> describing the interface we want people to use first -- kmap_local*(),
> then say "But if you can't use that, there's kmap_atomic()" and "If
> you can't use kmap_atomic(), you can use kmap()".  And vmap() should
> go right at the end because it's entirely different from the kmap()
> family.  I even question if it should be in this document, but it's not
> really documented anywhere else.
 
I agree in full. We should start by describing kmap_local_*(). Actually I 
had noticed that the layout is flawed when I had to write: "(see below)". 
Making a reference to what comes after looks very strange to my eyes. 

I'll rework the layout in v2. 

> Also, you should probably cc the person who is listed as the author
> of the document, don't you think?

Oh, yes, I'm sorry. I don't know how I could have overlooked Peter Zijlstra. 
It won't happen again with my v2 patch (I have already noticed that you added
him in Cc with your email).

Again, many thanks for taking the time to write this review,

Fabio M. De Francesco



