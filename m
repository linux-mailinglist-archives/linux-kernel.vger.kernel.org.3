Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84D59BEB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiHVLkx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Aug 2022 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiHVLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:40:28 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F030C33A1D;
        Mon, 22 Aug 2022 04:40:26 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id a4so7598586qto.10;
        Mon, 22 Aug 2022 04:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=gD3YKhawXxvo58bUKUOlExnV1tyEwvD6NRrt00bkb+Q=;
        b=dq5FynGM93A1OSZj+kMxiBeTE/7L541T8P/w5PxNtZkiTIMxkOeUMP+Va9SmsMzjEF
         qxcjwMfM7FC6Egxy1krFKS894QLk/BjciiwPhVdAXWvb51oOulWVAyvGLXSOTbplFpBG
         DuAH8KYVjjdeCmRprNP+20iDzugDc4gTwEEBKJFykOET7A8oN/kRfo17+JNqGOiIJYK0
         2jEY0cWR41xLOP1KdD2r+VelL2mb9Wxqce6MEFajW1A0bI5m/tAWQWnwTL+YD9AbOjgU
         HxdI4kGXIB4AYGAu0TBdhM/K4dEGTIghfeev+G9TKCp0bDlfPtsb/8BVyk7G24uggU41
         MvOg==
X-Gm-Message-State: ACgBeo3GO9EejU99+fgIxlzaJDObzHqTsYzPz9NKXVpiLDk1Cu9scq1d
        Q8jPKQPcvjBFQxRGJwEn9kle0veZ6NJT1g==
X-Google-Smtp-Source: AA6agR753utc6EAXDankziXOrfZxJ70or+ICllnemqqzNUZzO7sbErIOf/AQrdWzp9Yw6a5lsBvgpA==
X-Received: by 2002:ac8:590d:0:b0:344:7e3a:3d9a with SMTP id 13-20020ac8590d000000b003447e3a3d9amr14649085qty.369.1661168425651;
        Mon, 22 Aug 2022 04:40:25 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id q15-20020ac8450f000000b003447ee0a6bfsm8679127qtn.17.2022.08.22.04.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 04:40:24 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3321c2a8d4cso284570947b3.5;
        Mon, 22 Aug 2022 04:40:24 -0700 (PDT)
X-Received: by 2002:a5b:bcd:0:b0:68f:b4c0:7eca with SMTP id
 c13-20020a5b0bcd000000b0068fb4c07ecamr18713118ybr.202.1661168424232; Mon, 22
 Aug 2022 04:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220815050815.22340-1-samuel@sholland.org> <5593349.DvuYhMxLoT@jernej-laptop>
 <3881930.ZaRXLXkqSa@diego> <2249129.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <2249129.ElGaqSPkdT@jernej-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Aug 2022 13:40:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEjKnkj8JKpHUajU=xnDyuWeHmtrz0Y7qML+_XuCxDRg@mail.gmail.com>
Message-ID: <CAMuHMdVEjKnkj8JKpHUajU=xnDyuWeHmtrz0Y7qML+_XuCxDRg@mail.gmail.com>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base devicetree
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Tue, Aug 16, 2022 at 11:28 AM Jernej Škrabec
<jernej.skrabec@gmail.com> wrote:
> Dne torek, 16. avgust 2022 ob 11:12:05 CEST je Heiko Stübner napisal(a):
> > Am Dienstag, 16. August 2022, 09:49:58 CEST schrieb Jernej Škrabec:
> > > Dne torek, 16. avgust 2022 ob 09:41:45 CEST je Krzysztof Kozlowski
> napisal(a):
> > > > On 15/08/2022 08:08, Samuel Holland wrote:
> > > > > +
> > > > > +       de: display-engine {
> > > > > +               compatible = "allwinner,sun20i-d1-display-engine";
> > > > > +               allwinner,pipelines = <&mixer0>, <&mixer1>;
> > > > > +               status = "disabled";
> > > > > +       };
> > > > > +
> > > > > +       osc24M: osc24M-clk {
> > > >
> > > > lowercase
> > > >
> > > > > +               compatible = "fixed-clock";
> > > > > +               clock-frequency = <24000000>;
> > > >
> > > > This is a property of the board, not SoC.
> > >
> > > SoC needs 24 MHz oscillator for correct operation, so each and every board
> > > has it. Having it here simplifies board DT files.
> >
> > I guess the oscillator is a separate component on each board, right?
>
> Correct.
>
> > And DT obvious is meant to describe the hardware - independently from
> > implementation-specific choices.
>
> There is no choice in this case. 24 MHz crystal has to be present.
>
> FWIW, including crystal node in SoC specific DTSI is already common pattern in
> Allwinner ARM SoC DTSI files.

I could also be a programmable clock generator on the board, programmed
to generate a 24 MHz clock on one of its outputs? Again, on the board.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
