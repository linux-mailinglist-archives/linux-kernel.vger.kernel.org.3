Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA96D46C9EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhLHBaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhLHBaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:30:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC39C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:26:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so2750824edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhJ4UcLzq8BcFK+gzuERcPjWwXUL7IwpOkKpmgGdQW8=;
        b=j3CUCAS4OURie4o1zBZLLvnq9DOvnNvxs5enL68rI2toyO2fyZCY40H7s/8OnO3XIi
         dfSmbxfwqWHYm1+bG88OJhqtfRWpm10CJFp1+WEZDfY+q+gBHllCO7dbuhzH5oI8Cas3
         aWKVtqwNjZ+GCqhs2DGkFPpiLM/UeEknRrNbXAgpXNBGbG7y5zf/4P7aczFNxQ2jAai0
         ixzJXi8QNfKmri7QBUwXvUdVs+xTT/SsCXK1utainTV7vqaloh4GadavR81NCJmxPKxl
         kG0exhLVVEGU18ikyV/NQtiFBSRWhxgBSBDFIvD/MTcBzvFijudxgu+WFhnCE0mPqdDw
         OUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhJ4UcLzq8BcFK+gzuERcPjWwXUL7IwpOkKpmgGdQW8=;
        b=sJJkc8pkuPNBoR2ySB6Lbgyq1BzpzqDc/2mFYU6hlTwz7E9Vaplq058ZN1m+IsHX3f
         AON6rcoFWWNfWfdEpVtZunGrVZUR4Sa6cEI+eIh6sDnRv4Mm37ZnXmgBIF39t/mSKbcf
         cpsJovNFLnsVjt1x5tuz7ukSTJ+YDoiK1ZL+4sZX5ZQJir+BfvlhNT3E7RQtnVTHs70c
         9kRbXNx6utsTyxeKu5C+9uuf6Abdqqpro33ajQZb+Quk1vksnlZwToVogsbArDBbQJQu
         fIP3DLT7IkZ3zriV6XQsKI/Ras0L+yENJpT1+JISRa/6nbZTnYma/8muZGizdB5TZfZQ
         OA+Q==
X-Gm-Message-State: AOAM5317COl2F88O4Rgke5QOTg4AeZ+XAtH5c86b76I+VM1OxPOxnxfR
        eySvvCaOxrTNoZ2xmP8tScdZJNx0D5axGQdr8hM=
X-Google-Smtp-Source: ABdhPJyPXcD60/YewvO1HLrGeJs0m6UgRqQp+o87fQpON7pCEIVaT1cbPKkiZw5ySSLGQVboEGu8SnDdwg9s3sQWCKo=
X-Received: by 2002:a17:907:dab:: with SMTP id go43mr3523717ejc.537.1638926804347;
 Tue, 07 Dec 2021 17:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20211207224013.880775-1-npache@redhat.com> <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
 <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com>
 <17a7d9e4-5ebc-1160-1e5e-97707b6e5286@redhat.com> <CAHbLzkokNjJOb2fknm2+5pgf1+PBHviZA73nug5+dCB=7NKF4w@mail.gmail.com>
In-Reply-To: <CAHbLzkokNjJOb2fknm2+5pgf1+PBHviZA73nug5+dCB=7NKF4w@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 7 Dec 2021 17:26:32 -0800
Message-ID: <CAHbLzkpG4aogZRW5ct9zKDU+5C8jwtWyRAkaia1x3+goR-wGMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
To:     Nico Pache <npache@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 5:23 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Dec 7, 2021 at 4:33 PM Nico Pache <npache@redhat.com> wrote:
> >
> >
> >
> > On 12/7/21 19:26, Yang Shi wrote:
> > > On Tue, Dec 7, 2021 at 3:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >>
> > >> On Tue,  7 Dec 2021 17:40:13 -0500 Nico Pache <npache@redhat.com> wrote:
> > >>
> > >>> We have run into a panic caused by a shrinker allocation being attempted
> > >>> on an offlined node.
> > >>>
> > >>> Our crash analysis has determined that the issue originates from trying
> > >>> to allocate pages on an offlined node in expand_one_shrinker_info. This
> > >>> function makes the incorrect assumption that we can allocate on any node.
> > >>> To correct this we make sure the node is online before tempting an
> > >>> allocation. If it is not online choose the closest node.
> > >>
> > >> This isn't fully accurate, is it?  We could allocate on a node which is
> > >> presently offline but which was previously onlined, by testing
> > >> NODE_DATA(nid).
> > >>
> > >> It isn't entirely clear to me from the v1 discussion why this approach
> > >> isn't being taken?
> > >>
> > >> AFAICT the proposed patch is *already* taking this approach, by having
> > >> no protection against a concurrent or subsequent node offlining?
> > >
> > > AFAICT, we have not reached agreement on how to fix it yet. I saw 3
> > > proposals at least:
> > >
> > > 1. From Michal, allocate node data for all possible nodes.
> > > https://lore.kernel.org/all/Ya89aqij6nMwJrIZ@dhcp22.suse.cz/T/#u
> > >
> > > 2. What this patch does. Proposed originally from
> > > https://lore.kernel.org/all/20211108202325.20304-1-amakhalov@vmware.com/T/#u
> >
> > Correct me if im wrong, but isn't that a different caller? This patch fixes the
> > issue in expand_one_shrinker_info.
>
> Yes, different caller, but same approach. The cons with this approach

And the same underlying problem.

> is we have to fix all the places. It seems Michal and David are not
> fans for this approach IIRC.
>
> >
> > > 3. From David, fix in node_zonelist().
> > > https://lore.kernel.org/all/51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com/T/#u
> > >
> > >>
> > >>> --- a/mm/vmscan.c
> > >>> +++ b/mm/vmscan.c
> > >>> @@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> > >>>       int size = map_size + defer_size;
> > >>>
> > >>>       for_each_node(nid) {
> > >>> +             int tmp = nid;
> > >>
> > >> Not `tmp', please.  Better to use an identifier which explains the
> > >> variable's use.  target_nid?
> > >>
> > >> And a newline after defining locals, please.
> > >>
> > >>>               pn = memcg->nodeinfo[nid];
> > >>>               old = shrinker_info_protected(memcg, nid);
> > >>>               /* Not yet online memcg */
> > >>>               if (!old)
> > >>>                       return 0;
> > >>>
> > >>> -             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> > >>> +             if(!node_online(nid))
> > >>
> > >> s/if(/if (/
> > >>
> > >>> +                     tmp = numa_mem_id();
> > >>> +             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
> > >>>               if (!new)
> > >>>                       return -ENOMEM;
> > >>>
> > >>
> > >> And a code comment fully explaining what's going on here?
> > >
> >
