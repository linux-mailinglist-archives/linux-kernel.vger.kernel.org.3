Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E2952A092
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345322AbiEQLig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiEQLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:38:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733D93C723
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:38:30 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a76so14287267qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7MuDWeCSuQazazoHOlGyQ/2mA3OQREOb6rejrGv/uN0=;
        b=Ibizt8bP2vr4awv/7CMn8ECg8FVfXOSzi1w4kXv3P4hNWz1O1Vdo01q9zEbDQdPIFe
         5M+To11ZIJS7qz0JHsIwjel9HgHFvBrbGURMP2e0aa7eAcaavTmRvT6Fxsn8DDCHgWt3
         uUJVUWWIzevGisFFztQRGJllbFXM+qsDxG8fmHwSz4TBxqoPYWtm+j1qXQZbjDsPRHQ3
         vEGB+BZyxBVIo/90VwwEFOesSRBmevHWc/iudfpkpO8rsaLFMnNnxjXIgPzXAwD1pMPY
         HgK/VfgcpAld3UHAJ46U0EZKlDHWWCJPMlkJoY/WGBSD51hI1SoMN/jWek2Z5u7eKGLd
         Yrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7MuDWeCSuQazazoHOlGyQ/2mA3OQREOb6rejrGv/uN0=;
        b=w9w08+/8+ShYUusKWaillcIyVkHIHWheUdFRVECBW4aua4D0NHf29TKoVHYIcZcklK
         J+Nhw+r3lXDn5h3EmeJwse+r88MMeWxOeXUa/Sb/6CwuDTcUqWgIcvK2YFIkBVTboRlG
         IBvtPf/waMStTYb5zl9GUmAOKW0YfO1dWIDWOYtEtL3+qLtW8kYuWcGCy0JRcPFrzAut
         YBIn8u5/FWxf7KgWbSl2tTTVe3PspJgsO1z4OLbqtfYxPodcDVrQUp6aQ2ZjRH5TnXtG
         F3WvwUxfCQbsTbMhuRyCYEuhgjLSBZkz8Xn+By6eAJ2wGdk5yMYxII9Nq7G/swx7bsMR
         0IdQ==
X-Gm-Message-State: AOAM5302GHnzLYdfu1nPbqonczrNbKmab3ZzcGsPrCo0QnZdeWr/hubQ
        MjRgMqqKIHp9ZmXNuFjMSKlQT6w2XSpPiJX5XdE=
X-Google-Smtp-Source: ABdhPJxBxvj35eMYHQ7L3pX1KD3hqz+WaJDdihGkyJGjuExnQMlROHtZFSpN1tEoYTD36zSttWX6o59v7yqU15L7MqI=
X-Received: by 2002:a05:620a:4451:b0:6a0:add:274b with SMTP id
 w17-20020a05620a445100b006a00add274bmr15704030qkp.196.1652787509582; Tue, 17
 May 2022 04:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4@epcas1p1.samsung.com>
 <20220509074330.4822-1-jaewon31.kim@samsung.com> <20220516173321.67402b7f09eacc43d4e476f4@linux-foundation.org>
 <YoNcBG6kQnmLZ3Z9@linux.ibm.com>
In-Reply-To: <YoNcBG6kQnmLZ3Z9@linux.ibm.com>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Tue, 17 May 2022 20:38:18 +0900
Message-ID: <CAJrd-UuzTh-0Ee9+rMRES9onP_EkvJS-VpPP66J4M4n0Ku0ZWA@mail.gmail.com>
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

Hello Mike Rapoport
Thank you for your comment.

Oh really? Could you point out the code or the commit regarding 'all
struct pages in any section should be valid and
properly initialized' ?

Actually I am using v5.10 based source tree on an arm64 device.
I tried to look up and found the following commit in v5.16-rc1, did
you mean this?
3de360c3fdb3 arm64/mm: drop HAVE_ARCH_PFN_VALID

I guess memblock_is_memory code in pfn_valid in arch/arm64/mm/init.c, v5.10
might affect the page_ext_init.

Thank you

2022=EB=85=84 5=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 5:25, M=
ike Rapoport <rppt@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, May 16, 2022 at 05:33:21PM -0700, Andrew Morton wrote:
> > On Mon,  9 May 2022 16:43:30 +0900 Jaewon Kim <jaewon31.kim@samsung.com=
> wrote:
> >
> > > The page extension can be prepared for each section. But if the first
> > > page is not valid, the page extension for the section was not
> > > initialized though there were many other valid pages within the secti=
on.
>
> What do you mean by "first page [in a section] is not valid"?
> In recent kernels all struct pages in any section should be valid and
> properly initialized.
>
> > > To support the page extension for all sections, refer to memblock mem=
ory
> > > regions. If the page is valid use the nid from pfn_to_nid, otherwise =
use
> > > the previous nid.
> > >
> > > Also this pagech changed log to include total sections and a section
> > > size.
> > >
> > > i.e.
> > > allocated 100663296 bytes of page_ext for 64 sections (1 section : 0x=
8000000)
> >
> > Cc Joonsoo, who wrote this code.
> > Cc Mike, for memblock.
> >
> > Thanks.
> >
> > >
> > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > index 2e66d934d63f..506d58b36a1d 100644
> > > --- a/mm/page_ext.c
> > > +++ b/mm/page_ext.c
> > > @@ -381,41 +381,43 @@ static int __meminit page_ext_callback(struct n=
otifier_block *self,
> > >  void __init page_ext_init(void)
> > >  {
> > >     unsigned long pfn;
> > > -   int nid;
> > > +   int nid =3D 0;
> > > +   struct memblock_region *rgn;
> > > +   int nr_section =3D 0;
> > > +   unsigned long next_section_pfn =3D 0;
> > >
> > >     if (!invoke_need_callbacks())
> > >             return;
> > >
> > > -   for_each_node_state(nid, N_MEMORY) {
> > > +   /*
> > > +    * iterate each memblock memory region and do not skip a section =
having
> > > +    * !pfn_valid(pfn)
> > > +    */
> > > +   for_each_mem_region(rgn) {
> > >             unsigned long start_pfn, end_pfn;
> > >
> > > -           start_pfn =3D node_start_pfn(nid);
> > > -           end_pfn =3D node_end_pfn(nid);
> > > -           /*
> > > -            * start_pfn and end_pfn may not be aligned to SECTION an=
d the
> > > -            * page->flags of out of node pages are not initialized. =
 So we
> > > -            * scan [start_pfn, the biggest section's pfn < end_pfn) =
here.
> > > -            */
> > > +           start_pfn =3D (unsigned long)(rgn->base >> PAGE_SHIFT);
> > > +           end_pfn =3D start_pfn + (unsigned long)(rgn->size >> PAGE=
_SHIFT);
> > > +
> > > +           if (start_pfn < next_section_pfn)
> > > +                   start_pfn =3D next_section_pfn;
> > > +
> > >             for (pfn =3D start_pfn; pfn < end_pfn;
> > >                     pfn =3D ALIGN(pfn + 1, PAGES_PER_SECTION)) {
> > >
> > > -                   if (!pfn_valid(pfn))
> > > -                           continue;
> > > -                   /*
> > > -                    * Nodes's pfns can be overlapping.
> > > -                    * We know some arch can have a nodes layout such=
 as
> > > -                    * -------------pfn-------------->
> > > -                    * N0 | N1 | N2 | N0 | N1 | N2|....
> > > -                    */
> > > -                   if (pfn_to_nid(pfn) !=3D nid)
> > > -                           continue;
> > > +                   if (pfn_valid(pfn))
> > > +                           nid =3D pfn_to_nid(pfn);
> > > +                   nr_section++;
> > >                     if (init_section_page_ext(pfn, nid))
> > >                             goto oom;
> > >                     cond_resched();
> > >             }
> > > +           next_section_pfn =3D pfn;
> > >     }
> > > +
> > >     hotplug_memory_notifier(page_ext_callback, 0);
> > > -   pr_info("allocated %ld bytes of page_ext\n", total_usage);
> > > +   pr_info("allocated %ld bytes of page_ext for %d sections (1 secti=
on : 0x%x)\n",
> > > +           total_usage, nr_section, (1 << SECTION_SIZE_BITS));
> > >     invoke_init_callbacks();
> > >     return;
> > >
> > > --
> > > 2.17.1
> > >
>
> --
> Sincerely yours,
> Mike.
