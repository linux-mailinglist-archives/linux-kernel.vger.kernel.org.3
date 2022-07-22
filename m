Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44E57DFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiGVKZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiGVKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:25:04 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C549C275;
        Fri, 22 Jul 2022 03:24:58 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id g1so3252361qki.7;
        Fri, 22 Jul 2022 03:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZH509W1fDdZf+E9OLY1sYyTxMMIeDobeLQYLua0VlU=;
        b=EjuLf1eyQxaQ0md9WksvrtKUS7xMoobZKbQD0kVSg+HEofejarDTuBXKng67SQfeS8
         t0xdz3oZlgQ30iXKSzqroqvgInn+mEeWwtI7DmUYgGo7dy07seJT8/t586O6nEVDOGNg
         LLR6i2E8KcaZjgWdBfmu+oONXYvSS+Rz37JvtvvPkqg6e3GVe6CzIoFr9PHL5hK7BjIS
         K7OEBWApzZcNYBTd5MtnZP7dO/TIiHs2t/IJs1OO3QXhffwODb/ozqZeUSHMZkmjmSqs
         5UyKJR/+F15liyzNmHWQglAlbfOENbCiIMmRaTA67Lqefjxf73QDINSJ4ZodIdi4ZbGO
         tQ4g==
X-Gm-Message-State: AJIora+Ao3wJbKRr/ToaDDPFXn+Ra0UCu9xI7hVZir4+GcpcfPHnXeot
        JvOHb8M81z+57I4QPpVukV89Ld0oJ/q0Cg==
X-Google-Smtp-Source: AGRyM1vQKiumGVsdfSBHnzBICNwjDOGKujpwtDpME55MRZxZ3K3g0GpCzHL/hbPCVYEVQXx/plLFUw==
X-Received: by 2002:a05:620a:29ce:b0:6a7:1379:62d4 with SMTP id s14-20020a05620a29ce00b006a7137962d4mr1958995qkp.604.1658485497113;
        Fri, 22 Jul 2022 03:24:57 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id j18-20020a05620a411200b006af10bd3635sm3131220qko.57.2022.07.22.03.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 03:24:56 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31e67c46ba2so43013207b3.2;
        Fri, 22 Jul 2022 03:24:56 -0700 (PDT)
X-Received: by 2002:a81:4f87:0:b0:31e:7122:16fb with SMTP id
 d129-20020a814f87000000b0031e712216fbmr2473121ywb.358.1658485496374; Fri, 22
 Jul 2022 03:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220721221212.18491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220721221212.18491-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVy0w8Y-+MegHnjdFkQ7vB1Y=jPY-9atTFT_WTVYOiGLg@mail.gmail.com> <CA+V-a8tddFVQnJjKSg9MTKB-Hh3X=2OwsU+THis+KFEfz7KB=g@mail.gmail.com>
In-Reply-To: <CA+V-a8tddFVQnJjKSg9MTKB-Hh3X=2OwsU+THis+KFEfz7KB=g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jul 2022 12:24:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzakUT4vEV=MSw+tCReXn0mng1XPKf6iE-5S8q-XQjnw@mail.gmail.com>
Message-ID: <CAMuHMdWzakUT4vEV=MSw+tCReXn0mng1XPKf6iE-5S8q-XQjnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: renesas: renesas,rzg2l-sysc:
 Document RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jul 22, 2022 at 12:21 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, Jul 22, 2022 at 10:31 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Jul 22, 2022 at 12:15 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Document RZ/Five (R9A07G043) SYSC bindings. SYSC block found on the
> > > RZ/Five SoC is almost identical to one found on the RZ/G2L (and alike)
> > > SoC's. To differentiate RZ/G2UL from RZ/Five, "-rzfive" is included in
> > > the compatible string for the RZ/Five SoC as there are no interrupts
> > > from the SYSC block to the core.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > ---
> > >  .../soc/renesas/renesas,rzg2l-sysc.yaml       | 56 +++++++++++++------
> > >  1 file changed, 39 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
> > > index ce2875c89329..bdaf05f8b29b 100644
> > > --- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
> > > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
> > > @@ -20,35 +20,57 @@ description:
> > >  properties:
> > >    compatible:
> > >      enum:
> > > -      - renesas,r9a07g043-sysc # RZ/G2UL
> > > -      - renesas,r9a07g044-sysc # RZ/G2{L,LC}
> > > -      - renesas,r9a07g054-sysc # RZ/V2L
> > > +      - renesas,r9a07g043-rzfive-sysc # RZ/Five
> >
> > renesas,r9a07g043f-sysc?
> >
> Agreed.
>
> > But I'm wondering if we really need a different compatible value?
> > It looks like both blocks differ only in external wiring, so if
> > anything needs to be handled differently (the removed/added registers
> > are related to CPU topology), that can be inferred from the system
> > topology (or even #ifdef CONFIG_{ARM64,RISCV} ;-)
> >
> Good point, but I wonder if we would end up in too many #ifdef
> CONFIG_{ARM64,RISCV} checks. If thats OK I will stick with
> "renesas,r9a07g043-sysc"
>
> > > +      - renesas,r9a07g043-sysc        # RZ/G2UL
> > > +      - renesas,r9a07g044-sysc        # RZ/G2{L,LC}
> > > +      - renesas,r9a07g054-sysc        # RZ/V2L
> > >
> > >    reg:
> > >      maxItems: 1
> > >
> > > -  interrupts:
> > > -    items:
> > > -      - description: CA55/CM33 Sleep/Software Standby Mode request interrupt
> > > -      - description: CA55 Software Standby Mode release request interrupt
> > > -      - description: CM33 Software Standby Mode release request interrupt
> > > -      - description: CA55 ACE Asynchronous Bridge Master/Slave interface deny request interrupt
> > > +  interrupts: true
> > >
> > > -  interrupt-names:
> > > -    items:
> > > -      - const: lpm_int
> > > -      - const: ca55stbydone_int
> > > -      - const: cm33stbyr_int
> > > -      - const: ca55_deny
> > > +  interrupt-names: true
> > >
> > >  required:
> > >    - compatible
> > >    - reg
> > > -  - interrupts
> > > -  - interrupt-names
> > >
> > >  additionalProperties: false
> > >
> > > +allOf:
> > > +  - if:
> > > +      not:
> > > +        properties:
> > > +          compatible:
> > > +            contains:
> > > +              enum:
> > > +                - renesas,r9a07g043-rzfive-sysc
> > > +    then:
> > > +      properties:
> > > +        interrupts:
> > > +          items:
> > > +            - description: CA55/CM33 Sleep/Software Standby Mode request interrupt
> > > +            - description: CA55 Software Standby Mode release request interrupt
> > > +            - description: CM33 Software Standby Mode release request interrupt
> > > +            - description: CA55 ACE Asynchronous Bridge Master/Slave interface deny request interrupt
> > > +
> > > +        interrupt-names:
> > > +          items:
> > > +            - const: lpm_int
> > > +            - const: ca55stbydone_int
> > > +            - const: cm33stbyr_int
> > > +            - const: ca55_deny
> > > +
> > > +      required:
> > > +        - interrupts
> > > +        - interrupt-names
> > > +
> > > +    else:
> > > +      properties:
> > > +        interrupts: false
> > > +        interrupt-names: false
> >
> > Do all interrupts{,-names} have to be moved?
> > Wouldn't it be sufficient to just have
> >
> Agreed.
>
> >     if [...]
> >     then:
> >         required:
> >           - interrupts
> >           - interrupt-names
> >     else:
> >         properties:
> >             interrupts: false
> >             interrupt-names: false
> >
> > ?
> >
> > But again, without a new compatible value, you could just make
> > interrupts{,-names} not required?
> >
> You mean we just make it optional for all the SoC's?

Indeed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
