Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146F0558022
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiFWQnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiFWQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:42:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56BB96
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:42:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r1so18618750plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6hz8M8YZFqPg+rrGciN8Bxo8th0Vg1fhfElGS1vnuI=;
        b=d0K9ZioXVT08tRoikYi6GqBEGr4BS/wf+DoeVBqJLLTdCIAWr2FXnOm1S10GPbwYnM
         jrKEFElgWZVEh9MFxB04cMQUnbFUjkYQF6r3Et+6GwNx4sd5TBWgPLocKlQVjWZCRrB2
         ARU20yfQHyYNbhYUYT2fRgUV0lQ7hAEbQm5Ecu28CgITIPYzepsNEyC3MQT7q4lzyOMG
         BEb4FpUhSQqobA9Pob8eUcmRKpHq4Ba+ObD0fZeq4cfioNCAyrTlL4Kk4vln7x4X3x3m
         v9Qe2nr8fIcROwb84JZkX3RO0rTyNxbolLnY4WvgiXdA9lJ95b7oDT7ySZKqmCCazPDA
         3LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6hz8M8YZFqPg+rrGciN8Bxo8th0Vg1fhfElGS1vnuI=;
        b=iNPN17QIDGxSPMm0l60DEsJBeumSU+YAJzM77NzRJdM4YRxLqC+qG7hPquKnrXh5tS
         f2cm0KKXIwNxyJoCoo/iRm0ew5S30lZS/KNIL8O/XXMbH5NLPC9unyfzg5DamGlWqAO4
         nrMbrwam7FPEHfFktsuyQlpQVX/Rii7fX5QVfCeWpFhSL7YmzYLARBBhPP5AZs+84xvK
         Xkm/SxgKrEhx3xK5wJTmD+YaS3djxkmcSW5TuD1TlPd+0rBZRfSwS7yzfPOrIWM+hIHD
         TKgFbIH6SVmrRNMFGFS1Xjx0iCSNl0rOPMeDOUOlcvPJ8ivdqYigWOs8q4x8hyl6L3/s
         Emyg==
X-Gm-Message-State: AJIora80pNVMhLtpSU25hTSbq5FVap2RhvYndh9uoUeUpSNHTHDSobQp
        T9g+ap+WWEO0Plqef1w/sPWmdzpRuxRa1KvDodpQ1Q==
X-Google-Smtp-Source: AGRyM1tIkL+FeUm4IWfsd5tVJ0yduL2FFqQQW4NwI9yBKuUe8peXkhFsv/YnlRQe9BGM49zGFj3XXDX46gMWXqEYh4o=
X-Received: by 2002:a17:903:2cb:b0:14f:4fb6:2fb0 with SMTP id
 s11-20020a17090302cb00b0014f4fb62fb0mr39330727plk.172.1656002575066; Thu, 23
 Jun 2022 09:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220623000530.1194226-1-yosryahmed@google.com>
 <YrQe5A+FXnbgOR1f@dhcp22.suse.cz> <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
 <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz> <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz>
In-Reply-To: <YrSWruhPlJV1X9kp@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 Jun 2022 09:42:43 -0700
Message-ID: <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
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

On Thu, Jun 23, 2022 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 23-06-22 09:22:35, Yosry Ahmed wrote:
> > On Thu, Jun 23, 2022 at 2:43 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 23-06-22 01:35:59, Yosry Ahmed wrote:
> [...]
> > > > In our internal version of memory.reclaim that we recently upstreamed,
> > > > we do not account vmpressure during proactive reclaim (similar to how
> > > > psi is handled upstream). We want to make sure this behavior also
> > > > exists in the upstream version so that consolidating them does not
> > > > break our users who rely on vmpressure and will start seeing increased
> > > > pressure due to proactive reclaim.
> > >
> > > These are good reasons to have this patch in your tree. But why is this
> > > patch benefitial for the upstream kernel? It clearly adds some code and
> > > some special casing which will add a maintenance overhead.
> >
> > It is not just Google, any existing vmpressure users will start seeing
> > false pressure notifications with memory.reclaim. The main goal of the
> > patch is to make sure memory.reclaim does not break pre-existing users
> > of vmpressure, and doing it in a way that is consistent with psi makes
> > sense.
>
> memory.reclaim is v2 only feature which doesn't have vmpressure
> interface. So I do not see how pre-existing users of the upstream kernel
> can see any breakage.
>

Please note that vmpressure is still being used in v2 by the
networking layer (see mem_cgroup_under_socket_pressure()) for
detecting memory pressure.

Though IMO we should deprecate vmpressure altogether.
