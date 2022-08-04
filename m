Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D67589F3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiHDQSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiHDQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:18:47 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA8461B2D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 09:18:46 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q184so4775932oif.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etAmvsyhZzAzzT9eyPtlklylpAwVqTimPZnoJD750d4=;
        b=pWnBXfjSYro00kkuIYoJF0a2gPtXFqFR4GH/dMGyfAykOejvu7D4UgubnzN3FVCHS6
         NjhzjrRRHIBQ2OBJMRfYXGChXYK1G1OV0SI8qniz8fYyrBX5Lg5p+au0EIZ8Mr12X2tS
         tKpiV7Uz1R6hL6HKiRGcnv+CHLOUWaP7JjsqrbWVZrpD7SRozuMNcXwlYPK1jOARpD86
         VBscChfT1Xfihl626+98SWfniv94iuungvj1WCertkzdTjdXVQjK7lv1sqNYjnMJrKe1
         PqDyybDheiusgxZmpwZ2NFAcLtNQK0TlxUgo+LuAoDJCOKP9prTiH0VX+0hb8ssPchLo
         BqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etAmvsyhZzAzzT9eyPtlklylpAwVqTimPZnoJD750d4=;
        b=fnF0AH1Ev8qWjUa0F8q83i/m78jL5aLO/GY4SqGEY5WIMEuthj0Hgvjn7GhFbd5N+5
         A31JelrJ46xIs1bFsoqSu6KhrDcuPY9MQIU04ufd5/t6orVHZRXr/uSqS1ry8ZMrZmnb
         E7p8h5aTjJitDz6EMVs+XWhjQZ//NvcVqeXlPvsmCMI9fEZOUOcP4wx6lrjcveCmPmu5
         LB/ZI+N7pu37GZudcUW3Kge3y5SiSNFgSmwciQGlLry6mO3nvJu4Rcj7ejsBbV55V6TG
         bhcWtKH8ujCxW1bxAvu/WWhTd0sEz4eafaV41J9c1oPXGNnjgV9lrLNwkxzNGOyIrMoJ
         lrGg==
X-Gm-Message-State: ACgBeo0bN7g63ELqV8PV2Obr2vxDyqHntA94bzy3Ka7qKUW5BuwjZHse
        wHd/gblIoUMxb1Q18igEzpdjr6CAY/jDzls4Px04uw==
X-Google-Smtp-Source: AA6agR6u16XAL1FnO7eIUszF9FfQdkgFIC6uxAlbpWpZyYsU0mhIYHZxKJBtdR7qGRo6OF6/ZYdw47SwytgyMqwpqhM=
X-Received: by 2002:a05:6808:138c:b0:33a:b02b:8a9a with SMTP id
 c12-20020a056808138c00b0033ab02b8a9amr4170972oiw.227.1659629925330; Thu, 04
 Aug 2022 09:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
 <CAFTs51UAyc4Z5WUFdMXCTYR6zji6NwLeBxYsp9GQZvFdEtUm1w@mail.gmail.com>
 <500891137.95782.1659452479846.JavaMail.zimbra@efficios.com>
 <CAPNVh5dviLMLS5APS8M+n9cHups2zvoJvcguqnO0aPO8bi4DDQ@mail.gmail.com> <2019726322.96838.1659473613204.JavaMail.zimbra@efficios.com>
In-Reply-To: <2019726322.96838.1659473613204.JavaMail.zimbra@efficios.com>
From:   Chris Kennelly <ckennelly@google.com>
Date:   Thu, 4 Aug 2022 12:18:33 -0400
Message-ID: <CAEE+ybmG+LrowRwhsBzT8yXkpMLWkye-AP1Gt_0i3A=MtHbAtQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] RSEQ node id and virtual cpu id extensions
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Oskolkov <posk@google.com>, Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@aculab.com>,
        "Carlos O'Donell" <carlos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 4:53 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Aug 2, 2022, at 1:06 PM, Peter Oskolkov posk@google.com wrote:
>
> > On Tue, Aug 2, 2022 at 8:01 AM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >
> > [...]
> >
> >> >
> >> > We have experimented with several approaches here. The one that we are
> >> > currently using is the "flat" model: we allocate vcpu IDs ignoring numa nodes.
> >> >
> >> > We did try per-numa-node vcpus, but it did not show any material improvement
> >> > over the "flat" model, perhaps because on our most "wide" servers the CPU
> >> > topology is multi-level. Chris Kennelly may provide more details here.

As Peter mentioned, though, we solely use the flat vcpu ID implementation.

> >>
> >> I would really like to know more about Google's per-numa-node vcpus
> >> implementation.
> >> I suspect you guys may have taken a different turn somewhere in the design which
> >> led to these results. But having not seen that implementation, I can only guess.
> >>
> >> I notice the following Google-specific prototype extension in tcmalloc:
> >>
> >>   // This is a prototype extension to the rseq() syscall.  Since a process may
> >>   // run on only a few cores at a time, we can use a dense set of "v(irtual)
> >>   // cpus."  This can reduce cache requirements, as we only need N caches for
> >>   // the cores we actually run on simultaneously, rather than a cache for every
> >>   // physical core.
> >>   union {
> >>     struct {
> >>       short numa_node_id;
> >>       short vcpu_id;
> >>     };
> >>     int vcpu_flat;
> >>   };
> >>
> >> Can you tell me more about the way the numa_node_id and vcpu_id are allocated
> >> internally, and how they are expected to be used by userspace ?
> >
> > Based on a "VCPU policy" flag passed by the userspace during rseq registration
> > request, our kernel would:
> > - do nothing re: vcpus, i.e. behave like it currently does upstream;
> > - allocate VCPUs in a "flat" manner, ignoring NUMA;
> > - populate numa_node_id with the value from the function with the same name in
> >  https://elixir.bootlin.com/linux/latest/source/include/linux/topology.h
> >  and allocate vcpu_id within the numa node in a tight manner.
> >
> > Basically, if there are M threads running on node 0 and N threads
> > running on node 1 at time T, there will be [0,M-1] vcpu IDs associated with
> > node 0 and [0,N-1] vcpu IDs associated with node 1 at this moment
> > in time. If a thread migrates across nodes, the balance would change
> > accordingly.
> >
> > I'm not sure how exactly tcmalloc tried to use VCPUs under this policy, and
> > what were the benefits expected. The simplest way would be to keep
> > a freelist per node_id/vcpu_id pair (basically, per vcpu_flat in the union),
> > but this would tend to increase the number of freelists due to thread
> > migrations,
> > so benefits should be related to memory locality, and so somewhat difficult to
> > measure precisely.
>
> So, based on your explanation of the Google implementation, for each memory space,
> the kernel keeps per-numa-node vcpu-id allocation domains.
>
> This leaves two choices to userspace AFAIU:
>
> 1) Userspace takes the vcpu_flat (int, combining the short node_id with the short vcpu_id)
>    as index in a sparse array. The sparseness of the array may be unwelcome in terms of
>    memory and cache footprint.

In general, TCMalloc addresses sparseness by lazily allocating caches.
Virtual address space is relatively inexpensive, so we can allocate
enough space to have cache space for every feasible CPU ID and
structure things so on fault (of a zero page), we trigger the slow
path and handle initialization
(https://github.com/google/tcmalloc/blob/master/tcmalloc/cpu_cache.h#L824).

Even without virtual CPU IDs, TCMalloc still preferred to allocate a
cache per possible core, so no additional checks would be needed on
the fast path.

>
>
> 2) Userspace could take a 2-level approach: using the short node_id to index an array of
>    "numa node" objects, which would then point to a 2nd level indexed by short vcpu_id.
>    This adds an extra pointer dereference on the fast-path, and touches additional cache
>    lines on the fast path as well, which is probably unwelcome. In addition, keeping track
>    of this 2-level table adds extra complexity in userspace, and requires that user-space
>    designs its data structure specifically for NUMA, which is unusual considering that NUMA
>    is typically just an optimization hint to improve locality of memory accesses.

This is the strategy I looked at using previously.

> Hopefully I did not miss anything there.
>
> So here is how I did things differently.
>
> I realized that when userspace uses a rseq_abi()->cpu_id as index into per-cpu data structures,
> it expects that when any of the process' threads observe a numa_node_id when running on behalf
> of a given cpu_id once in the process lifetime, this topology is invariant [1]. IOW, the same
> cpu_id should always run on the same NUMA node in the future.
>
> This characteristic is what allows indexing by cpu_id to index data structures that have a
> good NUMA locality: on first use of a given cpu_id, memory allocation can be done on behalf of
> the right NUMA node, and then all per-cpu accesses are guaranteed to be local.
>
> So I applied this concept to vcpu_ids.
>
> The trick here is mostly to add a per-numa-node bitmap to the mm_struct in addition to the bitmap
> tracking the current vcpu_id allocation. The per-numa-node bitmap keeps track of which vcpu_ids
> have been allocated on behalf of each numa node in the past.
>
> So when a thread running on a given NUMA node needs to find the lowest vcpu_id which is available,
> it uses cpumask_first_one_and_zero(node_cpumask, cpumask) to find the first bit which has both
> been allocated already for this NUMA node, and is currently not in use by another thread.
>
> There is also a node_alloc_vcpumask bitmap which keeps track of which vcpu have already been
> allocated in the past, across all NUMA nodes. This allows scanning efficiently for the first
> vcpu which was _not_ yet allocated, and is currently unused with
> cpumask_first_zero_and_zero(node_alloc_cpumask, cpumask).
>
> With this, user-space can simply use the vm_vcpu_id field as index into the per-vcpu array,
> and the NUMA locality is implicit. Upon initial allocation of the numa-local memory, it just
> needs to read both vm_vcpu_id and numa_node_id fields within a rseq critical section to
> ensure there is no migration between the two field loads.
>
>
> So as long as the scheduler does a good job at keeping the number of threads per NUMA node
> relatively constant by pushing back against thread migration across NUMA nodes over the process
> lifetime, there should not be too many extra vcpu_ids needed. In the worse-case scenario, the
> number of vcpu_ids needed is equal to the number of online cpus in the system.

Interesting.  It seems like this simplifies the fast path for using
the NUMA ID quite a bit.

As Peter mentions, our implementation prefers lower indexed vCPU IDs
over higher ones, but TCMalloc is agnostic to the precise IDs in use
(it looks at individual cache stats, not IDs, to make decisions).
Definitively skipping a vCPU ID on one node because it is used on
another seems entirely workable.

Chris



>
> The performance overhead of keeping track of those additional bitmaps for NUMA locality should
> be minimal considering that the only update needed in the per-numa-node bitmap and the
> node_alloc_vcpumask bitmap is the first time a vcpu_id is assigned within a process. The rest
> is lookup only. And even there, the optimizations I have put in place skip those lookups in
> the common scenarios entirely.
>
>
> Thanks,
>
> Mathieu
>
> [1] There is the exception of Power CPU hotplug which can reconfigure the NUMA topology,
>     but this seems like a rather odd and rare corner-case. It is supported by my implementation,
>     but userspace would have to deal with this kind of reconfiguration on its own to
>     preserve NUMA locality.
>
> >
> > Chris Kennelly may offer more details here.
> >
> > Thanks,
> > Peter
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
