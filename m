Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D875821CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiG0IK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiG0IKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:10:25 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301DA559B;
        Wed, 27 Jul 2022 01:10:24 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31d85f82f0bso166964557b3.7;
        Wed, 27 Jul 2022 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8WsuTI5HqjVqZ3mqJBPeJnAkwvhfGL30L5LTvOm6u4=;
        b=D5Kgg84JRiZOPD+q5N9vaIRd2tAD5RR1MMcDuqJUuLM5SoPObzBi0fHFHtSyVJUR9O
         v98JAwUINxP/fSbxHCfYR5FNx4zgpBC6hISx2oW9k0/zBoX9FE7YiJW+J1EFMEAEJ+Oq
         lA2xBcvprRZtJ+tHFoyslZUNR5dAFOwIGhqiaS9/SmpRU/TgdpMjXJ/EhTDnZfA+Dbq/
         hZYkSm7aS2gxXZFc93DL31tdTuVc1ePql257a4NK2rTX46Eqz+9E3k8hznhoenxQDIeC
         figuSrUlcgUE5iPST0Y6XB2hsacUgifsw9KnJp79loAdx2GyMHN7e1D2M4xe4ceLDo77
         /0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8WsuTI5HqjVqZ3mqJBPeJnAkwvhfGL30L5LTvOm6u4=;
        b=kFpzpIAqA7JWNLUr7XxOOHbNVKlUzZRYED0n5OyaDj+c255fo89vmFCnEuooSaZf8J
         HsIXZuEL/T2lrWuBtsL6IalUiiCg7kboWgDPNbWiAG6U4+eO+Dvl8CWPF1Ho16XEyDSm
         E0hQlMSOqHRW7hW7LMhn3vao1cohmdoH6sVHLs1vqxLeOIfQaLD94+b7MiYKq0QQQPbp
         txenUmw+4UH2BLoudytMs9kYJRmbIa+rYUf+ek0K4vSop+3a+uVLUmTwtPTZrDF7o/er
         hCwkOPKYkkKb8gU2/Ctm/MPngzwA1ip6ovSA7m8Fe3VjvBrgpB4v5S0g3iwZrzZMgKCE
         64uQ==
X-Gm-Message-State: AJIora/hT2rgrQC8dh197zMWB6EiD24kJF18xJHt5j3nHQ5otY9xG8Sa
        pxahbsI/1A5jvFHIwzgOYhmUktRRUgaG6favo8o=
X-Google-Smtp-Source: AGRyM1tq/fVV6xPYbEKCqMXyTJ4clWzdeyD8mpCOp2Jxixf0hphMcBS1e5sTtpCLva92LX3/MwHqdomugY1fgU0srZs=
X-Received: by 2002:a81:d542:0:b0:31e:c878:7565 with SMTP id
 l2-20020a81d542000000b0031ec8787565mr17170281ywj.382.1658909423375; Wed, 27
 Jul 2022 01:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <cc6f723a-441e-55fc-5044-890d45fb79b4@microchip.com>
In-Reply-To: <cc6f723a-441e-55fc-5044-890d45fb79b4@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 09:09:55 +0100
Message-ID: <CA+V-a8vwhsa2S2UX+hi0MPnrjpfRYLzo1Ca1vffx-5A9jr6Hpg@mail.gmail.com>
Subject: Re: [PATCH 6/6] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Conor.Dooley@microchip.com
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Conor,

On Tue, Jul 26, 2022 at 7:25 PM <Conor.Dooley@microchip.com> wrote:
>
> Hey,
> Saw your other binding patches coming in earlier & wondered if
> this would show up today ;)
>
:)

> On 26/07/2022 19:06, Lad Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
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
> > ---
> >  arch/riscv/boot/dts/Makefile               |   1 +
> >  arch/riscv/boot/dts/renesas/r9a07g043.dtsi | 121 +++++++++++++++++++++
>
> Missing files? Where is your Makefile for this directory?
> Or the board dts?
>
My plan was to get the initial minimal SoC DTSi and then later
gradually add the board DTS, but it looks like I'll have to include it
along with this series.

> Enabling CONFIG_SOC_RENESAS_RZFIVE causes dtbs_check to fail :(
>
I shall include the Makefile and boards dts in v2

> >  2 files changed, 122 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> >
> > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> > index ff174996cdfd..b0ff5fbabb0c 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -3,5 +3,6 @@ subdir-y += sifive
> >  subdir-y += starfive
> >  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
> >  subdir-y += microchip
> > +subdir-y += renesas
> >
> >  obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
> > diff --git a/arch/riscv/boot/dts/renesas/r9a07g043.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> > new file mode 100644
> > index 000000000000..6e0b640c6c7f
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/*
> > + * Device Tree Source for the RZ/Five SoC
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
>
> Including arm gic stuff on riscv? That seems a bit odd to me.
>
Ouch this needs to be replaced with irq.h (required for IRQ_TYPE_LEVEL_* flags)

> > +#include <dt-bindings/clock/r9a07g043-cpg.h>
> > +
> > +/ {
> > +       compatible = "renesas,r9a07g043";
> > +       #address-cells = <2>;
> > +       #size-cells = <2>;
> > +
> > +       /* clock can be either from exclk or crystal oscillator (XIN/XOUT) */
> > +       extal_clk: extal-clk {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               /* This value must be overridden by the board */
> > +               clock-frequency = <0>;
>
> Why add the empty value in that case?
>
For ARM64 SoC DTSI we use the above approach so f Iollowed the same,
but you are right this can be dropped.

> > +       };
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               timebase-frequency = <24000000>;
> > +
> > +               ax45mp: cpu@0 {
> > +                       compatible = "andestech,ax45mp", "riscv";
> > +                       device_type = "cpu";
> > +                       reg = <0x0>;
> > +                       status = "okay";
> > +                       riscv,isa = "rv64imafdc";
> > +                       mmu-type = "riscv,sv39";
> > +                       i-cache-size = <0x8000>;
> > +                       i-cache-line-size = <0x40>;
> > +                       d-cache-size = <0x8000>;
> > +                       d-cache-line-size = <0x40>;
> > +                       clocks = <&cpg CPG_CORE R9A07G043_AX45MP_CORE0_CLK>,
> > +                                <&cpg CPG_CORE R9A07G043_AX45MP_ACLK>;
> > +
> > +                       cpu0_intc: interrupt-controller {
> > +                               #interrupt-cells = <1>;
> > +                               compatible = "riscv,cpu-intc";
> > +                               interrupt-controller;
> > +                       };
> > +               };
> > +       };
> > +
> > +       soc: soc {
> > +               compatible = "simple-bus";
> > +               interrupt-parent = <&plic>;
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
> > +                       interrupt-names = "eri", "rxi", "txi",
> > +                                         "bri", "dri", "tei";
> > +                       clocks = <&cpg CPG_MOD R9A07G043_SCIF0_CLK_PCK>;
> > +                       clock-names = "fck";
> > +                       power-domains = <&cpg>;
> > +                       resets = <&cpg R9A07G043_SCIF0_RST_SYSTEM_N>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               cpg: clock-controller@11010000 {
> > +                       compatible = "renesas,r9a07g043-cpg";
> > +                       reg = <0 0x11010000 0 0x10000>;
> > +                       clocks = <&extal_clk>;
> > +                       clock-names = "extal";
> > +                       #clock-cells = <2>;
> > +                       #reset-cells = <1>;
> > +                       #power-domain-cells = <0>;
> > +               };
> > +
> > +               sysc: system-controller@11020000 {
> > +                       compatible = "renesas,r9a07g043-sysc";
> > +                       reg = <0 0x11020000 0 0x10000>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               pinctrl: pinctrl@11030000 {
> > +                       compatible = "renesas,r9a07g043-pinctrl";
> > +                       reg = <0 0x11030000 0 0x10000>;
> > +                       gpio-controller;
> > +                       #gpio-cells = <2>;
> > +                       #interrupt-cells = <2>;
> > +                       interrupt-controller;
> > +                       gpio-ranges = <&pinctrl 0 0 152>;
> > +                       clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
> > +                       power-domains = <&cpg>;
> > +                       resets = <&cpg R9A07G043_GPIO_RSTN>,
> > +                                <&cpg R9A07G043_GPIO_PORT_RESETN>,
> > +                                <&cpg R9A07G043_GPIO_SPARE_RESETN>;
> > +               };
> > +
> > +               plic: interrupt-controller@12c00000 {
> > +                       compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
> > +                       #interrupt-cells = <2>;
> > +                       #address-cells = <0>;
> > +                       riscv,ndev = <543>;
> > +                       interrupt-controller;
> > +                       reg = <0x0 0x12c00000 0 0x400000>;
>
> Does reg not usually get sorted after compatible?
> For consistency in this file it should at least.
>
Agreed will fix that.

Cheers,
Prabhakar
