Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCFC4734B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242176AbhLMTKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhLMTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:10:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9589FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:10:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so56423671edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1ecokVaQ0SqYiY1LdKXr1h9sQBEtT8rIZ4tvd1OORo=;
        b=P9QGIql6Vz08w9S1y2wCaCKJ00KD6ArvAbhyxv18w7YoTErQ51ONNYgXtlxcTE0Yb9
         NVwqPpvj6U96DcjR/IzsBGZ0DssZ4SwGICNnyFJcUy6HxSp4k3r/T88OWWpjg/d/uQzi
         XSLqPrueMXzBrYRuxiodAw2l77KD+fkq2wT2MPBD85zSXp9cxJ0RFnybH633nRJP058a
         sToFj/ReoQ8yk1LzY/fA4BGjpMhgJZM0ncAjHI9dBNFIcO1fOV+AvFNO1/C29sIuk49X
         27xlmv7pfRVtycCqA8ZQfhy+ByzUfZq3lsDtdpMGvuAE5DzoF42vhkH24f5QVJ1hi/JG
         +c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1ecokVaQ0SqYiY1LdKXr1h9sQBEtT8rIZ4tvd1OORo=;
        b=G4HuEina0D1Jk+74E6BwGswiRYiCq+UINaE3zHKI8vwOkA7VeD78nXQ55W5gfV8W15
         278AhN136mzl3V6KUXJjq3K1xbqSiXe0pu7FxVpdoyBuQYInNJuCoKZ4KeEqdUV7tyso
         8YGZSmiNJ0TqeMj1lgWL6FgkOq1EmtqpStL094o1JLg00PyEWf5YUasVflEmi2JeMqs+
         Cd1sqczBdQtYMVNhaKcempeF2m2qWeiJtZwGktTvNQhfgkhU4qhLneWS6xelrOErEKOT
         r5Az8bwCluBZvgyy4wQRDBJz1dJtO6MlN7VHc3FbKpCrYZpfWx3x/zRRhrHjMT5+1U+5
         naHA==
X-Gm-Message-State: AOAM533I1+/f9iZDgcocjkawCK4mu5Unx+ww67uoXKFMmrTwqxZL1LDr
        orWhkV4xxdG9xXRPhOrAqOc02SrKxP9In5e2GHk=
X-Google-Smtp-Source: ABdhPJzQinaM+hVBEzI9tlMOJ3e2UplBZSf3lwwJrbT54tPMEnG8T3A0zZ9qjGlss6IMO001lNWyapemMwfs3y4PhcA=
X-Received: by 2002:a17:907:2d20:: with SMTP id gs32mr325813ejc.270.1639422643210;
 Mon, 13 Dec 2021 11:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20211207224013.880775-1-npache@redhat.com> <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
 <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com>
 <17a7d9e4-5ebc-1160-1e5e-97707b6e5286@redhat.com> <CAHbLzkokNjJOb2fknm2+5pgf1+PBHviZA73nug5+dCB=7NKF4w@mail.gmail.com>
 <CAHbLzkpG4aogZRW5ct9zKDU+5C8jwtWyRAkaia1x3+goR-wGMg@mail.gmail.com> <YbBl6O8wzgVQb6Oi@dhcp22.suse.cz>
In-Reply-To: <YbBl6O8wzgVQb6Oi@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 13 Dec 2021 11:10:31 -0800
Message-ID: <CAHbLzkpZhTKvAdZ8Xp9XUboEXphF7BkgkeK1JLY_AEFQv-0Yyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nico Pache <npache@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 11:59 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 07-12-21 17:26:32, Yang Shi wrote:
> > On Tue, Dec 7, 2021 at 5:23 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Tue, Dec 7, 2021 at 4:33 PM Nico Pache <npache@redhat.com> wrote:
> > > >
> > > >
> > > >
> > > > On 12/7/21 19:26, Yang Shi wrote:
> [...]
> > > > > AFAICT, we have not reached agreement on how to fix it yet. I saw 3
> > > > > proposals at least:
> > > > >
> > > > > 1. From Michal, allocate node data for all possible nodes.
> > > > > https://lore.kernel.org/all/Ya89aqij6nMwJrIZ@dhcp22.suse.cz/T/#u
> > > > >
> > > > > 2. What this patch does. Proposed originally from
> > > > > https://lore.kernel.org/all/20211108202325.20304-1-amakhalov@vmware.com/T/#u
> > > >
> > > > Correct me if im wrong, but isn't that a different caller? This patch fixes the
> > > > issue in expand_one_shrinker_info.
> > >
> > > Yes, different caller, but same approach. The cons with this approach
> >
> > And the same underlying problem.
> >
> > > is we have to fix all the places. It seems Michal and David are not
> > > fans for this approach IIRC.
>
> Yes, agreed. We definitely do not want to spread this node_offline
> oddity all over the place. There are two different way to approach this.
> Either we handle node_offline nodes at the page allocator level when
> setting the proper zonelist (ideally protect that by a static key for
> setups which have these nodes) or we allocate pgdat for all possible
> nodes. I would prefer the second because that is more robust (less
> likely to blow up when somebody does
>         for_each_node(nid)
>                 something(NODE_DATA(nid))
>
> The discussion is ongoing at the original thread where Alexey Makhalov
> reported a similar problem (the subthread is
> http://lkml.kernel.org/r/Ya89aqij6nMwJrIZ@dhcp22.suse.cz)

Thanks, Michal. Yeah, it seems more straightforward and more robust to
me. I'm not familiar with memory hotplug, hopefully it doesn't break
hotplug.

> --
> Michal Hocko
> SUSE Labs
