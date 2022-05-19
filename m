Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6981052C88E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiESAUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiESAUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:20:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0C2F592
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:20:31 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 11so1528224qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FfSGeGLsTGa/kN0tZZMhQzuZST7aaZkoCseqfn8igks=;
        b=Qoo2GAm1GcS9vr9qvOXmUufnaVX1H7cVYwMNkjhhTlYdOEeWcRpS5J/w2bbRafsAz5
         fOqxGsggoCgmSux73CsRcliZ1CWDoHg/vSPSro39VoUSZlXJO5uvTZ9ZruRzJio1RBL3
         5AUqHVbSehF4mYOZUvbhXiXbWhEKJmhNeUls91eP9TK8/sMeiYNiDdIVaK3fwxjrhTxF
         PZpKR0E9b/ZO4RZzx6kTIeJhYsYwmc8w0Pj+DzsUswk9YaOv8EHevjGeMWe3H0gXTOnx
         N5mj2jrirO5QmOsz1vANmm+8LWnYKZTIAyzTQTywXBkgyEwFMKY6rCvNxWlR6aqEsLM0
         KZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FfSGeGLsTGa/kN0tZZMhQzuZST7aaZkoCseqfn8igks=;
        b=p4S35oaY769eOGq2sYrgo9Gt5MwyN/f0yJyOM7W4uCkptR6fKV16gh1VySea8eh0RA
         Y1SjMUdkR0oIsqVCgKeNOW4R/MyIeKV+Dg82W7YL9lKoddHYHixoq1gkxI+caBBTcfuH
         G2E1gsQjXjBi4ofq2CAl15JjtApOsC2Sq6SxiKZ47rimGSXXrZNnXrbIpg4wZLMyKROr
         ENSL3sL+Fu7XmZgrMYgK0V0oxJT+DoxnpwNGcoKxi8JzPC98QjFYIP/r73InfCuPFIL3
         OJLXrt520BDssmG3BNvyFP0MsCb1IcLDnmXLdLyaoPMNim90Ru9KVkzNCX+319nDa7X4
         y6bw==
X-Gm-Message-State: AOAM530leslbjvsYme+8MiVbyIDVftZRSsrLQWy6qFDlsOA/Vbft6uol
        4/g1VJx5jNNmJ3YelWejaQGmTRzqNUCvEMBimf0=
X-Google-Smtp-Source: ABdhPJxDek2LF7DP9dQwX8JsUtw5IjZ7CSYqmNP1d7EoPpSzK2QvG0oE35HNRG+acwZBCFxDmSTzHlpcQz+HRWeMW0M=
X-Received: by 2002:a05:622a:1746:b0:2f3:e05f:ade6 with SMTP id
 l6-20020a05622a174600b002f3e05fade6mr2001007qtk.479.1652919631137; Wed, 18
 May 2022 17:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4@epcas1p1.samsung.com>
 <20220509074330.4822-1-jaewon31.kim@samsung.com> <20220516173321.67402b7f09eacc43d4e476f4@linux-foundation.org>
 <YoNcBG6kQnmLZ3Z9@linux.ibm.com> <CAJrd-UuzTh-0Ee9+rMRES9onP_EkvJS-VpPP66J4M4n0Ku0ZWA@mail.gmail.com>
 <YoObTJcBUjeW+2l2@linux.ibm.com> <CAJrd-UtYqEMy+Yr9gP0v0dZ3HZ=fCHe67dTRe=5YtLWrbmd1UQ@mail.gmail.com>
 <YoT1LMALyqTUtg6e@linux.ibm.com>
In-Reply-To: <YoT1LMALyqTUtg6e@linux.ibm.com>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Thu, 19 May 2022 09:20:20 +0900
Message-ID: <CAJrd-UuxYyoyWyjd5GTMpCUFrOT_RB=tEPCGTWC71DNC3HDALA@mail.gmail.com>
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

As I said it is v5.10 based kernel.
 ; Actually I am using v5.10 based source tree on an arm64 device.

Thank you
Jaewon Kim

2022=EB=85=84 5=EC=9B=94 18=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:31, =
Mike Rapoport <rppt@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, May 17, 2022 at 10:10:20PM +0900, Jaewon Kim wrote:
> > 64
> > 59
> >
> > 2022=EB=85=84 5=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:5=
5, Mike Rapoport <rppt@linux.ibm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Tue, May 17, 2022 at 08:38:18PM +0900, Jaewon Kim wrote:
> > > > Hello Mike Rapoport
> > > > Thank you for your comment.
> > > >
> > > > Oh really? Could you point out the code or the commit regarding 'al=
l
> > > > struct pages in any section should be valid and
> > > > properly initialized' ?
> > >
> > > There were several commits that refactored the memory map initializat=
ion,
> > > freeing of the unused memory map and abuse of pfn_valid() as a substi=
tute
> > > of "is memory valid" semantics.
> > >
> > > > Actually I am using v5.10 based source tree on an arm64 device.
> > >
> > > Then most probably your change is not relevant for the upstream kerne=
l.
> > > Did you observe any issues with page_ext initialization on v5.18-rcN
> > > kernels?
> >
> > Actually I observed only 59 sections were initialized for page_ext and
> > missed 5 sections.
> > It should be totally 64 sections * 128 MB =3D 8,192 MB
>
> Does this happen with v5.10 based kernel or with v5.18-rcN based kernel?
>
> > > > I tried to look up and found the following commit in v5.16-rc1, did
> > > > you mean this?
> > > > 3de360c3fdb3 arm64/mm: drop HAVE_ARCH_PFN_VALID
> > >
> > > Yes, this is one of those commits.
> > >
> > > > I guess memblock_is_memory code in pfn_valid in arch/arm64/mm/init.=
c, v5.10
> > > > might affect the page_ext_init.
> > >
> > > Yes. In 5.10 the pfn_valid() test in page_ext_init() will skip an ent=
ire
> > > section if the first pfn in that section is not memory that can be ma=
pped
> > > in the linear map.
> > >
> > > But again, this should be fixed in the latest kernels.
> >
> > Great! Thank you for your explanation.
> > I will check it someday later when I use the latest kernel on our devic=
es.
> > The next version on our devices seems to be v5.15 though.
> >
> > Thank you
> > Jaewon Kim
>
> --
> Sincerely yours,
> Mike.
