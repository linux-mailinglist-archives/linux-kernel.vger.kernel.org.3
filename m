Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71855972E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiFXKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFXKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:00:08 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B548B56F84;
        Fri, 24 Jun 2022 03:00:07 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id q132so3621192ybg.10;
        Fri, 24 Jun 2022 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=naacGnwFVI2XIwy985in6Vo6kcKveQxxT4YcXRz3t2g=;
        b=qTLL1e/OmEF57ZzeFNoJTrSXTfcgLGd3V0zVHMQ/Or4PHjrPqyapiSxc0WXfXC8zNo
         Lq4mvf+uMBjmOtK5od+0mnNbQiXeST0s09Xv+9UAhKaztMhjgPWINCG2SqUWviTwb5Rh
         A+lc0OqyWWMVlQ1UbVjhIcL5AeM3BquyK7peuR4G+mMh5eRz1e+U2EVy+1C+TK8Tj8Ml
         F8+LyA+Hgd6mUe00NcpwIFJn2vZL5+H1S61eTXf1/+uSCrA8E0sR6bDWXQsskgWV5V8i
         sma97m3T9VSQ6NFCHscUr7dqR07+UzbAeHzSI9zs0oILWR+QCMt5Q4gBJsweaj7XpCl3
         ovxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naacGnwFVI2XIwy985in6Vo6kcKveQxxT4YcXRz3t2g=;
        b=uIKmIdqe7fSCNKfdHlQ7U61lMnxV7yROAThufjlBI0lDm2mji/dwBqpMJ2GdvNMcfC
         2schIA+pio2giXomJWlh2y9Y+z+Oycwom3HA9fI3dOLLjtik4AIO3E1oD2L4Qh7kcIrP
         D1XGhmwx5E2gtbs6v8H1H+PlKxh4ftKfUMh4cCG7y6nt4L54Y5qGU+b8EEf5FKQmBp04
         WuqCL2UdpixyM9ArdiXva8dL33Uo2TioEI3AQoW7UrW18fN5XLosa8JRWLscfm/j5btt
         c/pbHgIySLEWATzlv21PHcAtNkSzmktGIfgkKBt0ba8bl94arpEzgVeWfvsK61Xoparh
         XhJg==
X-Gm-Message-State: AJIora+2dWOJsNUPVMXxCWgN+44HMcxWTZ5hJrSp7ewVzmdQ2nd1e3fU
        o6vvZh1+q7eYUvmvB5cYb8gZJg7l6QODQDArob4=
X-Google-Smtp-Source: AGRyM1s5rIVdpDbuAlUIVf1/orDfdYSOoUJm6XY19sO/OwVRoYkjjJCQ1uzMT6xuXsG2Uwq7nLXbA/RpZ4sNnhctOSA=
X-Received: by 2002:a05:6902:1407:b0:64a:ecc7:aa2 with SMTP id
 z7-20020a056902140700b0064aecc70aa2mr14513281ybu.645.1656064806840; Fri, 24
 Jun 2022 03:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220524172214.5104-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220605142333.GA3439339-robh@kernel.org>
In-Reply-To: <20220605142333.GA3439339-robh@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 24 Jun 2022 10:59:40 +0100
Message-ID: <CA+V-a8smk8TqyWpm1KXo-3dKnCAodKsiYsaqnK_3ubfXE9YauQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Document Renesas RZ/Five SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        LKML <linux-kernel@vger.kernel.org>,
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

Hi Rob,

Thank you for the review.

On Sun, Jun 5, 2022 at 3:23 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 24, 2022 at 06:22:13PM +0100, Lad Prabhakar wrote:
> > Document Renesas RZ/Five (R9A07G043) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../sifive,plic-1.0.0.yaml                    | 38 +++++++++++++++++--
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > index 27092c6a86c4..78ff31cb63e5 100644
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
>
> Did you test this? The above properties won't be allowed because of
> additionalProperties below. You need to change it to
> 'unevaluatedProperties' or move these to the top level.
>
Yes I have run the dt_binding check.

So with the below diff it does complain about the missing properties.

prasmi@prasmi:~/work/renasas/renesas-drivers$ git diff
Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 20ded037d444..bb14a4b1ec0a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -130,7 +130,7 @@ examples:
     plic: interrupt-controller@c000000 {
       #address-cells = <0>;
       #interrupt-cells = <1>;
-      compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
+      compatible = "renesas-r9a07g043-plic";
       interrupt-controller;
       interrupts-extended = <&cpu0_intc 11>,
                             <&cpu1_intc 11>, <&cpu1_intc 9>,
prasmi@prasmi:~/work/renasas/renesas-drivers$ make ARCH=riscv
CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTEX    Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dts
  DTC     Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb
  CHECK   Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb
/home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
interrupt-controller@c000000: #interrupt-cells:0:0: 2 was expected
    From schema:
/home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
/home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
interrupt-controller@c000000: 'clocks' is a required property
    From schema:
/home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
/home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
interrupt-controller@c000000: 'resets' is a required property
    From schema:
/home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
/home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
interrupt-controller@c000000: 'power-domains' is a required property
    From schema:
/home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
prasmi@prasmi:~/work/renasas/renesas-drivers$
prasmi@prasmi:~/work/renasas/renesas-drivers$

Is there something I'm missing here?

Cheers,
Prabhakar

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
> >  additionalProperties: false
> >
> >  examples:
> > --
> > 2.25.1
> >
> >
