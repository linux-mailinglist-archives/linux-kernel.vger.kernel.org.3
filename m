Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A246575FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiGOLBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGOLBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:01:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014985F99;
        Fri, 15 Jul 2022 04:01:16 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id u6so3592926iop.5;
        Fri, 15 Jul 2022 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmRCA/LiungRB9dNg0L8Jv8y/3XJdg8KhXJdHQWBT8s=;
        b=Qlx2ZfVFxy2UOWskdQiCPtPnqVYoYtwLvQq5Yu9diw8qStL3WTHIaJl75stp7d0aUw
         Yd6/zCaCsSBGKqWMWy56CWnVwieafFIWdRENyBTPWuXjl1SQHbrRALJBxOLPZZz5Vv28
         M/oZHoXBMV2ZWuGEzg0xCkVuobllCyMWGhXY+CsIfNrS9xtG1j19F/m/dkjWiBNUcs3v
         KmTvPKwQheikTZk2M/+ekm5wA5r2YJfpgj7pZbW8Rk6GSh8H9rfKy/oqPQpBFd8JUB0x
         7ulZauNFCa+n6F8Pzch2CD87W6t5upjGu+JL13DLLIdFeY7QOEg0pu29cyt+zrmDVTmw
         W+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmRCA/LiungRB9dNg0L8Jv8y/3XJdg8KhXJdHQWBT8s=;
        b=B06e+o0m4BCPEAU1KiGPqj/NcSRYhRodSA/cTfFGRrRZx8TNTi8dLIr50+Y/uvPytY
         ti6KCqpAEJyA8N3v1ehTqWxvCWUHYbx2oEQtjj58ljGe+Qj1WiGva9l0AxI/RbyERbAG
         0qSbaRaCA0JXdp6eutK3ODq5jqNqPz9LHzkjnEu52Gl6PZhXFIjfSnHM/9e+QZfwe4DJ
         d27+uK0lcHUWUKfqErli5tRsX7exfSAgMXB/ASwaxSI0ksF/sesNe4JKliXW5BAHTfXn
         ot9LurnF59wKa4yQGnCz/RJp3i6bKkpYm7uaQGxmJ+6HiSYW6M9nwXIxVUthu53S9oYH
         o5Pg==
X-Gm-Message-State: AJIora+t60j7AMt0K7P0YyCIeba+U4cZrRe3NkzZzKj6Ea5cuXhfV/yh
        5IJbmp9cNV4cwAHuicUBzE+o24aLodemRdb3GF8=
X-Google-Smtp-Source: AGRyM1vZZ3UQOGfgMYDweQ9lVqTLy5z2IcTlGeyhos85Km9ll0NOv2JAsRTLHjSUhSRirc+NzEesoMLnm/TjyLhbKUY=
X-Received: by 2002:a6b:e011:0:b0:67b:cf17:ddb8 with SMTP id
 z17-20020a6be011000000b0067bcf17ddb8mr4201071iog.44.1657882876035; Fri, 15
 Jul 2022 04:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220713203409.559c5464@canb.auug.org.au> <Ys6u88DqQdgmkWWf@hirez.programming.kicks-ass.net>
 <CANiq72k_dtr2=KX-WheUiM2v2370imAdWFawJR+8P41L7HjwpA@mail.gmail.com> <YtEs9H+JEDUq6NNm@worktop.programming.kicks-ass.net>
In-Reply-To: <YtEs9H+JEDUq6NNm@worktop.programming.kicks-ass.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 15 Jul 2022 13:01:04 +0200
Message-ID: <CANiq72=oOEdxY1bEA3YFwFkSiYk+Uwv=x-4yEwHgCz0SizY66w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with Linus' tree
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Borislav Petkov <bp@suse.de>, Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        joao@overdrivepizza.com, Kees Cook <keescook@chromium.org>,
        Arthur Cohen <arthur.cohen@embecosm.com>,
        Antoni Boucher <bouanto@zoho.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Philip Herron <philip.herron@embecosm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 11:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Ok; I'm supposing that'll be sorted by the time rust happens.

No, it most likely won't, and I don't see why you would assume that,
or why we would want to block Rust support on that.

> There's quite a few things affecting code-gen; rustc not using the exact
> same compiler arguments is going to create a head-ache.

Yes, a GCC-like driver in `rustc` would be nice for projects like the
kernel. The GCC Rust project will support GCC-like flags, as far as I
understand.

(Cc'ing Antoni, Arthur, Josh, Philip).

> But does it support everything clang does now? If not, you need to
> express that in Kconfig and disable the features it doesn't carry. So
> even for a single rustc version will you need RUSTC_HAS_ stuff.

You could still make everything work around the `RUST` symbol, no need
to "litter everything" (as you said) just yet. :)

> What about CC_HAS_IBT? Can rust generate sane IBT code? Current next
> doesn't seem to have anything there, suggesting I can't build an IBT
> enabled kernel if rust is on (or rather, it'll build, but it'll also
> burn at boot).
>
> What if LLVM were to grow -mindirect-branch-cs-prefix (please!) and rust
> doesn't have it? Same if LLVM finally stops generating those pesky
> conditional tail-calls, will rust continue emitting them?
>
> I'm thinking of the kCFI work, will rustc support that from day 1 or
> will that only work when not building any rust.
>
> There being a single rustc is not a single target, every compiler
> version grows (and breaks) new features. And for some reason we seem to
> change the actual kernel calling convetion a lot of late :/
>
> Currently we can support a feature when one compiler version supports it
> (either gcc or clang), but the moment rust becomes a mandatory part of
> the kernel build (and I dread that day) we'll need to
> wait/update/wrangle at least two different toolchains to implement the
> feature in a consistent manner before we can use it.
>
> I also don't see any RUST -mfentry support...

I think you are getting way too ahead.

Merging the Rust support now is meant to evaluate whether Rust _as a
language_ makes sense for the kernel, whether we can write enough % of
kernel code in the safe subset (and whether that brings enough
advantages), etc.

It is not meant to provide "day 1 support" for everything. In fact,
getting merged now is what will allow to grow support for everything
needed everywhere: not just in terms of compiler flags, faster
integration of LLVM codegen/mitigation features in `rustc`, new
frontends and backends (`rustc_codegen_gcc` and GCC Rust), etc.; but
also within the kernel, in terms of safe abstractions for kernel APIs,
kernel maintainers' experience with Rust, etc.

Cheers,
Miguel
