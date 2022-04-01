Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39554EEA40
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbiDAJT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbiDAJTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:19:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40C266B5C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:18:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so4792885pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcE1vZsqOC27RAHXsaotKwbu3NGWTU8/jzgbrphRdpE=;
        b=L+wRmwtFkpd+m0tszgzRoGykDP58MklBTX07/cJ3alDFu0VTSd1I/hq/zSMXHjhGd+
         ORsn1KzqqogGVi4mEaAioTilnjtqw+9fiL/T5mhdsV7F09NJgeLoW1Pong3lb9u44HlH
         heu2mrTDcicJ+vo4LfufK5AN8/JHVWx4UZTgexfGuT74z4KNunHe8Z7/XU3izLZfSuhA
         lrUtAomJfqUQvzsXIXGjLIZxE9YtIHnpOVXrDNjcg9V3wHsMcNWLnx0N9xjIIXeb2MIW
         E242uqzwCdo3qulMfbGnkEpwGOgq94HkLWTJXXR5Dj/7x5mDcvtd59PD1MalZ/0jqiJz
         yT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcE1vZsqOC27RAHXsaotKwbu3NGWTU8/jzgbrphRdpE=;
        b=QHAShddvpbVfvw09DmVpoBm5HFAeqVhe4067Dsx+oov1FruGTTIo37KUnb14s2XROC
         rdgVTxYaX/j5iqZbcan9U8y8xNJ8OHeH9i9UE1eBn7jHQqKg7OzOWDGWxvb4VwVukR/v
         QZiNEQspHJu1paiUf7ROvk6UYzv6TvgHAFD94pKeiDVrGE/7o8pu/vUxAPcBHYW7AyPj
         hBqCTCPoRCzhg/0GHHHwXuMa/Bz4LG+Rjuxd+LPmuBmkIRhiYkmesX76GB5SU1BAFif0
         Z009VzYb28Fhs/08Yiuci3O4RkzXyIKDtbXcwKrUSgIEDzFSQs8v8fISfVH8dzh+PnpQ
         EWKA==
X-Gm-Message-State: AOAM530zRCLXQvFUf811wYcHLjcz3lHMSLx0oCAJXbziEmCIABmaILcH
        H0Y6TOzKgJfcbeIY9w6rT50hdQeiPYD9yLoUpkIxDg==
X-Google-Smtp-Source: ABdhPJzIcbBBYmnkH3+FpntCyPdMrtDjlssU8PqFqE4s/EVCA8z8gJO+XVwbeP3Q/W5eRtmJH46bL1QGzljwG3Suleg=
X-Received: by 2002:a17:903:2341:b0:156:196a:3ef with SMTP id
 c1-20020a170903234100b00156196a03efmr9330941plh.81.1648804684807; Fri, 01 Apr
 2022 02:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <20220331173350.1fe09370479a4a6f916b477d@linux-foundation.org> <CAAPL-u-_Da0qe7h_o70HCz4gPtjT8_bjx4rVNdgKZh3KNruzpA@mail.gmail.com>
In-Reply-To: <CAAPL-u-_Da0qe7h_o70HCz4gPtjT8_bjx4rVNdgKZh3KNruzpA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 1 Apr 2022 02:17:28 -0700
Message-ID: <CAJD7tkarUYM6fjty8FXn9gtR=RVWgksa3LNwswi1Ug1LPnLt4g@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Wei Xu <weixugc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
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

On Thu, Mar 31, 2022 at 8:38 PM Wei Xu <weixugc@google.com> wrote:
>
> On Thu, Mar 31, 2022 at 5:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 31 Mar 2022 08:41:51 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
> > >       return nbytes;
> > >  }
> > >
> > > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > > +                           size_t nbytes, loff_t off)
> > > +{
> > > +     struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > > +     unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > > +     unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > > +     int err;
> > > +
> > > +     buf = strstrip(buf);
> > > +     err = page_counter_memparse(buf, "", &nr_to_reclaim);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     while (nr_reclaimed < nr_to_reclaim) {
> > > +             unsigned long reclaimed;
> > > +
> > > +             if (signal_pending(current))
> > > +                     break;
> > > +
> > > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > > +                                             nr_to_reclaim - nr_reclaimed,
> > > +                                             GFP_KERNEL, true);
> > > +
> > > +             if (!reclaimed && !nr_retries--)
> > > +                     break;
> > > +
> > > +             nr_reclaimed += reclaimed;
> > > +     }
> >
> > Is there any way in which this can be provoked into triggering the
> > softlockup detector?
>
> memory.reclaim is similar to memory.high w.r.t. reclaiming memory,
> except that memory.reclaim is stateless, while the kernel remembers
> the state set by memory.high.  So memory.reclaim should not bring in
> any new risks of triggering soft lockup, if any.
>
> > Is it optimal to do the MAX_RECLAIM_RETRIES loop in the kernel?
> > Would additional flexibility be gained by letting userspace handle
> > retrying?
>
> I agree it is better to retry from the userspace.

Thanks Andrew and Wei for looking at this. IIUC the
MAX_RECLAIM_RETRIES loop was modeled after the loop in memory.high as
well. Is there a reason why it should be different here?
