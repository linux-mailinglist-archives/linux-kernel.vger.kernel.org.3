Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7325597A09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbiHQXOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiHQXNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:13:55 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2779483BDD;
        Wed, 17 Aug 2022 16:13:55 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id o184so16912925oif.13;
        Wed, 17 Aug 2022 16:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uAFZhRG94yqKesKWZYz5Nx3zn74jTlFRVSrtAcB7opM=;
        b=k1YA1pS6Eajn7sFpOI3x8NusjBtYGTLlphQCfOr2iifQhQYUaZT4rFqmLD/dnKP9b0
         utTJIDqQJUQkYqpDPJEQSpJJyYNfgsMs6oM0rq19CKnK4L95D5GfF+cXJl8IGJgwp3zi
         l8/2VaIIRMi4bLQ4ldVdetEpn6sUd8H3RC0bDOEMLSdFLYf/pm6WA4p9f3FBAmB/9mNO
         Ya+2NapCpC+1bkSFyYgo9K7XUiXikWQMDF89oUPh4N7c7kSVCLVYfHFf4RX2YmQD/BJ+
         RHahVZppC8tmZH9/nDlRSCFUHQ2Jjbnzz15ck+oNRgTfBuH2OYcBdWAaAK8ktADD0UsG
         Sepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uAFZhRG94yqKesKWZYz5Nx3zn74jTlFRVSrtAcB7opM=;
        b=RiyLLm276x/7CZRCX8/2ftpny0ADxc0vq9W889vlBURYq1yJzPlH+zPtMGiI0oT1Vn
         3e8C/BKlr8MO9YT8Sec/e+QOjnX0rU8Re/EFwMuRZBEp2UrsYSX6tQI/MURYYS6ieD/Y
         wuoDRjHXFC1kGiW9XsdT6sX9+qxy4ilNLJHAHlHpEn2Lfyl712TxZL3T2GAd5OJXSVT+
         DUKh+Y22iq+kx0ajfmoXVZjyq7cej9vIbbObBWlFQp20yqyMmH8ELUnB21GbnEl2oPzY
         BKX7Wf7Y3KDOvLOVf2aVEzktdstPjB2/mS5kJV7OeNyW/No75WhUmCDCleU8/s7A9rVO
         HxAg==
X-Gm-Message-State: ACgBeo0KIftU54vWa5ZfjM7BIs4wzM/f/mAExkpFnNEEpSs3+LUwICcA
        +zPiXpbCf7dylLxWsWdesq4QsZYoSoSDmg7ZIE8=
X-Google-Smtp-Source: AA6agR5Gpv9Ub/ZSzw8wXnuwWJOg7P877U0UYF+ZIWdllhEPLwf7oW+lHlQM1was0sDQQVbiYoikM6dK3ZGBH+jke3Q=
X-Received: by 2002:a05:6808:4d2:b0:343:dc3:fa31 with SMTP id
 a18-20020a05680804d200b003430dc3fa31mr176406oie.120.1660778034487; Wed, 17
 Aug 2022 16:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-28-ojeda@kernel.org>
 <CAK8P3a0jqhGY9E85VC9gNem5q6-dWeq0H6-7bhJopinMnLtOKQ@mail.gmail.com>
 <CANiq72nNucEhXAXkXSujnGkpQrkv3-Pcn7ua8N=2XB-suAjs9w@mail.gmail.com> <CAK8P3a2YuGsSJY2-=npqXMHXEr+zaF36iDrM+kP=9nS85FLpbA@mail.gmail.com>
In-Reply-To: <CAK8P3a2YuGsSJY2-=npqXMHXEr+zaF36iDrM+kP=9nS85FLpbA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 18 Aug 2022 01:13:42 +0200
Message-ID: <CANiq72mW456PbD1WTkh0f=fhgO0FVdpjpXaT5cogXGT4BmKDjw@mail.gmail.com>
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

On Wed, Aug 17, 2022 at 5:51 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Thanks for the explanation. My hope was that building the kernel

Don't mention it!

> would actually be easier here than building the more complicated
> rust user space.

Yeah, the kernel is complicated for them in different ways, so I
assume they will decide which bits to tackle first... Hopefully I will
succeed in my attempts to convince them to focus a bit on the kernel
at least ;)

> I tried one more step and just removed the unsupported command
> line flags to see what would happen, but that did not get me any
> further:

Thanks!

It looks like it failed when compiling the target spec generator,
which is a Rust host program. If they were to attempt the GCC Rust
support early on, we could make things easier for them by not
compiling host programs with gccrs.

By the way, feel free to remove all the `-D` flags ("denying") when
playing with it since they are related to diagnostics (making lints
errors that can still be bypassed if needed), in case the crash is
about handling those.

Cheers,
Miguel
