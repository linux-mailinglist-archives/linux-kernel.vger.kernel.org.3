Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A44EE123
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbiCaSzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiCaSzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:55:20 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AE949903;
        Thu, 31 Mar 2022 11:53:32 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z7so617757iom.1;
        Thu, 31 Mar 2022 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fjHiw3tSlF8xzWdnfkDJb8f7xRlTsPnt1EO5+A/JUI0=;
        b=IJG/vzXBHrQid5Fx+EDcVAs9Ne8QV4eyVw+Gp8x1ezIxrePb1NplYbLGAZrcslz9xJ
         6StX0CKnZb5FjBqMF0yZG48YfddNonUtscxgadjdMcB+ky+3dVsLffJK4f4n4PsXGCge
         dGfmSz8FNMr6ywgtj6OLg/GWLFAhMg7hyzZK8GZTISwvsdFhihDtzoBwGuVodwGAs2lG
         SpKvZvIjnCrs/B8+AZwhiQXtl/+iPu1vMfm+qErDh6YtYbOQUi/6Lp7MR7XhVxakyavj
         FqEUuKMab98QbGcLdsdF6vywmlSYTBsrbmbYDSxin/S73pPROkkMZPjuF3mMfrV7BVQU
         qqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fjHiw3tSlF8xzWdnfkDJb8f7xRlTsPnt1EO5+A/JUI0=;
        b=Ru0fVPvaAh0dquA1Neo0Btwqhk9oLdzBLFZzvHFHwv9xQxBHOkmPIfgvMV5tCS4FBV
         +NgdzDIjzthkUcZH3UnLvNZ6EQIL34fiQKHMk7hx9bLQkJnS09NPdCUyWLUNBxr0AZsP
         tcbTOvQCMkOzQ3IWPXidWH64GuB7df5XE6YHeCMTilN5454qivuyyA9xVOwHW+gz75mn
         Lc7L22qkn9UKkk7Xw06vzvYdznKwcyaZsutja8NA4wQY6OCaxInUhwp7UPjWq5bBmm6F
         ZuiqqUTgikZqIPQLsNrWQqHoTFSfV0NCTSmFPPwyZ5xM0zWg89SWP9aLrS77KeR7NLAh
         Ch5w==
X-Gm-Message-State: AOAM530t1macq+vXzFhKpkWhWoYRHioydT7o8ffGpnveb7k+W/nUyvWJ
        KPhxsKEMVCkejMhiPXYX1ZuLbCbFu4doDUH3vfQ=
X-Google-Smtp-Source: ABdhPJwPysv+BsKwur5Dvxd4Qoxgl32o1LBJWqaDmMm7KgBE0tN7H8IfFeGziEZ59jhgHpSE7+2K37QOmZhQmxtuhnI=
X-Received: by 2002:a05:6638:a3a:b0:323:5c6d:ae20 with SMTP id
 26-20020a0566380a3a00b003235c6dae20mr3877699jao.80.1648752811797; Thu, 31 Mar
 2022 11:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220330234528.1426991-1-nathan@kernel.org> <20220330234528.1426991-2-nathan@kernel.org>
 <CA+icZUXrVgGyaujA1iQEw5P3nJHVwMtbFxpE2gKktaxW0Xg-wg@mail.gmail.com> <YkXKnRwvbMdvOtlJ@thelio-3990X>
In-Reply-To: <YkXKnRwvbMdvOtlJ@thelio-3990X>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 31 Mar 2022 20:52:55 +0200
Message-ID: <CA+icZUV-pHn0mWCnHr2x9SrcbaQos=M=Eg7p2KOaca829DmN_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: Remove '-mno-global-merge'
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 5:37 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Mar 31, 2022 at 09:11:12AM +0200, Sedat Dilek wrote:
> > On Thu, Mar 31, 2022 at 5:27 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > This flag is specific to clang, where it is only used by the 32-bit and
> > > 64-bit ARM backends. In certain situations, the presence of this flag
> > > will cause a warning, as shown by commit 6580c5c18fb3 ("um: clang: Strip
> > > out -mno-global-merge from USER_CFLAGS").
> > >
> > > Since commit 61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for
> > > building kernel with Clang") that added this flag back in 2014, there
> > > have been quite a few changes to the GlobalMerge pass in LLVM. Building
> > > several different ARCH=arm and ARCH=arm64 configurations with LLVM 11
> > > (minimum) and 15 (current main version) with this flag removed (i.e.,
> > > with the default of '-mglobal-merge') reveals no modpost warnings, so it
> > > is likely that the issue noted in the comment is no longer relevant due
> > > to changes in LLVM or modpost, meaning this flag can be removed.
> > >
> > > If any new warnings show up that are a result of the removal of this
> > > flag, it can be added back under arch/arm{,64}/Makefile to avoid
> > > warnings on other architectures.
> > >
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > >  Makefile | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index daeb5c88b50b..f2723d9bfca4 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -784,10 +784,6 @@ ifdef CONFIG_CC_IS_CLANG
> > >  KBUILD_CPPFLAGS += -Qunused-arguments
> > >  # The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
> > >  KBUILD_CFLAGS += -Wno-gnu
> > > -# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
> > > -# source of a reference will be _MergedGlobals and not on of the whitelisted names.
> > > -# See modpost pattern 2
> > > -KBUILD_CFLAGS += -mno-global-merge
> > >  else
> > >
> > >  # gcc inanely warns about local variables called 'main'
> > > --
> > > 2.35.1
> > >
> >
> > I have tested this several times and was able to boot into bar metal -
> > no problems with building and/or booting my kernel-modules.
> >
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> I would be very concerned if you did see any impact, given this flag is
> ARM specific :) thanks as always for verifying!
>
> > Just as a side-note:
> > As with Linux v5.18-rc1 and -std=gnu11 we change the above comment ...?
> >
> > # The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
> > KBUILD_CFLAGS += -Wno-gnu
>
> It was updated as part of the shift to '-std=gnu11':
>
> https://git.kernel.org/linus/e8c07082a810fbb9db303a2b66b66b8d7e588b53
>
> The UML tree is based on 5.17-rc6, which does not have that change.
> There should not be a merge conflict though.
>

Ah OK, a different base for UML.

- Sedat -
