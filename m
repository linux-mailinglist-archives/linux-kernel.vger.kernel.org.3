Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10C4C6867
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiB1KyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiB1Kwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:52:54 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7F2674DC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:51:27 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d07c4a0d06so102662437b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYkiTGE+IL621wQjI8CgMwBjCYo+uE8eI9lxYVOTdh4=;
        b=RgzHqIp1vA8is+C2ytkSxIxm4DQxeOY/hmAu6Qz3W1Q93ZAHaBl9TSm9MdRE48hQHp
         EcIAdPLfPu6/h7lXHaroH40GzxJBOSc0ioDrKP4QB8iOQlbT4slFg2FSDyrWxg4UgjE3
         bOM9MSgnY3oaG+1e30qKUFXA4jeONfittua8vGZfygqJ/HPOqUbs7Q8OJ7QitjMJxPhS
         ZrsJDGMk23U2ili69HorKtfW6zbNnbsOYRaRVp6Tt345WWGtGJjQo0l4LAGmA0PKIsgt
         FUfFiZ4o46XXMd2vFJsoOHHII2yv9PvbSmtMIqAd8a/+ZEnDLxV+vb07oex9eUIV/9lw
         GgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYkiTGE+IL621wQjI8CgMwBjCYo+uE8eI9lxYVOTdh4=;
        b=NwIgWe8Y4FheVW8qdUxSD18n9VPJ10r3VsXzWmX5cXIYSagcieCTu7+zaIeOSjE5Uu
         VB4I0ug+DBxrv8bZ2AUx7Jj7NS9G80Vw9eXQ5nKS8SsQVYcw8v96ZenWkIn2+LCP0DaC
         MsYnoGlCYoM4qSSvoBwvaq2xzlbZ9cKhb77L9cCLjjNc/dxfVq/Z7hhs7HeSp6dn92Da
         apM5vUgghmZsW88wT09qaqSknlRkUqQxVQT+3VyObuLNGsnlsawxrx4wwlnyOaCyIrNa
         /p5uD3lhdkYinchuEh4zXM7LBdXivqxDHpl2bxuApVdFQL0G08G6a4nJdMh646Lh3pms
         Xg+A==
X-Gm-Message-State: AOAM5333nKN9kSJl17K9JVXVHcymczKBfBWhXVcEwgOHWKtyohbyIIHX
        eUiz3kPwJs+1gb6p/AQM6wAPKNviiCDx7D+brh2C4Q==
X-Google-Smtp-Source: ABdhPJxNJhPVWSLXvI3iBbzOTe+qklatZ5k5QaYFXfBVeasYi8gKHeTY8TCV153zvQlSda9HbUSe36S5qOS966ph55M=
X-Received: by 2002:a81:1a49:0:b0:2d7:fc73:dab2 with SMTP id
 a70-20020a811a49000000b002d7fc73dab2mr19291710ywa.316.1646045486359; Mon, 28
 Feb 2022 02:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20220225180318.20594-3-vbabka@suse.cz> <YhrrM7NTYXG5JluY@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <CANpmjNOyVTQZroOEVF_ZLASCtQ=SiC12WGWEwOib3vDk3sCbtw@mail.gmail.com> <YhyeaP8lrzKgKm5A@ip-172-31-19-208.ap-northeast-1.compute.internal>
In-Reply-To: <YhyeaP8lrzKgKm5A@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Feb 2022 11:50:49 +0100
Message-ID: <CANpmjNOOhuoU7T4UqHbzkRAvM+b-gvt+Qtx41va=9ixGgUSWaQ@mail.gmail.com>
Subject: Re: [PATCH] lib/stackdepot: Use page allocator if both slab and
 memblock is unavailable
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Zqiang <qiang.zhang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 at 11:05, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
[...]
> > This is odd - who is calling stack_depot_init() while neither slab nor
> > memblock are available?
>
> It's not merged yet - but Oliver's patch (2/5) in his series [1] does:
> If user is debugging cache, it calls stack_depot_init() when creating
> cache.
>
> > @@ -4221,6 +4220,9 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> >       s->remote_node_defrag_ratio = 1000;
> >  #endif
> >
> > +     if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> > +             stack_depot_init();
> > +
>
> Oliver's patch series enables stack depot when arch supports stacktrace,
> to store slab objects' stack traces. (as slub debugging feature.)
>
> Because slub debugging is turned on by default, the commit 2dba5eb1c73b
> ("lib/stackdepot: allow optional init and stack_table allocation by
> kvmalloc()") made stack_depot_init() can be called later.
>
> With Oliver's patch applied, stack_depot_init() can be called in
> contexts below:
>
>   1) only memblock available (for kasan)
>   2) only buddy available, vmalloc/memblock unavailable (for boot caches)
>   3) buddy/slab available, vmalloc/memblock unavailable (vmap_area cache)
>   4) buddy/slab/vmalloc available, memblock unavailable (other caches)
>
> SLUB supports enabling debugging for specific cache by passing
> slub_debug boot parameter. As slab caches can be created in
> various context, stack_depot_init() should consider all contexts above.
>
> Writing this, I realized my patch does not handle case 3).. I'll send v3.
>
> [1] https://lore.kernel.org/linux-mm/YhoakP7Kih%2FYUgiN@ip-172-31-19-208.ap-northeast-1.compute.internal/T/#t
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v1
>
> > Do you have a stacktrace?
>
> Yeah, here:
>
> You can reproduce this on vbabka's slab-stackdepot-v1 branch [2] with
> slub_debug=U, and CONFIG_STACKDEPOT_ALWAYS_INIT=n
>
[...]
> [    0.000000] Call trace:
> [    0.000000]  __memset+0x16c/0x188
> [    0.000000]  stack_depot_init+0xc8/0x100
> [    0.000000]  __kmem_cache_create+0x454/0x570
> [    0.000000]  create_boot_cache+0xa0/0xe0

I think even before this point you have all the information required
to determine if stackdepot will be required. It's available after
setup_slub_debug().

So why can't you just call stack_depot_init() somewhere else and avoid
all this complexity?

> [    0.000000]  kmem_cache_init+0xf8/0x204
> [    0.000000]  start_kernel+0x3ec/0x668
> [    0.000000]  __primary_switched+0xc0/0xc8
> [    0.000000] Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428)
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
