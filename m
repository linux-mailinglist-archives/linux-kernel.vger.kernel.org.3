Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD64F8994
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiDGWOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiDGWOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:14:33 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D2E301089
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:12:31 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k25so8529524iok.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62GjerdaAck66OudlovFMoMWV8LkosnjVIBtISAsTok=;
        b=m2dekUbSBaWg3wdckQk3GkcVHt/A/a6ywrsRC7Zr+OHQ+BkUTgjlNU1vXv6zm/3iaY
         xxadAcipHmqh0C7F0D9EU7NFc5YAb9FZkVSzEL4+O/jx8yrcYGqW9GM2yIaEnMiFbDZr
         Dmeep7sExLjsu4JxhO4DuuelqA5rbJ/3cOSonPHCwi4EREyhTBEYbgVQhFVpUUAxAx2w
         Ut/XMTm8M2y818f4j0tTkICVsLLaYMNiaqyjeMNKx7ad+ovCX2uYckpoN2pt5vcpYAeT
         9tJny/n/6viFNEbAyrkzNAxLHvA8tlWWvcytzOJR1OO7iJWyOtRt4oRyF8WK5s9ke1jL
         DBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62GjerdaAck66OudlovFMoMWV8LkosnjVIBtISAsTok=;
        b=z61OPmS0gZXN5aBc0JWFhpUwUFCJoId3yRXY7NEUnFz97QQL7jCN6Vv4LdEG75M7Na
         RoFsNlCsubliLAWemPD/BbLWCYw+BpO9cEH+YDFETAHfMgbQnaxVfrIcGFEigWDE2pXC
         WxtKshl2rZTK22v3z8Nkhd7GlscRC09rYGHEyzV0PXdBKGWZSRSww8EOoOAZ5ThPEEra
         wUZQF7lclVWNHVtQQGhKTQoL08+TETcj05jDGmCo4q1Mgu79fB9Lg805w9+E9vUpIQCk
         6v3UCTpCLP6Mgn/6JTKbAvUINzlDWugFZsQFX+PEpK2uSj8deETgmpnXc/zluMOYAI0d
         igCg==
X-Gm-Message-State: AOAM5328U66PuWLgqo/OxIrRDF0IK6EvkBCaH2+7fJ1QqnFuHZffJ2Un
        uzq6/A9sy5QLTE12XtERG4AYp488s0oBlHTzv5casw==
X-Google-Smtp-Source: ABdhPJxpAZUHlbMukQnpLndfXFl1Rj5fBAxD3imudhiINhEZ65rRZuJcb7Kl9s6yTOWOiwiRJ4IViP6YLnbs5QZ5zWY=
X-Received: by 2002:a02:84c9:0:b0:31a:1cf2:4468 with SMTP id
 f67-20020a0284c9000000b0031a1cf24468mr8517916jai.31.1649369550638; Thu, 07
 Apr 2022 15:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkcEMdsi9G5y8mX4@dhcp22.suse.cz> <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
 <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAAPL-u8wjtBRE7KZyZjoQ0eTJecnW35uEXAE3KU0M+AvL=5-ug@mail.gmail.com>
 <87o81fujdc.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAAPL-u_6XqQYtLAMNFvEo+0XU2VR=XYm0T9btL=g6rVVW2h93w@mail.gmail.com>
 <87bkxfudrk.fsf@yhuang6-desk2.ccr.corp.intel.com> <215bd7332aee0ed1092bad4d826a42854ebfd04a.camel@linux.intel.com>
In-Reply-To: <215bd7332aee0ed1092bad4d826a42854ebfd04a.camel@linux.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 7 Apr 2022 15:12:19 -0700
Message-ID: <CAAPL-u_aAbDOmATSA8ZvjnfBk_7EoXvLoh0etM0fB0aY1845VQ@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
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

On Thu, Apr 7, 2022 at 2:26 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Wed, 2022-04-06 at 10:49 +0800, Huang, Ying wrote:
> >
> > > > If so,
> > > >
> > > > # echo A > memory.reclaim
> > > >
> > > > means
> > > >
> > > > a) "A" bytes memory are freed from the memcg, regardless demoting is
> > > >    used or not.
> > > >
> > > > or
> > > >
> > > > b) "A" bytes memory are reclaimed from the memcg, some of them may be
> > > >    freed, some of them may be just demoted from DRAM to PMEM.  The total
> > > >    number is "A".
> > > >
> > > > For me, a) looks more reasonable.
> > > >
> > >
> > > We can use a DEMOTE flag to control the demotion behavior for
> > > memory.reclaim.  If the flag is not set (the default), then
> > > no_demotion of scan_control can be set to 1, similar to
> > > reclaim_pages().
> >
> > If we have to use a flag to control the behavior, I think it's better to
> > have a separate interface (e.g. memory.demote).  But do we really need b)?
> >
> > > The question is then whether we want to rename memory.reclaim to
> > > something more general.  I think this name is fine if reclaim-based
> > > demotion is an accepted concept.
> >
>
> memory.demote will work for 2 level of memory tiers.  But when we have 3 level
> of memory (e.g. high bandwidth memory, DRAM and PMEM),
> it gets ambiguous again of wheter we sould demote from high bandwidth memory
> or DRAM.
>
> Will something like this be more general?
>
> echo X > memory_[dram,pmem,hbm].reclaim
>
> So echo X > memory_dram.reclaim
> means that we want to free up X bytes from DRAM for the mem cgroup.
>
> echo demote > memory_dram.reclaim_policy
>
> This means that we prefer demotion for reclaim instead
> of swapping to disk.
>

(resending in plain-text, sorry).

memory.demote can work with any level of memory tiers if a nodemask
argument (or a tier argument if there is a more-explicitly defined,
userspace visible tiering representation) is provided.  The semantics
can be to demote X bytes from these nodes to their next tier.

memory_dram/memory_pmem assumes the hardware for a particular memory
tier, which is undesirable.  For example, it is entirely possible that
a slow memory tier is implemented by a lower-cost/lower-performance
DDR device connected via CXL.mem, not by PMEM.  It is better for this
interface to speak in either the NUMA node abstraction or a new tier
abstraction.

It is also desirable to make this interface stateless, i.e. not to
require the setting of memory_dram.reclaim_policy.  Any policy can be
specified as arguments to the request itself and should only affect
that particular request.

Wei
