Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3606B5464F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349263AbiFJK7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349288AbiFJK6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:58:17 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D080F2DCB2B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:56:29 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id x38so532460ybd.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVWDkivKH1r0YSSFaw6OjTiC/YFmD6ezZssjPD8j23w=;
        b=RXvlY48vrnprsPhlzCN84oVM35sDdA8yC03DQqkStEKvLu2TPLb4+GXHZs42yE1HQx
         ttOCe8rdEkjLlqM3l9WDtsBCXfF4s+ChMyYv8Rr+fnyZ3LeVOcdMg6nEcEEKhCDER0yr
         fJTIw9qxUsAPtehkIPwv0SyUlxvDgwGcMmXAwiiBSv9/Zl7En+0nWztnAMnMDurZDcZY
         api97837F1HNyG80jX0Pe+SJ1JI7N7lMGqY67LErpq+TZ7CiRQ+ruwaymVLbslc02zZl
         XSlXazfrWTPWCpkIL90Vp8CX52j6WIsUEJ/9kUyf+tpm9WQnID+ZJjebzkTlpXQUnTgH
         lxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVWDkivKH1r0YSSFaw6OjTiC/YFmD6ezZssjPD8j23w=;
        b=2Z++5Udj0kOIpa70hzGf4pAHCnlAipPgf3SmgsTFuexkskwdWe1D5W7O1wAWpDWtpJ
         1qTyxNiTzqch/UK7UQQhzhCt5sB5Ah6wEJ/MeaE6BS2wfnjnjhsD/q73QwGNNuAS9qyv
         Q9ddUBYfJvn2P+2hAt4hEw+ouAXgHir59C73DuEWlfVHDYNLVnCdf49x8g15QZEeIeTi
         VPAH+NiPn2xS8mxZYnJ3cQhzNXF6yhaY1VUXr5UKMAWRmOUYjh4yLTskSHH47U3+h4eK
         QNFfAqagZuRgzLBfv5lK2yAMbknUhr7yZ2br6tOnddxN/yW5RrcS4zZT18NjkoR0hEG0
         Kodw==
X-Gm-Message-State: AOAM532zSvJ/mPPq8YPhaL1DR3x675XmLTWcm5eexVeLAFkL1ApMIfAx
        2rynKPV79a2rFw8KH5ogl5rpA+fEn1puAEAJ4Tlh2w==
X-Google-Smtp-Source: ABdhPJwm7RORsPVX9EpA+f/rpyV/bm7dA/SQ01EzbzV1yVf+JvmxjuyQHKmWdjTOtYg6usHy7cw6J444+7/JlR3E6Mo=
X-Received: by 2002:a25:6546:0:b0:660:2a80:d6b6 with SMTP id
 z67-20020a256546000000b006602a80d6b6mr42004476ybb.617.1654858588911; Fri, 10
 Jun 2022 03:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv7fESqpGoeKmHoJsst6wfRNMi2wQLGm+PsjbLDuDjdMQ@mail.gmail.com>
 <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com> <YqItYKEIvsw4Yzjx@carbon>
In-Reply-To: <YqItYKEIvsw4Yzjx@carbon>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 10 Jun 2022 16:26:17 +0530
Message-ID: <CA+G9fYuLNjq0hc6T4sZcq7g4YoWgBwa1H7x21otED7QoLaTYXw@mail.gmail.com>
Subject: Re: [next] arm64: boot failed - next-20220606
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vasily Averin <vvs@openvz.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Thu, 9 Jun 2022 at 22:57, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Tue, Jun 07, 2022 at 11:00:39AM +0530, Naresh Kamboju wrote:
> > On Mon, 6 Jun 2022 at 17:16, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > Linux next-20220606 arm64 boot failed. The kernel boot log is empty.
> > > I am bisecting this problem.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > The initial investigation show that,
> > >
> > > GOOD: next-20220603
> > > BAD:  next-20220606
> > >
> > > Boot log:
> > > Starting kernel ...
> >
> > Linux next-20220606 and next-20220607 arm64 boot failed.
> > The kernel panic log showing after earlycon.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Naresh, can you, please, check if the following patch resolves the issue?
> (completely untested except for building)

I have tested this patch on top of next-20220606 and boot successfully [1].

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> --
>
> From 6a454876c9a1886e3cf8e9b66dae19b326f8901a Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <roman.gushchin@linux.dev>
> Date: Thu, 9 Jun 2022 10:03:20 -0700
> Subject: [PATCH] mm: kmem: make mem_cgroup_from_obj() vmalloc()-safe
>
> Currently mem_cgroup_from_obj() is not working properly with objects
> allocated using vmalloc(). It creates problems in some cases, when
> it's called for static objects belonging to  modules or generally
> allocated using vmalloc().
>
> This patch makes mem_cgroup_from_obj() safe to be called on objects
> allocated using vmalloc().
>
> It also introduces mem_cgroup_from_slab_obj(), which is a faster
> version to use in places when we know the object is either a slab
> object or a generic slab page (e.g. when adding an object to a lru
> list).
>
> Suggested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/memcontrol.h |  6 ++++
>  mm/list_lru.c              |  2 +-
>  mm/memcontrol.c            | 71 +++++++++++++++++++++++++++-----------
>  3 files changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0d7584e2f335..4d31ce55b1c0 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1761,6 +1761,7 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
>  }
>
>  struct mem_cgroup *mem_cgroup_from_obj(void *p);
> +struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
>
>  static inline void count_objcg_event(struct obj_cgroup *objcg,
>                                      enum vm_event_item idx)
> @@ -1858,6 +1859,11 @@ static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
>         return NULL;
>  }
>
> +static inline struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
> +{
> +       return NULL;
> +}
> +
>  static inline void count_objcg_event(struct obj_cgroup *objcg,
>                                      enum vm_event_item idx)
>  {
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index ba76428ceece..a05e5bef3b40 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -71,7 +71,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
>         if (!list_lru_memcg_aware(lru))
>                 goto out;
>
> -       memcg = mem_cgroup_from_obj(ptr);
> +       memcg = mem_cgroup_from_slab_obj(ptr);
>         if (!memcg)
>                 goto out;
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4093062c5c9b..8c408d681377 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -783,7 +783,7 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>         struct lruvec *lruvec;
>
>         rcu_read_lock();
> -       memcg = mem_cgroup_from_obj(p);
> +       memcg = mem_cgroup_from_slab_obj(p);
>
>         /*
>          * Untracked pages have no memcg, no lruvec. Update only the
> @@ -2833,27 +2833,9 @@ int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
>         return 0;
>  }
>
> -/*
> - * Returns a pointer to the memory cgroup to which the kernel object is charged.
> - *
> - * A passed kernel object can be a slab object or a generic kernel page, so
> - * different mechanisms for getting the memory cgroup pointer should be used.
> - * In certain cases (e.g. kernel stacks or large kmallocs with SLUB) the caller
> - * can not know for sure how the kernel object is implemented.
> - * mem_cgroup_from_obj() can be safely used in such cases.
> - *
> - * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
> - * cgroup_mutex, etc.
> - */
> -struct mem_cgroup *mem_cgroup_from_obj(void *p)
> +static __always_inline
> +struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
>  {
> -       struct folio *folio;
> -
> -       if (mem_cgroup_disabled())
> -               return NULL;
> -
> -       folio = virt_to_folio(p);
> -
>         /*
>          * Slab objects are accounted individually, not per-page.
>          * Memcg membership data for each individual object is saved in
> @@ -2886,6 +2868,53 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>         return page_memcg_check(folio_page(folio, 0));
>  }
>
> +/*
> + * Returns a pointer to the memory cgroup to which the kernel object is charged.
> + *
> + * A passed kernel object can be a slab object, vmalloc object or a generic
> + * kernel page, so different mechanisms for getting the memory cgroup pointer
> + * should be used.
> + *
> + * In certain cases (e.g. kernel stacks or large kmallocs with SLUB) the caller
> + * can not know for sure how the kernel object is implemented.
> + * mem_cgroup_from_obj() can be safely used in such cases.
> + *
> + * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
> + * cgroup_mutex, etc.
> + */
> +struct mem_cgroup *mem_cgroup_from_obj(void *p)
> +{
> +       struct folio *folio;
> +
> +       if (mem_cgroup_disabled())
> +               return NULL;
> +
> +       if (unlikely(is_vmalloc_addr(p)))
> +               folio = page_folio(vmalloc_to_page(p));
> +       else
> +               folio = virt_to_folio(p);
> +
> +       return mem_cgroup_from_obj_folio(folio, p);
> +}
> +
> +/*
> + * Returns a pointer to the memory cgroup to which the kernel object is charged.
> + * Similar to mem_cgroup_from_obj(), but faster and not suitable for objects,
> + * allocated using vmalloc().
> + *
> + * A passed kernel object must be a slab object or a generic kernel page.
> + *
> + * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
> + * cgroup_mutex, etc.
> + */
> +struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
> +{
> +       if (mem_cgroup_disabled())
> +               return NULL;
> +
> +       return mem_cgroup_from_obj_folio(virt_to_folio(p), p);
> +}
> +
>  static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  {
>         struct obj_cgroup *objcg = NULL;
> --
> 2.35.3

[1] https://lkft.validation.linaro.org/scheduler/job/5156201

--
Linaro LKFT
https://lkft.linaro.org
