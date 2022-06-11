Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3062E5476E2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiFKRac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiFKRaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:30:30 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D317AAB;
        Sat, 11 Jun 2022 10:30:25 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 25BHU9e9000538;
        Sun, 12 Jun 2022 02:30:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 25BHU9e9000538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654968610;
        bh=OSACDTzwM3nmDx5T3K9VpI7ucvHxYTzvbUngRQkLr+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TomygkbFlEnETUNK56J/VTJtdffuMsuPj8R/S5mjXn9ys966unGmeQpZ7SkIaFg6t
         Y/kghcEfgqRC5UpAyZwgmjcNiPwddcuyjUPsim8J+JWK5Ea2/4l3ng1IOPceiZpsbV
         HlWhPYG/JWBPCJMFoKAVQqqKxBjKaJwjzxE8TjUKu3dIeMBL12/KgfXFaoxqom4XJG
         IMvmwWA74dFIJOPQ7sbECa4jwjBIoNa21cPi2Ka4U5lSNWZRXtfZzs+Sq6y4EKtYCX
         JGrHcww7fgGvJdOgB8WoU71nxWsxbORLzYGl2Ad5TS6EXzyNMlzHhTGQv+2LRRpvHj
         zCqOw7FC4LrAQ==
X-Nifty-SrcIP: [209.85.221.49]
Received: by mail-wr1-f49.google.com with SMTP id m24so2246292wrb.10;
        Sat, 11 Jun 2022 10:30:09 -0700 (PDT)
X-Gm-Message-State: AOAM5328zT8wuqXjVq9EPKrXKNaDAC58r4seERJ3hj0Em8Vbt1JLTBbk
        CddWuJOtFmzooZp7V1eupj15OUqxtLG9piDbzjc=
X-Google-Smtp-Source: ABdhPJxFQ4VR0rikIrQmnyzW5yFwMBQ21UyA+EWB6Z3mCZwhT0pwLKVeOIT4MNgfpM1Ic97A6mYaSh3bwWNFqX/h6fY=
X-Received: by 2002:a5d:584f:0:b0:219:e106:3e02 with SMTP id
 i15-20020a5d584f000000b00219e1063e02mr11475842wrf.461.1654968608246; Sat, 11
 Jun 2022 10:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
 <CAK7LNAS-0kQOvt=7TNn0osf9JO5hZhSp9PaFFBsSx++2Pevc9g@mail.gmail.com>
 <22a067fe-795f-d3ae-fac6-7baa75393349@digikod.net> <75918f49-5670-766a-09a2-f29aef95f2ca@digikod.net>
In-Reply-To: <75918f49-5670-766a-09a2-f29aef95f2ca@digikod.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 12 Jun 2022 02:29:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZLL=EA61-j+x8YjujW6U1RKZtL8+qhi1hgFhma5vbzA@mail.gmail.com>
Message-ID: <CAK7LNARZLL=EA61-j+x8YjujW6U1RKZtL8+qhi1hgFhma5vbzA@mail.gmail.com>
Subject: Re: [PATCH] certs: Convert spaces in certs/Makefile to a tab
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 2:17 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
>
>
> On 09/06/2022 19:12, Micka=C3=ABl Sala=C3=BCn wrote:
> >
> > On 06/06/2022 18:49, Masahiro Yamada wrote:
> >> On Mon, Jun 6, 2022 at 9:32 PM David Howells <dhowells@redhat.com> wro=
te:
> >>>
> >>> There's a rule in certs/Makefile for which the command begins with ei=
ght
> >>> spaces.  This results in:
> >>>
> >>>          ../certs/Makefile:21: FORCE prerequisite is missing
> >>>          ../certs/Makefile:21: *** missing separator.  Stop.
> >>>
> >>> Fix this by turning the spaces into a tab.
> >>>
> >>> Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are
> >>> valid")
> >>> Signed-off-by: David Howells <dhowells@redhat.com>
> >>> cc: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >>> cc: Jarkko Sakkinen <jarkko@kernel.org>
> >>> cc: keyrings@vger.kernel.org
> >>
> >>
> >> Not only 8-space indentation, but also:
> >>
> >>    - config_filename does not exist
> >>    - $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX) is always empty
> >>    - $(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) is always empty
> >
> > These are imported helpers (not only used for this hash list BTW), henc=
e
> > not defined in this Makefile.
>
> Well, they were defined in scripts/Kbuild.include but they are gone
> since your commit b8c96a6b466c ("certs: simplify $(srctree)/ handling
> and remove config_filename macro").
>
> I guess it just happens during the merge. We need to fix that.

Today, I took a closer look at it.
I volunteered to fix the build issues with some refactoring.

https://lore.kernel.org/keyrings/20220611172233.1494073-1-masahiroy@kernel.=
org/T/#t







--=20
Best Regards
Masahiro Yamada
