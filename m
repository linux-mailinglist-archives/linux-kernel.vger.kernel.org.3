Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978B046C834
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbhLGX3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbhLGX3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:29:20 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D6AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:25:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id l22so1874085lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksO4mg+S5nd7OsgjcUoTpMFoQ8vcHTeW8iC1snF/+Pg=;
        b=ITW+AL0If2STlT+rWDw9Rz+6svEqbZDjkcRjZCJavg4JhKjkYJjYJ4TgzaKaO6hBPx
         XN2/8ETl+zn4bHiGoQeSHzXfMfC8/3WB+EA8rHgTqUzsIG87uYIFgEPGpQxixCXeA5v1
         vhbbrdRcd1Xb6SJH+Tq51qbqymoiOl5josa+E7y1LMlTsvq0tFRa6eFk/OVM8pS7zNpd
         qP2h5sqaBor4sK87jIUVnNd7QYHH4F+R7WPIXGxUe6kacNm4W/NCsyxhUZhwGOnKham+
         9O2bAPLbwrZGdubVScM8k+9deJV8Bz+wrfsZz4KH1i52GwH25BJ9yMQUTK0J+nPiR4ms
         zlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksO4mg+S5nd7OsgjcUoTpMFoQ8vcHTeW8iC1snF/+Pg=;
        b=g3e33WZ0cHq9LJlhNijUnKMgSX05ROVSk20Akg3BG/VPVkygZe3/dWF+6j7mfu+6Mr
         6/Z0DJ3EWEqie7nHU2l4RF2GyNUge+Wej1GqZNOp48KuG3Y7Pl2U4HEBfumjs264HBIM
         zdkBEQ8i1j2QRqSOI2XiTnN2fW+eCbpCiJpSOTfxLw1PtKsslRJ+EZnWAJ9lA4kESmRN
         5FFkF7XVK4hmc6YAXNs0Uqw8ukTXYBynFTsVmE5+J2ozWfFRnG/ZdXvK2siHeVBd6PXn
         JAD8bJmMW1S4+Hf9TlmJiIcQDtteqQLJP2z4gyo6Gd3b8icOeY5SJe0Q2Oeijh5fyrpA
         VC9Q==
X-Gm-Message-State: AOAM530O/Jy8kKPGm7CHvZVHWmdfYlCg5VM6/9it8GpdkiUAn1dRjYRk
        J8WJzyqTlIy31aFfKc4atAmfwHsTIo7GFr+FAsrf
X-Google-Smtp-Source: ABdhPJzhR31dAJMhOqm9mRgPph2EUpsZZiP/J0+mFg/LTgJsz9Sg++yNDLy9FvTrMmTf99tJ0mmqbzh+TckRPhulQZg=
X-Received: by 2002:a19:7019:: with SMTP id h25mr45875416lfc.464.1638919547275;
 Tue, 07 Dec 2021 15:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-16-ojeda@kernel.org>
 <CAKwvOd=7QTUH69+ZbT7e8einvgcosTbDkyohmPaUBv6_y8RfrQ@mail.gmail.com> <CAKwvOdk9VNenJJN5HnPpGgsHT+OsRsgPGSesQgqMP2aLPWy0NQ@mail.gmail.com>
In-Reply-To: <CAKwvOdk9VNenJJN5HnPpGgsHT+OsRsgPGSesQgqMP2aLPWy0NQ@mail.gmail.com>
From:   Wedson Almeida Filho <wedsonaf@google.com>
Date:   Tue, 7 Dec 2021 23:25:36 +0000
Message-ID: <CAMKQLNJKumnucRHttHFN0cMK_g6kCJ7o0ev_3_RJsmPqbjo08g@mail.gmail.com>
Subject: Re: [PATCH 15/19] Kbuild: add Rust support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
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

On Tue, 7 Dec 2021 at 23:21, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Dec 7, 2021 at 2:45 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Mon, Dec 6, 2021 at 6:07 AM Miguel Ojeda <ojeda@kernel.org> wrote:
> > >
> >
> > ... snip ...
> >
> > Miguel and team,
> > I'm happy to see progress here! Just some quick notes after a first pass.
> >
> > Testing this series applied on mainline, I see:
> > $ make LLVM=1 -j72 defconfig
> > $ grep RUST .config
> > CONFIG_HAS_RUST=y
> > CONFIG_RUSTC_VERSION=14000
> > # CONFIG_RUST is not set
> > ...
> > $ make LLVM=1 -j72 menuconfig
> > # enable CONFIG_RUST
> > $ make LLVM=1
> > ...
> >   CALL    scripts/checksyscalls.sh
> > error: @path is unstable - use -Z unstable-options to enable its use
> >
> > error: @path is unstable - use -Z unstable-options to enable its use
> > $ rustc --version
> > rustc 1.40.0 (73528e339 2019-12-16)
> >
> > Can we update some Kconfig checks to fix that?
>
> After now reading though the Documentation/ patch:
>
> $ rustup update
> $ rustc --version
> rustc 1.57.0 (f1edd0429 2021-11-29)
> $ make LLVM=1 -j72
> ...
> make[1]: *** No rule to make target
> '/usr/local/google/home/ndesaulniers/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/lib.rs',
> needed by 'rust/core.o'.  Stop.

Can you run `rustup component add rust-src`?

When we change the compiler version, we need to install the source
code for `core` for the new version. (We'll update the documentation
to reflect that.)

> Maybe I'm holding it wrong, let me reread the Documentation/ again.
>
> I still think CONFIG_RUST shouldn't be selectable unless
> CONFIG_RUSTC_VERSION is either a blessed version, or above some
> minimal value (like we do for CONFIG_GCC_VERSION, CONFIG_LD_VERSION,
> CONFIG_CLANG_VERSION, LLD_VERSION, etc).
>
> Also, it looks like I don't have bindgen installed. Anything we can do
> there to help the developer out, as in informing them that it's
> necessary perhaps via a Kconfig check? I don't think I should be able
> to select CONFIG_RUST if I don't have bindgen installed. (Same comment
> about version check probably applies, too).  Installing bindgen
> doesn't change the error I'm observing above though.
> --
> Thanks,
> ~Nick Desaulniers
