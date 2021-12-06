Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2F646AA71
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349239AbhLFVcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348959AbhLFVcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:32:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F226C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:28:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z5so48986671edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrzG1F2FOa3VtmEiI4VOyaEzgpwlPGnaXDRCIF3mM/U=;
        b=eSxgxzc1WnpZmWh38Ufecg6Ba+9/74i9ytV3nuEJx4uwWE05riNrdYZQocDSYDj7w/
         DQgXLTlCPzP4KkQgJ2aFaS1js7tJ2rNT3D5EZs2WJEmkgId4Q3cBF4PYvTUyxWA8QJuD
         5vyaBVsqTIGR3RHGmECMC1yjjtWXHZk4waYtRvXF0Po1GeaBHq8X98mm6TgtgZyW7kWv
         v60mIlb9tYppOiYyFqXxFDI0+tbUZu6CeKdflEEscBIx62oOhtbWN04Z8+Hl23gLra0Y
         R/79O4vVCm4ran9ZZxgSoRrntvYd/ucXGuLv+E4FO1+WoSRTGXMfx9zEgXRupiI9Zqiw
         pv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrzG1F2FOa3VtmEiI4VOyaEzgpwlPGnaXDRCIF3mM/U=;
        b=bcR3TfBW6AXX4Lq/Pgv2VX9cnK5LDuRfweW/C9m62lI4TeqP8P0bmuoUz7gTmmIuH9
         PjfpI5Hd/E8jBe3tTDldQPpxCau+DhwbGnpKKXcj/GYy01yCUrM9Gegr6xRKUNI5vkP2
         6Prn5487Ug7Qtz/KOvBXjRl8vZo9egG2wx2yrlv8O2u3SydE4J57iKgqK022badEbodT
         9IuY9E9wlWOwOLv+W+GJbHAe+fCfDKZ5Tw30zte/x3SYFaXgN9Ug582QsIFxCBVZN8cK
         xLq/nhme+kPpubIcYPqAgDqlRNqUu+dVrj5JHQ5plaoaZt39aRFLXfvy3PDIXGl7YLVW
         isxw==
X-Gm-Message-State: AOAM531QqSMNDd//J3B0oP2ReQBpxAa7emnJoBDW35YbuTr9kEV8NAMu
        wPfxEOPiMVtNLXA+4UQMo+S+oca2M1YyYQHoP5g=
X-Google-Smtp-Source: ABdhPJyADNf6T4Ies4DR3lGsTriyK7xqtDItPSxSe1FWodoGiJVmcPcC2cedfVtcVGj+RKEYxjYtlzbcXbYUmhRpT30=
X-Received: by 2002:a17:906:538d:: with SMTP id g13mr49050917ejo.62.1638826126701;
 Mon, 06 Dec 2021 13:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20211206033338.743270-1-npache@redhat.com> <20211206033338.743270-3-npache@redhat.com>
 <Ya3WcYKcej8XEI0W@dhcp22.suse.cz> <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com> <CAHbLzko0UeNadswXEnwr6EtuKAZT4T-fnC5F7xnFcH4RbjhAiA@mail.gmail.com>
 <a48c16d6-07df-ff44-67e6-f0942672ec28@redhat.com>
In-Reply-To: <a48c16d6-07df-ff44-67e6-f0942672ec28@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 6 Dec 2021 13:28:34 -0800
Message-ID: <CAHbLzkrfU3SQ8r4FyhumDHr02DSKd8oWbhwwVbBUHF7GCGY2Hg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
To:     David Hildenbrand <david@redhat.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>, Nico Pache <npache@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 11:01 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 06.12.21 19:42, Yang Shi wrote:
> > On Mon, Dec 6, 2021 at 5:19 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 06.12.2021 13:45, David Hildenbrand wrote:
> >>>> This doesn't seen complete. Slab shrinkers are used in the reclaim
> >>>> context. Previously offline nodes could be onlined later and this would
> >>>> lead to NULL ptr because there is no hook to allocate new shrinker
> >>>> infos. This would be also really impractical because this would have to
> >>>> update all existing memcgs...
> >>>
> >>> Instead of going through the trouble of updating...
> >>>
> >>> ...  maybe just keep for_each_node() and check if the target node is
> >>> offline. If it's offline, just allocate from the first online node.
> >>> After all, we're not using __GFP_THISNODE, so there are no guarantees
> >>> either way ...
> >>
> >> Hm, can't we add shrinker maps allocation to __try_online_node() in addition
> >> to this patch?
> >
> > I think the below fix (an example, doesn't cover all affected
> > callsites) should be good enough for now? It doesn't touch the hot
> > path of the page allocator.
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index fb9584641ac7..1252a33f7c28 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -222,13 +222,15 @@ static int expand_one_shrinker_info(struct
> > mem_cgroup *memcg,
> >         int size = map_size + defer_size;
> >
> >         for_each_node(nid) {
> > +               int tmp = nid;
> >                 pn = memcg->nodeinfo[nid];
> >                 old = shrinker_info_protected(memcg, nid);
> >                 /* Not yet online memcg */
> >                 if (!old)
> >                         return 0;
> > -
> > -               new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> > +               if (!node_online(nid))
> > +                       tmp = -1;
> > +               new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
> >                 if (!new)
> >                         return -ENOMEM;
> >
> > It used to use kvmalloc instead of kvmalloc_node(). The commit
> > 86daf94efb11d7319fbef5e480018c4807add6ef ("mm/memcontrol.c: allocate
> > shrinker_map on appropriate NUMA node") changed to use *_node()
> > version. The justification was that "kswapd is always bound to
> > specific node. So allocate shrinker_map from the related NUMA node to
> > respect its NUMA locality." There is no kswapd for offlined node, so
> > just allocate shrinker info on node 0. This is also what
> > alloc_mem_cgroup_per_node_info() does.
>
> Yes, that's what I refer to as fixing it in the caller -- similar to
> [1]. Michals point is to not require such node_online() checks at all,
> neither in the caller nor in the buddy.
>
> I see 2 options short-term
>
> 1) What we have in [1].
> 2) What I proposed in [2], fixing it for all such instances until we
> have something better.
>
> Long term I tend to agree that what Michal proposes is better.
>
> Short term I tend to like [2], because it avoids having to mess with all
> such instances to eventually get it right and the temporary overhead
> until we have the code reworked should be really negligible ...

Thanks, David. Basically either option looks fine to me. But I'm a
little bit concerned about [2]. It silently changes the node requested
by the callers. It actually papers over potential bugs? And what if
the callers specify __GFP_THISNODE (I didn't search if such callers
really exist in the current code)?

How's about a helper function, for example, called
kvmalloc_best_node()? It does:

void * kvmalloc_best_node(unsigned long size, int flag, int nid)
{
    bool onlined = node_online(nid);

    WARN_ON_ONCE((flag & __GFP_THISNODE) && !onlined);

    if (!onlined)
        nid = -1;

    return kvmalloc_node(size, GFP_xxx, nid);
}

>
>
>
> [1] https://lkml.kernel.org/r/20211108202325.20304-1-amakhalov@vmware.com
> [2]
> https://lkml.kernel.org/r/51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com
>
> --
> Thanks,
>
> David / dhildenb
>
