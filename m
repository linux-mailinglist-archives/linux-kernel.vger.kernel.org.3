Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31854CCEF5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiCDHTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiCDHTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:19:40 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0F3EDF3D;
        Thu,  3 Mar 2022 23:18:52 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id q4so5950622ilt.0;
        Thu, 03 Mar 2022 23:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Em4vIFtbnAfHzqImau3wflNwYLrEwWXRRPlRb6fFAik=;
        b=AQ+vItkCK/KQHEUSzHxM2ukwePVCTPXqZLpjiIIjLSzXBM/fx496O/ME8K9a7ToBPr
         Zq/k+3ePgMPSe6/WF3bnzmmZU5Ug/g+LbCGqp5NhR3bRqIRxVh+Y8849i/zi+5H2xKa+
         WvKzoo/YAHjnKJpu/mzRt1wMIvnb7xB16f6eaX/nkdpqFUQR3ARHHwvH4TNBStQ4qI7u
         lyApT9q8gW3izpqDEn/R6+kyou2u7qEWkYx+SintwAhnrMjMom0UDKV/p3KqrFFl1kd2
         rxrbIa3NgFagkcYzZik+r/acVk4SrJVa5BOMLQtPg5ZqGFw64XI63tPA+UOUQNwzvtqS
         wwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Em4vIFtbnAfHzqImau3wflNwYLrEwWXRRPlRb6fFAik=;
        b=M4pcmKU6/EOuG4htYGYfCuv4tGApsniVloDfgkOW25FEMAOEDquhgklukQvS+Q+7Am
         YIDjcDll9J710qqw7gQPOZlebfWIpBZxAXfYNx8bH2qs8jP78YEOdiJM4vzykb8AIAMh
         Th2SDusumXriXuAQSatIcdgPWfP9nQ0OC0AFcwJmkRmE27oPC5P2lkVhOGR3rkdxKyX0
         GLCnL/QEG1sVihyD3c1xLNLWNS8vSxIjChf3vkJHuRTpLq11g6xLV6vaORmO5TtUidAe
         Wg1O4mCfZvsh0+5TMmigSROAYm1pVKYUdQU7uuMocxgodY27yebNlcHOsRSFM066yK6J
         VCoQ==
X-Gm-Message-State: AOAM530sMNn6mTWxSq2X72snOyZHFOnUKTdchqse4IgN7MV3uC/aIchY
        iDmScH8lVi1YOlf3uIElqe8CT9o9veXFI0hh8gs=
X-Google-Smtp-Source: ABdhPJybQ6fYgvuM8D5CD0i1MixyIsqbUa6RJpl03+vMLWnwjvlqkhpRtmzXdXhlPEcIGQg643vX7Clekr+saOwTIKA=
X-Received: by 2002:a05:6e02:de2:b0:2c6:f14:884a with SMTP id
 m2-20020a056e020de200b002c60f14884amr2995481ilj.100.1646378332178; Thu, 03
 Mar 2022 23:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-3-arnd@kernel.org>
 <CA+icZUWCTuVeohWvePhxYY3WC9xAYSy9nP1xQQf=tFH_mWDCNQ@mail.gmail.com>
 <CAKwvOdn04aoWO_384k5HQodwA1-DCFwU50iRXQXh_BQk5pyz7w@mail.gmail.com>
 <CA+icZUWD_O1WTKNDTj7f+EUxx5Pf=zC53mfOBNgtj1JQwjZVAQ@mail.gmail.com>
 <YiD86pay2ENCebkR@dev-arch.thelio-3990X> <CA+icZUXDBe5MF6G_2v4XoV0SFVkTZ96M5i-VGSvHsP1pFJ+nAg@mail.gmail.com>
In-Reply-To: <CA+icZUXDBe5MF6G_2v4XoV0SFVkTZ96M5i-VGSvHsP1pFJ+nAg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 4 Mar 2022 08:18:15 +0100
Message-ID: <CA+icZUXNtq3+cW6OBiO1TPhHT2xwXFe_D-Ja8HAO0XH2y6h=GA@mail.gmail.com>
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

On Fri, Mar 4, 2022 at 7:47 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Mar 3, 2022 at 6:37 PM Nathan Chancellor <nathan@kernel.org> wrot=
e:
> >
> > Hi Sedat,
> >
> > On Thu, Mar 03, 2022 at 07:26:05AM +0100, Sedat Dilek wrote:
> > > Hey Nick!
> > >
> > > This only applies 1/3.
> > >
> > > $ b4 --version
> > > 0.8.0
> > >
> > > $ b4 am https://lore.kernel.org/lkml/20220301145233.3689119-1-arnd@ke=
rnel.org/
> > > -o - | git am -3
> > > Analyzing 14 messages in the thread
> > > Will use the latest revision: v3
> > > You can pick other revisions using the -vN flag
> > > Checking attestation on all messages, may take a moment...
> > > ---
> > >  =E2=9C=93 [PATCH v3 1/3] Kbuild: move to -std=3Dgnu11
> > >    =E2=9C=93 Signed: DKIM/kernel.org
> > >    + Reviewed-by: Nathan Chancellor <nathan@kernel.org> (=E2=9C=93 DK=
IM/kernel.org)
> > >  ERROR: missing [2/3]!
> > >  ERROR: missing [3/3]!
> > >  ---
> > >  NOTE: install patatt for end-to-end signature verification
> > > ---
> > > Total patches: 1
> > > ---
> > > WARNING: Thread incomplete!
> > > Link: https://lore.kernel.org/r/20220301145233.3689119-1-arnd@kernel.=
org
> > > Base: not specified
> > > Wende an: Kbuild: move to -std=3Dgnu11
> >
> > It looks like the threading somehow got broken, likely due to the [v3]
> > on the first patch and not the second or third:
> >
> > This worked for me on v5.17-rc6:
> >
> > $ for i in $(seq 1 3); do b4 shazam -P _ 20220301145233.3689119-"$i"-ar=
nd@kernel.org; done
> >
> > "b4 shazam" is the equivalent of "b4 am -o - ... | git am" and the
> > "-P _" tells b4 to only fetch that exact message ID, not the whole
> > thread.
> >
>
> Hmm, the universe is not good to me...
>
> $ for i in $(seq 1 3); do b4 shazam -P _
> 20220301145233.3689119-"$i"-arnd@kernel.org; done
> usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} ...
> b4: error: argument subcmd: invalid choice: 'shazam' (choose from
> 'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
> usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} ...
> b4: error: argument subcmd: invalid choice: 'shazam' (choose from
> 'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
> usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} ...
> b4: error: argument subcmd: invalid choice: 'shazam' (choose from
> 'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
>
> Do I need a higher version of b4 (here: v0.8.0)?
>
> Check myself... b4.git:
>
> commit 7c1d044ff1d5235e598d4c777c4abfe60e0a09a8
> ("shazam: change default behaviour to be "apply-here"")
>
> ...is post-v0.8.0.
>

I brutally applied the post-v0.8.0 patches stolen from b4.git over my
local distro b4 files.

And was able to apply the triple:

$ git log --oneline --no-merges
5.17.0-rc6-1-amd64-clang13-lto..5.17.0-rc6-2-amd64-clang13-lto
96a4222bdd4c (for-5.17/kbuild-std_gnu11-arndb-20220301) Kbuild: use
-std=3Dgnu11 for KBUILD_USERCFLAGS
c4e8cef401a8 treewide: use -Wdeclaration-after-statement
6a7cc105b238 Kbuild: move to -std=3Dgnu11

- sed@ -
