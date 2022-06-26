Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C555ADCD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 02:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiFZAcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 20:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiFZAcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:32:15 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F6A13F95;
        Sat, 25 Jun 2022 17:32:13 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3178ea840easo55326997b3.13;
        Sat, 25 Jun 2022 17:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9dPmWk2Vcw5sGKQ49PZ7QnGrzXJQOQ3Dx2Y9NtzjQg=;
        b=lLgAYtOYAcDJV6WG8taYMcRcJgrDX7mnUZxRRfVfw77nR1dpFb1rHbU3r9osill1Bw
         QZfsMAesvlQKGf8xzF4RnWgzV2nWei44Sa/MAG7YB3JFIfMfGLt+VIgu8PnLefwAtYBH
         a0ZdOLnqBVC2s6eQDWdGWyIRbOW3EsbLv3sZpUe8nVE58C73f+ykIXZNdgu2DYR9y/NG
         R18lMh9D7EOLS2gN0FREe7NKB6QrRvhgQPCWqy+9EcnvIU5sFL2bTkMELFuTMqk4tiHA
         vkWYYbJNxiudH9k2hILeN2pUffbjC03qSthLw/LdqLgFK8vCDoO9KtsU/4rV3i17fRsh
         6Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9dPmWk2Vcw5sGKQ49PZ7QnGrzXJQOQ3Dx2Y9NtzjQg=;
        b=vUZJFQi+IHIOT7hjsJ1rnZ+dirz9CDiIfYPwO3WIGUXFQUe6w1a3gSSwM9OlE5STSX
         +R20B3mJYk8THdqfoHeh8WuMydubISs8wAw066nTIE6DmCCRgaaPN16Jp9Qu/ft/V/K8
         UJoMX1HZjeAR3yOI/0oAsqFbgZay2yQ1VXP3AlNNOLRdoemg2fSe0f6w1p3w6GPmHcpw
         TyKNkwMm8mzVaDcTMKX19pWP/uPxJVtPoCEoo/rrBo+quTHi+o4McRFrnx/sI138Zulm
         ztqQ1Sd2j0JZO2JAZMbABF7ec1bk1GUQYJoJHDEUBa9zfsn9hfHfEJJFNAldild8DVsc
         79NA==
X-Gm-Message-State: AJIora/lP2JgzOvtcmtEuVKpoYQUdR9jWrmxk1Og03pTgkLC8XTKKZOw
        a4TCvJMgiClJ3Co7vGqxJMVecGQf+85+uCZN1+E=
X-Google-Smtp-Source: AGRyM1s9Z6oCZdo0CcI/aqlgYtTw/kdgWgE65i+E+vrZEo2FOOR0vzAoiCRXPiSQh0BSSpjHOnpAUis1/lMql2BJa+0=
X-Received: by 2002:a81:989:0:b0:318:38c3:ade0 with SMTP id
 131-20020a810989000000b0031838c3ade0mr7367936ywj.292.1656203532980; Sat, 25
 Jun 2022 17:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220624180311.3007-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220624180311.3007-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <59c043a4-dd40-1f6b-69d2-bc32b970e874@linaro.org>
In-Reply-To: <59c043a4-dd40-1f6b-69d2-bc32b970e874@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 26 Jun 2022 01:31:46 +0100
Message-ID: <CA+V-a8s3oD+n+o5KGXW4p5FJZspo8DpZhDypLYSoN5OPJgt4tQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Document Renesas RZ/Five SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

Hi Krzysztof,

Thank you for the review.

On Sat, Jun 25, 2022 at 9:01 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/06/2022 20:03, Lad Prabhakar wrote:
> > Document Renesas RZ/Five (R9A07G043) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > RFC->v1:
> > * Fixed Review comments pointed by Geert and Rob
> > ---
> >  .../sifive,plic-1.0.0.yaml                    | 40 +++++++++++++++++--
> >  1 file changed, 36 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > index 27092c6a86c4..5eebe0b01b4d 100644
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
> > +      - const: renesas,r9a07g043-plic
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
> > @@ -91,7 +94,36 @@ required:
> >    - interrupts-extended
> >    - riscv,ndev
> >
> > -additionalProperties: false
> > +if:
>
> Make it inside allOf. Avoids further indentation change on next variant.
>
Agreed.

> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: renesas,r9a07g043-plic
> > +then:
> > +  properties:
> > +    clocks:
> > +      maxItems: 1
> > +
> > +    resets:
> > +      maxItems: 1
> > +
> > +    power-domains:
> > +      maxItems: 1
> > +
> > +    '#interrupt-cells':
> > +      const: 2
> > +
> > +  required:
> > +    - clocks
> > +    - resets
> > +    - power-domains
> > +
> > +else:
> > +  properties:
> > +    '#interrupt-cells':
> > +      const: 1
> > +
> > +unevaluatedProperties: false
>
>
> This does not look correct, why changing additional->unevaluated here?
>
Agreed will drop this.

Cheers,
Prabhakar
