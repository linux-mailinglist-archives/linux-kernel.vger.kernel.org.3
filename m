Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2523657D1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiGUQtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGUQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:49:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE388F3F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:49:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso1138044wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdUUQLWwQt1lokFjpVxfgBDqZBmrvlIq3f9uYET+tvs=;
        b=GY5wu9Q/FEgr1xnB2EhxJuzovNWJwL4CbpjQ4mge6mweV3qC/mZ0X2IJ4qIMHbUUAG
         UAvCXBjfOz56dmlgiKQ40A8WYTaPIowbBSTxq8HYzTMdNas7AZ66zJ79UC4oYn9KQko5
         Wyn061wupTIFwzmtENvE6UeJ5MCktaVrRDbnpP56MexcUXHFft4o+C/Amwpp9RiqCt7w
         r8rjXuOIrINJLUX4LbvxHTzwEb+a00CsAJzmE2PBDL9EEpSSEIAR2/46he8lpjR23dPa
         Jn1nOFUTWXgYcS6hT4+jq4SrRLsflQkzCKKbYVtnUMDDM7Kio/t61r+yB0bYBIBEMz3Q
         2s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdUUQLWwQt1lokFjpVxfgBDqZBmrvlIq3f9uYET+tvs=;
        b=D5SYCDoHOJ+hcfjkYIz+JC2PUQ8WvETwSlc/UUv7lgwqaDs9aGlbXhSVbuNLl6a1NP
         CttGN/jMsraScMFRdKTxsL/1TcdKpBI/0fZJ902hOYreudfv5aQXhXZav7veOSoaqDH3
         RWfIRsnX6hxxVfOptbtRrw1laLJiUH7LGRhO8v4IQbCLsqLoTtDnVmxcOuoHJQzx7jHv
         wavL0cTebXpCo+LmSuSI0WegBCVh1X8qBMWFoKkhDG7ZPy77JwO9OgdwYg7yWGAln1q1
         GIHIZ/Llp73+gCJurNa19OActuotmELGGs8n3Jfuf3Lt03HHglSQ3AvOHwsy5lKtzP/w
         0yyg==
X-Gm-Message-State: AJIora9T+oM6YA6mAqxrirP5Ao4gZIz0bdpU2dEs73haLxPHZdEjAgLV
        M9CxYz371F69aRkLkef2ydluWSLhNUe2uJ3ZN/K3Xg==
X-Google-Smtp-Source: AGRyM1uueYuywQlzFF79QTrzJABzxA9oBvmvm72bRPUCr6v3SC49VU6rYoQLotGaJGSdOVt7/FOJ/SgaBNAk+1wOFj4=
X-Received: by 2002:a7b:c85a:0:b0:3a3:1884:6391 with SMTP id
 c26-20020a7bc85a000000b003a318846391mr9132955wml.196.1658422189317; Thu, 21
 Jul 2022 09:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220714064918.2576464-1-yosryahmed@google.com>
 <YtfJug77XJ9BPA8L@dhcp22.suse.cz> <CALvZod7X3PsM2+ZrWXwb75FNBBjaBGJpjd+WVmzr5hStROvW+g@mail.gmail.com>
 <CAJD7tkYBm+L_-GTLDux0ZsJ6=kw-zzHjs6vgKUtmeZhcxLwqiw@mail.gmail.com>
 <Ytk8EBBEi4EubvPn@dhcp22.suse.cz> <CAJD7tkZVcQ6xzdnGPS0kQAP=+Q=yZwVT_ZrLaEsAgkLi_DAMtQ@mail.gmail.com>
 <YtmCDCsv+K+9refK@dhcp22.suse.cz>
In-Reply-To: <YtmCDCsv+K+9refK@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 21 Jul 2022 09:49:12 -0700
Message-ID: <CAJD7tkagAqXQ8b921d3_1=JtwKXM-q3ubK6wgN3ku-0XSLmJaA@mail.gmail.com>
Subject: Re: [PATCH v4] mm: vmpressure: don't count proactive reclaim in vmpressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 9:42 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 21-07-22 08:58:06, Yosry Ahmed wrote:
> > On Thu, Jul 21, 2022 at 4:44 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 20-07-22 11:02:56, Yosry Ahmed wrote:
> > > > On Wed, Jul 20, 2022 at 10:50 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > > >
> > > > > On Wed, Jul 20, 2022 at 2:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > [...]
> > > > > >
> > > > > > I think what we are missing here is
> > > > > > - explain that this doesn't have any effect on existing users of
> > > > > >   vmpressure user interface because that is cgroup v1 and memory.reclaim
> > > > > >   is v2 feature. This is a trivial statement but quite useful for future
> > > > > >   readers of this commit
> > > > > > - explain the effect on the networking layer and typical usecases
> > > > > >   memory.reclaim is used for currently and ideally document that.
> > > > >
> > > > > I agree with the above two points (Yosry, please address those) but
> > > > > the following third point is orthogonal and we don't really need to
> > > > > have an answer for this patch to be accepted.
> > > > >
> > > >
> > > > That's great feedback, thanks Michal and Shakeel!
> > > >
> > > > How do you feel about the following commit message instead? Does it
> > > > address your concerns?:
> > > >
> > > > memory.reclaim is a cgroup v2 interface that allows users to
> > > > proactively reclaim memory from a memcg, without real memory pressure.
> > > > Reclaim operations invoke vmpressure, which is used in cgroup v1 to
> > > > notify userspace of reclaim efficiency, and used in both v1 and v2 as
> > > > a signal for a memcg being under memory pressure for networking (see
> > > > mem_cgroup_under_socket_pressure()). For the former, vmpressure
> > > > notifications in v1 are not affected by this change since
> > > > memory.reclaim is a v2 feature.
> > > >
> > > > For the latter, the effects of the vmpressure signal (according to
> > > > Shakeel [1]) are as follows:
> > > > 1. Reducing send and receive buffers of the current socket.
> > > > 2. May drop packets on the rx path.
> > > > 3. May throttle current thread on the tx path.
> > > >
> > > > Since proactive reclaim is invoked directly by userspace, not by
> > > > memory pressure, it makes sense not to throttle networking. Hence,
> > > > this change makes sure that proactive reclaim caused by memory.reclaim
> > > > does not trigger vmpressure.
> > >
> > > OK, looks much better. Please also add a note to the documentation about
> > > this side effect.
> >
> > I don't want to add something to the documentation about throttling
> > networking because it seems like these are implementation details that
> > we may change in the future. I don't know if we can document this
> > behavior today and then change it later.
>
> The exact mechanism on how the throttling is done is one thing. This can
> change. But the fact that _no_ throttling is applied is something that
> we shouldn't change of course. If we were really strict we shouldn't
> change it even now but considering that the interface is new and
> usecases still shaping then better now than later.
>
> > How about we document a more generic statement in memory.reclaim
> > documentation, like:
> >
> > "With reactive reclaim operations triggered by the kernel, the kernel
> > may take further actions to alleviate memory pressure (such as
> > throttling networking memory consumption). For proactive reclaim
> > operations triggered by this interface, the kernel may choose to skip
> > such actions as reclaim is not an indication of memory pressure."
>
> IDK, this sounds too much word lawyering to me TBH. It is better to be clear
> about explicitly known side effects. For example where do shrinkers
> stand in the light of above wording? Kernel can chose to do almost
> anything and I do not think we want to control which shrinkers are
> triggered and what they do.
>
> So I would really prefer to say something like:
> "
> Please note that the proactive reclaim (triggered by this interface) is
> not meant to indicate memory pressure on the memory cgroup. Therefore
> socket memory balancing triggered by the memory reclaim normally is not
> exercised in this case. This means that the networking layer will not
> adapt based on reclaim induced by memory.reclaim.
> "

Sounds good to me! Will send v5 shortly with added doc changes and the
newly agreed upon commit log. Thanks Michal!

> --
> Michal Hocko
> SUSE Labs
