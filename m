Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1CA4752FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhLOG3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhLOG3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:29:11 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B3FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:29:11 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z6so15573319plk.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g+leonSXX48LomKGcsKyh2T51IYWLoQSJ7KEkFp32Wk=;
        b=mMjW6iUWuOdnj+flmFj3MJtFoWpoEPPqv0+EEXjD21U1lHZpEB5Rmv/9FWrHGzqExc
         gkfKYzsZV2nWABXfd0sgno5wmKFl4f1ZeDhQ9Asc6r+avGwQFIrPyA1X8KzDA9tOz7Om
         bOJTYZuRejW3HdGeg6Y+WO5o0amEFP9A5cNQKnfsQPROFG8XtVomeBZprDuLv/Y5RZcE
         v+vRSwRiaX7VbsjHfB+s6gIzuDPesNqD1hAmmABdVCK4WAffBPNRAaaEwzIxmJI1g6QS
         uYM58lI2LuivULz71GWcIOz4lPoxhIxQsx3XN3PyiGy3U8VpmkPT1lY0CgzAEU2h6Fgd
         xYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g+leonSXX48LomKGcsKyh2T51IYWLoQSJ7KEkFp32Wk=;
        b=WS/WYElYxr/2iQsazpaO5rvdyW3/Jb7MxdwP6aCqqP+97C6axX6noS9BG174p8EEmz
         yZhx4mYqKf9phIWcnqg6MK6Xe11LRy3le0RQIeOX880fb8scFcCy4F29yp+gdS6UL9zU
         kvNUMHxKWOrgvPTO81p4E/H2zOpVjSw7wAiOFhzpT/X8L1r8dXgs5kJ6VEkaUww2G9qB
         Vy4DEVBouXZZU7F6dHYcwOxSHYvbREj1iKf/9CJ2zmL40wSN2y3yYfKClKAOH7SEr/dz
         kT87ImyFHgnkuBOyDhotZ0mmhrQdoa0KV9SuKPcDqOzFY/33SxyHOfloc/RgysxDOv2F
         WXBw==
X-Gm-Message-State: AOAM530wBMzd4eZhFxOZ3mPZhrOEW9Rx6Wbg33+xA2DNPjNyyoteg+4u
        g++c8oou3APhgLo0Mg9urrg=
X-Google-Smtp-Source: ABdhPJxoT8XnKPp1LzJMcjQONxjMiabHoVJHG4toh14VOoaNO8zxrOXhujCzb8HVfO2obOQ6PpgFjQ==
X-Received: by 2002:a17:90b:1bcf:: with SMTP id oa15mr10442083pjb.161.1639549750733;
        Tue, 14 Dec 2021 22:29:10 -0800 (PST)
Received: from odroid ([114.29.23.242])
        by smtp.gmail.com with ESMTPSA id g17sm1145550pfv.136.2021.12.14.22.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 22:29:10 -0800 (PST)
Date:   Wed, 15 Dec 2021 06:29:04 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@gentwo.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Do we really need SLOB nowdays?
Message-ID: <20211215062904.GA1150813@odroid>
References: <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
 <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YXqSoo+b9RTclW/2@casper.infradead.org>
 <20211210110835.GA632811@odroid>
 <alpine.DEB.2.22.394.2112101305500.290446@gentwo.de>
 <cbfaeb40-13c7-15b6-177d-07b3f3c4a0a9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbfaeb40-13c7-15b6-177d-07b3f3c4a0a9@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:24:58PM +0100, Vlastimil Babka wrote:
> On 12/10/21 13:06, Christoph Lameter wrote:
> > On Fri, 10 Dec 2021, Hyeonggon Yoo wrote:
> > 
> >> > > (But I still have doubt if we can run linux on machines like that.)
> >> >
> >> > I sent you a series of articles about making Linux run in 1MB.
> >>
> >> After some time playing with the size of kernel,
> >> I was able to run linux in 6.6MiB of RAM. and the SLOB used
> >> around 300KiB of memory.
> > 
> > What is the minimal size you need for SLUB?
>  

I don't know why Christoph's mail is not in my mailbox. maybe I deleted it
by mistake or I'm not cc-ed.

Anyway, I tried to measure this again with SLUB and SLOB.

SLUB uses few hundreds of bytes than SLOB.

There isn't much difference in 'Memory required to boot'.
(interestingly SLUB requires less)

'Memory required to boot' is measured by reducing memory
until it says 'System is deadlocked on memory'. I don't know
exact reason why they differ.

Note that the configuration is based on tinyconfig and
I added initramfs support + tty layer (+ uart driver) + procfs support,
+ ELF binary support + etc.

there isn't even block layer, but it's good starting point to see
what happens in small system.

SLOB:

	Memory required to boot: 6950K

	/proc/meminfo:
		MemTotal:           4820 kB
		MemFree:            1172 kB
		MemAvailable:        800 kB
		Buffers:               0 kB
		Cached:             2528 kB
		SwapCached:            0 kB
		Active:                4 kB
		Inactive:            100 kB
		Active(anon):          4 kB
		Inactive(anon):      100 kB
		Active(file):          0 kB
		Inactive(file):        0 kB
		Unevictable:        2528 kB
		Mlocked:               0 kB
		SwapTotal:             0 kB
		SwapFree:              0 kB
		Dirty:                 0 kB
		Writeback:             0 kB
		AnonPages:           120 kB
		Mapped:              848 kB
		Shmem:                 0 kB
		KReclaimable:          0 kB
		Slab:                368 kB
		SReclaimable:          0 kB
		SUnreclaim:          368 kB
		KernelStack:         128 kB
		PageTables:           28 kB
		NFS_Unstable:          0 kB
		Bounce:                0 kB
		WritebackTmp:          0 kB
		CommitLimit:        2408 kB
		Committed_AS:        524 kB
		VmallocTotal:    1032192 kB
		VmallocUsed:          16 kB
		VmallocChunk:          0 kB
		Percpu:               32 kB

SLUB:
	Memory required to boot: 6800K

	/proc/meminfo:
		MemTotal:           4660 kB
		MemFree:             836 kB
		MemAvailable:        568 kB
		Buffers:               0 kB
		Cached:             2528 kB
		SwapCached:            0 kB
		Active:                4 kB
		Inactive:            100 kB
		Active(anon):          4 kB
		Inactive(anon):      100 kB
		Active(file):          0 kB
		Inactive(file):        0 kB
		Unevictable:        2528 kB
		Mlocked:               0 kB
		SwapTotal:             0 kB
		SwapFree:              0 kB
		Dirty:                 0 kB
		Writeback:             0 kB
		AnonPages:           120 kB
		Mapped:              848 kB
		Shmem:                 0 kB
		KReclaimable:        188 kB
		Slab:                552 kB
		SReclaimable:        188 kB
		SUnreclaim:          364 kB
		KernelStack:         128 kB
		PageTables:           28 kB
		NFS_Unstable:          0 kB
		Bounce:                0 kB
		WritebackTmp:          0 kB
		CommitLimit:        2328 kB
		Committed_AS:        524 kB
		VmallocTotal:    1032192 kB
		VmallocUsed:          16 kB
		VmallocChunk:          0 kB
		Percpu:               32 kB

SLUB with slab merging:

	Memory required to boot: 6800K
	/proc/meminfo:
		MemTotal:           4660 kB
		MemFree:             840 kB
		MemAvailable:        572 kB
		Buffers:               0 kB
		Cached:             2528 kB
		SwapCached:            0 kB
		Active:                4 kB
		Inactive:            100 kB
		Active(anon):          4 kB
		Inactive(anon):      100 kB
		Active(file):          0 kB
		Inactive(file):        0 kB
		Unevictable:        2528 kB
		Mlocked:               0 kB
		SwapTotal:             0 kB
		SwapFree:              0 kB
		Dirty:                 0 kB
		Writeback:             0 kB
		AnonPages:           120 kB
		Mapped:              848 kB
		Shmem:                 0 kB
		KReclaimable:        188 kB
		Slab:                536 kB
		SReclaimable:        188 kB
		SUnreclaim:          348 kB
		KernelStack:         128 kB
		PageTables:           28 kB
		NFS_Unstable:          0 kB
		Bounce:                0 kB
		WritebackTmp:          0 kB
		CommitLimit:        2328 kB
		Committed_AS:        524 kB
		VmallocTotal:    1032192 kB
		VmallocUsed:          16 kB
		VmallocChunk:          0 kB
		Percpu:               32 kB



If you're interested in reproducing this,
some links below will help:

https://hyeyoo.com/148 (written in korean but the commands and pictures will help)
http://events17.linuxfoundation.org/sites/events/files/slides/tiny.pdf
http://events17.linuxfoundation.org/sites/events/files/slides/opdenacker-embedded-linux-size-reduction-techniques_0.pdf
https://lukaszgemborowski.github.io/articles/minimalistic-linux-system-on-qemu-arm.html
https://weeraman.com/building-a-tiny-linux-kernel-8c07579ae79d

the target board is ARM Versatile Platform Board (based on ARMv5).
And I ran this on qemu.

Thanks,
Hyeonggon.

> Good question. Meanwhile I tried to compare Slab: in /proc/meminfo on a virtme run:
> virtme-run --mods=auto --kdir /home/vbabka/wrk/linux/ --memory 2G,slots=2,maxmem=4G --qemu-opts --smp 4
> 
> Got ~30800kB with SLOB, 34500kB with SLUB without DEBUG and PERCPU_PARTIAL.
> Then did a quick and dirty patch (below) to never load c->slab in
> ___slab_alloc() and got to 32200kB. Fiddling with
> slub_min_order/slub_max_order didn't actually help, probably due to causing
> more internal fragmentation.
> 
> So that's relatively close, but on a really small system the difference can
> be possibly more prominent. Also my test doesn't account for text/data or
> percpu usage differences.
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 68aa112e469b..fd9c853971d1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3054,6 +3054,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		 */
>  		goto return_single;
>  
> +	goto return_single;
> +
>  retry_load_slab:
>  
>  	local_lock_irqsave(&s->cpu_slab->lock, flags);
> 
> 
