Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD94F5852FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiG2Pmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiG2Pmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:42:40 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D0B12630
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:42:39 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id x64so3911969iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kCTGfje1fJFas/OSSYXwzmU0ryvoidhQVfjEFPox9Ks=;
        b=ViQu1D6Alet57Klf1pnQODk6w+nk6A6UOWOa0n0pTLBT+o40SmdgMGR5hBKGKOazTF
         u0MQ3MqZ4beySNi1J5INcBTRL+a3SUCGtLvWwxWV/599Z0DMW7SDY5y1XxKDc1Pjjcqe
         SyyNogI31VXYNM6TJ67+vZN/8MPclQBDX1jYKA0G0XKm9E7Qzs9QCTgvXeasxflnblBo
         Lh98h+ZcF1Pit42pD4F/XtcGJsE/VA6saPgDHsUj02bP6vb4E+hQ7Xc+ixCB/6iulfLW
         IiSbltYoaP2S2AU+rfl6Nby+SM7Lu+3oRJuA1AcC1PARWE0BSj4EUFT0//4dKf32ASRk
         QDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kCTGfje1fJFas/OSSYXwzmU0ryvoidhQVfjEFPox9Ks=;
        b=3PEygDUt/auf02FwdUgY7jet+0Avya5IJ6Qi4RERaGv8Njsztw1u3n6llMrDX0C/w2
         kaaFO9FCrhl5JD2yYppZh7zX6b/ZzPpcJgzsES/m2QGZRWIJxM7/pMkLRjH5Ws9VETkx
         IE96wVb4e0IsaceEKk90b6Xl1smAipGkYfVmoUKa+ElfA0cXi92H1FAi6m8UTXkDsmMS
         SmsfmDamsGO232xjq28NmkgN/7ekHmL2XQfTUvth+raVupjVN1gRky8iXXcRbrVF+0jA
         vFFgbVnJLnRVnE/9L9DBiku7CfO0yUODk7fRnJ4EfWybyObqwjzzzlP6zXloRzUdR4D8
         Lg8w==
X-Gm-Message-State: AJIora+RCKbdxPajzI0My/h56JBPM1cPoeua0iEPTNPd0xcQ4tboNqKu
        /7MqEwYYKGnVLWojt1VK85v8HYlptT1X/WM7ddI=
X-Google-Smtp-Source: AGRyM1tYfNcVD4xTeCVdmESPh7t63rEToOj8EtFi0wf56LpVEpg+9hzou6HYU5FQr8g6XPYoFkzJKT681t8I9sc8F/U=
X-Received: by 2002:a6b:3ec2:0:b0:67c:6baf:a51f with SMTP id
 l185-20020a6b3ec2000000b0067c6bafa51fmr1409868ioa.160.1659109358821; Fri, 29
 Jul 2022 08:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com> <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
 <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com>
 <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com> <CAD4RrFPfwu4Ascj5tdz8qq2Qgnu5GN2eHjVwMW5AqUa1H7JapA@mail.gmail.com>
 <49a8be9269ee47de9fc2d0d7f09eb0b1@AcuMS.aculab.com> <5d14cf64-46b7-dc37-bbb8-dd6be82d06af@gmail.com>
 <999057a9-d209-323b-90eb-5756b7c0e91e@gmail.com> <658586b208ea4339b3ead19378484434@AcuMS.aculab.com>
 <CAD4RrFPeX=HaB9R3MmJgg0BqvPJKVjroMxEpjkS_8eaYe7rUJg@mail.gmail.com> <CAHp75Vfy6wYqzT-T9aEjVEAQCZ_k=0qN8S8OwG3knbrC-oOkMQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfy6wYqzT-T9aEjVEAQCZ_k=0qN8S8OwG3knbrC-oOkMQ@mail.gmail.com>
From:   Yu-Jen Chang <arthurchang09@gmail.com>
Date:   Fri, 29 Jul 2022 23:42:28 +0800
Message-ID: <CAD4RrFMMZ1ysZoTjhp-fqFAxnbOWZkfVeELp8PCm7muw1JVtsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "andy@kernel.org" <andy@kernel.org>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 12:56 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Friday, July 22, 2022, Yu-Jen Chang <arthurchang09@gmail.com> wrote:
>>
>> On Wed, Jul 13, 2022 at 6:24 PM David Laight <David.Laight@aculab.com> w=
rote:
>> >
>> > From: Andrey Semashev
>> > > Sent: 13 July 2022 11:03
>> > >
>> > > On 7/13/22 12:49, Andrey Semashev wrote:
>> > > > On 7/13/22 12:39, David Laight wrote:
>> > > >> From: Yu-Jen Chang
>> > > >>> Sent: 12 July 2022 15:59
>> > > >> ...
>> > > >>>> I think you're missing the point. Loads at unaligned addresses =
may not
>> > > >>>> be allowed by hardware using conventional load instructions or =
may be
>> > > >>>> inefficient. Given that this memchr implementation is used as a=
 fallback
>> > > >>>> when no hardware-specific version is available, you should be
>> > > >>>> conservative wrt. hardware capabilities and behavior. You shoul=
d
>> > > >>>> probably have a pre-alignment loop.
>> > > >>>
>> > > >>> Got it. I add  pre-alignment loop. It aligns the address to 8 or=
 4bytes.
>> > > >>
>> > > >> That should be predicated on !HAS_EFFICIENT_UNALIGNED_ACCESS.
>> > > >>
>> > > >> ...
>> > > >>>         for (; p <=3D end - 8; p +=3D 8) {
>> > > >>>             val =3D *(u64*)p ^ mask;
>> > > >>>             if ((val + 0xfefefefefefefeffull)
>> > > >>> & (~val & 0x8080808080808080ull))
>> > > >>>                 break;
>> > > >>
>> > > >> I would add a couple of comments, like:
>> > > >>    // Convert to check for zero byte.
>> > > >>    // Standard check for a zero byte in a word.
>> > > >> (But not the big 4 line explanation you had.
>> > > >>
>> > > >> It is also worth looking at how that code compiles
>> > > >> on 32bit arch that don't have a carry flag.
>> > > >> That is everything based on MIPS, including riscv.
>> > > >
>> > > > It may be worth looking at how glibc does it:
>> > > >
>> > > >
>> > > https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dstring/memchr=
.c;h=3D422bcd0cd646ea46711a57fa3cbdb8a3329
>> > > fc302;hb=3Drefs/heads/release/2.35/master#l46
>> > > >
>> > > > They do use 32-bit words on 32-bit targets and 64-bit on 64-bit on=
es. I
>> > > > think memchr in the kernel should follow this.
>> > >
>> > > Also, if by chance this optimization is aimed for x86-64, it may be
>> > > worth adding an arch-specific version that uses ERMS.
>> >
>> > Don't believe everything you see in glibc.
>> > The common cases in the kernel are different from the ones they
>> > tend to optimise for..
>> >
>> > You might try using:
>> >         #define GEN_MASK(x) (x * (unsigned long)0x0101010101010101ull)
>> > for the mask and the two constants.
>> > Then make all the variables 'long'.
>> >
>> > I'm not at all sure what the test for fast multiply is about.
>> > It may be very historic, for modern cpu generating the 64bit
>> > constant is likely to be more problematic (check arm64).
>> > If the input value is 'unsigned char' (or masked) then the
>> > compiler may decide to do the repeated <<=3D itself.
>> >
>> >         David
>> >
>> > -
>> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, =
MK1 1PT, UK
>> > Registration No: 1397386 (Wales)
>>
>>
>> I have rewrite my code as the following. I use several macros
>
>
>
>  My gosh, have you checked what strscpy() does under the hood?
>
> Why can=E2=80=99t you just reuse parts of it?
>
>>
>> to
>> generate the mask and detect target char for 32-bit or 64-bit.
>> The  DETECT_CHAR macro is the same as this part:
>>
>> (val + 0xfefefefefefefeffull) & (~val & 0x8080808080808080ull)
>>
>> The 0xfefefefefefefeffull is the 2's complement of  0x0101010101010101UL=
L.
>> I perform subtraction here exactly.
>>
>> If the CPU architecture is unable to perform unaligned access
>> efficiently, the pre-alignment loop will align the string at first.
>>
>>
>> #define LBLOCKSIZE (sizeof(long))
>> #if BITS_PER_LONG =3D=3D 64
>>
>> #define DETECT_CHAR(X)                                                  =
       \
>> (((X) - 0x0101010101010101ULL) & ~(X) & 0x8080808080808080ULL)
>>
>> #define MEMCHR_MASK_GEN(mask)                                           =
       \
>> do {                                                                   \
>>     (mask) |=3D (mask) << 8;                                         \
>>     (mask) |=3D (mask) << 16;                                        \
>>     (mask) |=3D (mask) << 32;                                        \
>> } while (0)
>>
>> #else
>>
>> #define DETECT_CHAR(X) (((X)-0x01010101UL) & ~(X)&0x80808080UL)
>>
>> #define MEMCHR_MASK_GEN(mask)                                           =
       \
>> do {                                                                   \
>>     (mask) |=3D (mask) << 8;                                         \
>>     (mask) |=3D (mask) << 16;                                        \
>> } while (0)
>>
>> #endif
>>
>> void *memchr(const void *p, int c, size_t length)
>> {
>>     unsigned long mask, val;
>>     const void *end =3D p + length;
>>     c &=3D 0xff;
>> #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>>     while ((long)p & (sizeof(long) - 1)) {
>>         if (p >=3D end)
>>             return NULL;
>>         if (*(unsigned char *)p =3D=3D c)
>>             return (void *)p;
>>         p++;
>>     }
>> #endif
>>     if (p <=3D end - LBLOCKSIZE) {
>>         mask =3D c;
>>         MEMCHR_MASK_GEN(mask);
>>
>>        for (; p <=3D end - LBLOCKSIZE; p +=3D LBLOCKSIZE) {
>>               val =3D *(unsigned long *)p ^ mask;
>>               if (DETECT_CHAR(val))
>>                   break;
>>        }
>>     }
>>
>>     for (; p < end; p++)
>>        if (*(unsigned char *)p =3D=3D c)
>>            return (void *)p;
>>
>>     return NULL;
>> }
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

I reuse some parts of the strscpy and use "read_word_at_a_time"
to read strings and "has_zero" to find if the address of the target char
is in the current word.

Yu-Jen Chang


#if BITS_PER_LONG =3D=3D 64

#define MEMCHR_MASK_GEN(mask)                                              =
    \
    do {                                                                   =
\
        (mask) |=3D (mask) << 8;                                         \
        (mask) |=3D (mask) << 16;                                        \
        (mask) |=3D (mask) << 32;                                        \
    } while (0)

#else

#define MEMCHR_MASK_GEN(mask)                                              =
    \
    do {                                                                   =
\
        (mask) |=3D (mask) << 8;                                         \
        (mask) |=3D (mask) << 16;                                        \
    } while (0)

#endif

void *memchr(const void *p, int c, size_t length)
{
    unsigned long mask;
    unsigned char *src =3D (unsigned char *) p;
    const void *end =3D p + length;
    const struct word_at_a_time constants =3D WORD_AT_A_TIME_CONSTANTS;
    size_t max =3D length;
    c &=3D 0xff;

    #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
/*
* If src is unaligned, don't cross a page boundary,
* since we don't know if the next page is mapped.
*/
    if ((long)p & (sizeof(long) - 1)) {
        size_t limit =3D PAGE_SIZE - ((long)src & (PAGE_SIZE - 1));

        if (limit < max)
            max =3D limit;
    }

    #else
        /* If src is unaligned, don't do word-at-a-time. */
        if (((long) p) & (sizeof(long) - 1))
            max =3D 0;
    #endif
    mask =3D c;
    MEMCHR_MASK_GEN(mask);
    for ( ; max >=3D sizeof(unsigned long); max -=3D sizeof(unsigned
long), src +=3D sizeof(unsigned long)) {
        unsigned long data, result;
        data =3D read_word_at_a_time(src);
        data =3D data ^ mask;
        if (has_zero(data, &result, &constants))
            break;

    }

    for (; src < end; src++)
        if (*src =3D=3D c)
            return (void *)src;

    return NULL;
}
