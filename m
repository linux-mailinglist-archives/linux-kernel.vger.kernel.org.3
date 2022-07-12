Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95024571EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiGLPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiGLPPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:15:35 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308CC1FDA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:08:43 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c8a1e9e33so84118107b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rVxYUPu70x23v27CqTL6O9oHmdkYH1ZfRmRpfUbyCvM=;
        b=M1QfBgD73UtrxG8I52Nqel8WC41cU8VsHP+DERTznglaNV9+hzcqBS9XvLWDbcieAm
         4VZX66r8ZRGqWEC2kekhDfqkF7bPZYcoCFUEO1kwvYTaYDJ+LHhY3aw1n4PqsJKcQ0z+
         TprxrIl+zKGETCWiXHGvRqDgsnuEzrFPQua72h1g4BdtExXl1+kXoa4Zmy9j6ZLauAIo
         TtBy7i7nDuHV0cPxTh2E0msQAaHQs2jABV7yvAFKuqxECiS+cMflyBphZ7AiHGZhP9Hy
         VfyrQckLldZwo2SjCoR9ropJd4hVuFCgtZFnm6bceC5aqENMz8QeCoK3rXkPqQBhBZC0
         Fppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rVxYUPu70x23v27CqTL6O9oHmdkYH1ZfRmRpfUbyCvM=;
        b=eAf6Jond8h8T4zG4i1jDC4mJKHKymIXDSOlVMJgeOYZ0NZDL7Lpcv/KdaSCOXdq5nc
         3zWSdopjM2eh93x2+jcoJYfNYTSpFNwSF5gdaaY72S+fDaj6fOAyYlAY47bH2DdC/NdT
         ucMxvKDlIeh1IGzi86MXD5P/P0thz2Z/LdiwaFUuzldlZvKvFWreum4NsbAM+XK9kDWc
         RKCOkj+b7ZwI+5Fwr1L0bNaf5CjCrutVhoyF+oO/FKwqhIvju4f5w5Qh1op4PIxU7qrZ
         pa2xvORh+TnwEKryfPTKNlww3OEiX9jsrLu3wcnAAIqzlNt0PLPJXok93Kxs0dcI5jJG
         LuUg==
X-Gm-Message-State: AJIora/YIeVsS35Alyvx7pi8yo5I1pwbz+mtOiDo5iuFjwe5tC6pqmwC
        xBng0d98GqlloysX6cvppWAFSojHApC5uTYlPy0=
X-Google-Smtp-Source: AGRyM1vsi7TFCJDQF776IC08vhKWXr+8INR+vq1yIP+dP9dKvn+DQnHcTs3K+LwrDJAvHIytvKftUylKcjq10HwkOHA=
X-Received: by 2002:a81:4986:0:b0:31d:388b:d08d with SMTP id
 w128-20020a814986000000b0031d388bd08dmr20961683ywa.185.1657638522767; Tue, 12
 Jul 2022 08:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com> <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
 <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com>
 <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com> <CAD4RrFPfwu4Ascj5tdz8qq2Qgnu5GN2eHjVwMW5AqUa1H7JapA@mail.gmail.com>
In-Reply-To: <CAD4RrFPfwu4Ascj5tdz8qq2Qgnu5GN2eHjVwMW5AqUa1H7JapA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 17:08:06 +0200
Message-ID: <CAHp75Vc0s6bFmNWtnVJEowJsDUPO6RnNqPgnYFQmV6A2P0mtYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
To:     Yu-Jen Chang <arthurchang09@gmail.com>
Cc:     Andrey Semashev <andrey.semashev@gmail.com>,
        Andy Shevchenko <andy@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jul 12, 2022 at 4:58 PM Yu-Jen Chang <arthurchang09@gmail.com> wrot=
e:
> Andrey Semashev <andrey.semashev@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A11:00=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On 7/11/22 17:52, Yu-Jen Chang wrote:
> > > Andrey Semashev <andrey.semashev@gmail.com> =E6=96=BC 2022=E5=B9=B47=
=E6=9C=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E5=87=8C=E6=99=A84:01=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > >> On 7/10/22 17:28, Yu-Jen Chang wrote:

...

> > >>> +             for (; p <=3D end - 8; p +=3D 8) {
> > >>> +                     val =3D *(u64 *)p ^ mask;
> > >>
> > >> What if p is not aligned to 8 (or 4 on 32-bit targets) bytes? Not al=
l
> > >> targets support (efficient) unaligned loads, do they?
> > >
> > > I think it works if p is not aligned to 8 or 4 bytes.
> > >
> > > Let's say the string is 10 bytes. The for loop here will search the f=
irst
> > > 8 bytes. If the target character is in the last 2 bytes, the second f=
or
> > > loop will find it. It also work like this on 32-bit machine.
> >
> > I think you're missing the point. Loads at unaligned addresses may not
> > be allowed by hardware using conventional load instructions or may be
> > inefficient. Given that this memchr implementation is used as a fallbac=
k
> > when no hardware-specific version is available, you should be
> > conservative wrt. hardware capabilities and behavior. You should
> > probably have a pre-alignment loop.
>
> Got it. I add  pre-alignment loop. It aligns the address to 8 or 4bytes.

Still far from what can be accepted. Have you had a chance to read how
strscpy() is implemented? Do you understand why it's done that way?

> void *memchr(const void *p, int c, size_t length)
> {
>     u64 mask, val;
>     const void *end =3D p + length;
>     c &=3D 0xff;

>     while ((long ) p & (sizeof(long) - 1)) {
>         if (p >=3D end)
>             return NULL;
>         if (*(unsigned char *)p =3D=3D c)
>             return (void *) p;
>         p++;
>     }
>     if (p <=3D end - 8) {
>         mask =3D c;
>         MEMCHR_MASK_GEN(mask);
>
>         for (; p <=3D end - 8; p +=3D 8) {

Why you decided that this code will be run explicitly on 64-bit arch?

>             val =3D *(u64*)p ^ mask;
>             if ((val + 0xfefefefefefefeffull)
> & (~val & 0x8080808080808080ull))
>                 break;
>         }
>     }
>
>     for (; p < end; p++)
>         if (*(unsigned char *)p =3D=3D c)
>             return (void *)p;
>
>     return NULL;
> }

--=20
With Best Regards,
Andy Shevchenko
