Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA23346A438
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbhLFSai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347369AbhLFSaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:30:15 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32590C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:26:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x6so46582985edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7b9gNaP+SmSc68bpz6rexAdvfFqjoyV7ca979OMjGo=;
        b=bbD/HjGmHDdznAPIU1hsU3oake4L3RF3PwowUcQS4Yze2KgVDKc1h6XpkvXv8Qkhg7
         5OhjzYCP9cNdU2dzV4V+yO3X27WE3Le/khZPconYRbvbCF7m8fOQR5lPNYukRIlj4qFy
         6OAOkKlaV9Jis5nFNwRXEJAGoAbB5BCoJN9uARnqMExdSe1t+lfoiUaCI954tdeAOEAc
         LVSHbbuJU4qaV2HGLtItiq43HP399DPIckeRX+TN9s8jlVvgrBA9kXvldZfrDxmleKOd
         UeN/LwOkrNKvgLv2rzFO0VbP22dA4ACAskUOBEPaQasbbNpv5wE3InQsAqLsIiAMfH4U
         h4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7b9gNaP+SmSc68bpz6rexAdvfFqjoyV7ca979OMjGo=;
        b=IiKVGYs1XDzTpbyEyRpfjDp9hwKn54jHpL+x5vG898dd4Yu0X63QEQSWn26wLOd78d
         dHLg5m1x53bz++tMjA0J+Pl0QdnTUidoWravSll6OEPLO3vm7rUzxJnxt9FL3iCspo2M
         sGwQrcBlbex6iGxcCDlUC6jQqFonmDMcSID3/9779UuIzoBrlfBdTI1hrlGbg5DroUeM
         0jNncHPUPQlzezvk5b0rDQ3edoLsw5MbVejtInG4tUEn36m8r36xvBSOzH3yPZByyuNj
         dB3XzmTY/i0KOlxOukbz+vQS/svr5eUq9H9c38PszA1RFTH0bCRDiGlNxAH5/q7/nbzR
         bS4g==
X-Gm-Message-State: AOAM530w69o3qMT2SpEbTFdW+fXOFVMHA+s0TYsV14pbu5Zb6XOFgPcw
        Nj57zy5K6xX2D/Fecul3VKlP6JjL4om8fU18/n8=
X-Google-Smtp-Source: ABdhPJxAp0h9yZDmP3EIloEbdAq8KvLf27IY9TvjjcNWe+fyHa1yogc3zbFInlf6iGqYn3KTw4D7wP6dekvZmX7BVhI=
X-Received: by 2002:a17:907:94ce:: with SMTP id dn14mr47864389ejc.85.1638815204756;
 Mon, 06 Dec 2021 10:26:44 -0800 (PST)
MIME-Version: 1.0
References: <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz> <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
 <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz> <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
 <Ya4K0+XCmv3NBmwQ@dhcp22.suse.cz> <05157de4-e5df-11fc-fc46-8a9f79d0ddb4@redhat.com>
 <Ya4Y07Iu2ygj5zwZ@dhcp22.suse.cz> <d4f281e6-1999-a3de-b879-c6ca6a25ae67@redhat.com>
 <Ya4cUQpLJHnm3jyK@dhcp22.suse.cz> <f2c695f0-9621-a7be-82c3-8850dc8ca3e3@suse.cz>
 <Ya4kBASzAJ32UBfT@dhcp22.suse.cz>
In-Reply-To: <Ya4kBASzAJ32UBfT@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 6 Dec 2021 10:26:32 -0800
Message-ID: <CAHbLzkpnvqDCKjf7cmZDcVROAkh_Vzu3HXRJgkZsqp+xVokRZA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Nico Pache <npache@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 6:53 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 06-12-21 15:30:37, Vlastimil Babka wrote:
> > On 12/6/21 15:21, Michal Hocko wrote:
> > > On Mon 06-12-21 15:08:10, David Hildenbrand wrote:
> > >>
> > >> >> But there might be more missing. Onlining a new zone will get more
> > >> >> expensive in setups with a lot of possible nodes (x86-64 shouldn't
> > >> >> really be an issue in that regard).
> > >> >
> > >> > Honestly, I am not really concerned by platforms with too many nodes
> > >> > without any memory. If they want to shoot their feet then that's their
> > >> > choice. We can optimize for those if they ever prove to be standar.
> > >> >
> > >> >> If we want stable backports, we'll want something simple upfront.
> > >> >
> > >> > For stable backports I would be fine by doing your NODE_DATA check in
> > >> > the allocator. In upstream I think we should be aiming for a more robust
> > >> > solution that is also easier to maintain further down the line. Even if
> > >> > that is an investment at this momemnt because the initialization code is
> > >> > a mess.
> > >> >
> > >>
> > >> Agreed. I would be curious *why* we decided to dynamically allocate the
> > >> pgdat. is this just a historical coincidence or was there real reason to
> > >> not allocate it for all possible nodes during boot?
> > >
> > > I don't know but if I was to guess the most likely explanation would be
> > > that the numa init code was in a similar order as now and it was easier
> > > to simply allocate a pgdat when a new one was onlined.
> > > 9af3c2dea3a3 ("[PATCH] pgdat allocation for new node add (call pgdat allocation)")
> > > doesn't really tell much.
> >
> > I don't know if that's true for pgdat specifically, but generally IMHO the
> > advantages of allocating during/after online instead for each possible is
> > - memory savings when some possible node is actually never online
> > - at least in some cases, the allocations can be local to the node in
> > question where the advantages is
> >   - faster access
> >   - less memory occupied on nodes that are earlier online, especially node 0
> >
> > So while the approach of allocate on boot for all possible nodes instead of
> > just online nodes has advantages of being generally safer and simpler (no
> > memory hotplug callbacks etc), we should also be careful not to overdo this
> > approach so we don't end up with Node 0 memory filled with structures used
> > for nodes 1-X that are just onlined later. I imagine that could be a problem
> > even for "sane" archs that don't have tons of possible, but offline nodes.
>
> Yes this can indeed turn out to be a problem as the memory allocations
> scales not only with numa nodes but memcgs as well. The later one being
> a more visible one.
>
> > Concretely, pgdat should probably be fine, but things like all shrinkers?
> > Maybe less so.
>
> Yeah, right. But for that purpose the concept of online_node is just
> misleading. You would need a check whether the node is populated with
> memory and implement hotplug notifiers.

Yes, the cons is memory waste. I think it is a known problem since
memcg has per node data (a.k.a. mem_cgroup_per_node_info) which holds
lruvec and shrinker infos. And the comment in the code of
alloc_mem_cgroup_per_node_info() does say:

"TODO: this routine can waste much memory for nodes which will never
be onlined. It's better to use memory hotplug callback function."

But IMHO actually the memory usage should be not that bad for memcg
heavy usecases since there should be not too many "never onlined"
nodes for such workloads?

>
> --
> Michal Hocko
> SUSE Labs
