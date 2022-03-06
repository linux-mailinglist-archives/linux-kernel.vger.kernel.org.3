Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F83C4CEA74
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 11:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiCFKFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 05:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCFKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 05:05:52 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C2F6CA5B;
        Sun,  6 Mar 2022 02:05:00 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id k7so9614910ilo.8;
        Sun, 06 Mar 2022 02:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ESgklctOQqYlZPJTzsNo744f6q9u/AsDia/ttur2s+w=;
        b=pQh3qKhO1pOKJYjjzWwQpHgD4Ss8VhwZQ7Xfse8+PNobDLoi3Kr5jbqXShtcAVBsTy
         ++6Sd5HxdPMXOmA5lDBcAC+D57Yp1UFtRM293wvKUadPnrXk5t/6I3n5F4V9/4E5YcQH
         PCztAeXKbhirRmdd+5f35kSrektLI+2ysQsHTgzayQfdkF9l2Iy0Vu80U4OACpHXK7+2
         aaRQUKcqI5VNei+Qpw9+wWLWULavLr0iDz0/gTkhfuHkgKwsJd2QbNMvLxIthOfFSdRs
         IIJ/03gccagXgb/k6MwQBpJ3qh1V8MfcL4KBmYKFqN5tuETuEoL/B4+WDPQYuKU/jgbI
         Znog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ESgklctOQqYlZPJTzsNo744f6q9u/AsDia/ttur2s+w=;
        b=IVJIH+mh2xp/AruJNslFvtuy2X+BuL0vOCcCPzc+EVT50DPO+tFfUO42FGrbGxbZ7W
         /PJQFmpjLfZCH4bqrnXZc/ZPwXIhYAcSB5L/xXJGvI6Wu3BB1AQum1eUFrW/FmpxVWSN
         gl/XsJ83jJJ7XBXy9mT16h3CHJFp9YG1OXLqh10XjYyhe9sbTvrrGIAb003XnRyIVJxQ
         SKtpp2NYComfaiu+yR1wzFNTHF3xw4tE1OppDJ+pJVOykVf1nK39vXLx8pw/taud/pLv
         GSDmTBaMw5+wm/pVKHS9kaX5ZSSZuV+5Yz3s3+2/brf7Daac1EOS4zPT6GYo1GX2SfeK
         0w0Q==
X-Gm-Message-State: AOAM533oQNm5MIBqGmxpLZXVEAYkk8XYp7NVO9LW8vdWZPuDc9yDUJ9A
        4WRqf2vooV8o4xJTEhd5rY2T6NwCuKJWu7eYbUU=
X-Google-Smtp-Source: ABdhPJymFJmO/rbAm66B96DsYrx2cpCqzxWw/vrFMi8K7/qMhr34kerBlS9vq08LDBXOUTD+ju3bNAvRs4lnmd2mTNs=
X-Received: by 2002:a05:6e02:de2:b0:2c6:f14:884a with SMTP id
 m2-20020a056e020de200b002c60f14884amr6916885ilj.100.1646561099918; Sun, 06
 Mar 2022 02:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-3-arnd@kernel.org>
 <CA+icZUWCTuVeohWvePhxYY3WC9xAYSy9nP1xQQf=tFH_mWDCNQ@mail.gmail.com>
 <CAKwvOdn04aoWO_384k5HQodwA1-DCFwU50iRXQXh_BQk5pyz7w@mail.gmail.com>
 <CA+icZUWD_O1WTKNDTj7f+EUxx5Pf=zC53mfOBNgtj1JQwjZVAQ@mail.gmail.com>
 <YiD86pay2ENCebkR@dev-arch.thelio-3990X> <CA+icZUXDBe5MF6G_2v4XoV0SFVkTZ96M5i-VGSvHsP1pFJ+nAg@mail.gmail.com>
 <CA+icZUXNtq3+cW6OBiO1TPhHT2xwXFe_D-Ja8HAO0XH2y6h=GA@mail.gmail.com> <CA+icZUVKJdtCWhhwcY5UkWwFA4TQAn+MF2w1DeZistYmG_ZEuQ@mail.gmail.com>
In-Reply-To: <CA+icZUVKJdtCWhhwcY5UkWwFA4TQAn+MF2w1DeZistYmG_ZEuQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 6 Mar 2022 11:04:23 +0100
Message-ID: <CA+icZUUp1xT-i9ewsOJ4Ckk59L=kjh93U+2nEN81jTMJ-aSy=A@mail.gmail.com>
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

On Fri, Mar 4, 2022 at 12:12 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Mar 4, 2022 at 8:18 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Mar 4, 2022 at 7:47 AM Sedat Dilek <sedat.dilek@gmail.com> wrot=
e:
> > >
> > > On Thu, Mar 3, 2022 at 6:37 PM Nathan Chancellor <nathan@kernel.org> =
wrote:
> > > >
> > > > Hi Sedat,
> > > >
> > > > On Thu, Mar 03, 2022 at 07:26:05AM +0100, Sedat Dilek wrote:
> > > > > Hey Nick!
> > > > >
> > > > > This only applies 1/3.
> > > > >
> > > > > $ b4 --version
> > > > > 0.8.0
> > > > >
> > > > > $ b4 am https://lore.kernel.org/lkml/20220301145233.3689119-1-arn=
d@kernel.org/
> > > > > -o - | git am -3
> > > > > Analyzing 14 messages in the thread
> > > > > Will use the latest revision: v3
> > > > > You can pick other revisions using the -vN flag
> > > > > Checking attestation on all messages, may take a moment...
> > > > > ---
> > > > >  =E2=9C=93 [PATCH v3 1/3] Kbuild: move to -std=3Dgnu11
> > > > >    =E2=9C=93 Signed: DKIM/kernel.org
> > > > >    + Reviewed-by: Nathan Chancellor <nathan@kernel.org> (=E2=9C=
=93 DKIM/kernel.org)
> > > > >  ERROR: missing [2/3]!
> > > > >  ERROR: missing [3/3]!
> > > > >  ---
> > > > >  NOTE: install patatt for end-to-end signature verification
> > > > > ---
> > > > > Total patches: 1
> > > > > ---
> > > > > WARNING: Thread incomplete!
> > > > > Link: https://lore.kernel.org/r/20220301145233.3689119-1-arnd@ker=
nel.org
> > > > > Base: not specified
> > > > > Wende an: Kbuild: move to -std=3Dgnu11
> > > >
> > > > It looks like the threading somehow got broken, likely due to the [=
v3]
> > > > on the first patch and not the second or third:
> > > >
> > > > This worked for me on v5.17-rc6:
> > > >
> > > > $ for i in $(seq 1 3); do b4 shazam -P _ 20220301145233.3689119-"$i=
"-arnd@kernel.org; done
> > > >
> > > > "b4 shazam" is the equivalent of "b4 am -o - ... | git am" and the
> > > > "-P _" tells b4 to only fetch that exact message ID, not the whole
> > > > thread.
> > > >
> > >
> > > Hmm, the universe is not good to me...
> > >
> > > $ for i in $(seq 1 3); do b4 shazam -P _
> > > 20220301145233.3689119-"$i"-arnd@kernel.org; done
> > > usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} .=
..
> > > b4: error: argument subcmd: invalid choice: 'shazam' (choose from
> > > 'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
> > > usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} .=
..
> > > b4: error: argument subcmd: invalid choice: 'shazam' (choose from
> > > 'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
> > > usage: b4 [-h] [--version] [-d] [-q] {mbox,am,attest,pr,ty,diff,kr} .=
..
> > > b4: error: argument subcmd: invalid choice: 'shazam' (choose from
> > > 'mbox', 'am', 'attest', 'pr', 'ty', 'diff', 'kr')
> > >
> > > Do I need a higher version of b4 (here: v0.8.0)?
> > >
> > > Check myself... b4.git:
> > >
> > > commit 7c1d044ff1d5235e598d4c777c4abfe60e0a09a8
> > > ("shazam: change default behaviour to be "apply-here"")
> > >
> > > ...is post-v0.8.0.
> > >
> >
> > I brutally applied the post-v0.8.0 patches stolen from b4.git over my
> > local distro b4 files.
> >
> > And was able to apply the triple:
> >
> > $ git log --oneline --no-merges
> > 5.17.0-rc6-1-amd64-clang13-lto..5.17.0-rc6-2-amd64-clang13-lto
> > 96a4222bdd4c (for-5.17/kbuild-std_gnu11-arndb-20220301) Kbuild: use
> > -std=3Dgnu11 for KBUILD_USERCFLAGS
> > c4e8cef401a8 treewide: use -Wdeclaration-after-statement
> > 6a7cc105b238 Kbuild: move to -std=3Dgnu11
> >
>
> I was able to build and boot on bare metal.
>
> No new warnings in my build-log here after switching to -std=3Dgnu11.
>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v13.0.0 x86-6=
4
>

I have re-tested with Debian's LLVM/Clang v14.0.0-rc2.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v14.0.0-rc2 (x8=
6-64)

- sed@ -
