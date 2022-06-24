Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5E559740
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiFXKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiFXKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:01:40 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF41B7A1A1;
        Fri, 24 Jun 2022 03:01:39 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3178ea840easo19298757b3.13;
        Fri, 24 Jun 2022 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIvuhv2O2LJCEA/cN0nPJqVqA1J4nPDoUe8QnZLZj2o=;
        b=OanFfdyuKWF/daWLttmMlN7K0lRksfwYbjOsxSKcHo34GCUcbPBriX5mcqX8lLgrog
         8Ptx1jfKsJY0bB7uGBoWlYtGGu4nC1+GVlG/m0Pck2Wvm6Rwyadt01y+fUxnUdxodFD1
         GFPSAjSKnKV0IluZSwSLEwFHrLFsclN6mGg4Aizheu7R29WvVsteR32S86H+xPZQ9IAk
         shfRsHsiL6cGYE+ydspOeHaia/esEdz46UL3kvYHPbc2cwzVlm7kc0sK6Zs7TNbihsNg
         FNr9gvBxhLU8gXS5OjhqS3rggnw91+1tg4pu5g9cYg3fyPGJsyU2DdhcDyD+zbSBn2+4
         Nj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIvuhv2O2LJCEA/cN0nPJqVqA1J4nPDoUe8QnZLZj2o=;
        b=RhUkS6KrTw1Icy4UdsgBcJGErROmyLvynwbynSWU9RcewG2TpoV/CrXN+upet5kzsp
         PQuBnKWPFQ4iDwnGu1iIyRtJc9Q8m1MjTULcbgUUcj/AomDBl6YtdRQ7HrWh0PMN5/qw
         gr1l7YVZXLuFjcVmZC8ptO3v9kbakWhk+66YaDU/Kru6cN/G5Qbjnq2B5by0KuZ00THL
         gh9nMno4HmXxTa+glVxh+UY+Mgx7ugaSM/BCmLKR00Afne3AnF1DFy5zS/kk5yzYHYSG
         ep35dT5H8sc7t//LK1b/vYA2ZNDN/LOw8Z8W/wQuAuF/Rdg14aIbp9nkH9o2ecg9dwLR
         blcQ==
X-Gm-Message-State: AJIora89i57912md6/aVtpiJx7UBUddXVOsiNFMvZIUwLSQqxkqK+A6u
        4frNslTYk4CoKnRLwEgEJyHEVO+6ObICIufrOt0=
X-Google-Smtp-Source: AGRyM1uZqW7BeQR39fipb9XeJooEfmtD6YpdpSLjgsLZ1D0uhV9s/Y+ZgP2nYziC4BGU2b9eW/L214EfjspICcNXG1s=
X-Received: by 2002:a81:600a:0:b0:318:81bc:e928 with SMTP id
 u10-20020a81600a000000b0031881bce928mr6392488ywb.119.1656064898995; Fri, 24
 Jun 2022 03:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220524172214.5104-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVos-hVhGar91oBvZaCOLfjdsNR7vRGnX-KuNt0UX3xWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVos-hVhGar91oBvZaCOLfjdsNR7vRGnX-KuNt0UX3xWQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 24 Jun 2022 11:01:12 +0100
Message-ID: <CA+V-a8vDF-GwfqgerWFNOrKGukdYk52OrcbprJv-=9J-M4VbUA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Document Renesas RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
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

Thank you for the review.

On Thu, Jun 9, 2022 at 10:42 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, May 24, 2022 at 7:22 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Document Renesas RZ/Five (R9A07G043) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > @@ -28,7 +28,10 @@ description:
> >
> >    While the PLIC supports both edge-triggered and level-triggered interrupts,
> >    interrupt handlers are oblivious to this distinction and therefore it is not
> > -  specified in the PLIC device-tree binding.
> > +  specified in the PLIC device-tree binding for SiFive PLIC (and similar PLIC's),
> > +  but for the Renesas RZ/Five Soc (AX45MP AndesCore) which has NCEPLIC100 we need
> > +  to specify the interrupt type as the flow for EDGE interrupts is different
> > +  compared to LEVEL interrupts.
> >
> >    While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> >    "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
> > @@ -57,6 +60,7 @@ properties:
> >            - enum:
> >                - allwinner,sun20i-d1-plic
> >            - const: thead,c900-plic
> > +      - const: renesas-r9a07g043-plic
>
> renesas,r9a07g043-plic
>
Agreed.

> >
> >    reg:
> >      maxItems: 1
> > @@ -64,8 +68,7 @@ properties:
> >    '#address-cells':
> >      const: 0
> >
> > -  '#interrupt-cells':
> > -    const: 1
> > +  '#interrupt-cells': true
> >
> >    interrupt-controller: true
> >
> > @@ -91,6 +94,35 @@ required:
> >    - interrupts-extended
> >    - riscv,ndev
> >
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: renesas-r9a07g043-plic
>
> renesas,r9a07g043-plic
>
ditto.

Cheers,
Prabhakar
