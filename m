Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02B74D7282
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 05:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiCME6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 23:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiCME6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 23:58:38 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8291CAF21;
        Sat, 12 Mar 2022 20:57:31 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2dbd97f9bfcso131914897b3.9;
        Sat, 12 Mar 2022 20:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ostrLnUO2mj0wyzHZmJJ7h19bUlrS9Vf5+VLNn3DoVM=;
        b=dh66cpD7Wqk3kfXaEFRzK8xzrsPwvBoq7TZ9ooyv4XDKUeHYqyHlNZ0Puys6VeRCq8
         ZeEpkcELlSmEMF3MWSQVxqGjMWhAh99RkXxOvPbH5tMn8FodBaVE/dZL9eot+WK/CbQx
         HqZrcT6pqKgB7yBCLCtMttlIgsBmt0IBQ3JReKBdETgcE3TvNmwx5qyZgU/RrOpBapxP
         K+98SC3kT6XN5AxVBYJ8VLI6yzHvkjthzDZBZRan0NBAbi7WMtxT6vqcbDN1OB4a8UGN
         WXG1deoOr8X+Iin1hE2aYBkPblipBdZaDwEy/f6g4jbyDEmnqTjq9qiFDjycfmwJ5WiH
         kFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ostrLnUO2mj0wyzHZmJJ7h19bUlrS9Vf5+VLNn3DoVM=;
        b=D7a6QLxbR8al4IidV/lL6bkRIEmsIGCsWxHgTucXZpi4orh3c/vT462PIDncvju81V
         MZdjpKahHDRSK/bLzDqGihd7E5SiXOQUGo6IQlG0YaPc99+qFY/LM2onIsk9i0w6tuo+
         mTG4MjxoqwFej0BDcMlE2Db4w67Mhy0i+heR0GC5NuvKweHSaGLc0lRibApKTrFSFWPu
         Oh0u7Yi9WRPDLZPdklMls31mKsB7EnitXlJQ/JAmkvrtZL94CALXT2wUjpQSlcUu5wg4
         jbFDPViqJK275L+iMoqw561RWRoMIFUOMXtpdZW0ofV3WYAdEc5T4eISnQ2WarPzWy2s
         X3EQ==
X-Gm-Message-State: AOAM530xHlem3WHNfPLC7V48a4ex5/mCedEQlTiC7PLkZTkCELdSj9lo
        w9fiDHLCWKdeXW1ZVKOjsIbeLcKn5bWKUiWx2BA=
X-Google-Smtp-Source: ABdhPJwNkleOUaZ6JhmszubFPw5Yuz+G5WUwkcp6MzjBDnPeAeiZ/J4iyVVsOuwRgvltoEq4/nE1ac7NEGuyCjW4uHo=
X-Received: by 2002:a81:9806:0:b0:2dc:5953:4d13 with SMTP id
 p6-20020a819806000000b002dc59534d13mr14185928ywg.233.1647147450199; Sat, 12
 Mar 2022 20:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-5-yuzhao@google.com>
 <YgV4lZXc6+jhUdsR@cmpxchg.org> <Ygt1qaQM5YobEZK9@google.com>
 <CAGsJ_4wN_CAOsyR3LATE+EUhuV0gO-zhhNiMwEBwyXOp0CbkZg@mail.gmail.com>
 <CAOUHufaUJD8nC6PDVfmkeTwB4BtzBzigxh+V-hfR-_26VwjOPA@mail.gmail.com>
 <CAGsJ_4zT7gtGSEoAay=VE6x_YZkNKtLymRL94pBnVgKekPzxaQ@mail.gmail.com> <CAOUHufbor4L5OfjNFEMcaM5bXnM9VWXw-LK9A04vP65rkcLNMg@mail.gmail.com>
In-Reply-To: <CAOUHufbor4L5OfjNFEMcaM5bXnM9VWXw-LK9A04vP65rkcLNMg@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 13 Mar 2022 17:57:17 +1300
Message-ID: <CAGsJ_4x+BP1RuB4ig=z67br+cdUom1eUov6_t-wxGjWvbpF2Rg@mail.gmail.com>
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
To:     Yu Zhao <yuzhao@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 10:12 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Sat, Mar 12, 2022 at 3:37 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Sat, Mar 12, 2022 at 12:45 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Fri, Mar 11, 2022 at 3:16 AM Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > On Tue, Feb 15, 2022 at 10:43 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > On Thu, Feb 10, 2022 at 03:41:57PM -0500, Johannes Weiner wrote:
> > > > >
> > > > > Thanks for reviewing.
> > > > >
> > > > > > > +static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
> > > > > > > +{
> > > > > > > +   unsigned long max_seq = lruvec->lrugen.max_seq;
> > > > > > > +
> > > > > > > +   VM_BUG_ON(gen >= MAX_NR_GENS);
> > > > > > > +
> > > > > > > +   /* see the comment on MIN_NR_GENS */
> > > > > > > +   return gen == lru_gen_from_seq(max_seq) || gen == lru_gen_from_seq(max_seq - 1);
> > > > > > > +}
> > > > > >
> > > > > > I'm still reading the series, so correct me if I'm wrong: the "active"
> > > > > > set is split into two generations for the sole purpose of the
> > > > > > second-chance policy for fresh faults, right?
> > > > >
> > > > > To be precise, the active/inactive notion on top of generations is
> > > > > just for ABI compatibility, e.g., the counters in /proc/vmstat.
> > > > > Otherwise, this function wouldn't be needed.
> > > >
> > > > Hi Yu,
> > > > I am still quite confused as i am seeing both active/inactive and lru_gen.
> > > > eg:
> > > >
> > > > root@ubuntu:~# cat /proc/vmstat | grep active
> > > > nr_zone_inactive_anon 22797
> > > > nr_zone_active_anon 578405
> > > > nr_zone_inactive_file 0
> > > > nr_zone_active_file 4156
> > > > nr_inactive_anon 22800
> > > > nr_active_anon 578574
> > > > nr_inactive_file 0
> > > > nr_active_file 4215
> > >
> > > Yes, this is expected. We have to maintain the ABI, i.e., the
> > > *_active/inactive_* counters.
> > >
> > > > and:
> > > >
> > > > root@ubuntu:~# cat /sys//kernel/debug/lru_gen
> > > >
> > > > ...
> > > > memcg    36 /user.slice/user-0.slice/user@0.service
> > > >  node     0
> > > >          20      18820         22           0
> > > >          21       7452          0           0
> > > >          22       7448          0           0
> > > > memcg    33 /user.slice/user-0.slice/user@0.service/app.slice
> > > >  node     0
> > > >           0    2171452          0           0
> > > >           1    2171452          0           0
> > > >           2    2171452          0           0
> > > >           3    2171452          0           0
> > > > memcg    37 /user.slice/user-0.slice/session-1.scope
> > > >  node     0
> > > >          42      51804     102127           0
> > > >          43      18840     275622           0
> > > >          44      16104     216805           1
> > > >
> > > > Does it mean one page could be in both one of the generations and one
> > > > of the active/inactive lists?
> > >
> > > In terms of the data structure, evictable pages are either on
> > > lruvec->lists or lrugen->lists.
> > >
> > > > Do we have some mapping relationship between active/inactive lists
> > > > with generations?
> > >
> > > For the counters, yes -- pages in max_seq and max_seq-1 are counted as
> > > active, and the rest are inactive.
> > >
> > > > We used to put a faulted file page in inactive, if we access it a
> > > > second time, it can be promoted
> > > > to active. then in recent years, we have also applied this to anon
> > > > pages while kernel adds
> > > > workingset protection for anon pages. so basically both anon and file
> > > > pages go into the inactive
> > > > list for the 1st time, if we access it for the second time, they go to
> > > > the active list. if we don't access
> > > > it any more, they are likely to be reclaimed as they are inactive.
> > > > we do have some special fastpath for code section, executable file
> > > > pages are kept on active list
> > > > as long as they are accessed.
> > >
> > > Yes.
> > >
> > > > so all of the above concerns are actually not that correct?
> > >
> > > They are valid concerns but I don't know any popular workloads that
> > > care about them.
> >
> > Hi Yu,
> > here we can get a workload in Kim's patchset while he added workingset
> > protection
> > for anon pages:
> > https://patchwork.kernel.org/project/linux-mm/cover/1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com/
>
> Thanks. I wouldn't call that a workload because it's not a real
> application. By popular workloads, I mean applications that the
> majority of people actually run on phones, in cloud, etc.
>
> > anon pages used to go to active rather than inactive, but kim's patchset
> > moved to use inactive first. then only after the anon page is accessed
> > second time, it can move to active.
>
> Yes. To clarify, the A-bit doesn't really mean the first or second
> access. It can be many accesses each time it's set.
>
> > "In current implementation, newly created or swap-in anonymous page is
> >
> > started on the active list. Growing the active list results in rebalancing
> > active/inactive list so old pages on the active list are demoted to the
> > inactive list. Hence, hot page on the active list isn't protected at all.
> >
> > Following is an example of this situation.
> >
> > Assume that 50 hot pages on active list and system can contain total
> > 100 pages. Numbers denote the number of pages on active/inactive
> > list (active | inactive). (h) stands for hot pages and (uo) stands for
> > used-once pages.
> >
> > 1. 50 hot pages on active list
> > 50(h) | 0
> >
> > 2. workload: 50 newly created (used-once) pages
> > 50(uo) | 50(h)
> >
> > 3. workload: another 50 newly created (used-once) pages
> > 50(uo) | 50(uo), swap-out 50(h)
> >
> > As we can see, hot pages are swapped-out and it would cause swap-in later."
> >
> > Is MGLRU able to avoid the swap-out of the 50 hot pages?
>
> I think the real question is why the 50 hot pages can be moved to the
> inactive list. If they are really hot, the A-bit should protect them.

This is a good question.

I guess it  is probably because the current lru is trying to maintain a balance
between the sizes of active and inactive lists. Thus, it can shrink active list
even though pages might be still "hot" but not the recently accessed ones.

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (used-once) pages
50(uo) | 50(h)

3. workload: another 50 newly created (used-once) pages
50(uo) | 50(uo), swap-out 50(h)

the old kernel without anon workingset protection put workload 2 on active, so
pushed 50 hot pages from active to inactive. workload 3 would further contribute
to evict the 50 hot pages.

it seems mglru doesn't demote pages from the youngest generation to older
generation only in order to balance the list size? so mglru is probably safe
in these cases.

I will run some tests mentioned in Kim's patchset and report the result to you
afterwards.

>
> > since MGLRU
> > is putting faulted pages to the youngest generation directly, do we have the
> > risk mentioned in Kim's patchset?
>
> There are always risks :) I could imagine a thousand ways to make VM
> suffer, but all of them could be irrelevant to how it actually does in
> production. So a concrete use case of yours would be much appreciated
> for this discussion.

Thanks
Barry
