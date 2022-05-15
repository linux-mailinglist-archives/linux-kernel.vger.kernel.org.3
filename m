Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E352783C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiEOOuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbiEOOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:49:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2A8186F9
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:49:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a5so13617099wrp.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVVOCTvJRX3Olou6oLL+JZw4cMsITWwHrp/zHjilPa0=;
        b=C+eq1A7HiHDaSo0p27ThkLSdQenQd4sfQWLvzP0ajbo/oIGxBN5Dqaz1SVvL3dcQg5
         t1uahCp1gCZeu50g/nzqoHTK9vjJ/C0ZgQkiYK91Gz+8A77RE5kE24SdXAZBKZ8YfWmE
         GhtKVZoYXFFfnhdpOr3Q4FiqiiEJ+Hgxcjwv7iEiGvRwPr3Asj16nr+DD/v7VBgmWDJU
         FUekiYTa1EJCHbTByoXJh84MoSbXSRqwb8GZFr1qOFJXXbB7DWbuVIlt/EPOK2Qxmu2c
         IkMnzinehd0xbC62K3YmNbctekwEuM7AfuCWVF0c0bXJwPSwDbL+YliNlRdn/M0H/ggv
         6GgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVVOCTvJRX3Olou6oLL+JZw4cMsITWwHrp/zHjilPa0=;
        b=VZQEtdo9l7iLu91W6qjLEERJGjjdnaEVGwaoA9zhDDXDqRdafjFUQ3Gget9PJmnozG
         ScoMq9wRUbkVOJwxcXTeB1oTn2vQJlUU23ZNB3r1o0NNa53sHMCYtq3CHs0lgscyFHKT
         qSpinETDYXyUwFqurcdBzyWf7YrEBcl+09F2T+Dphs8yS9NvfzjAJjmc1X0JN2GNY85J
         KcQk8frzlRBfc9wjew7d7wV2D9OfqO+xZzrCIVSc5iw0hOqzUJfbFFWY1KU1GCLQIx88
         cGN2xp9WUSzOsVjdln1iEUXbv4p69OANokih2xDmD+jCW7yiFMyALzkYXO4MhlYnGX9T
         WuYA==
X-Gm-Message-State: AOAM5302nd8pOjssW09HvDpcER6RXi+xCPvZuKv2fJ9UghgQp8jOWPsR
        9XQLfzk6wozf5Cx/nobpCaFPrMTs79xH/8wKL6HJYafrWSKS8w==
X-Google-Smtp-Source: ABdhPJwvR7potoC48hgEHBhyQ61tXNCGwdKt+L5cAyYYXHe31JWD4GvHiG2bEfrFRSngiArwFWJ2URXkxCY1N53mvkc=
X-Received: by 2002:adf:f001:0:b0:20d:22b:183c with SMTP id
 j1-20020adff001000000b0020d022b183cmr4176252wro.313.1652626190014; Sun, 15
 May 2022 07:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220508160749.984-1-jszhang@kernel.org> <20220508160749.984-3-jszhang@kernel.org>
 <CAK9=C2Xinc6Y9ue+3ZOvKOOgru7wvJNcEPLvO4aZGuQqETXi2w@mail.gmail.com>
 <YnkoKxaPbrTnZPQv@xhacker> <CAOnJCU+XR5mtqKBQLMj3JgsTPgvAQdO_jj2FWqcu7f9MezNCKA@mail.gmail.com>
 <YoCollqhS93NJZjL@xhacker>
In-Reply-To: <YoCollqhS93NJZjL@xhacker>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 15 May 2022 20:19:37 +0530
Message-ID: <CAAhSdy3_av5H-V_d5ynwgfeZYsCnCSd5pFSEKCzDSDBbD+pGLA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] riscv: introduce unified static key mechanism for
 CPU features
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 12:54 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Wed, May 11, 2022 at 11:29:32PM -0700, Atish Patra wrote:
> > On Mon, May 9, 2022 at 7:50 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> > >
> > > On Mon, May 09, 2022 at 09:17:10AM +0530, Anup Patel wrote:
> > > > On Sun, May 8, 2022 at 9:47 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > > >
> > > > > Currently, riscv has several features why may not be supported on all
> > > > > riscv platforms, for example, FPU, SV48 and so on. To support unified
> > > > > kernel Image style, we need to check whether the feature is suportted
> > > > > or not. If the check sits at hot code path, then performance will be
> > > > > impacted a lot. static key can be used to solve the issue. In the past
> > > > > FPU support has been converted to use static key mechanism. I believe
> > > > > we will have similar cases in the future.
> > > >
> > > > It's not just FPU and Sv48. There are several others such as Svinval,
> > > > Vector, Svnapot, Svpbmt, and many many others.
> > > >
> > > > Overall, I agree with the approach of using static key array but I
> > > > disagree with the semantics and the duplicate stuff being added.
> > > >
> > > > Please see more comments below ..
> > > >
> > > > >
> > > > > Similar as arm64 does(in fact, some code is borrowed from arm64), this
> > > > > patch tries to add an unified mechanism to use static keys for all
> > > > > the cpu features by implementing an array of default-false static keys
> > > > > and enabling them when detected. The cpus_have_*_cap() check uses the
> > > > > static keys if riscv_const_caps_ready is finalized, otherwise the
> > > > > compiler generates the bitmap test.
> > > >
> > > > First of all, we should stop calling this a feature (like ARM does). Rather,
> > > > we should call these as isa extensions ("isaext") to align with the RISC-V
> > > > priv spec and RISC-V profiles spec. For all the ISA optionalities which do
> > > > not have distinct extension name, the RISC-V profiles spec is assigning
> > > > names to all such optionalities.
> > >
> > > Same as the reply a few minutes ago, the key problem here is do all
> > > CPU features belong to *ISA* extensions? For example, SV48, SV57 etc.
> > > I agree with Atish's comments here:
> > >
> > > "I think the cpu feature is a superset of the ISA extension.
> > > cpu feature != ISA extension"
> > >
> >
> > It seems to be accurate at that point in time. However, the latest
> > profile spec seems to
> > define everything as an extension including sv48.
> >
> > https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#623-rva22s64-supported-optional-extensions
> >
> > It may be a redundant effort and confusing to create two sets i.e.
> > feature and extension in this case.
> > But this specification is not frozen yet and may change in the future.
> > We at least know that that is the current intention.
> >
> > Array of static keys is definitely useful and should be used for all
> > well defined ISA extensions by the ratified priv spec.
> > This will simplify this patch as well. For any feature/extensions
> > (i.e. sv48/sv57) which was never defined as an extension
> > in the priv spec but profile seems to define it now, I would leave it
> > alone for the time being. Converting the existing code
> > to static key probably has value but please do not include it in the
> > static key array setup.
> >
> > Once the profile spec is frozen, we can decide which direction the
> > Linux kernel should go.
> >
>
> Hi Atish, Anup,
>
> I see your points and thanks for the information of the profile
> spec. Now, I have other two points about isa VS features:
>
> 1. Not all isa extenstions need static key mechanism, so if we
> make a static key array with 1:1 riscv_isa <-> static key relationship
> there may be waste.
>
> For example, the 'a', 'c', 'i', 'm' and so on don't have static
> key usage.

Not all isa extensions but a large number of them will need a static
key. It's better to always have one static key per ISA extension
defined in cpufeatures.c

For example, F, D, V, Sstc, Svinval, Ssofpmt, Zb*, AIA, etc.

>
> 2.We may need riscv architecture static keys for non-isa, this is
> usually related with the linux os itself, for example
> a static key for "unmap kernelspace at userspace".
> static keys for "spectre CVE mitigations"
> etc.

These things look more like errata or workarounds so better
to use that framework instead of ISA extensions (or features).

Some of these things might even use ALTERNATIVEs instead
of static keys.

>
> In summary, I can see riscv_isa doesn't cover features which need static
> keys, and vice vesa.
>
> Could you please comment?
>
> Thanks in advance,
> Jisheng

Regards,
Anup
