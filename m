Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37A5972C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiHQPNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240822AbiHQPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:13:38 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C111150;
        Wed, 17 Aug 2022 08:13:37 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id l5so3358080iln.8;
        Wed, 17 Aug 2022 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1Aw1dSa3JPytcA6jepz8LxW98jZGIVvGrbA5oXW6cF4=;
        b=QylPRZ7po85CmoykNUCyneM7mjy0jfxW6cm0tMG76VU+SEJs1TOHYjvUgCyJ5X34Ah
         29R7oZJhhLUIaE/wB+fpvInm0t+Qtil2d7DsxFJO50ROSKqBTc4hrnQGXwMIq6mca6hs
         54+kXi+r5dpmDFccUSfnuFBS3sWyt6leP9lY9G9/jXs02kwOe+87RXKykgBUvBdu+VxK
         zgC40tcbIxY+/ARk2CL5sgZZPmfoBBvLljwObz/HD90zb/2wCmgAigALmX3sUAZMaM6/
         yYvXO5L6d8RGEEhjCx/i99yVgYsx0VSd+Ea2XG0jsxBYGj9nUTR57UcZ9Som18Y15zyH
         eUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1Aw1dSa3JPytcA6jepz8LxW98jZGIVvGrbA5oXW6cF4=;
        b=ufe1hEfqk05NHFKRKRlClYW9bZhuy/rHvu05/sxI9i0gxEnNjSKlFWo5Secw4+LyHX
         WfRX2xT7xB0xx6vXSRwJlTFqNIj5YW4yVEKaDkEk7tOUYgfS/eCOYxWU0qxNWG76Gfe7
         Tbn4d++qj9kme8FsrKTATPRFqNGjaAxVCYPWAYuji02dqEx64GqHx98rGoWY8kl4JLjX
         7lzoI51iDWAT9y+79QI/MVX09cm6XqPDQavmUUyAOK366kKR9iheTgDa/mBBtwM5UTjF
         dnzA9/VKeSGDcv5u2JscHE6aVb48ZiVjk2+I8va+aTGrcr3DgkuHIWu26o/brX33LuDJ
         aINQ==
X-Gm-Message-State: ACgBeo347fI7Io18tzujbJnuBHUxAV6hKepYQMfZa4Wanj3Vt2+8H6l9
        zWByQrXt0F6AJyoXzM6uGR/29zvacGDNiL9txlU=
X-Google-Smtp-Source: AA6agR76oTCoP2K9omiY3xisTcRhkl/VGb6FFCKu/kjjdtf4CwkBwADBK/ZOKLvdnvOPta40wh5R8EYE/TiRBIyFijg=
X-Received: by 2002:a05:6e02:1522:b0:2e5:9e3c:a7c8 with SMTP id
 i2-20020a056e02152200b002e59e3ca7c8mr8021588ilu.237.1660749216849; Wed, 17
 Aug 2022 08:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-28-ojeda@kernel.org>
 <CAK8P3a0jqhGY9E85VC9gNem5q6-dWeq0H6-7bhJopinMnLtOKQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0jqhGY9E85VC9gNem5q6-dWeq0H6-7bhJopinMnLtOKQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 17 Aug 2022 17:13:25 +0200
Message-ID: <CANiq72nNucEhXAXkXSujnGkpQrkv3-Pcn7ua8N=2XB-suAjs9w@mail.gmail.com>
Subject: Re: [PATCH v8 27/31] Kbuild: add Rust support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Miguel Cano <macanroj@gmail.com>,
        Paul Mackerras <paulus@samba.org>, Gary Guo <gary@garyguo.net>,
        Douglas Su <d0u9.su@outlook.com>,
        Borislav Petkov <bp@alien8.de>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-um@lists.infradead.org,
        =?UTF-8?Q?Bj=C3=83B_6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Daniel Xu <dxu@dxuuu.xyz>, David Gow <davidgow@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        linux-arm-kernel@lists.infradead.org,
        Tiago Lam <tiagolam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Richard Weinberger <richard@nod.at>,
        Finn Behrens <me@kloenk.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linuxppc-dev@lists.ozlabs.org,
        Philip Herron <philip.herron@embecosm.com>,
        Arthur Cohen <arthur.cohen@embecosm.com>
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

Hi Arnd,

On Wed, Aug 17, 2022 at 4:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Hi Miguel,
>
> I tried enabling rust support in the gcc builds I provide at
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/arm64/12.1.0/

Thanks for giving it a go!

> to make this more accessible, but it appears that the command line
> options here are not portable:
>
>  /home/arnd/cross/x86_64/gcc-12.1.0+rust-nolibc/x86_64-linux/bin/x86_64-linux-gccrs

So you mean with GCC Rust, right? (i.e. we have "GCC builds" working,
via compiling the Rust side with LLVM and linking with the GCC C side,
but it is not intended for production or to be supported, even if we
cover it in our CI, test it boots and loads modules etc.).

Indeed, `gccrs` does not support `rustc` flags yet. I am not sure if
the GCC Rust team will eventually provide a driver for those like
clang does for e.g. `cl` -- I would hope they do, since many projects
would benefit from it, but maybe they plan to start simply by
modifying Cargo to call them as they need instead.

If they don't support it, we will have to map the flags on our side --
it should not be a big problem. However, see below...

> I guess nobody has tried this so far. Would you think that fixing this is only
> a matter for fixing the build system to pass the correct flags depending on the
> compiler, or is this broken in a more fundamental way?

If you meant GCC Rust, then it is a bit too early for the compiler. As
far as I now, they are working on compiling the `core` crate and
supporting more stable language features. They are also researching
the integration of the borrow checker, though we wouldn't need that
for "only" compiling the kernel.

Now, if they decided to focus on supporting Rust for Linux early on
(which would be great), they would still need to work on the delta
between what what they target now and what we use (which includes both
stable and some unstable features), plus I assume infrastructure bits
like the platform (target spec) support, the flags / `rustc` driver
(though I would be happy to do as much as possible on our side to
help), etc.

(We privately talked about possible timelines for all that if they
were to focus on Rust for Linux etc., but I let them comment or not on
that... Cc'ing them! :)

Cheers,
Miguel
