Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7C5210B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiEJJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiEJJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:24:51 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D6C54021
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:20:54 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id h13so12237999qvh.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uxcc/DTzovoffJ13PVN0mid4IVz9jbn3TyqnUZaKPk=;
        b=6Ialmy3L8GOUAg5sMNy7gNMor67JlaWmEWCHVDFdxzrBXkEr6OxyDd4Nqsp2Wi0CFG
         2sOEvvlMReLT4d1CtgzKpCdPZit7BOx5KabUsx+QLCwZIFZEtYeSbKrUqprQd/F/ThcA
         AJANKZHXqky7UwnLMR4WYNZBv+TuHXnrKfDanDtFt47YTgVmDjsj/Aq/xjpKxt2/THIe
         23ASn+eYJzU7gNC5cEbrKtv+4XHxFAKVUQUfdIAi4QArxCgQjk5AwJNUAyK4SGlIU0jq
         NWI3qsaeHboDRVB4pTSZE4xB7WWgfUmOJA4FQsFLt3w7jP7C0GpsOn1TY9FqdaKLoD9U
         8zZQ==
X-Gm-Message-State: AOAM530XhbdTaRjyok+s9nOCYfEkHnQaARdZgbLrsMMgKmo26nfHpTlc
        8oXDupuyad3p9rMNu8vNckA66V8GS9tAbQ==
X-Google-Smtp-Source: ABdhPJwhl8iaqR9nwyVCpSEuE5v3Y59PcPDYWygo7ZPmL0l2AcLAyYsKHFG2iEsBgxcFN1n+hvM9SQ==
X-Received: by 2002:a05:6214:2389:b0:435:ba04:8f18 with SMTP id fw9-20020a056214238900b00435ba048f18mr17173181qvb.4.1652174453405;
        Tue, 10 May 2022 02:20:53 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id k5-20020a05620a07e500b0069fc13ce1ecsm7947254qkk.29.2022.05.10.02.20.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 02:20:52 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id v59so29536555ybi.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:20:52 -0700 (PDT)
X-Received: by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP id
 f9-20020a056902038900b0063331c1d0f7mr16519213ybs.543.1652174451905; Tue, 10
 May 2022 02:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <df002b0ff3cb89954d5a2c39a5dd8528d45771f3.1652103603.git.geert+renesas@glider.be>
 <20220510091502.GA27219@willie-the-truck>
In-Reply-To: <20220510091502.GA27219@willie-the-truck>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 May 2022 11:20:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVyjZzuNTrinRddt=nRDU-=tb+vgweemaOpG6QWsKC=JQ@mail.gmail.com>
Message-ID: <CAMuHMdVyjZzuNTrinRddt=nRDU-=tb+vgweemaOpG6QWsKC=JQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: ARM Scalable Matrix Extension is ARMv9-A
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, May 10, 2022 at 11:15 AM Will Deacon <will@kernel.org> wrote:
> On Mon, May 09, 2022 at 03:40:30PM +0200, Geert Uytterhoeven wrote:
> > The help text for the config option to enable support for the ARM
> > Scalable Matrix Extension does not mention the specification baseline
> > for this extension.  Make it clear this is an extension for the ARMv9-A
> > architecture, so users know when it is safe to disable this option,
> > which is enabled by default.
> >
> > Fixes: a1f4ccd25cc25625 ("arm64/sme: Provide Kconfig for SME")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1964,9 +1964,9 @@ config ARM64_SME
> >       default y
> >       depends on ARM64_SVE
> >       help
> > -       The Scalable Matrix Extension (SME) is an extension to the AArch64
> > -       execution state which utilises a substantial subset of the SVE
> > -       instruction set, together with the addition of new architectural
> > +       The Scalable Matrix Extension (SME) is an ARMv9-A extension to the
> > +       AArch64 execution state which utilises a substantial subset of the
> > +       SVE instruction set, together with the addition of new architectural
>
> Why is this useful information? The v9 vs v8 distinction is purely a

Because I tend to disable support for extensions that are not present
in Renesas SoCs in the (local) renesas_defconfig.
If it's ARMv9, I know it's not present in e.g. Cortex-A57 or A-76.

> marketing thing, so I'd be _very_ wary of drawing any technical conclusions
> based on that, especially as Arm have a track record for "backporting"
> features into older CPUs if there is demand for it. Do you know what the
> toolchains have done here? (i.e. is there march=armv9-a or can you do
> march=armv8-a+sme or something else?).

I have no idea.  This option doesn't seem to control any compiler
flags?

> Having said all that, we do already have the Kconfig menu entries for "Armv8.x
> architectural features", so adding one for "Armv9" would be consistent with
> that if you really want it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
