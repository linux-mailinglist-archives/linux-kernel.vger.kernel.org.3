Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1BC58233B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiG0Jfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiG0Jfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:35:51 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E232BA;
        Wed, 27 Jul 2022 02:35:50 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id j63so8252159ybb.13;
        Wed, 27 Jul 2022 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tO96KCUrmod4Bc1ngFqk0NF3aHyVouo2a5XyYHy3WtA=;
        b=bfGBK5IAfMvP2xnlRZtAoV1vqJHJNuA+Rk9DU4uwapU+O4esI07HFst2iQtQ+dXDw5
         w/ieBMT3/j5vQDkH2VKCyKkZikrEY4wP/rgaWMejjZ7bfgm3jc+2RFe7cYa5kAmxsPS7
         E10w/dQLhdcgSNaNjMlRb1R2MS3XgFykoYMqbfofmbXustfawqSJOi5N9WSSh1NTdaaZ
         r0Pi25Emj5arzzrrQPG3CHmlj44IAfgUsjkFjHiw6L+EoEc7wnnD8lQrEoQbYeBntkAf
         yJYYRJ4FsPnvrSNsIvbR69v6/dbBWokNQfTYPmgS1KzXjCZPWXyT9B+GuLy8aqE84Kqy
         NXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tO96KCUrmod4Bc1ngFqk0NF3aHyVouo2a5XyYHy3WtA=;
        b=6TLf5BBpknBB1LihF3Q/QmLrJMSU7Jf8w1JC23J/duoR6/hubLUQI11hAaarYlu2tJ
         YIYAIK8qYys5D5A1oN1FAUUzKz3TWtoCLGKLNJRZgweTz17mE+xYEeA99/niygeG8Hez
         DJQvezAQMUtMqQWzXGBOD4X84M+XuDXoPcdB9i0bL2t7IAnKx2/g0d8q8Kr9c9LTnYvK
         ugx7u0iMexhkCm4dH7UtVuwc+kIBRMfEgYHkxNM9JSv0NyqfuOPhJ8IcCbWe+NuBwNZC
         4ckC/5I8ZDSm64owRi2ve+YoRP7bjgbkO0BDf+3C69tt3SGJFJJ7RPXxEULGOSSaBp+c
         NFIg==
X-Gm-Message-State: AJIora+39TiHfCgah/dyfIT2ocJMUpr0x61gmZfjL/Yu+5U9flAoVCaz
        dGsYeW8eqSJ/qgQRWpokmUnafL+2kFATInjfisk=
X-Google-Smtp-Source: AGRyM1tTw4w511Z1qejEOK9vSuyQPylIYKCBdl8onOcjCJ2A9h7t/jpCh5PWMT+1BJjigzlLpNJe0GLPufh8KC9k13Q=
X-Received: by 2002:a25:830f:0:b0:66f:cc60:c740 with SMTP id
 s15-20020a25830f000000b0066fcc60c740mr17248720ybk.117.1658914549731; Wed, 27
 Jul 2022 02:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org> <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <OS0PR01MB5922F1DEF93337884249DBF586979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922F1DEF93337884249DBF586979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 10:35:22 +0100
Message-ID: <CA+V-a8t6h2++KfhG92FrKXtwg4nF5-nE2TPjfnWZzNgtxJHONA@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Biju,

On Wed, Jul 27, 2022 at 10:27 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Lad, Prabhakar,
>
> > Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding
> > documentation for Renesas RZ/Five SoC and SMARC EVK
> >
> > Hi Krzysztof,
> >
> > Thank you for the review.
> >
> > On Wed, Jul 27, 2022 at 9:54 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 26/07/2022 20:06, Lad Prabhakar wrote:
> > > > Document Renesas RZ/Five (R9A07G043) SoC and SMARC EVK based on this
> > SoC.
> > > >
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  .../devicetree/bindings/riscv/renesas.yaml    | 49
> > +++++++++++++++++++
> > > >  1 file changed, 49 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/riscv/renesas.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/riscv/renesas.yaml
> > > > b/Documentation/devicetree/bindings/riscv/renesas.yaml
> > > > new file mode 100644
> > > > index 000000000000..f72f8aea6a82
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/riscv/renesas.yaml
> > > > @@ -0,0 +1,49 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > > +---
> > > > +$id:
>
> > > > +
> > > > +title: Renesas RZ/Five Platform Device Tree Bindings
> > > > +
> > > > +maintainers:
> > > > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> > > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > +
> > > > +# We want to ignore this schema if the board is SMARC EVK based on
> > > > +ARM64 arch
> > > > +select:
> > > > +  not:
> > > > +    properties:
> > > > +      compatible:
> > > > +        contains:
> > > > +          items:
> > >
> > > I think you should rather ignore the RiscV SoCs, not specific board.
> > >
> > You mean to ignore ARM/64 SoCs?
> >
> > Agreed just the below enum, should do the trick.
> >
> >             - enum:
> >                 - renesas,r9a07g043u11
> >                 - renesas,r9a07g043u12
> >                 - renesas,r9a07g044c1
> >                 - renesas,r9a07g044c2
> >                 - renesas,r9a07g044l1
> >                 - renesas,r9a07g044l2
> >                 - renesas,r9a07g054l1
> >                 - renesas,r9a07g054l2
>
> Why do we need to add renesas,r9a07g044 and renesas,r9a07g054
> in riscv file? These are arm64 only SoC's.
>
The above needs to be added to avoid dtbs_check/dt_binding_check
errors. The above hunk ignores the RISC-V schema if it's an ARM64 SoC.

Cheers,
Prabhakar

> Cheers,
> Biju
>
>
>
> >
> > > > +            - const: renesas,smarc-evk
> > > > +            - enum:
> > > > +                - renesas,r9a07g043u11
> > > > +                - renesas,r9a07g043u12
> > > > +                - renesas,r9a07g044c1
> > > > +                - renesas,r9a07g044c2
> > > > +                - renesas,r9a07g044l1
> > > > +                - renesas,r9a07g044l2
> > > > +                - renesas,r9a07g054l1
> > > > +                - renesas,r9a07g054l2
> > > > +            - enum:
> > > > +                - renesas,r9a07g043
> > > > +                - renesas,r9a07g044
> > > > +                - renesas,r9a07g054
> > >
> > > Did you actually test that it works and properly matches?
> > >
> > Yes I have run the dtbs_check and dt_binding _check for ARM64 and RISC-
> > V. Do you see any cases where it can fail?
> >
> > Cheers,
> > Prabhakar
