Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782A05A67D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiH3QDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiH3QC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:02:58 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1889EEC72;
        Tue, 30 Aug 2022 09:02:55 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 27UG2Jjo030590;
        Wed, 31 Aug 2022 01:02:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 27UG2Jjo030590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661875340;
        bh=H2q6GsBXBNOWOoYdMHQTssZI3S7WHvmPpJBukTaedbs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ot8Tg+6/1s1kmiJLw1ydznab3YOfSiNXdCuw44p+8JjqI2khZ0fujC+26zRSDhwWe
         DriNnvPcUk8ZlxIwtzCJJTdzcfp1ikChCPhVm/QlpNc1URRYswQsxeFvz5Y0qsraMP
         mRYwQADHO0SyShIr1WqN8KD2TMDqPbWQh1GNhTUmGsblS/tgNY0MijCVFg6p3111gU
         wRjbSA8tvEKeD4emv1i5AmDFdHLz+rOxkLH6z7nPhgTmoH3VbBtN1+G4F3L05FzzDm
         OfKjq5LyGqtgjxTxAV0M3OFc0698u7R1tn7uq7E9V4GsqZZBw2ddZKaChAlqfY6RKf
         1WgBF7+vpczlw==
X-Nifty-SrcIP: [209.85.160.50]
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-11ee4649dfcso11342336fac.1;
        Tue, 30 Aug 2022 09:02:19 -0700 (PDT)
X-Gm-Message-State: ACgBeo0bUtGaGPigNuOS44Aem3h8Nb8VGHnkN3VUiCde7jUp3H62LwQP
        fcOp03WtReQCC0wX2BegmfxPUGWR2Rvgz8H+Qtg=
X-Google-Smtp-Source: AA6agR6MoD4lCTIAFc8q3Sk8P7vy+Sb/2h4auKZ7ZeB5eFyZj15pT1A0AmZO39Wc+iLf5CYwY4KHo8nucUreL/XP98k=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr10217645oab.287.1661875338862; Tue, 30
 Aug 2022 09:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220827164056.3365356-1-masahiroy@kernel.org>
 <58a90319-668f-7c87-4168-e0df10644aa7@csgroup.eu> <CAK7LNATJiQc5HMdsct1S5z15-b1fzc5-Y2xtBs6oT17Na79H_w@mail.gmail.com>
 <7daf34ca-ed5e-90ea-8ccc-6821127cbd96@csgroup.eu> <87o7w2j9jn.fsf@mpe.ellerman.id.au>
In-Reply-To: <87o7w2j9jn.fsf@mpe.ellerman.id.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 31 Aug 2022 01:01:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNASshE1zomfsvJf61YrAWH-AfFzx8y_NBey5MWH+3G4gvQ@mail.gmail.com>
Message-ID: <CAK7LNASshE1zomfsvJf61YrAWH-AfFzx8y_NBey5MWH+3G4gvQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: clean up binutils version check
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Aug 30, 2022 at 7:44 PM Michael Ellerman <mpe@ellerman.id.au> wrote=
:
>
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > Le 27/08/2022 =C3=A0 20:03, Masahiro Yamada a =C3=A9crit :
> >> On Sun, Aug 28, 2022 at 2:37 AM Christophe Leroy
> >> <christophe.leroy@csgroup.eu> wrote:
> >>> Le 27/08/2022 =C3=A0 18:40, Masahiro Yamada a =C3=A9crit :
> >>>> The checkbin in arch/powerpc/Makefile errors out if ld <=3D 2.24.
> >>>> So, the requirement on PPC is binutils >=3D 2.25. It is cleaner to
> >>>> specify it in scripts/min-tool-version.sh. If binutils < 2.25 is
> >>>> used, the toolchain check will fail in the Kconfig stage going
> >>>> forward.
> >>>>
> >>>> Since binutils >=3D 2.25 is already required, another version test
> >>>> for --save-restore-funcs on PPC64 is always met.
> ...
> >>>> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.=
sh
> >>>> index 250925aab101..7df9f2150ea1 100755
> >>>> --- a/scripts/min-tool-version.sh
> >>>> +++ b/scripts/min-tool-version.sh
> >>>> @@ -14,7 +14,13 @@ fi
> >>>>
> >>>>    case "$1" in
> >>>>    binutils)
> >>>> -     echo 2.23.0
> >>>> +     if [ "$SRCARCH" =3D powerpc ]; then
> >>>
> >>> Isn't this limitation only for ppc64le ?
> >>>
> >>> Refer commit 60e065f70bdb ("powerpc: Reject binutils 2.24 when buildi=
ng
> >>> little endian")
> >>
> >> I do not see any CONFIG check in the current checkbin.
> >>
> >> Refer commit a3ad84da0760 ("powerpc/toc: Future proof
> >> kernel toc")
> >
> > That's odd. There is no toc on PPC32.
>
> I think that's just a bug in a3ad84da0760.
>
> But that means we inadvertantly dropped support for 2.24 about 8 months
> ago, and no one noticed.
>
> Let's see what the responses are to Nick's proposal to increase the
> minimum to 2.25.1.
>
> cheers



Either way is fine with me, but in that case,
do I need to get a higher-level Ack from Linus?

The current one can go to the ppc tree
since apparently it does not affect any other arches.

--=20
Best Regards
Masahiro Yamada
