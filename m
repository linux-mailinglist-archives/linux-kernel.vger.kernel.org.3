Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375654ED49F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiCaHPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiCaHOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:14:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9311B7634;
        Thu, 31 Mar 2022 00:11:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e22so27569531ioe.11;
        Thu, 31 Mar 2022 00:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=7x1fdU6pqjAZLbP5PtFUo2vUl+jZ2Pw0oZiQRelFaww=;
        b=jRJHzTJIP2ij7OoBi7EoxZn8Lv/F8ANuafSpdYYtHY2l0iu/EIhW6Axb/Eb4/ShbYj
         VvshYHke/Ek54uH1G11HOJy1G+0Rc3oIoKRZeclydKZDkl2AekzZsTswfJQ9QRleZWk5
         SY/3t+X+O2w2D4/xcBKR7FqhT5M0rE40lBf1Vxs5aRZxhUl5HwjPFilFZCa6b4+ahx4r
         CuzJ+Lu12dZOuSHnUKSwR5zOhNuyRtrLrca6ZTb7GPUwFm7nUUmts/9trsBecdsVzGf0
         SRKh08VlvGUX+JPPMwaAAdRYDaObjySTNuwrtI5YrORrfo2ADUHknLxWX2fNteipk+HI
         wRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=7x1fdU6pqjAZLbP5PtFUo2vUl+jZ2Pw0oZiQRelFaww=;
        b=D9TZCbzxxaLPRtVWAoyo782Xdhdcb9JXPar4CfqnbnwnI/LD+0si7bFFq+eO+10rFn
         nHkJo80hMZqXqaUGvCSW0cImWN62FtJnlEDstbWEusGvmP+66fMh/4uMkTbTyegZIATl
         5FWkZ4PGKFz1DYbgk+3K4oHQ17nSyzOMw6yv9V59sNKqnLDedwtYpCRvBap1w7qOGZ+f
         +K91fIkrff71G+rT1biog+Pu/tvvVBkBN7yWSwcfcuFal/6mF5I2gZaYHwIH5xdDq574
         reF4f862WtoIOFOKZee7j9nhywPc6LojzA3JTyAYlBokF6WzRpiDFtToAigsOUgcMzyU
         Ji+g==
X-Gm-Message-State: AOAM533sMxz6/bHiJWB2wNEqHzFhnjnbaYXfNeGd5x5xClzKl88LWM1v
        GpPGnrTW1LAous61K1DOjnftJcS6O23Bnv3l14I=
X-Google-Smtp-Source: ABdhPJwWy7Y4cOJDc9jZYpOHaZTQZy2emksvzTY5Pr5LwDRkTPWRmcVZAivt62hqNW+lswewqcf1Qrku/kUk4nI5bDQ=
X-Received: by 2002:a05:6638:a3a:b0:323:5c6d:ae20 with SMTP id
 26-20020a0566380a3a00b003235c6dae20mr2323427jao.80.1648710708247; Thu, 31 Mar
 2022 00:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220330234528.1426991-1-nathan@kernel.org> <20220330234528.1426991-2-nathan@kernel.org>
In-Reply-To: <20220330234528.1426991-2-nathan@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 31 Mar 2022 09:11:12 +0200
Message-ID: <CA+icZUXrVgGyaujA1iQEw5P3nJHVwMtbFxpE2gKktaxW0Xg-wg@mail.gmail.com>
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

On Thu, Mar 31, 2022 at 5:27 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> This flag is specific to clang, where it is only used by the 32-bit and
> 64-bit ARM backends. In certain situations, the presence of this flag
> will cause a warning, as shown by commit 6580c5c18fb3 ("um: clang: Strip
> out -mno-global-merge from USER_CFLAGS").
>
> Since commit 61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for
> building kernel with Clang") that added this flag back in 2014, there
> have been quite a few changes to the GlobalMerge pass in LLVM. Building
> several different ARCH=arm and ARCH=arm64 configurations with LLVM 11
> (minimum) and 15 (current main version) with this flag removed (i.e.,
> with the default of '-mglobal-merge') reveals no modpost warnings, so it
> is likely that the issue noted in the comment is no longer relevant due
> to changes in LLVM or modpost, meaning this flag can be removed.
>
> If any new warnings show up that are a result of the removal of this
> flag, it can be added back under arch/arm{,64}/Makefile to avoid
> warnings on other architectures.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  Makefile | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index daeb5c88b50b..f2723d9bfca4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -784,10 +784,6 @@ ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CPPFLAGS += -Qunused-arguments
>  # The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
>  KBUILD_CFLAGS += -Wno-gnu
> -# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
> -# source of a reference will be _MergedGlobals and not on of the whitelisted names.
> -# See modpost pattern 2
> -KBUILD_CFLAGS += -mno-global-merge
>  else
>
>  # gcc inanely warns about local variables called 'main'
> --
> 2.35.1
>

I have tested this several times and was able to boot into bar metal -
no problems with building and/or booting my kernel-modules.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

Just as a side-note:
As with Linux v5.18-rc1 and -std=gnu11 we change the above comment ...?

# The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
KBUILD_CFLAGS += -Wno-gnu

- Sedat -
