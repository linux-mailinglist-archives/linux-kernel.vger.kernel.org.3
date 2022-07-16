Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F56576C91
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiGPIWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPIWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:22:53 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8D23718C;
        Sat, 16 Jul 2022 01:22:51 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 26G8MdC6030466;
        Sat, 16 Jul 2022 17:22:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 26G8MdC6030466
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657959760;
        bh=HFhi2GgLg7oEsoRiMqw8ZEkU/FUuixaMOlho3HR5dck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KQJPy4zY+KApyeS3nNKLZow7zNLtMccILdnCvGvqjtj+bVFKqJUrl/p26RcEfr0lR
         EsgJmADi6rIyoDr0VNkeQ9uUwFBfqDqEgN5AENI4WA1YjqWf0Fu9NrBF860LUvEhLm
         L2unvwJO7KBYkbGD2R8RaX524t8nvxYhy/YfYn9/wb15INl0HVt4AU0gi04OhrdhyK
         F+N/Nk5jHOQfD72VFKybMPJxZQRMuclRAzaxyjH/mwRz6df56v9M9FQIu+wKIL6Bkf
         ythtgKpy83ZwCtPuET3JGvFDboEs/odnApnmUemm4fPyrfwXw8Umd7R7PJyhdCTK4o
         xMVx1H6yxI8Rg==
X-Nifty-SrcIP: [209.85.128.42]
Received: by mail-wm1-f42.google.com with SMTP id n185so4053007wmn.4;
        Sat, 16 Jul 2022 01:22:39 -0700 (PDT)
X-Gm-Message-State: AJIora9NNEzbtGpIMSU6vehTraqGUNXSmBEin+QvhYyhihIMQKk0RyiP
        p8JSJ8MzgphNrqV+jd1Zz5dUSu6D6BmtDzycrOM=
X-Google-Smtp-Source: AGRyM1uoRO8Qz+FSCXJql+waCGu+mhRlQXVZ1LJNvE9kz6AJllMTUSrTJhZBfuW0GaHnoYXSlaf7O+xxZCeBVPOa6jI=
X-Received: by 2002:a05:600c:35d6:b0:3a2:e873:6295 with SMTP id
 r22-20020a05600c35d600b003a2e8736295mr17513065wmq.22.1657959758310; Sat, 16
 Jul 2022 01:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-22-ojeda@kernel.org>
In-Reply-To: <20220523020209.11810-22-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 16 Jul 2022 17:21:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZOTjxJyS3WC1sM7LE-An7DL8xoW=-s1ONe7cq4YukNQ@mail.gmail.com>
Message-ID: <CAK7LNAQZOTjxJyS3WC1sM7LE-An7DL8xoW=-s1ONe7cq4YukNQ@mail.gmail.com>
Subject: Re: [PATCH v7 21/25] Kbuild: add Rust support
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
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
        Daniel Xu <dxu@dxuuu.xyz>, Miguel Cano <macanroj@gmail.com>,
        David Gow <davidgow@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:04 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Having all the new files in place, we now enable Rust support
> in the build system, including `Kconfig` entries related to Rust,
> the Rust configuration printer, the target specification
> generation script, the version detection script and a few
> other bits.
>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Finn Behrens <me@kloenk.de>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Douglas Su <d0u9.su@outlook.com>
> Signed-off-by: Douglas Su <d0u9.su@outlook.com>
> Co-developed-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
> Co-developed-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Co-developed-by: Miguel Cano <macanroj@gmail.com>
> Signed-off-by: Miguel Cano <macanroj@gmail.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---





> +# Rust targets
> +# ---------------------------------------------------------------------------
> +
> +# "Is Rust available?" target
> +PHONY += rustavailable
> +rustavailable:
> +       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust-is-available.sh -v && echo >&2 "Rust is available!"
> +

Is it intentional to print the successful message to stderr?



-- 
Best Regards
Masahiro Yamada
