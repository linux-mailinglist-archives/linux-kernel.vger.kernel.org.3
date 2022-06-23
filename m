Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B7C55877F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiFWS1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiFWS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:26:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9E12AAD;
        Thu, 23 Jun 2022 10:27:49 -0700 (PDT)
Received: from mail-yb1-f177.google.com ([209.85.219.177]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MIdS1-1nqOOc3dJN-00Ecgv; Thu, 23 Jun 2022 19:27:48 +0200
Received: by mail-yb1-f177.google.com with SMTP id 15so247910ybc.2;
        Thu, 23 Jun 2022 10:27:47 -0700 (PDT)
X-Gm-Message-State: AJIora8RZpDd+59VbRnMN/KVRZXiNQaIKsAOheSqMW+wYkB1cUNpHNfZ
        Vw7IRO0bU0HX5nRDiiE/iLW1IYnc/nHLNPRZw2E=
X-Google-Smtp-Source: AGRyM1sXbb09Op2pKcfwN6L4Ch/Q1/ff1/rtYtQX7EpRNhlw5gpcBOXG6GSX/Y4gtaFZA0hA29oa5+K8UMCqojOyXHY=
X-Received: by 2002:a25:86cf:0:b0:669:b4e7:7723 with SMTP id
 y15-20020a2586cf000000b00669b4e77723mr2373815ybm.106.1656005266613; Thu, 23
 Jun 2022 10:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220621133526.29662-1-mikoxyzzz@gmail.com> <CAKwvOd=Bmu40+_11GOBTeJBjToUf0LNG_RX0RiLcRLimUUkgcw@mail.gmail.com>
 <CAK7LNAT3FrpLnhSgfTo5bxk-9cHm6g1ti58wSY6W-fxMx+mUrA@mail.gmail.com>
In-Reply-To: <CAK7LNAT3FrpLnhSgfTo5bxk-9cHm6g1ti58wSY6W-fxMx+mUrA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Jun 2022 19:27:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2SkawPCtBgm4J9rUawRYa1CT_-BqTbdE-SUUa=9VC2pg@mail.gmail.com>
Message-ID: <CAK8P3a2SkawPCtBgm4J9rUawRYa1CT_-BqTbdE-SUUa=9VC2pg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Kconfig: -O3 enablement
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Miko Larsson <mikoxyzzz@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Cyi0DH3Ra8ysKGtDX+mBsA7v5zjRM8tFt84HZmMpMjGHJWhDpcX
 pGMpm8I6Qnt0Ze+QaYri7NRakaZiRR+n51HZxxV/t1hDj9oVjM/5QsxFz5cDdvekJF9AlCk
 9tHg1ZJM+XyGrpZduFckyIg5FMeNSWnnATQ+ehbMER06fLl2K2gvlGCXtnflXJWQ6SRvu1E
 CxO7ed1f6WeJCRNlb4eCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MROt+qzB0Jw=:AQDMG/uxv0QsQ50AHf4NWn
 Mlkhoi8K1LczfCGgEhI12c3p1RcrK4M2axDBr68sPCExEgW+prjyu+64+ECRABGMV5nhUNeyG
 WwvcPHQhkcIGK9Qr8/1S0q5XAamFaWSDfE82ODrgkcIlemuvwZ05hS0Mh+eXHV/40ZE8EWGSe
 YV7IDSkUjSXgHlgWPi2vKN8//yclP9I0Zg0dFY7gpi0w1cOOuA+1RNDj1qndxLUb/nHT3tv1R
 NMV/uRnQBDibBJfqsAH6ifnlJ86xtrSnGUWeNyPD8ghUF3lAm0n377ZpDFrfTfrz9zIeX/HE8
 S0Lt5UU70IzKpfExW6o8PX0V7sNonCwwMEawMblH/ounOR5qH3e7xHcz+k3PODrz2pBA+SAUY
 KniHnKtuDAJny3EQztwyA13D/2yhLigryaVTxi4qeQJns/4iv/xPtUmg1I7iQ1bJKpMf2zDgp
 jDOw8EG6P5ZPGo52Zb4JQyYg/J5SljDKV5iPsw/LFOsfWkAVo2Z3G/qhbTn1/yv9JeYT+2lZV
 8MFnRjVR/71YHwUdqvelsOnYglNf0FgzRNvSpSouuKtwYAQRCckZmhbVnqMvZccRXR0j2CBiD
 9zxxAvwwqb8RtrlEGkZ88/EcTgB1VhHJuO1XJOd9ah5Gd0IY20GQ8WvS8rhFbFUpAPfqgly18
 rg0sSXUXpT/RYErkW1ThMMI8Hjq7EB4pbqSa3gjGBNZH+4A2hMqQ7wG083nyrHLnSOLEjYPva
 2A9jTSnFrZYTHrz3K6evQKo3NfpyXQGKyGHJAQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 3:57 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Wed, Jun 22, 2022 at 1:17 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Tue, Jun 21, 2022 at 6:35 AM Miko Larsson <mikoxyzzz@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > This very small series allows -O3 to be used for all architectures. The
> > > first patch marks -O3 as experimental, with the reasoning being that it
> > > might expose unwanted regressions to users, and the second patch
> > > actually allows -O3 by removing the "depend on ARC" string.
> >
> > I think we should just remove -O3 support from KCONFIG.

I agree that would be best

> > If someone wants to mess around with "experimental features," there's
> > nothing stopping you from doing:
> >
> > $ make KCFLAGS=-O3
> >
>
> ARC uses -O3 since day1.
>
> "Generic build system uses -O2, we want -O3"
> in commit cfdbc2e16e65c1ec1c23057640607cee98d1a1bd
>
> If they want -O3, it is up to the ARC maintainer.

I suppose whatever the reason for using -O3 at the time has
likely changed by now.

> If you want to say "use this option carefully",
> EXPERT might be another option.
>
>     depends on ARC || EXPERT

This probably also needs a dependency on !COMPILE_TEST so we don't
report compile-time problems that are specific to -O3. Maybe a good first
step would be to turn this into

      depends on ARCH && EXPERT && !COMPILE_TEST

which should help both with compile-testing on ARC, and it would
prevent it from being visible on other architectures.

        Arnd
