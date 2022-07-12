Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085DD571D77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiGLO6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiGLO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:58:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3132563EA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:58:44 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h200so8043745iof.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n8VJkx0UohrHUcfROik699gEfwwdc0SDpII8DJF6C8s=;
        b=Oak10QNvZgMB7/UKrDYLWKdMeoxUzqKUF3rSNzKHrqxJ1iS9Sgo1duF4JPHtxMsuZL
         utvW26G04zusV8xskL22aeSChqvVcnzpNfbapVcrXTBO3oMVfm8W4KPiReYoUZynv2uD
         oKhbR8iJh+lKj7Pu5pUeE1FqXCWR+Rt1IYoNZmqryiNw3onhtWc7Tt7UOGgCoouOrPi0
         jGsrVhTa7Kf23vhLbiIp9/EyUxUwsk/sNgQRlkqubrReB4F5sPqEBZKpDDfOcYOSAN21
         BM64FZqhBpZhUe/RvMXRcpr4X9OHFssw56m9LldNto/w1+uxKazQwLA8CAAtM0UL6xgU
         /iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n8VJkx0UohrHUcfROik699gEfwwdc0SDpII8DJF6C8s=;
        b=Mr7DNE4irXc9qe6QcleTcybT76rJarIYxECd7sjnanFWX0s9wNZO18HKarphV+5N0y
         9q+bcXHcG7Q81X6+fZIJfwNked76Jp5aMoGYKVJJNq5jLbjHQ3WQ9VZETiAMyXXL8xeM
         xIQIxeEutjEVGWIrGLqnRbVzvg06wJa55jrVWyArFsmNWHHkGXxVpeHPJyfiBi1oFzWh
         rWyvtT8gMuwaLFu6MJAbw1Tugci0qTshFiX+NXPqQcB+uBLzxlZAtiNHl7SNqf+fNsP3
         LZxP7QA7najV8vZI6nc90zq1Q4MZH5zGXEQyu7N72jFnPFi+TdUHiEX4FOmv+aNvgaZK
         6jjg==
X-Gm-Message-State: AJIora8CqPf4faBDyztmDf9+prbFitHXK2nqFT3atIdvGwX1VIb5T+vG
        U5zqJDJpX1OEvNtlMLtFRuBfLGV6ifG4fDpVLWA=
X-Google-Smtp-Source: AGRyM1u3ECrix1ihvS3lPIRW2TSqVAMmFrHahV+S27hy0ug9xr2n6Xd3HUx6RGShCH+WQqtO5vuAmpP/GG0Fy4KT0IA=
X-Received: by 2002:a05:6602:2b14:b0:67b:8976:2945 with SMTP id
 p20-20020a0566022b1400b0067b89762945mr6442734iov.82.1657637924305; Tue, 12
 Jul 2022 07:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com> <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
 <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com> <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com>
In-Reply-To: <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com>
From:   Yu-Jen Chang <arthurchang09@gmail.com>
Date:   Tue, 12 Jul 2022 22:58:32 +0800
Message-ID: <CAD4RrFPfwu4Ascj5tdz8qq2Qgnu5GN2eHjVwMW5AqUa1H7JapA@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
To:     Andrey Semashev <andrey.semashev@gmail.com>
Cc:     andy@kernel.org, akinobu.mita@gmail.com,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        linux-kernel@vger.kernel.org
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

Andrey Semashev <andrey.semashev@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A11:00=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On 7/11/22 17:52, Yu-Jen Chang wrote:
> > Andrey Semashev <andrey.semashev@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E5=87=8C=E6=99=A84:01=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>
> >> On 7/10/22 17:28, Yu-Jen Chang wrote:
> >>> The original version of memchr() is implemented with the byte-wise
> >>> comparing technique, which does not fully use 64-bits or 32-bits
> >>> registers in CPU. We use word-wide comparing so that 8 characters
> >>> can be compared at the same time on CPU. This code is base on
> >>> David Laight's implementation.
> >>>
> >>> We create two files to measure the performance. The first file
> >>> contains on average 10 characters ahead the target character.
> >>> The second file contains at least 1000 characters ahead the
> >>> target character. Our implementation of =E2=80=9Cmemchr()=E2=80=9D is=
 slightly
> >>> better in the first test and nearly 4x faster than the orginal
> >>> implementation in the second test.
> >>>
> >>> Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
> >>> Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> >>> ---
> >>>  lib/string.c | 28 +++++++++++++++++++++-------
> >>>  1 file changed, 21 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/lib/string.c b/lib/string.c
> >>> index 80469e6c3..8ca965431 100644
> >>> --- a/lib/string.c
> >>> +++ b/lib/string.c
> >>> @@ -905,21 +905,35 @@ EXPORT_SYMBOL(strnstr);
> >>>  #ifndef __HAVE_ARCH_MEMCHR
> >>>  /**
> >>>   * memchr - Find a character in an area of memory.
> >>> - * @s: The memory area
> >>> + * @p: The memory area
> >>>   * @c: The byte to search for
> >>> - * @n: The size of the area.
> >>> + * @length: The size of the area.
> >>>   *
> >>>   * returns the address of the first occurrence of @c, or %NULL
> >>>   * if @c is not found
> >>>   */
> >>> -void *memchr(const void *s, int c, size_t n)
> >>> +void *memchr(const void *p, int c, unsigned long length)
>
> I didn't comment on this initially, but is the change of length type
> intentional? Why?

It is my mistake. I will change the type back to size_t.

>
> >>>  {
> >>> -     const unsigned char *p =3D s;
> >>> -     while (n-- !=3D 0) {
> >>> -             if ((unsigned char)c =3D=3D *p++) {
> >>> -                     return (void *)(p - 1);
> >>> +     u64 mask, val;
> >>> +     const void *end =3D p + length;
> >>> +
> >>> +     c &=3D 0xff;
> >>> +     if (p <=3D end - 8) {
> >>> +             mask =3D c;
> >>> +             MEMCHR_MASK_GEN(mask);
> >>> +
> >>> +             for (; p <=3D end - 8; p +=3D 8) {
> >>> +                     val =3D *(u64 *)p ^ mask;
> >>
> >> What if p is not aligned to 8 (or 4 on 32-bit targets) bytes? Not all
> >> targets support (efficient) unaligned loads, do they?
> >
> > I think it works if p is not aligned to 8 or 4 bytes.
> >
> > Let's say the string is 10 bytes. The for loop here will search the fir=
st
> > 8 bytes. If the target character is in the last 2 bytes, the second for
> > loop will find it. It also work like this on 32-bit machine.
>
> I think you're missing the point. Loads at unaligned addresses may not
> be allowed by hardware using conventional load instructions or may be
> inefficient. Given that this memchr implementation is used as a fallback
> when no hardware-specific version is available, you should be
> conservative wrt. hardware capabilities and behavior. You should
> probably have a pre-alignment loop.

Got it. I add  pre-alignment loop. It aligns the address to 8 or 4bytes.

void *memchr(const void *p, int c, size_t length)
{
    u64 mask, val;
    const void *end =3D p + length;
    c &=3D 0xff;
    while ((long ) p & (sizeof(long) - 1)) {
        if (p >=3D end)
            return NULL;
        if (*(unsigned char *)p =3D=3D c)
            return (void *) p;
        p++;
    }
    if (p <=3D end - 8) {
        mask =3D c;
        MEMCHR_MASK_GEN(mask);

        for (; p <=3D end - 8; p +=3D 8) {
            val =3D *(u64*)p ^ mask;
            if ((val + 0xfefefefefefefeffull)
& (~val & 0x8080808080808080ull))
                break;
        }
    }

    for (; p < end; p++)
        if (*(unsigned char *)p =3D=3D c)
            return (void *)p;

    return NULL;
}

>
> >>
> >>> +                     if ((val + 0xfefefefefefefeffu) &
> >>> +                         (~val & 0x8080808080808080u))
> >>> +                             break;
> >>>               }
> >>>       }
> >>> +
> >>> +     for (; p < end; p++)
> >>> +             if (*(unsigned char *)p =3D=3D c)
> >>> +                     return (void *)p;
> >>> +
> >>>       return NULL;
> >>>  }
> >>>  EXPORT_SYMBOL(memchr);
> >>
>
