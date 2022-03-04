Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573234CD321
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbiCDLOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiCDLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:13:58 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AC71B0BD5;
        Fri,  4 Mar 2022 03:13:07 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id 9so6248938ily.11;
        Fri, 04 Mar 2022 03:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pix5KDHACk5xuaWSUAnT0P8xCzYZyA+b1xfvdOjbWuQ=;
        b=iPZ/H1n3eyVmsRIMvk6KjphmQVML8dWniJcFydrYkBZnD8D/yr//2bAXTdLz+Ahs7D
         PsVdZZS93PmFF8tea3XV/GmTiWf/pd/ReZ75FFbq11Xx3Y9cB+MXaz+vjBFzFWMj9K3S
         IphB5/FbyBUL9+vvQkaYYZ8Jwh6bp4WF+vTlGmXNbfFxV7j12HwN9zsyRxRIZvqR6pgx
         kjNvwPU4Sa91Qie372VTsa36PwkWzfsSEibQAXZhaWwCK6ErJW+smWPIEEI2KQK1SMLa
         dtUIm2wIttSzC864Rc5cRjjJzRaJanrqLR7uy3GYsV50PuGMloSWavptw8SEIGp5k5/9
         TBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pix5KDHACk5xuaWSUAnT0P8xCzYZyA+b1xfvdOjbWuQ=;
        b=7rHWQv6D3oHGLEUKyKSfONydki0701wqyV+2DtZoFs9XABPGOjWG/2CbewiNDs0k9I
         QcNUpnS8WhD+anYZC8GHwhxv/ZlrsA57RAIIXsT2zkWMfj3ZjV45/zxtv8Yj4iMrz92g
         Fblj8v8Se60J5X7hSltiJHmXVj85YluiuMcoCIRmsrR8V+teFhuvNFoiC2iP7BsFNKyF
         YX4+t7HG2NpqMgNnawPBxThacYm166w0MYAnrX5h6AFYq2R3WlYxyWL7iqFDQvbwJZ3k
         +E5V5fE4MaPtA1ltZDgMaUo1JQ8+kES3r0VXZGpmupjMJ6dtn0p3vBiYFq3U389Uinbp
         IDsA==
X-Gm-Message-State: AOAM532Safx8WPRD/clHhHnKazb494L4VvoRdLn5C4afwGnIGVtiWZsX
        vVsUh+aM1lfXzaXPLfZrLJJjCAdUvzVs0ouJHGs=
X-Google-Smtp-Source: ABdhPJxVn0I1gYNcDyZWKfKxwXFubpSLDqDezcfdt+oRTcpIclWTeQb4GwhGqPoNLCc+9sUT94M0RiZ/tnc/M8p/P1o=
X-Received: by 2002:a05:6e02:1c04:b0:2be:4c61:20f4 with SMTP id
 l4-20020a056e021c0400b002be4c6120f4mr35937854ilh.245.1646392386116; Fri, 04
 Mar 2022 03:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-3-arnd@kernel.org>
 <CA+icZUWCTuVeohWvePhxYY3WC9xAYSy9nP1xQQf=tFH_mWDCNQ@mail.gmail.com>
 <CAKwvOdn04aoWO_384k5HQodwA1-DCFwU50iRXQXh_BQk5pyz7w@mail.gmail.com>
 <CA+icZUWD_O1WTKNDTj7f+EUxx5Pf=zC53mfOBNgtj1JQwjZVAQ@mail.gmail.com>
 <YiD86pay2ENCebkR@dev-arch.thelio-3990X> <CA+icZUXDBe5MF6G_2v4XoV0SFVkTZ96M5i-VGSvHsP1pFJ+nAg@mail.gmail.com>
 <CA+icZUXNtq3+cW6OBiO1TPhHT2xwXFe_D-Ja8HAO0XH2y6h=GA@mail.gmail.com>
In-Reply-To: <CA+icZUXNtq3+cW6OBiO1TPhHT2xwXFe_D-Ja8HAO0XH2y6h=GA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 4 Mar 2022 12:12:30 +0100
Message-ID: <CA+icZUVKJdtCWhhwcY5UkWwFA4TQAn+MF2w1DeZistYmG_ZEuQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Mar 4, 2022 at 8:18 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Mar 4, 2022 at 7:47 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Thu, Mar 3, 2022 at 6:37 PM Nathan Chancellor <nathan@kernel.org> wr=
ote:
> > >
> > > Hi Sedat,
> > >
> > > On Thu, Mar 03, 2022 at 07:26:05AM +0100, Sedat Dilek wrote:
> > > > Hey Nick!
> > > >
> > > > This only applies 1/3.
> > > >
> > > > $ b4 --version
> > > > 0.8.0
> > > >
> > > > $ b4 am https://lore.kernel.org/lkml/20220301145233.3689119-1-arnd@=
kernel.org/
> > > > -o - | git am -3
> > > > Analyzing 14 messages in the thread
> > > > Will use the latest revision: v3
> > > > You can pick other revisions using the -vN flag
> > > > Checking attestation on all messages, may take a moment...
> > > > ---
> > > >  =E2=9C=93 [PATCH v3 1/3] Kbuild: move to -std=3Dgnu11
> > > >    =E2=9C=93 Signed: DKIM/kernel.org
> > > >    + Reviewed-by: Nathan Chancellor <nathan@kernel.org> (=E2=9C=93 =
DKIM/kernel.org)
> > > >  ERROR: missing [2/3]!
> > > >  ERROR: missing [3/3]!
> > > >  ---
> > > >  NOTE: install patatt for end-to-end signature verification
> > > > ---
> > > > Total patches: 1
> > > > ---
> > > > WARNING: Thread incomplete!
> > > > Link: https://lore.kernel.org/r/20220301145233.3689119-1-arnd@kerne=
l.org
> > > > Base: not specified
> > > > Wende an: Kbuild: move to -std=3Dgnu11
> > >
> > > It looks like the threading somehow got broken, likely due to the [v3=
]
> > > on the first patch and not the second or third:
> > >
> > > This worked for me on v5.17-rc6:
> > >
> > > $ for i in $(seq 1 3); do b4 shazam -P _ 20220301145233.3689119-"$i"-=
arnd@kernel.org; done
> > >
> > > "b4 shazam" is the equivalent of "b4 am -o - ... | git am" and the
> > > "-P _" tells b4 to only fetch that exact message ID, not the whole
> > > thread.
> > >
> >
> > Hmm, the universe is not good to me...
> >
> > $ for i in $(seq 1 3); do b4 shazam -P _
> > 20220301145233.3689119-"$i"-arnd@kernel.org; done
> > usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} ...
> > b4: error: argument subcmd: invalid choice: 'shazam' (choose from
> > 'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
> > usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} ...
> > b4: error: argument subcmd: invalid choice: 'shazam' (choose from
> > 'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
> > usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} ...
> > b4: error: argument subcmd: invalid choice: 'shazam' (choose from
> > 'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
> >
> > Do I need a higher version of b4 (here: v0.8.0)?
> >
> > Check myself... b4.git:
> >
> > commit 7c1d044ff1d5235e598d4c777c4abfe60e0a09a8
> > ("shazam: change default behaviour to be "apply-here"")
> >
> > ...is post-v0.8.0.
> >
>
> I brutally applied the post-v0.8.0 patches stolen from b4.git over my
> local distro b4 files.
>
> And was able to apply the triple:
>
> $ git log --oneline --no-merges
> 5.17.0-rc6-1-amd64-clang13-lto..5.17.0-rc6-2-amd64-clang13-lto
> 96a4222bdd4c (for-5.17/kbuild-std_gnu11-arndb-20220301) Kbuild: use
> -std=3Dgnu11 for KBUILD_USERCFLAGS
> c4e8cef401a8 treewide: use -Wdeclaration-after-statement
> 6a7cc105b238 Kbuild: move to -std=3Dgnu11
>

I was able to build and boot on bare metal.

No new warnings in my build-log here after switching to -std=3Dgnu11.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v13.0.0 x86-64

- sed@ -
