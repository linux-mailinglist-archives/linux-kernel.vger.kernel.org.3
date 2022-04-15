Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED805032D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356460AbiDOXYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 19:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiDOXYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:24:12 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E193EAA9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:21:42 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g34so16685648ybj.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuo7iHZ1RNifX3JTO2eCwX7T0jOUxZ1qwp7LLcocIVI=;
        b=XEBSZwb2Tz6Zmz6ducvRkE4UvXRTLcZOtZX2rRoWnKxpWRJf6ljXu8Vc3NyRkjEjrS
         VBK0GW3CUTODz59QZq9Oj64X9t8amPvFT8P64/JUpfWeYWRl/kfpPl+//vs4HoW22Bd1
         TlIg+kPVUfMDJV4qLOHQtkmwBcP0g2B+j6YK5NESXMEfcRMp2Nfd1bjSNL1Ly5wL4oj8
         8ipcgdXXQ+Q/v67AIaS5Te/hACSNHlJQwMGnaABI2ol2K5et7tKpr44M/7YrS9cdGQxV
         3OgLqHBHy3PaCa1i4Qa0Y4e3mP27DqaD0rIZK2McBbpKrAY/AIS5qugVGrSd7aVHFK0P
         jPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuo7iHZ1RNifX3JTO2eCwX7T0jOUxZ1qwp7LLcocIVI=;
        b=ziNyD/dLTbrhXRi/3va+0hQAGORJ5hyvJZlhc78NfKfhVOuWTvRvdX2XbqOOJoZwsd
         9p2tGi1VcGZozUkn9BwkLZwjeADvN+tTGA5JP85R5sa0yHTsdZiSw5xBjmKxQVUWHUho
         VyZvG26vO7K2qeWHCTesFbPN15ax3V32LtdXyft60Yqu3QZxRPIaL6pOzI5xvs5KeHgU
         3lQxaR3yv+x01k8X/onAuYR3XYZT9cvKdhbkBmhoZANhIyqNmLNaqB+UzFPtHJ3wNXr4
         zLUvTraQB6mokiyvFh26+D29KcgobklULisBbY5BWV/VmLA4vgyEdmKpTTNiEKxOsa85
         LxMA==
X-Gm-Message-State: AOAM5325Oskjviq5863y0aZiLnq6V/tFdcvIpzJEFwwfrz4yfJtOl0Jg
        hbrpVl6ds12voa74aZZah+fF+dviK2Awcdi60pEOQg==
X-Google-Smtp-Source: ABdhPJxjBW3mXMuVLFyhRvmnClhk4vp3fKUtEpPFDSc1AuAHVIn6BHStkQ4Jww+esZZnyxTN+zvadMzQnK6p0Ebp5kM=
X-Received: by 2002:a05:6902:154b:b0:644:b5e4:aa34 with SMTP id
 r11-20020a056902154b00b00644b5e4aa34mr1414126ybu.126.1650064901749; Fri, 15
 Apr 2022 16:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220409135104.3733193-1-wuyun.abel@bytedance.com>
 <20220409135104.3733193-2-wuyun.abel@bytedance.com> <CABk29NtBL2WovUVcxXW8cF7Nk+UM_AeEJaX_JbQ4Wue-qMvz_w@mail.gmail.com>
 <56ded56d-f7ad-a49f-c19c-8aa40fb33a29@bytedance.com> <CABk29Nu+6vh825SqyNmSJoWBQmEBgCsk6mcEtWLmXCq_T0xUjg@mail.gmail.com>
 <45fdb9f1-ac3e-2b92-9bd9-0f5e5886e2c9@bytedance.com>
In-Reply-To: <45fdb9f1-ac3e-2b92-9bd9-0f5e5886e2c9@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 15 Apr 2022 16:21:30 -0700
Message-ID: <CABk29NtifQV7+kgg_8yLqGHraMAS48BJjmU9WfkJihu-C4c8hw@mail.gmail.com>
Subject: Re: [RFC v2 1/2] sched/fair: filter out overloaded cpus in SIS
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does this check help that much? Given that you added the filter below
> > to cut out searching overloaded cpus, I would think that the below is
> > sufficient.
>
> I see a ~10% performance drop in the higher load part of the hackbench
> and tbench without this check, in which cases system is quite overloaded
> and idle cpus can hardly exist.
>
> >
> > Another use case that would break with the above:
> >
> > A few cpus are reserved for a job, so that it always has a couple cpus
> > dedicated to it. It can run across the entire machine though (no
> > affinity restriction). If the rest of the machine is very busy, we'd
> > still want to be able to search for and find the idle reserved cpus
> > for the job.
>
> Yes, this could be true if very few cpus are reserved for the job. Along
> with the previous affinity case, I think the following might help both:
>
> static inline bool
> sched_domain_overloaded(struct sched_domain *sd, int nr_overloaded)
> {
>         return nr_overloaded == sd->span_weight;
> }
>
> Besides, I think sched_idle_balance() will work well on this case.

The change to sched_domain_overloaded SGTM. But note that an async
load balancing operation such as sched_idle_balance() can't be relied
on for keeping wakeup latency low if we fail to find an idle cpu to
wake on (and one exists).
