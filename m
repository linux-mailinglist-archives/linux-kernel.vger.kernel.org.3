Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DF15694D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiGFV6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiGFV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:58:35 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44D17A9B;
        Wed,  6 Jul 2022 14:58:33 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id p128so15250093iof.1;
        Wed, 06 Jul 2022 14:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UYaDr7d26s8biv8YaCbEXuacx3Q+wp2527oG6nWNU9E=;
        b=xLMfk7NwOlW4QyIRnoD9Lt2dbLyhXMhkJDYAw4Qrqo6c4pIJO2FpgthfO1qq9RTAgr
         /fCUdtxt+19CmLDrnZgFtap9p4rdB2fT0UYxIaLUs1DPOmOU0ux/T2Vshhha74y0bEFw
         /kA/uPrY7oZf/ZmvJDDTXRNPxdCIrx4yFWdrVOv/A2MAHa3GWH+rxLpdcO8g1HfpuxVK
         JDuTCyrBSBBLdcJt7AvcB/oUw4mBPzkAt8ZIBu1uqfuN2KY+P+OY2LyQZKdU4B7x53ad
         +j5SMlyJBSSZ0Ezxsj2j07JvwF37GTrE52VFdRsNl9NzCft3kO4WOD6/2RTL60kgVmbr
         73DA==
X-Gm-Message-State: AJIora/NETVJZOSHMr9JKYkHn5L7itgSthIN6VbIbwXokFwf+P0vHCdw
        M9Ba00BfaRwyWkkyN0+DvnqlFmqF0w==
X-Google-Smtp-Source: AGRyM1vUlh94A8twuxVlm4r5lh9uafeyxCm23L1h08nw+H2f7Mz48dXfQbrhuQSNCUD13+4OWEKeCA==
X-Received: by 2002:a6b:6a07:0:b0:66a:2e5f:2058 with SMTP id x7-20020a6b6a07000000b0066a2e5f2058mr21955569iog.72.1657144712836;
        Wed, 06 Jul 2022 14:58:32 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.139.118])
        by smtp.gmail.com with ESMTPSA id w6-20020a92d2c6000000b002dc377df3ecsm776355ilg.45.2022.07.06.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:58:32 -0700 (PDT)
Received: (nullmailer pid 607027 invoked by uid 1000);
        Wed, 06 Jul 2022 21:58:27 -0000
Date:   Wed, 6 Jul 2022 15:58:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
Subject: Re: [PATCH RFC 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Document Renesas RZ/Five SoC
Message-ID: <20220706215827.GA572635-robh@kernel.org>
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220524172214.5104-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220605142333.GA3439339-robh@kernel.org>
 <CA+V-a8smk8TqyWpm1KXo-3dKnCAodKsiYsaqnK_3ubfXE9YauQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8smk8TqyWpm1KXo-3dKnCAodKsiYsaqnK_3ubfXE9YauQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:59:40AM +0100, Lad, Prabhakar wrote:
> Hi Rob,
> 
> Thank you for the review.
> 
> On Sun, Jun 5, 2022 at 3:23 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, May 24, 2022 at 06:22:13PM +0100, Lad Prabhakar wrote:
> > > Document Renesas RZ/Five (R9A07G043) SoC.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  .../sifive,plic-1.0.0.yaml                    | 38 +++++++++++++++++--
> > >  1 file changed, 35 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > index 27092c6a86c4..78ff31cb63e5 100644
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > @@ -28,7 +28,10 @@ description:
> > >
> > >    While the PLIC supports both edge-triggered and level-triggered interrupts,
> > >    interrupt handlers are oblivious to this distinction and therefore it is not
> > > -  specified in the PLIC device-tree binding.
> > > +  specified in the PLIC device-tree binding for SiFive PLIC (and similar PLIC's),
> > > +  but for the Renesas RZ/Five Soc (AX45MP AndesCore) which has NCEPLIC100 we need
> > > +  to specify the interrupt type as the flow for EDGE interrupts is different
> > > +  compared to LEVEL interrupts.
> > >
> > >    While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> > >    "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
> > > @@ -57,6 +60,7 @@ properties:
> > >            - enum:
> > >                - allwinner,sun20i-d1-plic
> > >            - const: thead,c900-plic
> > > +      - const: renesas-r9a07g043-plic

Also, this should be 'renesas,r9...'

> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -64,8 +68,7 @@ properties:
> > >    '#address-cells':
> > >      const: 0
> > >
> > > -  '#interrupt-cells':
> > > -    const: 1
> > > +  '#interrupt-cells': true
> > >
> > >    interrupt-controller: true
> > >
> > > @@ -91,6 +94,35 @@ required:
> > >    - interrupts-extended
> > >    - riscv,ndev
> > >
> > > +if:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        const: renesas-r9a07g043-plic
> > > +then:
> > > +  properties:
> > > +    clocks:
> > > +      maxItems: 1
> > > +
> > > +    resets:
> > > +      maxItems: 1
> > > +
> > > +    power-domains:
> > > +      maxItems: 1
> >
> > Did you test this? The above properties won't be allowed because of
> > additionalProperties below. You need to change it to
> > 'unevaluatedProperties' or move these to the top level.
> >
> Yes I have run the dt_binding check.
> 
> So with the below diff it does complain about the missing properties.
> 
> prasmi@prasmi:~/work/renasas/renesas-drivers$ git diff
> Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 20ded037d444..bb14a4b1ec0a 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -130,7 +130,7 @@ examples:
>      plic: interrupt-controller@c000000 {
>        #address-cells = <0>;
>        #interrupt-cells = <1>;
> -      compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
> +      compatible = "renesas-r9a07g043-plic";
>        interrupt-controller;
>        interrupts-extended = <&cpu0_intc 11>,
>                              <&cpu1_intc 11>, <&cpu1_intc 9>,
> prasmi@prasmi:~/work/renasas/renesas-drivers$ make ARCH=riscv
> CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTEX    Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dts
>   DTC     Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb
>   CHECK   Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb
> /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
> interrupt-controller@c000000: #interrupt-cells:0:0: 2 was expected
>     From schema:
> /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
> interrupt-controller@c000000: 'clocks' is a required property
>     From schema:
> /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
> interrupt-controller@c000000: 'resets' is a required property
>     From schema:
> /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
> interrupt-controller@c000000: 'power-domains' is a required property
>     From schema:
> /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> prasmi@prasmi:~/work/renasas/renesas-drivers$
> prasmi@prasmi:~/work/renasas/renesas-drivers$
> 
> Is there something I'm missing here?

You've said these properties are required, but you didn't add them.

If you don't have the above 3 properties, then it's not going to 
complain that they are present. But it will when you do add them for the 
reason I gave.

Rob
