Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28264CB6EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiCCG13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiCCG10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:27:26 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6E11680B6;
        Wed,  2 Mar 2022 22:26:42 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i1so3259647ilu.6;
        Wed, 02 Mar 2022 22:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=6cIMVIL+CCfpPGGYjFcu/o0ZTv3OrIkZlvD7/pJ5jLE=;
        b=qAPglD6WY9eqhPAwpMIjhiwYNT2dKn4CN38Zc82q2s1SK/f3Natf+VLErUyGTKjrWy
         CRbOAq9HpURnNbnXCMUOr+t9a1Mn870/X6I7oaKHv1pzPlIbjauqddiERKoJBul3r10s
         nCWQcGOmXStt50Ncw7yT0WSq1l1J//LuF6ExO0Rn6TUTaWT+RAhlPh71W9bEKT6SNXvG
         H0szLTUbOPDyzykmzzajMj9cC+kp9+YVW/thD+dHHr6TDs9PFlk+GIUrSrwKCVqRkwMM
         v8xPgMzjlEaISe+pvI16QKOSkVWMsrLAT0LzSwCDMWsXnMANbDx24bQ13bVNQLl/O3pI
         +Dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=6cIMVIL+CCfpPGGYjFcu/o0ZTv3OrIkZlvD7/pJ5jLE=;
        b=pGXyOJUmUbkEspdVAp0AkMZSEBV4u+ZFeySNOqaH+4tkYSv5SOMA1pTwhJUMds8Fb6
         qwPJiFbTgGuryIM2LUiPz9WBcqVRAuwv4Au8YMMpgK1M4xreAngZNE2GWQve+gFXzBo5
         zP4zUB2krmubYtGlzKx0szWol+1K1Atbxdr1y33/ejoSBMM+oRD5rkaF3eJQIH64LD82
         yMPNiidgduVX3brHneJTC7tqIYp8crXJUdDjX4mMfOYc74BamjQcTKUZtQEny8yW3cC1
         Y36DVp53unAExLQ33TJtay03BOO0cXYrHEMEMjFG5x0hAAaqjq9hd+DaENwbxv59FHB/
         2m1g==
X-Gm-Message-State: AOAM533lRUuMI29Ur//sjef/lcQay9kEDSIKq9zAbmTadg0u1eprdJ06
        t11fRV28mP9giVvJLL4YW7ko6YVfefNHNFEQWOs=
X-Google-Smtp-Source: ABdhPJxN4sEwUhUly0CT6JZ3A4I17A47qSawqzxX8rRhMHb82FN8jNix1RE7+RJJ1Gk2Z/4ey0Hz4TWtsMIElevu9YY=
X-Received: by 2002:a05:6e02:1ba5:b0:2c2:b1a8:efcf with SMTP id
 n5-20020a056e021ba500b002c2b1a8efcfmr26236724ili.20.1646288801478; Wed, 02
 Mar 2022 22:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-3-arnd@kernel.org>
 <CA+icZUWCTuVeohWvePhxYY3WC9xAYSy9nP1xQQf=tFH_mWDCNQ@mail.gmail.com> <CAKwvOdn04aoWO_384k5HQodwA1-DCFwU50iRXQXh_BQk5pyz7w@mail.gmail.com>
In-Reply-To: <CAKwvOdn04aoWO_384k5HQodwA1-DCFwU50iRXQXh_BQk5pyz7w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 3 Mar 2022 07:26:05 +0100
Message-ID: <CA+icZUWD_O1WTKNDTj7f+EUxx5Pf=zC53mfOBNgtj1JQwjZVAQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
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

On Wed, Mar 2, 2022 at 11:54 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Mar 2, 2022 at 2:14 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Wed, Mar 2, 2022 at 10:47 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > As we change the C language standard for the kernel from gnu89 to
> > > gnu11, it makes sense to also update the version for user space
> > > compilation.
> > >
> >
> > Overdue.
> >
> > Can you point me to a lore link where I can easily fetch the full 3/3
> > v3 patchset?
>
> Hey Sedat!
>
> $ b4 am https://lore.kernel.org/lkml/20220301145233.3689119-1-arnd@kernel=
.org/
> -o - | git am -3
>

Hey Nick!

This only applies 1/3.

$ b4 --version
0.8.0

$ b4 am https://lore.kernel.org/lkml/20220301145233.3689119-1-arnd@kernel.o=
rg/
-o - | git am -3
Analyzing 14 messages in the thread
Will use the latest revision: v3
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
 =E2=9C=93 [PATCH v3 1/3] Kbuild: move to -std=3Dgnu11
   =E2=9C=93 Signed: DKIM/kernel.org
   + Reviewed-by: Nathan Chancellor <nathan@kernel.org> (=E2=9C=93 DKIM/ker=
nel.org)
 ERROR: missing [2/3]!
 ERROR: missing [3/3]!
 ---
 NOTE: install patatt for end-to-end signature verification
---
Total patches: 1
---
WARNING: Thread incomplete!
Link: https://lore.kernel.org/r/20220301145233.3689119-1-arnd@kernel.org
Base: not specified
Wende an: Kbuild: move to -std=3Dgnu11

- Sedat -

> https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestati=
on
>
> >
> > I would like to give this a try on x86-64 with my latest kernel-config
> > (based on the latest kernel-config v5.17-rc5 from Debian/unstable).
> >
> > What Linux source base do I need?
> > Is Linux v5.17-rc6 good enough (patchset applicable) for testing?
>
> I suspect so.
> --
> Thanks,
> ~Nick Desaulniers
