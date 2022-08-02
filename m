Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5012587E3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiHBOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiHBOjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:39:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC7A15704
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:39:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y11so22226040lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QZohr85P+ue0277oQoXbNYepoltTriUZ0lDtYLukdEI=;
        b=In4Gth7uTqyX8d4c/jU4A1a3LUb7Ejek3CNoVeJDkIPLGIVyFA2feDxeBeqCcKkDzG
         QmTeQdgEWK4Rg+IiIbsGfuwX9OuyUWP/cVK3vbquhimWiApMpzmkVMXQzjmqjXtSjCvA
         Ry3qAIwPWQJ3g+LYFVPjbFgUjoPlDCzNKHnUgn6Qk4n6eKEU2AKpAe7223gFiU0f1LoP
         X1Uy1YFjytlVYG/zp25sywzbOYG9Hc5/tcCUJB7L4ZkPrzKVTz/N0nJ8sZc7Y6wR10Tb
         V+oKrvLKEmBdduZtEDHdbI372KlaR5EO8xVdo2jxaffZYhoC68r6SX43ZFjSdgkFSHgb
         otMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QZohr85P+ue0277oQoXbNYepoltTriUZ0lDtYLukdEI=;
        b=EWb6ga+e2/XD2EGbKPuLGpmlclbi3BMyr72nztLqSGQ6ET/dsIW0TC/SvzvIKXNYZ9
         eHGI7u7yuzWkkkJEOT3r3AA+nIB4wJgc2Ai5mxFAYi7ezR8/Mrl5Vn1GWGbi9CHOOIm6
         O6gT6lNstPMWFbOA+/9uhP/PzhaSggKFLZfDwPlfUYOgeOAhXX/yaGuLK0dKyrGmlNvM
         sc2pw9jgEL/w5RbS3FTpxFApqJT5geluPAA132w/VhwBra6gDXy4MiWUGX3QlDS5pCcs
         5zLGSPvXFy9RxG5RGTF40h0UskOMfsXBAX3/pR1JMntDNSF/g8zgPVJzx0rbcFUNna+0
         Ew5g==
X-Gm-Message-State: ACgBeo2tU4ifTu/xclO2Em+lo3rZsw+c16hKltFSwep3QLv1Umvkv7um
        5mj/OtoY5Zzwxm4NtlIKZmuxOq37TLsu4QFG4y1rZA==
X-Google-Smtp-Source: AA6agR7GQ0hPXGj/I2EGL6yMSJqOgGm0PgvFkEvxGTPiBXGekS2WzqDBk8olBpXVfvuFq5+b1MoKmw7DxZGbeU64I2I=
X-Received: by 2002:a05:6512:1287:b0:48b:7f3:658 with SMTP id
 u7-20020a056512128700b0048b07f30658mr1547028lfs.417.1659451151874; Tue, 02
 Aug 2022 07:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220727071042.8796-4-feng.tang@intel.com> <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020>
 <YuY6Wc39DbL3YmGi@feng-skl> <Yudw5ge/lJ26Hksk@feng-skl> <0e545088-d140-4c84-bbb2-a3be669740b2@suse.cz>
 <YujKCxu2lJJFm73P@feng-skl> <CACT4Y+Zwg8BP=6WJpQ5cCbJxLu4HcnCjx8e53aDEbTZ5uzpUyg@mail.gmail.com>
 <85ec4ea8-ae4c-3592-5491-3db6d0ad8c59@suse.cz> <CACT4Y+asjzrBu8ogRDt9hYYaAB3tZ2pK5HBkzkuMp106vQwKWQ@mail.gmail.com>
 <YukoZEm4Q6CSEKKj@feng-skl>
In-Reply-To: <YukoZEm4Q6CSEKKj@feng-skl>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 Aug 2022 16:38:59 +0200
Message-ID: <CACT4Y+Y6M5MqSGC0MERFqkxgKYK+LrMYvW5xPH5kUA2mFh5_Xw@mail.gmail.com>
Subject: Re: [mm/slub] 3616799128: BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Sang, Oliver" <oliver.sang@intel.com>, lkp <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022 at 15:37, Feng Tang <feng.tang@intel.com> wrote:
>
> On Tue, Aug 02, 2022 at 06:30:44PM +0800, Dmitry Vyukov wrote:
> > .On Tue, 2 Aug 2022 at 11:43, Vlastimil Babka <vbabka@suse.cz> wrote:
> > >
> > > On 8/2/22 09:06, Dmitry Vyukov wrote:
> > > > On Tue, 2 Aug 2022 at 08:55, Feng Tang <feng.tang@intel.com> wrote:
> > > >>
> > > >> On Mon, Aug 01, 2022 at 10:23:23PM +0800, Vlastimil Babka wrote:
> > > >> > On 8/1/22 08:21, Feng Tang wrote:
> > > >> [snip]
> > > >> > > Cc kansan  mail list.
> > > >> > >
> > > >> > > This is really related with KASAN debug, that in free path, some
> > > >> > > kmalloc redzone ([orig_size+1, object_size]) area is written by
> > > >> > > kasan to save free meta info.
> > > >> > >
> > > >> > > The callstack is:
> > > >> > >
> > > >> > >   kfree
> > > >> > >     slab_free
> > > >> > >       slab_free_freelist_hook
> > > >> > >           slab_free_hook
> > > >> > >             __kasan_slab_free
> > > >> > >               ____kasan_slab_free
> > > >> > >                 kasan_set_free_info
> > > >> > >                   kasan_set_track
> > > >> > >
> > > >> > > And this issue only happens with "kmalloc-16" slab. Kasan has 2
> > > >> > > tracks: alloc_track and free_track, for x86_64 test platform, most
> > > >> > > of the slabs will reserve space for alloc_track, and reuse the
> > > >> > > 'object' area for free_track.  The kasan free_track is 16 bytes
> > > >> > > large, that it will occupy the whole 'kmalloc-16's object area,
> > > >> > > so when kmalloc-redzone is enabled by this patch, the 'overwritten'
> > > >> > > error is triggered.
> > > >> > >
> > > >> > > But it won't hurt other kmalloc slabs, as kasan's free meta won't
> > > >> > > conflict with kmalloc-redzone which stay in the latter part of
> > > >> > > kmalloc area.
> > > >> > >
> > > >> > > So the solution I can think of is:
> > > >> > > * skip the kmalloc-redzone for kmalloc-16 only, or
> > > >> > > * skip kmalloc-redzone if kasan is enabled, or
> > > >> > > * let kasan reserve the free meta (16 bytes) outside of object
> > > >> > >   just like for alloc meta
> > > >> >
> > > >> > Maybe we could add some hack that if both kasan and SLAB_STORE_USER is
> > > >> > enabled, we bump the stored orig_size from <16 to 16? Similar to what
> > > >> > __ksize() does.
> > > >>
> > > >> How about the following patch:
> > > >>
> > > >> ---
> > > >> diff --git a/mm/slub.c b/mm/slub.c
> > > >> index added2653bb0..33bbac2afaef 100644
> > > >> --- a/mm/slub.c
> > > >> +++ b/mm/slub.c
> > > >> @@ -830,6 +830,16 @@ static inline void set_orig_size(struct kmem_cache *s,
> > > >>         if (!slub_debug_orig_size(s))
> > > >>                 return;
> > > >>
> > > >> +#ifdef CONFIG_KASAN
> > > >> +       /*
> > > >> +        * When kasan is enabled, it could save its free meta data in the
> > > >> +        * start part of object area, so skip the kmalloc redzone check
> > > >> +        * for small kmalloc slabs to avoid the data conflict.
> > > >> +        */
> > > >> +       if (s->object_size <= 32)
> > > >> +               orig_size = s->object_size;
> > > >> +#endif
> > > >> +
> > > >>         p += get_info_end(s);
> > > >>         p += sizeof(struct track) * 2;
> > > >>
> > > >> I extend the size to 32 for potential's kasan meta data size increase.
> > > >> This is tested locally, if people are OK with it, I can ask for 0Day's
> > > >> help to verify this.
> > >
> > > Is there maybe some KASAN macro we can use instead of hardcoding 32?
> >
> > kasan_free_meta is placed in the object data after freeing, so it can
> > be sizeof(kasan_free_meta)
>
> 'kasan_free_meta' is defined in mm/kasan/kasan.h, to use it we need to
> include "../kasan/kasan.h" in slub.c, or move its definition to
> "include/linux/kasan.h"
>
> Another idea is to save the info in kasan_info, like:
>
> ---
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b092277bf48d..97e899948d0b 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -100,6 +100,7 @@ static inline bool kasan_has_integrated_init(void)
>  struct kasan_cache {
>         int alloc_meta_offset;
>         int free_meta_offset;
> +       int free_meta_size;

Storing it here looks fine to me.
But I would name it based on the meaning for external users (i.e. that
many bytes are occupied by kasan in freed objects). For some caches
KASAN does not store anything in freed objects at all.



>         bool is_kmalloc;
>  };
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index c40c0e7b3b5f..7bd82c5ec264 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -178,6 +178,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>                 return;
>         }
>
> +       cache->kasan_info.free_meta_size = sizeof(struct free_meta_offset);
> +
>         /*
>          * Add free meta into redzone when it's not possible to store
>          * it in the object. This is the case when:
