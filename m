Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE5359973D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347741AbiHSIZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiHSIZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:25:28 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4965EE1913;
        Fri, 19 Aug 2022 01:25:27 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id n21so2827118qkk.3;
        Fri, 19 Aug 2022 01:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZIz9uUnGvGIaQHLjwy5JfKqGUPRt15jYrUPzIJQykQk=;
        b=ZISG9WrP8kf1kOtq0BA0qF2iCqxMV8q/27fQnjiTCHhpg8mvyvgoeHk6963OsiZHd7
         MwkcV+uIt6A61Se0cxaI7NBLaSWs0eeryUvRHPEHyzGmb5mRiBsiYt4ZIRf6rps/eC1G
         QF+wl7xzH8yjoTNje1LXu2j8XIwhp9aOk0KeVtQIfcrnbeYLQN4r2tPXv2OZYpdLNvga
         hT5ejLpegd11RnzOR5vBHSybrWbD082FMkGSOLgArqgoGpssZQHa51MEKAnttW0zHgJu
         G6ZMAwwMqri4Og2oSa8QAsC9UVZoKiTvRGcbl2eQ58QaONDX50DyGWgwlrljHRTxjH08
         e0KA==
X-Gm-Message-State: ACgBeo3FRlwnnPpeW9thkEjmHbFht1R5kHV4LOlT1cB1OYsotDFFQSjT
        ppqwQIxLwZ0LUwVgUtLv/DFpcCJioeO0TA==
X-Google-Smtp-Source: AA6agR5tZIQrT01dl+s05GZhw1TbWhtib+sw8cy8vL7fUT+Ywl+K5/BFdLk0NHcHGdeBRCDIiXb2cQ==
X-Received: by 2002:a37:b306:0:b0:6b6:321:27a6 with SMTP id c6-20020a37b306000000b006b6032127a6mr4521503qkf.262.1660897526233;
        Fri, 19 Aug 2022 01:25:26 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id ch11-20020a05622a40cb00b0033b30e8e7a5sm2574690qtb.58.2022.08.19.01.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:25:25 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-324ec5a9e97so103272687b3.7;
        Fri, 19 Aug 2022 01:25:24 -0700 (PDT)
X-Received: by 2002:a5b:bcd:0:b0:68f:b4c0:7eca with SMTP id
 c13-20020a5b0bcd000000b0068fb4c07ecamr6672282ybr.202.1660897524733; Fri, 19
 Aug 2022 01:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <07342070-d96c-59fc-f9dd-b65cd742d97a@microchip.com> <CA+V-a8uNRr+WPX=YC+UMT4ch4S5XwsatHCzUoSt+hTk4C=cheA@mail.gmail.com>
In-Reply-To: <CA+V-a8uNRr+WPX=YC+UMT4ch4S5XwsatHCzUoSt+hTk4C=cheA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Aug 2022 10:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXjWsUF1_CnojrvT+EyEmAp25jkT2TyWSisGinAGgMb3w@mail.gmail.com>
Message-ID: <CAMuHMdXjWsUF1_CnojrvT+EyEmAp25jkT2TyWSisGinAGgMb3w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Aug 15, 2022 at 10:16 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Aug 15, 2022 at 8:00 PM <Conor.Dooley@microchip.com> wrote:
> > On 15/08/2022 16:14, Lad Prabhakar wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >
> > > Enable the minimal blocks required for booting the Renesas RZ/Five
> > > SMARC EVK with initramfs.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > v1->v2
> > > * New patch
> > > ---
> > >  arch/riscv/boot/dts/Makefile                  |  1 +
> > >  arch/riscv/boot/dts/renesas/Makefile          |  2 ++
> > >  .../boot/dts/renesas/r9a07g043f01-smarc.dts   | 16 ++++++++++
> > >  .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 22 +++++++++++++
> > >  arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 32 +++++++++++++++++++
> > >  5 files changed, 73 insertions(+)
> > >  create mode 100644 arch/riscv/boot/dts/renesas/Makefile
> > >  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
> > >  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> >
> > Just to sort out some of my own confusion here - is the smarc EVK
> > shared between your arm boards and the riscv ones? Or just the
> > peripherals etc on the soc?
> >
> RZ/Five SoC is pin compatible with RZ/G2UL Type 1 SoC (ARM64). RZ/G2UL
> SMARC EVK carrier board can be swapped with RZ/Five or RZ/G2UL SMARC
> SoM and still be used.
>
> > If it is the forver, does the approach suggested here for the
> > allwinner stuff make sense to also use for risc-v stuff with
> > shared parts of devicetrees?
> > https://lore.kernel.org/linux-riscv/3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com/
> >
> it does make sense. But I wonder where we would place the common
> shared dtsi that can be used by two arch's.

You can keep it under arch/arm/boot/dts/renesas/, and refer to
it from riscv as <arm64/renesas/...>.
Cfr. the symlinks under scripts/dtc/include-prefixes/arm64/ and
e.g. cros-ec-keyboard.dtsi.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
