Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61F546C824
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbhLGXZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbhLGXZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:25:14 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840D8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:21:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m27so1794927lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asJWBO7eY0QcfrBWswJqa0D8PLdaP618kcEvbJ50eIg=;
        b=AfW0d1I+nq7/xxFpdy1SyfbN4hZQhpvUWKC/GFTTsGAkXcBRgPA3Uoi8dsklmKbnZs
         BaHhEvIBWm5tYwA3UXnxtEtRrd4pSEvtTaywyA4iXU1bWgPUv1tK8UvDnxlPZQHTsqyk
         bPw4p4cTEMmd76cOMbNIq9pGcYn9opr3bNzZnIOwlkqcs7avXNIRj1sJuvVgHL+Bez2q
         anbMo3xtEQ3nttb1ctyuDdZzWVrD4P3w5jqNVPOF+nFveMKvJDJ9RCt7l17U5PsENZsj
         bTPpPjS24TkJRZNtOIjeB76IOXqQdfSTcK7q8AHp9NSxsSAZQ2atebIn/FJNYJywWeJG
         e1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asJWBO7eY0QcfrBWswJqa0D8PLdaP618kcEvbJ50eIg=;
        b=7KUVL5YYbWQRUUd+83HCFyRkwV9rKJFLfb/g8lLOra0JOSYvw71FZaP3Y/UBh310CI
         +68lf+T6C7k2EbJrWpQI/ffPx/VB3T4fmrQVSYqZstH1HBDTsdTIO1XVLDPVhSeYi79T
         8Y6yN7JzYAV1QL2AnGmbH1c/HwPFKU9UsWQP4td62ui0tRtXThj7OI/eVrf3x2ZU/yOg
         v5e4mLglAGqPXKcMyiEya+LkCSjqfodlNuXlLywQZSGvWzzZ9BNn+lrzbcYnm6dKljJJ
         bo6/T7yQpMV0J92xa1aWX6ZCwv620HkaC7niGbltThufnxWnELpkIkjDPhpjRZ+du5Af
         gSwA==
X-Gm-Message-State: AOAM531+GCOEYoFWXF1uluyIsRZNX9pu4pMmR/dKwboArf/j39MbWdSE
        SVAsBmbpC7Fd7n0SawH88e1K5euUmdwq100FUhimBw==
X-Google-Smtp-Source: ABdhPJysjkyhUOJrmyHDdSyDIM7lBOtMYaXwrIgiy6u2C5zfwK9sd9NDowrss4BuvDXhYt26C+A6eoi0whwvH42sfZc=
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr42666731lfi.82.1638919301609;
 Tue, 07 Dec 2021 15:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-16-ojeda@kernel.org>
 <CAKwvOd=7QTUH69+ZbT7e8einvgcosTbDkyohmPaUBv6_y8RfrQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=7QTUH69+ZbT7e8einvgcosTbDkyohmPaUBv6_y8RfrQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Dec 2021 15:21:29 -0800
Message-ID: <CAKwvOdk9VNenJJN5HnPpGgsHT+OsRsgPGSesQgqMP2aLPWy0NQ@mail.gmail.com>
Subject: Re: [PATCH 15/19] Kbuild: add Rust support
To:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 2:45 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Dec 6, 2021 at 6:07 AM Miguel Ojeda <ojeda@kernel.org> wrote:
> >
>
> ... snip ...
>
> Miguel and team,
> I'm happy to see progress here! Just some quick notes after a first pass.
>
> Testing this series applied on mainline, I see:
> $ make LLVM=1 -j72 defconfig
> $ grep RUST .config
> CONFIG_HAS_RUST=y
> CONFIG_RUSTC_VERSION=14000
> # CONFIG_RUST is not set
> ...
> $ make LLVM=1 -j72 menuconfig
> # enable CONFIG_RUST
> $ make LLVM=1
> ...
>   CALL    scripts/checksyscalls.sh
> error: @path is unstable - use -Z unstable-options to enable its use
>
> error: @path is unstable - use -Z unstable-options to enable its use
> $ rustc --version
> rustc 1.40.0 (73528e339 2019-12-16)
>
> Can we update some Kconfig checks to fix that?

After now reading though the Documentation/ patch:

$ rustup update
$ rustc --version
rustc 1.57.0 (f1edd0429 2021-11-29)
$ make LLVM=1 -j72
...
make[1]: *** No rule to make target
'/usr/local/google/home/ndesaulniers/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/lib.rs',
needed by 'rust/core.o'.  Stop.

Maybe I'm holding it wrong, let me reread the Documentation/ again.

I still think CONFIG_RUST shouldn't be selectable unless
CONFIG_RUSTC_VERSION is either a blessed version, or above some
minimal value (like we do for CONFIG_GCC_VERSION, CONFIG_LD_VERSION,
CONFIG_CLANG_VERSION, LLD_VERSION, etc).

Also, it looks like I don't have bindgen installed. Anything we can do
there to help the developer out, as in informing them that it's
necessary perhaps via a Kconfig check? I don't think I should be able
to select CONFIG_RUST if I don't have bindgen installed. (Same comment
about version check probably applies, too).  Installing bindgen
doesn't change the error I'm observing above though.
-- 
Thanks,
~Nick Desaulniers
