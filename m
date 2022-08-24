Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C8259F4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiHXIK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiHXIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:10:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D33E857C7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:10:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bf22so16296735pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=9/eyKaPfuteIwHEnAMNI1rBDayjT1OLnm5QHb0/XnpM=;
        b=cPxFHkHRNoi1QBAXIZO2yurpDn3w+3l34l7pBPurq8rCROhaUjmamifjcijzDGua/m
         YRIcg6wAzqTPTsp320ufVQc0Kb8NnQtL8yx25moUm5SswdFzVU9kYjWoc5jiCIF3uM2r
         3DyVOi1J8LAaxEvuVcahNa7DE7YdictCKevdI2TcRCvNDOUrIbX47U+KCKlVtPTWh9X6
         F6N3hXERQBk9dAvoiTRiFLR02mSYLOKIvrv9rnQst77WFHPvwKGYFm7utnSPnackgNwb
         LmYnZiPxuBIGZVPiSGBTcZINkXsugVVl2OktUjldWgZtHgmsxdOzfAyVEOkEYQRcr6GR
         ZcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=9/eyKaPfuteIwHEnAMNI1rBDayjT1OLnm5QHb0/XnpM=;
        b=SIG0cpZPpxljk1OhdxYk9iecKv1N5JJ2bEB/qVVfRyR3Ngi1f2Gpf7ASAYvrg8nSXs
         GwwJrxzpBz56Wsknu4zFQoO/MUCumIDXuJuAXzbAbanFKqzjKYWx4zmoyfNkRxyZRqEd
         WtcuPEGwNCsgNt8N1bq+cP6GjQ79ClmuxLd5QSSxu5yQ6gngg9HsJaNO2VZNtVOPhkZZ
         lEJ2AyIj0lR2a3FAxJo1w0wCk5hYOpyhRK7Ia+aBJvclsyx1hTDjJETogTZWjFPKcBHg
         YjoWL40OCLHJ/SgkjNuR89TYYgMcH/a0/T25SNRpKJGmpNS8u4NXqIPf0nP9XmXZccxe
         yJcQ==
X-Gm-Message-State: ACgBeo1WjbyRuq9J9qHEuN83QeRJqoCs6KuZBPveMnK0QxjEaNg1Ct1I
        yc7sCwkxuYykQHMw5H6bs0TqWPkg0XHquDn1oW4=
X-Google-Smtp-Source: AA6agR7mOlL6iWB+csFRao6aJppvPwxrM+PSC03oib3/MwvPJvTec2P0Wk4/CsnZda2KXSiwddkoqNaUXpxd2g1w8jk=
X-Received: by 2002:a17:90b:4a05:b0:1f5:62d5:4155 with SMTP id
 kk5-20020a17090b4a0500b001f562d54155mr7417749pjb.6.1661328623952; Wed, 24 Aug
 2022 01:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220824055637.10676-1-zhouzhouyi@gmail.com> <8d8bfc81-b584-20f4-65ae-d626f019cdf4@csgroup.eu>
 <CAABZP2w7jw4OHXPDANNabaD1L1BbUG8ymu9zLGEt5xA8YgZ3ow@mail.gmail.com> <66f0770d-83ee-34cb-2dea-b8d957613c7f@csgroup.eu>
In-Reply-To: <66f0770d-83ee-34cb-2dea-b8d957613c7f@csgroup.eu>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 24 Aug 2022 16:10:12 +0800
Message-ID: <CAABZP2ybddBG1KVTemcg4PvHsObVfP7Z+UMUkMCpZSBjBwFKbg@mail.gmail.com>
Subject: Re: [PATCH linux-next] mm: fix used but uninitialized variable
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
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

On Wed, Aug 24, 2022 at 2:49 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 24/08/2022 =C3=A0 08:41, Zhouyi Zhou a =C3=A9crit :
> > Thank Christophe for reviewing my patch
> >
> > On Wed, Aug 24, 2022 at 2:10 PM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >>
> >>
> >> Le 24/08/2022 =C3=A0 07:56, Zhouyi Zhou a =C3=A9crit :
> >>> In function walk_hugetlb_range, the local variable err may
> >>> be used uninitialzed when:
> >>> ops->pte_hole in side of "else if (ops->pte_hole)" is false.
> >>>
> >>> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >>> ---
> >>> Dear mm Developers:
> >>>
> >>> When I build kernel using "make CC=3Dclang-14"
> >>> the compiler complains following:
> >>>
> >>> CC      mm/pagewalk.o
> >>> mm/pagewalk.c:318:12: error: variable 'err' is used uninitialized whe=
never 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> >>>                   else if (ops->pte_hole)
> >>>                            ^~~~~~~~~~~~~
> >>> mm/pagewalk.c:321:7: note: uninitialized use occurs here
> >>>                   if (err)
> >>>                       ^~~
> >>> mm/pagewalk.c:318:8: note: remove the 'if' if its condition is always=
 true
> >>>                   else if (ops->pte_hole)
> >>>                        ^~~~~~~~~~~~~~~~~~
> >>> mm/pagewalk.c:311:10: note: initialize the variable 'err' to silence =
this warning
> >>>                   int err;
> >>>                          ^
> >>>                           =3D 0
> >>> 1 error generated.
> >>> make[1]: *** [scripts/Makefile.build:250: mm/pagewalk.o] Error 1
> >>> make: *** [Makefile:2006: mm] Error 2
> >>>
> >>> I initialize that variable outside of the for loop because we can ass=
ign 0 to err
> >>> only once in this function.
> >>>
> >>> After my fix, I can compile the kernel.
> >>>
> >>> Many Thanks
> >>> Zhouyi
> >>> --
> >>>    mm/pagewalk.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> >>> index 54b2a1beeeb3..b6eb330e8ecd 100644
> >>> --- a/mm/pagewalk.c
> >>> +++ b/mm/pagewalk.c
> >>> @@ -306,9 +306,9 @@ static int walk_hugetlb_range(unsigned long addr,=
 unsigned long end,
> >>>        unsigned long hmask =3D huge_page_mask(h);
> >>>        unsigned long sz =3D huge_page_size(h);
> >>>        const struct mm_walk_ops *ops =3D walk->ops;
> >>> +     int err =3D 0;
> >>
> >> Why do you move it back outside of the for loop allthough it is
> >> exclusively used inside the loop ?
> > I move it outside of the for loop for performance consideration. Becaus=
e
> > if we initialize err inside, there will be an assignment statement
> > every iteration.
>
> I think GCC is smart enough to do the assignment only when necessary,
> maybe have a look at the generated assembly in order to confirm.
Thank Christophe for your guidance, I disassembled the GCC generated
code, it optimized away int err =3D 0 on both X86 and PowerPC platforms.
The disassembled instructions are quite long, so I prefer not to paste
in my email unless someone asks me to do so ;-)
>
> >>
> >>>
> >>>        for (; addr < end; addr =3D next) {
> >>> -             int err;
> >>
> >> Another solution would be to add an explicit else, setting err =3D 0 i=
n
> >> the if/else if sequence.
> > Thank Christophe for your valuable advice, I am going to prepare a 2nd =
version
>
Thank Christophe for your reminder, I only subscribed to the RCU
mailing list currently, so I submitted duplicated work.  I should be
more devoted to the Linux community. I am sorry.
> Don't spend too much time on that, there are already other people
> looking at it, see
> https://lore.kernel.org/linux-mm/20220823153055.2517764-1-nathan@kernel.o=
rg/T/
>
> >
> > Thanks
> > Zhouyi
Many thanks
Zhouyi
> >>
> >>>                pte_t *pte =3D huge_pte_offset(walk->mm, addr & hmask,=
 sz);
> >>>
> >>>                next =3D hugetlb_entry_end(h, addr, end);
