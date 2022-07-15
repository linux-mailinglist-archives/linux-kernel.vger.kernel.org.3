Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591B2575904
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbiGOBNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiGOBN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:13:29 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEED61B02;
        Thu, 14 Jul 2022 18:13:29 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id c17so871008ilq.5;
        Thu, 14 Jul 2022 18:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5NIqMycZACDC+wr41k4tXL3ZG5mGSZ4ET8iOfR6n00=;
        b=XlGCC9+FlGreMYakH3DVPgazvSvcm8tHQ2IrolIeC27J6TlgywghW0hWX+jYrLjQhg
         xN/5SuWSpbiCMPjUaa1G5ew4JpReSZuZz4t7gVOliY9icVNvHyDVK2rj65uvg38YBMgT
         a+tV/5+OOrUUGtU0gSa+lJ3MrBal8EpkF0llBg98H0fxDMulm5QpVPszWe1+Q2SN74EE
         Q6REgwPEXmIiwlsUlzUfCaMMxG8pdPi8JWhtGtTAm7DkBEeyovQ4GsRb0u5qMQ8u26Gu
         BW3pSwzNa60XaZ3YtlNIlh5xZNF6g49npXFOIUW8uP293Klp9J43c8nb00A/yMQGjz5p
         E3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5NIqMycZACDC+wr41k4tXL3ZG5mGSZ4ET8iOfR6n00=;
        b=voPO++o5f1HjwwnpLDjggT5JdvhXiqrxO4QDLEubekbcXdg85GPnD0DPq04ExVf7RJ
         4Gra45+yzmmvQ9I2HvPECMBTEGThXDqD4yeKTGeNx5HDtiwBkcjqOl0t4exm/tyV5L6p
         +bs5HMQkiAdVk5movkR4QPDT0w5BiYGQW7Etb7tCL08oYQlPzjYW1Dhw1fFUf+8e+Tbf
         SgwsMczTEhTuwA3mRYkHcuyeEXFFm1kcgDHrsluQj7jRxUD67ODTiZdahlQialGDHoN1
         01afYdLFplqrKSpnk0OFa9utMKZ+QRT/QlefEHbwGy0F2aJ/SDrtwgPQehWYS08FLuTt
         GmpA==
X-Gm-Message-State: AJIora+XFIZp7fb2XYwEl9qODdulquR8v7Zo4tqU/VUjA9ugtBWn3xjx
        OmlQjlu4sFK9T4+x2OaC2W/iOf82nYm1YuXAuLs=
X-Google-Smtp-Source: AGRyM1truc/G4tBZKzgQbkRDYDLN93ZntDdSE/Jg7rZDp7eYrCWX34vEysc/EcvHjX5kaX5SgIa6Zoz3bOltZmPwKmk=
X-Received: by 2002:a92:c54e:0:b0:2dc:83a7:169e with SMTP id
 a14-20020a92c54e000000b002dc83a7169emr6035925ilj.72.1657847608805; Thu, 14
 Jul 2022 18:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220713203409.559c5464@canb.auug.org.au> <Ys6u88DqQdgmkWWf@hirez.programming.kicks-ass.net>
In-Reply-To: <Ys6u88DqQdgmkWWf@hirez.programming.kicks-ass.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 15 Jul 2022 03:13:17 +0200
Message-ID: <CANiq72k_dtr2=KX-WheUiM2v2370imAdWFawJR+8P41L7HjwpA@mail.gmail.com>
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
        Nick Desaulniers <ndesaulniers@google.com>
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

On Wed, Jul 13, 2022 at 1:40 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Does Rust have the equivalent of -mfunction-return=thunk-extern ?

While GCC has had it for a while, Nick just landed 2 days ago the
X86ReturnThunks pass in LLVM, so it will take some time to arrive in
rustc.

I have naively backported it to rustc and hacked it so that I set the
LLVM attribute for all functions, and I am getting the rets replaced
in Rust functions, e.g.

(gdb) disassemble a::f
Dump of assembler code for function _ZN1a1f17hdc6112b1b4a4fe99E:
   ...
   0x0000000000008a1f <+31>: pop    %rbp
   0x0000000000008a20 <+32>: jmp    0x8ce0 <__x86_return_thunk>

A trivial userspace program that counts the times that it goes through
the return thunk also appears to work.

> Related, how does Rust deal with all the various CC_HAS_ Kconfig stuff?
> What if C has the relevant option but Rust does not; then we must not
> have the feature enabled or there will be a mis-match.

I guess that would depend on the particular option: whether it applies
to Rust at all, whether it creates an incompatibility or not, etc.

> Do we now have to litter everythign with RUSTC_HAS_ ?

Why? Only a single `rustc` version is targeted at the moment, so it is
possible to statically know what it supports.

And later on, when we can declare a minimum version or when a second
compiler is ready, sure, we may need to have options depending on what
we want to do. Why would that be a problem?

Cheers,
Miguel
