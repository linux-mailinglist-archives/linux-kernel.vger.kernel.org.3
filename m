Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B2599B20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348533AbiHSLkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348114AbiHSLkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:40:09 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7310EF9F9;
        Fri, 19 Aug 2022 04:40:08 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3375488624aso84891817b3.3;
        Fri, 19 Aug 2022 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=V9Potjv6AygNMhgt+2OrpuJbud0dJblX7JtOBcX4tTc=;
        b=JhYvMSyYebnn/hH7W9E+SRJbQ/fAouSceya3rqItBq1mUu2XfX/4aesOWMFoqkaAJd
         YrBuKJMbKU3YQXzv1dLL2cgd5DMejo+X2iiH7WpkxfaGnw0zAAZuKbAkmPt7tCXP3Xpx
         kDLc5P/s7rK4E8b6QkrziPbuHbF4jps2FMyhsGzCk9s8i9Hq7FEPxGVdgYnkpkafoKx4
         9joN1M/K5fUaAxE9koqrRGIMxVRIx9971qLdYcOT+Saj1DLYcWVGsMX/+szKp7CIPnaQ
         +oPsAW1sZS4qUJKI1oBcarJzhOFflwwyTB7+Cw5oEC2fmBywy697klj9eftjoOvbGiKV
         /I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=V9Potjv6AygNMhgt+2OrpuJbud0dJblX7JtOBcX4tTc=;
        b=BoexOlSx2IkVz4Q8rNAyfWJ2d2yVhPgomgxOBDpYf9jpOTG0chK5rMbPOsnaPEM6/n
         8P4jggjAJmL5AP370W8gMlaepXRWTz24j0DTJT7Cav56vcLIIvr98GUrmlVPh+DL3cog
         rrB9HOEdk07QOA1CYR3ibXUknzhvF1cmK/3dL22M+xR2e04CgJL3YFuuKSqJJL/Rik7W
         MzxcsCKCTJ46U62r7rwClAXslws0YMeRU/rH9ZQk+94IsDTsJ13orVf5oOcfyUZftVSj
         HHVzP2CHdvSSp3YpzwaTiz4XrJm8dYj94Gmrt8isKuJ/S54sqiGkt0SMgZAQlg5ywoUy
         FzMQ==
X-Gm-Message-State: ACgBeo1M6EgzDbjMVaR30rtgagXaTYhDgsYQOONF2dZHacxnR4etSdt1
        oeegHlB+RYllUy6JTambyL/KEVwit7xQEerEJho=
X-Google-Smtp-Source: AA6agR5z/ae+3LUGHfPSdewFjNX850w3XDC/3VpieBRg+2ppKfE9XKW9bOyxaAObw85xyckVTg//mgFGeudhjeaxTyU=
X-Received: by 2002:a05:6902:20a:b0:670:c563:9180 with SMTP id
 j10-20020a056902020a00b00670c5639180mr7057933ybs.401.1660909207895; Fri, 19
 Aug 2022 04:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <07342070-d96c-59fc-f9dd-b65cd742d97a@microchip.com> <CA+V-a8uNRr+WPX=YC+UMT4ch4S5XwsatHCzUoSt+hTk4C=cheA@mail.gmail.com>
 <CAMuHMdXjWsUF1_CnojrvT+EyEmAp25jkT2TyWSisGinAGgMb3w@mail.gmail.com>
In-Reply-To: <CAMuHMdXjWsUF1_CnojrvT+EyEmAp25jkT2TyWSisGinAGgMb3w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 19 Aug 2022 12:39:40 +0100
Message-ID: <CA+V-a8t-O8ro8U3n46sjMS=HBJC-09V2hrdNXUCyhEZDrsiTfg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Geert,


On Fri, Aug 19, 2022 at 9:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Aug 15, 2022 at 10:16 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Mon, Aug 15, 2022 at 8:00 PM <Conor.Dooley@microchip.com> wrote:
> > > On 15/08/2022 16:14, Lad Prabhakar wrote:
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > >
> > > > Enable the minimal blocks required for booting the Renesas RZ/Five
> > > > SMARC EVK with initramfs.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > v1->v2
> > > > * New patch
> > > > ---
> > > >  arch/riscv/boot/dts/Makefile                  |  1 +
> > > >  arch/riscv/boot/dts/renesas/Makefile          |  2 ++
> > > >  .../boot/dts/renesas/r9a07g043f01-smarc.dts   | 16 ++++++++++
> > > >  .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 22 +++++++++++++
> > > >  arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 32 +++++++++++++++++++
> > > >  5 files changed, 73 insertions(+)
> > > >  create mode 100644 arch/riscv/boot/dts/renesas/Makefile
> > > >  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
> > > >  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> > >
> > > Just to sort out some of my own confusion here - is the smarc EVK
> > > shared between your arm boards and the riscv ones? Or just the
> > > peripherals etc on the soc?
> > >
> > RZ/Five SoC is pin compatible with RZ/G2UL Type 1 SoC (ARM64). RZ/G2UL
> > SMARC EVK carrier board can be swapped with RZ/Five or RZ/G2UL SMARC
> > SoM and still be used.
> >
> > > If it is the forver, does the approach suggested here for the
> > > allwinner stuff make sense to also use for risc-v stuff with
> > > shared parts of devicetrees?
> > > https://lore.kernel.org/linux-riscv/3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com/
> > >
> > it does make sense. But I wonder where we would place the common
> > shared dtsi that can be used by two arch's.
>
> You can keep it under arch/arm/boot/dts/renesas/, and refer to
> it from riscv as <arm64/renesas/...>.
> Cfr. the symlinks under scripts/dtc/include-prefixes/arm64/ and
> e.g. cros-ec-keyboard.dtsi.
>
Thanks for the pointer.

Cheers,
Prabhakar
