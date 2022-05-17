Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588855295AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350487AbiEQAB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiEQABX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:01:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4003403C3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:01:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id hh4so13271772qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bwFNpFYZRI4s8sYRdgxEUvvxEJucfpjzv82WDEUnK6U=;
        b=OhrSGSIxaeDgQCl5Fa7khH4ffPvRr+LBU76vP11lvWXAfAwhDOlAIz18UHnX0Q53Rl
         mzugI8fOZUNpjXhXuhdaX58LegHizQWV9ikpReFzq4/lXvribHQJW2krXByHQ67Ppu+K
         xQLcR2RTlPosawHhYxQ5qyXWVCZE3Jls6BYusHIRXvzvvaoB2xzh2npDtHHS4Dp4Bnhm
         r3+DKCNYEVnQPmH3Y7fjqfP9xDMGiYyVpjz7oH86u8r/uvvrUd2QR/mwT2qftkEzJkZx
         oqN2PpUzRSx/Hv6Rt8vOJF5JwQXfjvuV0icn3EI7t8WpycX99l7HbgpWAoREtjaTLvsg
         fyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bwFNpFYZRI4s8sYRdgxEUvvxEJucfpjzv82WDEUnK6U=;
        b=7wN7V8XYPxRlKbyTzXsiDmmCgA6LlUgGiWPwUdVb/XoNAJLuPdUZAST3VfuNUWTG97
         xtojAdknOn6Sh1qxjd6i2TBBpdtK2/iMW1+rCCsdFAJnVluZHWyeWOoDS8YiieR09a70
         WUbtaRLvCvakYnIPx9JnpW4Y9rBmHFLdoo9Mz52Ikpo7YtGLh/CUNKFtiy/QuXxlI4ol
         VhxbMEzd474ODm2JhYSAC33roH5EUCT7GplmUNAFBnQLGvJO9yyo+oOMoNTE4WHHHBab
         IrCEr+gcPlLEhi0TZfqIG2/SAKteJ3XJnoiVOWqPHrQT5wnJvXHWlr8wdP3+M2xkpXch
         KdJw==
X-Gm-Message-State: AOAM530oOM16fM/qw+JbOW14jcft15DBpReBd0sWAgCtS4ff48eLtau2
        K6sEdpZVKtvYjk6ND+LoKhNnBG+n4JB8DGWv2KE=
X-Google-Smtp-Source: ABdhPJzVEABwTV+appVmP953wYlG+AunVSoKlWbSkWciXQ/gFLiD/SSK/t8dBxfpcc1aYIKqEU25vjrrnWvNM00vWrw=
X-Received: by 2002:ac8:5e49:0:b0:2f3:be19:ec08 with SMTP id
 i9-20020ac85e49000000b002f3be19ec08mr17947594qtx.450.1652745681588; Mon, 16
 May 2022 17:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4@epcas1p1.samsung.com>
 <20220509074330.4822-1-jaewon31.kim@samsung.com> <CAJrd-UvRgtox=JD3jMKiUouHO7Jj42_qAfsZv5Rx38TKMdLv1A@mail.gmail.com>
In-Reply-To: <CAJrd-UvRgtox=JD3jMKiUouHO7Jj42_qAfsZv5Rx38TKMdLv1A@mail.gmail.com>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Tue, 17 May 2022 09:01:10 +0900
Message-ID: <CAJrd-UsFTAyh2ifJRErM+yX5ysivHXg9VckLwoo3HeZPBr_iHQ@mail.gmail.com>
Subject: Re: [RFC PATCH] page_ext: create page extension for all memblock
 memory regions
To:     Jaewon Kim <jaewon31.kim@samsung.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

Hello guys, could look into this patch?

2022=EB=85=84 5=EC=9B=94 10=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 9:00, J=
aewon Kim <jaewon31.kim@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> let me add Joonsoo Kim
>
> 2022=EB=85=84 5=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:39, =
Jaewon Kim <jaewon31.kim@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > The page extension can be prepared for each section. But if the first
> > page is not valid, the page extension for the section was not
> > initialized though there were many other valid pages within the section=
.
> >
> > To support the page extension for all sections, refer to memblock memor=
y
> > regions. If the page is valid use the nid from pfn_to_nid, otherwise us=
e
> > the previous nid.
> >
> > Also this pagech changed log to include total sections and a section
> > size.
> >
> > i.e.
> > allocated 100663296 bytes of page_ext for 64 sections (1 section : 0x80=
00000)
> >
> > Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> > ---
> >  mm/page_ext.c | 42 ++++++++++++++++++++++--------------------
> >  1 file changed, 22 insertions(+), 20 deletions(-)
> >
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index 2e66d934d63f..506d58b36a1d 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -381,41 +381,43 @@ static int __meminit page_ext_callback(struct not=
ifier_block *self,
> >  void __init page_ext_init(void)
> >  {
> >         unsigned long pfn;
> > -       int nid;
> > +       int nid =3D 0;
> > +       struct memblock_region *rgn;
> > +       int nr_section =3D 0;
> > +       unsigned long next_section_pfn =3D 0;
> >
> >         if (!invoke_need_callbacks())
> >                 return;
> >
> > -       for_each_node_state(nid, N_MEMORY) {
> > +       /*
> > +        * iterate each memblock memory region and do not skip a sectio=
n having
> > +        * !pfn_valid(pfn)
> > +        */
> > +       for_each_mem_region(rgn) {
> >                 unsigned long start_pfn, end_pfn;
> >
> > -               start_pfn =3D node_start_pfn(nid);
> > -               end_pfn =3D node_end_pfn(nid);
> > -               /*
> > -                * start_pfn and end_pfn may not be aligned to SECTION =
and the
> > -                * page->flags of out of node pages are not initialized=
.  So we
> > -                * scan [start_pfn, the biggest section's pfn < end_pfn=
) here.
> > -                */
> > +               start_pfn =3D (unsigned long)(rgn->base >> PAGE_SHIFT);
> > +               end_pfn =3D start_pfn + (unsigned long)(rgn->size >> PA=
GE_SHIFT);
> > +
> > +               if (start_pfn < next_section_pfn)
> > +                       start_pfn =3D next_section_pfn;
> > +
> >                 for (pfn =3D start_pfn; pfn < end_pfn;
> >                         pfn =3D ALIGN(pfn + 1, PAGES_PER_SECTION)) {
> >
> > -                       if (!pfn_valid(pfn))
> > -                               continue;
> > -                       /*
> > -                        * Nodes's pfns can be overlapping.
> > -                        * We know some arch can have a nodes layout su=
ch as
> > -                        * -------------pfn-------------->
> > -                        * N0 | N1 | N2 | N0 | N1 | N2|....
> > -                        */
> > -                       if (pfn_to_nid(pfn) !=3D nid)
> > -                               continue;
> > +                       if (pfn_valid(pfn))
> > +                               nid =3D pfn_to_nid(pfn);
> > +                       nr_section++;
> >                         if (init_section_page_ext(pfn, nid))
> >                                 goto oom;
> >                         cond_resched();
> >                 }
> > +               next_section_pfn =3D pfn;
> >         }
> > +
> >         hotplug_memory_notifier(page_ext_callback, 0);
> > -       pr_info("allocated %ld bytes of page_ext\n", total_usage);
> > +       pr_info("allocated %ld bytes of page_ext for %d sections (1 sec=
tion : 0x%x)\n",
> > +               total_usage, nr_section, (1 << SECTION_SIZE_BITS));
> >         invoke_init_callbacks();
> >         return;
> >
> > --
> > 2.17.1
> >
