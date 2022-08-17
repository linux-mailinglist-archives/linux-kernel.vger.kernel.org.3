Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3811596741
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiHQCFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiHQCFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:05:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184F98A63
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:05:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z187so10889368pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WA+jfFTow3ngSQMp6SitIm7gT1uGuNt3l+SXB6a0Mv0=;
        b=qiJV7zS6FtlxBFNHHOkR8rlWIt+MbyJaSUZ7NpnTAZEKk3nHle4ttU2ZB4kgF22Tkp
         S1dh0KV3aWiLTKjDLvp5WF4/n0wi7ubOMxjq3Jua8IxmsMwkY+MitL+3+BdnFXiyM6Z9
         Vj0T8hQE/4mpvokMpNmQdkh7SXA9IajLZo+MwUAmTuIcVI4nVJ8pUpEAjS6jnjtKDzg2
         KfpsFh/V5P1mzOUHQI1ya/3FWfExr2vTue9RXcqP853PYMeaZBfWhIJRrZFivOEYTm1X
         51iS/vf6KroL/sTdqrHBgH4syYwukIfaJeH0Pju9b2qL7My1FFECbC+OzdyGnK9xCcJd
         ZDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WA+jfFTow3ngSQMp6SitIm7gT1uGuNt3l+SXB6a0Mv0=;
        b=j7rSdGYq2oTZqxVazqQXwmr0Pad2y7lw6zxWxfudbOvsRSogbdSZhNE3IpOmGR0bR8
         qNyRj1EelxcECIepRPiGf7+z94zzynn1tdzrqsVTFD4fcU23IGS/bpGKYoDtlfPEH583
         7+Cktk/XcNzK1Wh3EmGyexN3cvaRholaMExjVvLIWV3Zq7m2rpEMyg9l18jcr1ih2bNv
         A/4X/Pi2WPLYC6Sxyu0MMEnL+idj2zJcHFOjTz077IRB04ISgV3j3kKJ0fxhkUWxS9kq
         kjgLXZAD1xkmwsWSyDElTu6A3xwzVlCtbbabH20/DUYEFIryARrs7/3lvkucNkqkysQl
         XNaQ==
X-Gm-Message-State: ACgBeo0oU/V4SZjjyIlQmyHVeFj64XCv3/Nrgwk8q04pid+uiGvXvIJm
        kxULNUy2ubHctQfccBtyEll9/fiLfqjXmA5c4xAV+A==
X-Google-Smtp-Source: AA6agR56SZJVAe0VONCRXNBcbWnXoQC8KCMiqHyj8VVu1s+GNGs6+PkgKQ+syZgne8UIErFvB+6OwwRit1zFZgqBtow=
X-Received: by 2002:a63:5f8e:0:b0:429:c286:4ef7 with SMTP id
 t136-20020a635f8e000000b00429c2864ef7mr1984263pgb.166.1660701930442; Tue, 16
 Aug 2022 19:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220816185801.651091-1-shy828301@gmail.com> <CALvZod5t7Qo1NQ040pRyWco+nJGn3hSrxZyuFQ0UBi31Ni6=_g@mail.gmail.com>
 <CAHbLzkrSU3ZHRiZAxy9Jju3-3ZFpDmE4uMx81c+yPWN28_j+tw@mail.gmail.com>
In-Reply-To: <CAHbLzkrSU3ZHRiZAxy9Jju3-3ZFpDmE4uMx81c+yPWN28_j+tw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Aug 2022 19:05:19 -0700
Message-ID: <CALvZod6558Ub52uvyGq02474noskMGf-jqeCEyoLqY0s4brQQw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: export workingset refault stats for cgroup v1
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 7:01 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Aug 16, 2022 at 3:06 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Tue, Aug 16, 2022 at 11:58 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > Workingset refault stats are important and usefule metrics to measure
> > > how well reclaimer and swapping work and how healthy the services are,
> > > but they are just available for cgroup v2.  There are still plenty users
> > > with cgroup v1, export the stats for cgroup v1.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > > I do understand the development of cgroup v1 is actually stalled and
> > > the community is reluctant to accept new features for v1.  However
> > > the workingset refault stats are really quite useful and exporting
> > > two new stats, which have been supported by v2, seems ok IMHO.  So
> > > hopefully this patch could be considered.  Thanks.
> > >
> >
> > Is just workingset refault good enough for your use-case? What about
> > the other workingset stats? I don't have a strong opinion against
> > adding these to v1 and I think these specific stats should be fine.
>
> The workingset refault is good enough for our usercase, but I don't
> mind adding all the workingset_* stats if nobody has objection.

For now let's just start with what your use-case needs. If in future
there is a need we can add other workingset_* stats as well.

>
> > (There is subtlety in exposing objcg based stats (i.e. reparenting) in
> > v1 due to non-hierarchical stats in v1. I remember Yosry and Muchun
> > were looking into that.)
>
> The workingset_* stats should have nothing to do with obj based stats IIUC.

Yeah, that was just FYI for anyone in future who wants to export such
stat in v1.
