Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A06583704
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiG1Chm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiG1Chj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:37:39 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613275A88B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:37:38 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id r12so250874uaf.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfJSj7i/OoCG7kZZKpDbdtqWbIKHdQEmX9HjfPFjqLs=;
        b=fRFnidABVPlzkU1RKqySnsqczmNZ4fJ07KJJoNuzJl/Wdi0H9s02JiQtUyPZ/xyBhh
         qcw6mqIm8znBQNIxPxmgDJsN0KShkqCJ2+uEiMoZrqZIAo9LxSpzEqnEQUSP3l6kLAPg
         JmEoO33JfxJ8INlKC7FBXNscD/wrqcQ0qCjCYbsVmlQFdQtVIZeE0aIkUZt55lyUbheS
         8sIRsQiDWh4yRRrxjyb8rUY53uQdPt/mv9vvjCvBmAzaUxH/ASdXIb10jWHbBxLlVg5I
         qHKOL5GV0L88a2VLfoVASih9dBWJBox6WDrMpSlfX9hGlh2VGq+p5tBLkCPWi6E+aoKi
         ztrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfJSj7i/OoCG7kZZKpDbdtqWbIKHdQEmX9HjfPFjqLs=;
        b=dmZjS6ZOvVkLAgwCko4IbsmKpHqlAingRvGFLmjp4tnZ4+lY+nnFeIpWoN9zZEteDf
         MOqm8gozgi3rrtcQKlZeSNlJawqqafUG8X3pNX3rEWNPGdVeGMwHbwh3VVUZGUVhVoZJ
         mZWwgTawe/FT+Coj5awAjGzy0WIifor6xtlOwFGtQ50v7gaF9mG5AnAGWLWPestfKhxU
         Te8WWj3GgFFsQc3hB5OmkEH0sYIDuOeUOnxIAvd1d2UlrxjOTJssk8RMYP59YtLRvHLl
         hsapa9UkocK9oKJGi1HLU70H7wiT+TNJ8o+4JqU7xqj4MGSVaVIhBQcQQC8mJztiok5z
         dW4g==
X-Gm-Message-State: AJIora9DczER+JZiV+xTJGu2bS64hbe5CwOxGdY+0yGYlq6pLD4f5F4N
        yXYOVKL/Rzks1pvdCz7KfWTDRL3RQAkJtHpylpScnyAPy3Z+ixmd
X-Google-Smtp-Source: AGRyM1sl5sOX7JmgxR5F/BN8PFjMkojxTysg5mhGPLjYrm6FdcTrt8XJ+wn/1bcqQfYWwWojW0IWs8oU/FKAslAidPA=
X-Received: by 2002:ab0:1c56:0:b0:384:cbd7:4329 with SMTP id
 o22-20020ab01c56000000b00384cbd74329mr3889572uaj.9.1658975857511; Wed, 27 Jul
 2022 19:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220727090700.3238-1-tujinjiang@bytedance.com>
 <YuFPKDx90+R3Qc6v@dhcp22.suse.cz> <CAHbLzkpu91gEDzep76iRT+yFxLFaTf4fn3=bmP-fs-UP4i3NEg@mail.gmail.com>
In-Reply-To: <CAHbLzkpu91gEDzep76iRT+yFxLFaTf4fn3=bmP-fs-UP4i3NEg@mail.gmail.com>
From:   =?UTF-8?B?6ZSm5rGf5bGg?= <tujinjiang@bytedance.com>
Date:   Thu, 28 Jul 2022 10:37:26 +0800
Message-ID: <CAF77dw_D5ZD74Sy9UBmQjxNO8ShHzBdVAgRKHv-z-4RKdO=C3g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] vmscan: fix potential arbitrary pointer
 passed to kfree in unregister_shrinker
To:     Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 11:50 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Jul 27, 2022 at 7:43 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > [Cc Yang Shi]
>
> Thanks, Michal.
>
> > On Wed 27-07-22 17:07:00, tujinjiang@bytedance.com wrote:
> > > From: Jinjiang Tu <tujinjiang@bytedance.com>
> > >
> > > when shrinker is registered with SHRINKER_MEMCG_AWARE flag,
> > > register_shrinker will not initialize shrinker->nr_deferred,
> > > but the pointer will be passed to kfree in unregister_shrinker
> > > when the shrinker is unregistered. This leads to kernel crash
> > > when the shrinker object is dynamically allocated.
> >
> > Is this a real life problem? I thought shrinkers were pre-zeroed
> > already. Not that we should be relying on that but it would be good to
> > mention whether this is a code fortification or something that we should
> > be really worried about.
>
> Yes, all memcg aware shrinkers are actually pre-zeroed. The fs
> shrinkers (embedded in super_block) are allocated by kzalloc, all
> other shrinkers are static declared. So I don't think it will cause
> any crash in real life.
>

Yes, the shrinkers in the current kernel will not cause crash, but a new
memcg aware shrinker may be added in the future,  and I think we
should not assume the shrinker is pre-zeroed.

Function free_prealloced_shrinker does not assume the shrinker is pre-zeroed,
and does not call kfree(shrinker->nr_deferred) if the shrinker is memcg aware.
So I think it is better for unregister_shrinker to call kfree only
when the shrinker
is not memcg aware.

> >
> > > To fix it, this patch initialize shrinker->nr_deferred at the
> > > beginning of prealloc_shrinker.
> >
> > It would be great to add
> > Fixes: 476b30a0949a ("mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers")
> >
> > > Signed-off-by: Jinjiang Tu <tujinjiang@bytedance.com>
> > > ---
> > >  mm/vmscan.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index f7d9a683e3a7..06ab5a398971 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -613,6 +613,7 @@ int prealloc_shrinker(struct shrinker *shrinker)
> > >       unsigned int size;
> > >       int err;
> > >
> > > +     shrinker->nr_deferred = NULL;
> > >       if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> > >               err = prealloc_memcg_shrinker(shrinker);
> > >               if (err != -ENOSYS)
> >
> > You should be able to move it under SHRINKER_MEMCG_AWARE branch, no?
> >
> > --
> > Michal Hocko
> > SUSE Labs
