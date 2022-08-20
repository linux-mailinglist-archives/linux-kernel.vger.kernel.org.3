Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443B659AF13
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbiHTRCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:02:34 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A468481E2;
        Sat, 20 Aug 2022 10:02:33 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 27KH2EaF011358;
        Sun, 21 Aug 2022 02:02:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 27KH2EaF011358
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661014935;
        bh=rWcJMY7/GFsvpMBGGJiZ1feLmy6PYxdktmyMOEXjeJI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qolt3Q4Bx1FqZAnlmFx+2zT5vw02doz+AZXfAbkPVIg09ye+JGapALCRtb2K4tB8Q
         MmuvVDHFEEqi2X7inV6QkBunGnqHcFZbs0ceCV2uiGeHMWUBIu2l46rMe4HOwQfJNd
         0W4+SUa8Tw8sWe6AmJYmpQNWc72NE7xzM70sAELQ6B2Td8MNGIbNyb4+1nAKk9QxGE
         k5au3wDCVDHlvP622tkYuYIST9MsRTB8Dv97/+sCviQgIEyoidBvLljoKPCd02bSM2
         TkjnIOQO5xCCteehl6rt+DpGBOuRwQ/hScYBzd5raI4akelyvdGlg56TVQkNSAdm+n
         Vi2BBOdXn6aEg==
X-Nifty-SrcIP: [209.85.128.43]
Received: by mail-wm1-f43.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso3905745wmr.3;
        Sat, 20 Aug 2022 10:02:14 -0700 (PDT)
X-Gm-Message-State: ACgBeo2/RSRrMz6j57mZMZoYy5W50d5/kDhT9onQChzU0pJb9uloNjQs
        +nW8E5AsTXBEot/ApBKgB6P2CrmxoYJzbp3BaVE=
X-Google-Smtp-Source: AA6agR4a38GI9YKC4xERkbHU9ElXctEQds+06WsO/F/prSuRh8HdNH/st3P0SljaF218/fKAXkX8im1ygaJc1WjpGrg=
X-Received: by 2002:a1c:19c2:0:b0:3a5:168e:a918 with SMTP id
 185-20020a1c19c2000000b003a5168ea918mr11004445wmz.31.1661014932901; Sat, 20
 Aug 2022 10:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220513113930.10488-1-masahiroy@kernel.org> <20220513113930.10488-3-masahiroy@kernel.org>
 <38605f6a-a568-f884-f06f-ea4da5b214f0@csgroup.eu> <CAK7LNATKh4DrgSeN+E1r7xmh1YL6mwWL_g2zL-rz=NYuzXT1bA@mail.gmail.com>
 <ad12004e-1eef-cc77-97ee-ef1738cfa141@csgroup.eu>
In-Reply-To: <ad12004e-1eef-cc77-97ee-ef1738cfa141@csgroup.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 21 Aug 2022 02:01:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQnYQH4BhYkw2G3KMDYRY3mzU9Yd1NudCABG8qpDVRtrQ@mail.gmail.com>
Message-ID: <CAK7LNAQnYQH4BhYkw2G3KMDYRY3mzU9Yd1NudCABG8qpDVRtrQ@mail.gmail.com>
Subject: Re: Build/boot problem with 7b4537199a4a (Re: [PATCH v6 02/10]
 kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS)
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
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

On Sat, Aug 20, 2022 at 11:15 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 20/08/2022 =C3=A0 14:51, Masahiro Yamada a =C3=A9crit :
> > On Sat, Aug 20, 2022 at 7:02 PM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >> Hi,
> >>
> >> Le 13/05/2022 =C3=A0 13:39, Masahiro Yamada a =C3=A9crit :
> >>> include/{linux,asm-generic}/export.h defines a weak symbol, __crc_*
> >>> as a placeholder.
> >>>
> >>> Genksyms writes the version CRCs into the linker script, which will b=
e
> >>> used for filling the __crc_* symbols. The linker script format depend=
s
> >>> on CONFIG_MODULE_REL_CRCS. If it is enabled, __crc_* holds the offset
> >>> to the reference of CRC.
> >>>
> >>> It is time to get rid of this complexity.
> >>>
> >>> Now that modpost parses text files (.*.cmd) to collect all the CRCs,
> >>> it can generate C code that will be linked to the vmlinux or modules.
> >>>
> >>> Generate a new C file, .vmlinux.export.c, which contains the CRCs of
> >>> symbols exported by vmlinux. It is compiled and linked to vmlinux in
> >>> scripts/link-vmlinux.sh.
> >>>
> >>> Put the CRCs of symbols exported by modules into the existing *.mod.c
> >>> files. No additional build step is needed for modules. As before,
> >>> *.mod.c are compiled and linked to *.ko in scripts/Makefile.modfinal.
> >>>
> >>> No linker magic is used here. The new C implementation works in the
> >>> same way, whether CONFIG_RELOCATABLE is enabled or not.
> >>> CONFIG_MODULE_REL_CRCS is no longer needed.
> >>>
> >>> Previously, Kbuild invoked additional $(LD) to update the CRCs in
> >>> objects, but this step is unneeded too.
> >>>
> >>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >>> Tested-by: Nathan Chancellor <nathan@kernel.org>
> >>> Tested-by: Nicolas Schier <nicolas@fjasle.eu>
> >>> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> >>
> >> Problem with v6.0-rc1
> >> Problem with v5.19
> >> No problem with v5.18
> >>
> >> Bisected to 7b4537199a4a ("kbuild: link symbol CRCs at final link,
> >> removing CONFIG_MODULE_REL_CRCS")
> >>
> >> The above patch leads to the following problem building
> >> mpc85xx_defconfig + CONFIG_RELOCATABLE
> >
> >
> >
> > Is this because the relocation implementation on ppc is incomplete?
> > (and is it the reason why relock_check.sh exists?)
> >
> > arch/powerpc/kernel/reloc_32.S does not support R_PPC_UADDR32
> >
> >
>
> Might be the reason.
>
> Is it expected that your patch adds an unsupported relocation ?
>
> Why was that relocation type unneeded before ?
>
> Thanks
> Christophe


I posted a patch (although I believe my commit is innocent).

https://lore.kernel.org/lkml/20220820165129.1147589-1-masahiroy@kernel.org/=
T/#u

The relocs_check.sh warnings are gone.
Please do a boot test.
Thanks.


--=20
Best Regards
Masahiro Yamada
