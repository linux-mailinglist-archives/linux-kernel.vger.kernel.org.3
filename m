Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B87352A2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiEQNKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347244AbiEQNKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:10:34 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB0A3527F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:10:33 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id u35so14205228qtc.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gmcEONG9+1ciQ4BCBbXzW8ZQDb+rsVHZqrgwG8DaMVQ=;
        b=YJ0ED44z23pbl+P0XROevtNAm0SqaJo88E/l43ihL8FMAQhguoBMua+P2AaUk8FsXS
         zxfm+aHHe6u+sRwL+RxlSkGYKRgAi9kET9lKDdYsoCCB5ogXqlUSc5BO03OsEJRpukEu
         MqzzaIVr8znWiQV7p0LyOGTIXgrf4+c+dyRpGXYIFGL4+t5ztE0dYrav98i8lHGVnbq0
         5i210eusk5r+5pzembYuRgi1Y6jFkx7LXeXo/L4uMEMPxnMZ7ETQzkEZb6KAmxmy10qi
         2VjbmkgU9V6sqYlnwzk+mD+IFABCj2a1fvNJ+22LmAR6/iwcePsR0mXa6DYUxfXqhOMV
         Dd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gmcEONG9+1ciQ4BCBbXzW8ZQDb+rsVHZqrgwG8DaMVQ=;
        b=hBn9oIRjS1Rg/4fA+fjd07DExPsPI1LAebsxbO510w1U9wSyLzBLUcScDw/182TJTM
         eehHRkrMRHXpd+X6SysaDOaqFILzzLsNhMRxjfZ8CoaQR0W1VXrUoGXZUwqLgj15Z0/i
         NuuWSPTJL2bNsq5gTm4ZkGGYzSDEAeApkTc7LO8Yd7eovcQUemtzQPQIGimwe2dBc4k+
         4Y1Y+WlfkvHSgHyWyS19JeXGiH20tO/2GFasABnx7ODp2d5WPkgrR+ud0y7emH+74Al0
         2wuStc2MavFxP6AYkcYaTV36SK/c8bbOsywFQEj63reUxhZZkt1+WPyUtdYOZpqhWbsY
         rRkQ==
X-Gm-Message-State: AOAM532wyBTwpEjX0ofYDbSGAk6cGFnHQs9LV2+2ETlZ2u03wZJr5wpQ
        gahAc8MD9hDlR9RY/y5Ny3Q9UV15lP+o8AFcLKOE+IuI0u/tpA==
X-Google-Smtp-Source: ABdhPJxW5436ieTpqMAgy8L7fLhNe6yUCi6stTzb+m969x6iSFVNEBg+amjnzNevI6b2UqXe20N9hOQuBoCrx/AAB7Q=
X-Received: by 2002:ac8:4e4f:0:b0:2f8:f64a:ee94 with SMTP id
 e15-20020ac84e4f000000b002f8f64aee94mr6285219qtw.97.1652793031974; Tue, 17
 May 2022 06:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4@epcas1p1.samsung.com>
 <20220509074330.4822-1-jaewon31.kim@samsung.com> <20220516173321.67402b7f09eacc43d4e476f4@linux-foundation.org>
 <YoNcBG6kQnmLZ3Z9@linux.ibm.com> <CAJrd-UuzTh-0Ee9+rMRES9onP_EkvJS-VpPP66J4M4n0Ku0ZWA@mail.gmail.com>
 <YoObTJcBUjeW+2l2@linux.ibm.com>
In-Reply-To: <YoObTJcBUjeW+2l2@linux.ibm.com>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Tue, 17 May 2022 22:10:20 +0900
Message-ID: <CAJrd-UtYqEMy+Yr9gP0v0dZ3HZ=fCHe67dTRe=5YtLWrbmd1UQ@mail.gmail.com>
Subject: Re: [RFC PATCH] page_ext: create page extension for all memblock
 memory regions
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

64
59

2022=EB=85=84 5=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:55, M=
ike Rapoport <rppt@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, May 17, 2022 at 08:38:18PM +0900, Jaewon Kim wrote:
> > Hello Mike Rapoport
> > Thank you for your comment.
> >
> > Oh really? Could you point out the code or the commit regarding 'all
> > struct pages in any section should be valid and
> > properly initialized' ?
>
> There were several commits that refactored the memory map initialization,
> freeing of the unused memory map and abuse of pfn_valid() as a substitute
> of "is memory valid" semantics.
>
> > Actually I am using v5.10 based source tree on an arm64 device.
>
> Then most probably your change is not relevant for the upstream kernel.
> Did you observe any issues with page_ext initialization on v5.18-rcN
> kernels?

Actually I observed only 59 sections were initialized for page_ext and
missed 5 sections.
It should be totally 64 sections * 128 MB =3D 8,192 MB

>
> > I tried to look up and found the following commit in v5.16-rc1, did
> > you mean this?
> > 3de360c3fdb3 arm64/mm: drop HAVE_ARCH_PFN_VALID
>
> Yes, this is one of those commits.
>
> > I guess memblock_is_memory code in pfn_valid in arch/arm64/mm/init.c, v=
5.10
> > might affect the page_ext_init.
>
> Yes. In 5.10 the pfn_valid() test in page_ext_init() will skip an entire
> section if the first pfn in that section is not memory that can be mapped
> in the linear map.
>
> But again, this should be fixed in the latest kernels.

Great! Thank you for your explanation.
I will check it someday later when I use the latest kernel on our devices.
The next version on our devices seems to be v5.15 though.

Thank you
Jaewon Kim

>
> > Thank you
> >
> > 2022=EB=85=84 5=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 5:2=
5, Mike Rapoport <rppt@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Mon, May 16, 2022 at 05:33:21PM -0700, Andrew Morton wrote:
> > > > On Mon,  9 May 2022 16:43:30 +0900 Jaewon Kim <jaewon31.kim@samsung=
.com> wrote:
> > > >
> > > > > The page extension can be prepared for each section. But if the f=
irst
> > > > > page is not valid, the page extension for the section was not
> > > > > initialized though there were many other valid pages within the s=
ection.
> > >
> > > What do you mean by "first page [in a section] is not valid"?
> > > In recent kernels all struct pages in any section should be valid and
> > > properly initialized.
> > >
> > > > > To support the page extension for all sections, refer to memblock=
 memory
> > > > > regions. If the page is valid use the nid from pfn_to_nid, otherw=
ise use
> > > > > the previous nid.
> > > > >
> > > > > Also this pagech changed log to include total sections and a sect=
ion
> > > > > size.
> > > > >
> > > > > i.e.
> > > > > allocated 100663296 bytes of page_ext for 64 sections (1 section =
: 0x8000000)
> > > >
> > > > Cc Joonsoo, who wrote this code.
> > > > Cc Mike, for memblock.
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > > > index 2e66d934d63f..506d58b36a1d 100644
> > > > > --- a/mm/page_ext.c
> > > > > +++ b/mm/page_ext.c
> > > > > @@ -381,41 +381,43 @@ static int __meminit page_ext_callback(stru=
ct notifier_block *self,
> > > > >  void __init page_ext_init(void)
> > > > >  {
> > > > >     unsigned long pfn;
> > > > > -   int nid;
> > > > > +   int nid =3D 0;
> > > > > +   struct memblock_region *rgn;
> > > > > +   int nr_section =3D 0;
> > > > > +   unsigned long next_section_pfn =3D 0;
> > > > >
> > > > >     if (!invoke_need_callbacks())
> > > > >             return;
> > > > >
> > > > > -   for_each_node_state(nid, N_MEMORY) {
> > > > > +   /*
> > > > > +    * iterate each memblock memory region and do not skip a sect=
ion having
> > > > > +    * !pfn_valid(pfn)
> > > > > +    */
> > > > > +   for_each_mem_region(rgn) {
> > > > >             unsigned long start_pfn, end_pfn;
> > > > >
> > > > > -           start_pfn =3D node_start_pfn(nid);
> > > > > -           end_pfn =3D node_end_pfn(nid);
> > > > > -           /*
> > > > > -            * start_pfn and end_pfn may not be aligned to SECTIO=
N and the
> > > > > -            * page->flags of out of node pages are not initializ=
ed.  So we
> > > > > -            * scan [start_pfn, the biggest section's pfn < end_p=
fn) here.
> > > > > -            */
> > > > > +           start_pfn =3D (unsigned long)(rgn->base >> PAGE_SHIFT=
);
> > > > > +           end_pfn =3D start_pfn + (unsigned long)(rgn->size >> =
PAGE_SHIFT);
> > > > > +
> > > > > +           if (start_pfn < next_section_pfn)
> > > > > +                   start_pfn =3D next_section_pfn;
> > > > > +
> > > > >             for (pfn =3D start_pfn; pfn < end_pfn;
> > > > >                     pfn =3D ALIGN(pfn + 1, PAGES_PER_SECTION)) {
> > > > >
> > > > > -                   if (!pfn_valid(pfn))
> > > > > -                           continue;
> > > > > -                   /*
> > > > > -                    * Nodes's pfns can be overlapping.
> > > > > -                    * We know some arch can have a nodes layout =
such as
> > > > > -                    * -------------pfn-------------->
> > > > > -                    * N0 | N1 | N2 | N0 | N1 | N2|....
> > > > > -                    */
> > > > > -                   if (pfn_to_nid(pfn) !=3D nid)
> > > > > -                           continue;
> > > > > +                   if (pfn_valid(pfn))
> > > > > +                           nid =3D pfn_to_nid(pfn);
> > > > > +                   nr_section++;
> > > > >                     if (init_section_page_ext(pfn, nid))
> > > > >                             goto oom;
> > > > >                     cond_resched();
> > > > >             }
> > > > > +           next_section_pfn =3D pfn;
> > > > >     }
> > > > > +
> > > > >     hotplug_memory_notifier(page_ext_callback, 0);
> > > > > -   pr_info("allocated %ld bytes of page_ext\n", total_usage);
> > > > > +   pr_info("allocated %ld bytes of page_ext for %d sections (1 s=
ection : 0x%x)\n",
> > > > > +           total_usage, nr_section, (1 << SECTION_SIZE_BITS));
> > > > >     invoke_init_callbacks();
> > > > >     return;
> > > > >
> > > > > --
> > > > > 2.17.1
> > > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>
> --
> Sincerely yours,
> Mike.

2022=EB=85=84 5=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:55, M=
ike Rapoport <rppt@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, May 17, 2022 at 08:38:18PM +0900, Jaewon Kim wrote:
> > Hello Mike Rapoport
> > Thank you for your comment.
> >
> > Oh really? Could you point out the code or the commit regarding 'all
> > struct pages in any section should be valid and
> > properly initialized' ?
>
> There were several commits that refactored the memory map initialization,
> freeing of the unused memory map and abuse of pfn_valid() as a substitute
> of "is memory valid" semantics.
>
> > Actually I am using v5.10 based source tree on an arm64 device.
>
> Then most probably your change is not relevant for the upstream kernel.
> Did you observe any issues with page_ext initialization on v5.18-rcN
> kernels?
>
> > I tried to look up and found the following commit in v5.16-rc1, did
> > you mean this?
> > 3de360c3fdb3 arm64/mm: drop HAVE_ARCH_PFN_VALID
>
> Yes, this is one of those commits.
>
> > I guess memblock_is_memory code in pfn_valid in arch/arm64/mm/init.c, v=
5.10
> > might affect the page_ext_init.
>
> Yes. In 5.10 the pfn_valid() test in page_ext_init() will skip an entire
> section if the first pfn in that section is not memory that can be mapped
> in the linear map.
>
> But again, this should be fixed in the latest kernels.
>
> > Thank you
> >
> > 2022=EB=85=84 5=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 5:2=
5, Mike Rapoport <rppt@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Mon, May 16, 2022 at 05:33:21PM -0700, Andrew Morton wrote:
> > > > On Mon,  9 May 2022 16:43:30 +0900 Jaewon Kim <jaewon31.kim@samsung=
.com> wrote:
> > > >
> > > > > The page extension can be prepared for each section. But if the f=
irst
> > > > > page is not valid, the page extension for the section was not
> > > > > initialized though there were many other valid pages within the s=
ection.
> > >
> > > What do you mean by "first page [in a section] is not valid"?
> > > In recent kernels all struct pages in any section should be valid and
> > > properly initialized.
> > >
> > > > > To support the page extension for all sections, refer to memblock=
 memory
> > > > > regions. If the page is valid use the nid from pfn_to_nid, otherw=
ise use
> > > > > the previous nid.
> > > > >
> > > > > Also this pagech changed log to include total sections and a sect=
ion
> > > > > size.
> > > > >
> > > > > i.e.
> > > > > allocated 100663296 bytes of page_ext for 64 sections (1 section =
: 0x8000000)
> > > >
> > > > Cc Joonsoo, who wrote this code.
> > > > Cc Mike, for memblock.
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > > > index 2e66d934d63f..506d58b36a1d 100644
> > > > > --- a/mm/page_ext.c
> > > > > +++ b/mm/page_ext.c
> > > > > @@ -381,41 +381,43 @@ static int __meminit page_ext_callback(stru=
ct notifier_block *self,
> > > > >  void __init page_ext_init(void)
> > > > >  {
> > > > >     unsigned long pfn;
> > > > > -   int nid;
> > > > > +   int nid =3D 0;
> > > > > +   struct memblock_region *rgn;
> > > > > +   int nr_section =3D 0;
> > > > > +   unsigned long next_section_pfn =3D 0;
> > > > >
> > > > >     if (!invoke_need_callbacks())
> > > > >             return;
> > > > >
> > > > > -   for_each_node_state(nid, N_MEMORY) {
> > > > > +   /*
> > > > > +    * iterate each memblock memory region and do not skip a sect=
ion having
> > > > > +    * !pfn_valid(pfn)
> > > > > +    */
> > > > > +   for_each_mem_region(rgn) {
> > > > >             unsigned long start_pfn, end_pfn;
> > > > >
> > > > > -           start_pfn =3D node_start_pfn(nid);
> > > > > -           end_pfn =3D node_end_pfn(nid);
> > > > > -           /*
> > > > > -            * start_pfn and end_pfn may not be aligned to SECTIO=
N and the
> > > > > -            * page->flags of out of node pages are not initializ=
ed.  So we
> > > > > -            * scan [start_pfn, the biggest section's pfn < end_p=
fn) here.
> > > > > -            */
> > > > > +           start_pfn =3D (unsigned long)(rgn->base >> PAGE_SHIFT=
);
> > > > > +           end_pfn =3D start_pfn + (unsigned long)(rgn->size >> =
PAGE_SHIFT);
> > > > > +
> > > > > +           if (start_pfn < next_section_pfn)
> > > > > +                   start_pfn =3D next_section_pfn;
> > > > > +
> > > > >             for (pfn =3D start_pfn; pfn < end_pfn;
> > > > >                     pfn =3D ALIGN(pfn + 1, PAGES_PER_SECTION)) {
> > > > >
> > > > > -                   if (!pfn_valid(pfn))
> > > > > -                           continue;
> > > > > -                   /*
> > > > > -                    * Nodes's pfns can be overlapping.
> > > > > -                    * We know some arch can have a nodes layout =
such as
> > > > > -                    * -------------pfn-------------->
> > > > > -                    * N0 | N1 | N2 | N0 | N1 | N2|....
> > > > > -                    */
> > > > > -                   if (pfn_to_nid(pfn) !=3D nid)
> > > > > -                           continue;
> > > > > +                   if (pfn_valid(pfn))
> > > > > +                           nid =3D pfn_to_nid(pfn);
> > > > > +                   nr_section++;
> > > > >                     if (init_section_page_ext(pfn, nid))
> > > > >                             goto oom;
> > > > >                     cond_resched();
> > > > >             }
> > > > > +           next_section_pfn =3D pfn;
> > > > >     }
> > > > > +
> > > > >     hotplug_memory_notifier(page_ext_callback, 0);
> > > > > -   pr_info("allocated %ld bytes of page_ext\n", total_usage);
> > > > > +   pr_info("allocated %ld bytes of page_ext for %d sections (1 s=
ection : 0x%x)\n",
> > > > > +           total_usage, nr_section, (1 << SECTION_SIZE_BITS));
> > > > >     invoke_init_callbacks();
> > > > >     return;
> > > > >
> > > > > --
> > > > > 2.17.1
> > > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>
> --
> Sincerely yours,
> Mike.
