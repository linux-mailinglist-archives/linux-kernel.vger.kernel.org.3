Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98D599B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348570AbiHSLmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348553AbiHSLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:42:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FEAFF8DA;
        Fri, 19 Aug 2022 04:42:40 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3246910dac3so113564467b3.12;
        Fri, 19 Aug 2022 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JsbjkAc9nKBUwo2BV+lJuV+9wDAaqVtP+AYnXddE06M=;
        b=iDTh499ntFuBhmhm7+PjOS+kN6/En/kCc/a8vA9tl2w1O8cLjE/Ir/vKAbzKCX8Or8
         jpBlUTLJMWCEtu9bqL4nJsIEUdcZlmXlHj28PE1T5Smwz/+PEyhw5wOmR+kLaM0dyp+W
         4mdXmFzMYFGg7GZbHh/eTn1fkvR1nGjW54Cmm/gTZpn0cxmmFZiVi2Czj9xL/AwAWTok
         d3V84hpqoxNbYkA1fWOJjcObObcoKJ9N0JLDLBPzHzosukWEM/iAjGHZ79P+1AYS7uRl
         kkRhHe0WScPj/Yn/mXzBUrdMm4u57g0Q12rYS4n47Uvg+Iv7EY6MWYLWeRxnzsUdEvt6
         XzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JsbjkAc9nKBUwo2BV+lJuV+9wDAaqVtP+AYnXddE06M=;
        b=2rtZQkGqUNvPPnTV829lQiPesHgGGQxNvGTWCp1nDk8YZan91+E4/MPHlct5lGYPmo
         LMwQtW4fQ2/nyC0MWEwvejr1lOvRRFw9yYvJTrcVCPQ3f8fInH49mOm404WnLTjPApr4
         yK68tyPhE37fjWd6RJENLKwh1aqWNvQkdgNJlPeiNUyjPge5UXqjMAdm55j/hw/Svy9B
         8P532ej1om1LV6glADHlY8pi5D7fRnDSMjV6b8XCBROx+q25e8NDfXbjBPfYYcnZ8DbO
         /dMX+yvMJjDg4QZY3k1jYGyW050fQ9f9IsQNhHutb+U5+X02hmm3BW6a40voGwFinpMV
         ot+g==
X-Gm-Message-State: ACgBeo1kQ2dMAAsiXR5KnVu/yfyoA9KFTCuQ+HmQ2t2GnCLHLV8XJpHY
        wxsf0xGVE+4OGsW7sKh6ICaI0xtVuApYF2MHWMI=
X-Google-Smtp-Source: AA6agR64CGhHuJItOoEwYlI4Q1qKbjkazebB6e8Fjy2TxN3npFljabqR+ivGNTyMVFhoyPJuhYFBJHKQURNW/HRyAmA=
X-Received: by 2002:a25:4689:0:b0:671:6d4f:c974 with SMTP id
 t131-20020a254689000000b006716d4fc974mr7342816yba.354.1660909359543; Fri, 19
 Aug 2022 04:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisGxHMBPUEa8nTMFpzw@mail.gmail.com>
In-Reply-To: <CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisGxHMBPUEa8nTMFpzw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 19 Aug 2022 12:42:12 +0100
Message-ID: <CA+V-a8tyvoVPctQU4Gz3FEQSCk0DBZ9=83qvh3P2UENJ5FSHAA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Aug 19, 2022 at 9:05 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhalar,
>
> On Mon, Aug 15, 2022 at 5:17 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> > Single).
> >
> > Below is the list of IP blocks added in the initial SoC DTSI which can be
> > used to boot via initramfs on RZ/Five SMARC EVK:
> > - AX45MP CPU
> > - CPG
> > - PINCTRL
> > - PLIC
> > - SCIF0
> > - SYSC
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/*
> > + * Device Tree Source for the RZ/Five SoC
>
> My first thought was:
>
>     This should be arch/riscv/boot/dts/renesas/r9a07g043f01.dtsi,
>      including the common r9a07g043.dtsi, shared by
>      arch/arm64/boot/dts/renesas/r9a07g043u11.dtsi.
>
> Then I realized this is harder than it sounds, due:
>
Indeed, my initial thought after the comments from Conor was we could
share the SoC dtsi, but that would be to messey due to PLIC.

Cheers,
Prabhakar

> > +       soc: soc {
> > +               compatible = "simple-bus";
> > +               interrupt-parent = <&plic>;
>
> vs. "interrupt-parent = <&plic>;" for r9a07g043u11, but mostly
> due to
>
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> > +
> > +               scif0: serial@1004b800 {
> > +                       compatible = "renesas,scif-r9a07g043",
> > +                                    "renesas,scif-r9a07g044";
> > +                       reg = <0 0x1004b800 0 0x400>;
> > +                       interrupts = <412 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <414 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <415 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <413 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <416 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <416 IRQ_TYPE_LEVEL_HIGH>;
>
> vs. "interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH> ..." on
> r9a07g043u11.
> Interestingly, the actual hardware interrupt numbers are the same,
> but the GIC DT bindings abstracts the offset of 32 by using a second
> cell and GIC_SPI.  Unfortunately this cannot be handled by some CPP
> magic, as dtc does not support arithmetic operations yet.
>
> I expect this or similar issues to pop up everywhere, when more
> RISCV-V SoCs will appear that share the non-CPU parts with ARM SoCs.
>
> Ignoring this issue, which we probably can solve only later:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
