Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC43558119
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiFWQ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiFWQvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:51:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B767EE09
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:50:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so1880939wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyotFVIHbhwpabNYCGpU2td0gSap/Y9S4vgKOOyoLJk=;
        b=FrYaPn5yCP6c7XLE34Oe4aHh28I2+edN+azHdmB/Hm41HqxPPG50LlZclCjAXo/6sd
         sUji2HaPVj4NqIerdZV1Dq99mON5/WCMELiHVpfXmAwKM1hHBHG1C+ovvS4LPKdT0BHz
         MU+httuoGZN0A02Bd7UJMb4bVlLuJlrEMqr3r+eOFmOPuMHAP7R4lyJrGwSWuI5FSwxF
         4HcDKCVCynBgWQuRcyr/73vXpiRCxe2AXuunChxGXu68Bey0VzUozDru4wS/+GO88u9X
         k8yG4gwL6fQWebAgqaipPE1moMjXv2dwUZBeCIlPcJ25UdJEqfrVImTleyGcA+DbBcjA
         teOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyotFVIHbhwpabNYCGpU2td0gSap/Y9S4vgKOOyoLJk=;
        b=yGdCOfb8T04byO+wON7ZoJtnt5icClXq8aQZ2FUj11+a0uxko0F+jMOaNPFr7PN013
         BO0HAhpQsTjLs20WeOVUGtz/ZJarJsmqUMWhKFX4G/51iQ4aW6PS5htJGIFsPauYXFp7
         6EmTO1INmpPJAujyP09hIs8cyU0vINcO8WuARfxqEb465Luak1CRbvv4mo6HZdryk0s2
         FEMARzBtXzvzWFetbwtyswe5hg8w3PPSQ5Tyt8IVVtMlbDjeAN8F5EknCv0wjgLE539O
         1JQ/iXms6m87EcClbw65pfH3VV1kC1/yLhtuxlJS01+bJkN17XtHfIE+6ZhSPfydzAbt
         ptog==
X-Gm-Message-State: AJIora9LorvoPMDu23jFcj/1mjvikjSBZcE5gzdtw0x1hvef+uHj62ub
        jsfXZTsNPKjN9sdPMp/rRteav/Wi0Kv4GKD9AElglg==
X-Google-Smtp-Source: AGRyM1veKrdS63pvIE+ZqkDsx+2WUvC3Q147rHm2GTilmFfL/Eh0tVd/vlOO+xQfiDVYfU3UuSB9FmFFZe27Zk+zBa8=
X-Received: by 2002:a05:600c:1906:b0:39c:7f82:3090 with SMTP id
 j6-20020a05600c190600b0039c7f823090mr5159188wmq.152.1656003025075; Thu, 23
 Jun 2022 09:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220623000530.1194226-1-yosryahmed@google.com>
 <YrQe5A+FXnbgOR1f@dhcp22.suse.cz> <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
 <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz> <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz> <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
In-Reply-To: <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Jun 2022 09:49:48 -0700
Message-ID: <CAJD7tkY4a7AsUxa_k+_6q56+MmTJmsiy7uk176Z=6o-eC-950w@mail.gmail.com>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
To:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 9:42 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Jun 23, 2022 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 23-06-22 09:22:35, Yosry Ahmed wrote:
> > > On Thu, Jun 23, 2022 at 2:43 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 23-06-22 01:35:59, Yosry Ahmed wrote:
> > [...]
> > > > > In our internal version of memory.reclaim that we recently upstreamed,
> > > > > we do not account vmpressure during proactive reclaim (similar to how
> > > > > psi is handled upstream). We want to make sure this behavior also
> > > > > exists in the upstream version so that consolidating them does not
> > > > > break our users who rely on vmpressure and will start seeing increased
> > > > > pressure due to proactive reclaim.
> > > >
> > > > These are good reasons to have this patch in your tree. But why is this
> > > > patch benefitial for the upstream kernel? It clearly adds some code and
> > > > some special casing which will add a maintenance overhead.
> > >
> > > It is not just Google, any existing vmpressure users will start seeing
> > > false pressure notifications with memory.reclaim. The main goal of the
> > > patch is to make sure memory.reclaim does not break pre-existing users
> > > of vmpressure, and doing it in a way that is consistent with psi makes
> > > sense.
> >
> > memory.reclaim is v2 only feature which doesn't have vmpressure
> > interface. So I do not see how pre-existing users of the upstream kernel
> > can see any breakage.
> >
>
> Please note that vmpressure is still being used in v2 by the
> networking layer (see mem_cgroup_under_socket_pressure()) for
> detecting memory pressure.
>
> Though IMO we should deprecate vmpressure altogether.

Thanks Shakeel for mentioning that, I was just about to. Although I
agree vmpressure should be deprecated at some point, the current state
is that memory.reclaim will give incorrect vmpressure signals.

IMO psi and vmpressure (though legacy) both signify memory pressure
and should both be consistent as to what is being accounted for.
