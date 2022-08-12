Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33145590A37
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiHLCVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiHLCVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:21:03 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2375A4B0DF;
        Thu, 11 Aug 2022 19:21:01 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id z8so9614918ile.0;
        Thu, 11 Aug 2022 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=WsUtfkxGdMHgT9/AVgH6Va7YFkzDZH9SitNsfQOEq0s=;
        b=I8ep2pTaIKU+c8m6Yu6bEWeou5ZyQ2VkeSUr9w1lZeALbZuKzkMyUGtWXcr+/6xmrc
         2/AHddrsvq88KsfhAzrV0/zOCkPbJG21uG+NZQucWJ1lNLlDGS30QaKcwO0ZtortIO1r
         ImMXALLl3b4nEHSN8pcsx843DL8G0F5eswFtcBM9tF5n03tvzKVZTvClLmELEDSPCgKZ
         3krn9TgeSIklKKA3gkV/Mqc4BLnZaZ2zR1LpdjX5s4K87o3e09bugFos8ha2uC7XfghD
         NsS6Y2/Zv89tGjghVC891KjzsjMmuqW7wiF+lNGjMevf5KxXn58FuHGL402POr5YxX2o
         lngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=WsUtfkxGdMHgT9/AVgH6Va7YFkzDZH9SitNsfQOEq0s=;
        b=u+T+C8vcHOKE4xzWbphndHqDd7qGFLeQeLu0rm+Y748sN7ImoAZnO57BOoz0xknLAu
         EfQOj1Ew6kutKWYDpa6AuLcE6bLWXnS0km3qKJkoiF/p8EXiQEbtFcwk5yq6tZBa+s6t
         FNIf8eHKkLua7FbsdJPrQmmfgsHNjel7hfRqSNaGTKZxhV1RAAMXLPh2Qlx/R8AUbAYA
         ooU/XScvKKa8H5JbfejUjQXwuYGRj6ZBy66HcHKaNBnhx4r3CvZ9wrHvACUsfLq/Da0G
         sUtD+RLwxUeFImtMc6Y2u22MO2Z+j6QBEmw142RPq4M9xaNaKdB3n+AJ2On4rxr8Kg7l
         /8eg==
X-Gm-Message-State: ACgBeo3jQZznilSzCn6hRPxrmSWhP1qlihXZjdPx6K6ckIh9aiN9dp8p
        8MtxQM9m1MHPpYDWFv14zG9kS5diqa1QSY1vOHyeHKWD
X-Google-Smtp-Source: AA6agR7YZ9/9SJLxiSZzeoeSdPHKCrr3iywx+o0i5rH/62e6/T5w0qrKWLilu+nSFwcTe72q34JEPjqPWtkVWi7JZW8=
X-Received: by 2002:a05:6e02:1645:b0:2df:1f18:3d7f with SMTP id
 v5-20020a056e02164500b002df1f183d7fmr848087ilu.281.1660270859926; Thu, 11 Aug
 2022 19:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220811215204.64911C433D6@smtp.kernel.org>
In-Reply-To: <20220811215204.64911C433D6@smtp.kernel.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 12 Aug 2022 11:20:49 +0900
Message-ID: <CAAmzW4MV4rqZsSkbUO385jiijMnLzW1i7U9DaikL-T4H8Pje=A@mail.gmail.com>
Subject: Re: + filemap-make-the-accounting-of-thrashing-more-consistent.patch
 added to mm-unstable branch
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     mm-commits@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>, corbet@lwn.net,
        cgel.zte@gmail.com, bsingharora@gmail.com, yang.yang29@zte.com.cn,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Yang.

2022=EB=85=84 8=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 7:10, A=
ndrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
>
> The patch titled
>      Subject: filemap: make the accounting of thrashing more consistent
> has been added to the -mm mm-unstable branch.  Its filename is
>      filemap-make-the-accounting-of-thrashing-more-consistent.patch
>
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree=
/patches/filemap-make-the-accounting-of-thrashing-more-consistent.patch
>
> This patch will later appear in the mm-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/process/submit-checklist.rst when testi=
ng your code ***
>
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
>
> ------------------------------------------------------
> From: Yang Yang <yang.yang29@zte.com.cn>
> Subject: filemap: make the accounting of thrashing more consistent
> Date: Fri, 5 Aug 2022 03:38:39 +0000
>
> Once upon a time, we only support accounting thrashing of page cache.
> Then Joonsoo introduced workingset detection for anonymous pages and we
> gained the ability to account thrashing of them[1].
>
> So let delayacct account both the thrashing of page cache and anonymous
> pages, this could make the codes more consistent and simpler.
>
> [1] commit aae466b0052e ("mm/swap: implement workingset detection for ano=
nymous LRU")
>
> Link: https://lkml.kernel.org/r/20220805033838.1714674-1-yang.yang29@zte.=
com.cn
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  Documentation/accounting/delay-accounting.rst |    2 -
>  mm/filemap.c                                  |   18 +++-------------
>  2 files changed, 5 insertions(+), 15 deletions(-)
>
> --- a/Documentation/accounting/delay-accounting.rst~filemap-make-the-acco=
unting-of-thrashing-more-consistent
> +++ a/Documentation/accounting/delay-accounting.rst
> @@ -13,7 +13,7 @@ a) waiting for a CPU (while being runnab
>  b) completion of synchronous block I/O initiated by the task
>  c) swapping in pages
>  d) memory reclaim
> -e) thrashing page cache
> +e) thrashing
>  f) direct compact
>  g) write-protect copy
>
> --- a/mm/filemap.c~filemap-make-the-accounting-of-thrashing-more-consiste=
nt
> +++ a/mm/filemap.c
> @@ -1221,15 +1221,11 @@ static inline int folio_wait_bit_common(
>         struct wait_page_queue wait_page;
>         wait_queue_entry_t *wait =3D &wait_page.wait;
>         bool thrashing =3D false;
> -       bool delayacct =3D false;
>         unsigned long pflags;
>
>         if (bit_nr =3D=3D PG_locked &&
>             !folio_test_uptodate(folio) && folio_test_workingset(folio)) =
{
> -               if (!folio_test_swapbacked(folio)) {
> -                       delayacct_thrashing_start();
> -                       delayacct =3D true;
> -               }
> +               delayacct_thrashing_start();
>                 psi_memstall_enter(&pflags);
>                 thrashing =3D true;
>         }

I think that a better place to measure swap thrashing is swap_readpage().
For some cases, like a zram, swap_readpage() is called directly rather than
loading the page onto the swap cache. Your code would miss that case.

Thanks.
