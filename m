Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B53572259
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiGLSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiGLSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:19:20 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37F59B9D8;
        Tue, 12 Jul 2022 11:19:19 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id p128so8697012iof.1;
        Tue, 12 Jul 2022 11:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wcp64K5PVliSn3UzjvTNUpS1fkGlfk4O82lLCf8rw9U=;
        b=PuXzbIHoS8ivIxGCe2nNxpH7Cb4hg8ZtVTdY5XUDcrTFHV0HAz2zI5Tw/Kq2E/x/na
         UdiIVgloSPDeOlxYUgoCfrz0Uq9DBF3SI0p4GWOQdHQKF5sw5n/LJ2yKOODAi8A/lZxH
         IHPWQDVzD3ZRecBaBuJtmXpmkHwFF+fMHq8JArmgtX4VgdNysgQ555j4S7nnqGJl9fqZ
         clj/fLT3djgTtjuuTGaei9ETk2tVJOYgTmqSmY4AvtJp/mSri6YN/15MiQqhK6Ictt7L
         yIc+LNfwgzTe5au2xatLh8oLJeIapFlqeHDdsxspz0asFfMaUihJY90Ujpalv0S+i11B
         Y1YA==
X-Gm-Message-State: AJIora+9tx+tSw+o4JMYwu+rfgPnNZxGY6BEkDQpyg7WmFOdkRNa9ppc
        8xzkneXbqpRJND/HScnpEA==
X-Google-Smtp-Source: AGRyM1ueRBOx0x21LlqhraF76MncQ1Zco5/yhr5wSySTaOk3txyA4FFBNJfRj9DjZGKcWXykYk4BUw==
X-Received: by 2002:a05:6638:349e:b0:33f:4322:d9cd with SMTP id t30-20020a056638349e00b0033f4322d9cdmr10073664jal.296.1657649958940;
        Tue, 12 Jul 2022 11:19:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n8-20020a02a188000000b0033f51b3b0d9sm3098773jah.138.2022.07.12.11.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 11:19:18 -0700 (PDT)
Received: (nullmailer pid 2130848 invoked by uid 1000);
        Tue, 12 Jul 2022 18:19:16 -0000
Date:   Tue, 12 Jul 2022 12:19:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20220712181916.GI1823936-robh@kernel.org>
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220524172214.5104-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220605142333.GA3439339-robh@kernel.org>
 <CA+V-a8smk8TqyWpm1KXo-3dKnCAodKsiYsaqnK_3ubfXE9YauQ@mail.gmail.com>
 <20220706215827.GA572635-robh@kernel.org>
 <87a69lmesa.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a69lmesa.wl-maz@kernel.org>
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

On Thu, Jul 07, 2022 at 10:51:33AM +0100, Marc Zyngier wrote:
> On Wed, 06 Jul 2022 22:58:27 +0100,
> Rob Herring <robh@kernel.org> wrote:
> > 
> > On Fri, Jun 24, 2022 at 10:59:40AM +0100, Lad, Prabhakar wrote:
> > > Hi Rob,
> > > 
> > > Thank you for the review.
> > > 
> > > On Sun, Jun 5, 2022 at 3:23 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Tue, May 24, 2022 at 06:22:13PM +0100, Lad Prabhakar wrote:
> > > > > Document Renesas RZ/Five (R9A07G043) SoC.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > ---
> > > > >  .../sifive,plic-1.0.0.yaml                    | 38 +++++++++++++++++--
> > > > >  1 file changed, 35 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > > > index 27092c6a86c4..78ff31cb63e5 100644
> > > > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > > > @@ -28,7 +28,10 @@ description:
> > > > >
> > > > >    While the PLIC supports both edge-triggered and level-triggered interrupts,
> > > > >    interrupt handlers are oblivious to this distinction and therefore it is not
> > > > > -  specified in the PLIC device-tree binding.
> > > > > +  specified in the PLIC device-tree binding for SiFive PLIC (and similar PLIC's),
> > > > > +  but for the Renesas RZ/Five Soc (AX45MP AndesCore) which has NCEPLIC100 we need
> > > > > +  to specify the interrupt type as the flow for EDGE interrupts is different
> > > > > +  compared to LEVEL interrupts.
> > > > >
> > > > >    While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> > > > >    "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
> > > > > @@ -57,6 +60,7 @@ properties:
> > > > >            - enum:
> > > > >                - allwinner,sun20i-d1-plic
> > > > >            - const: thead,c900-plic
> > > > > +      - const: renesas-r9a07g043-plic
> > 
> > Also, this should be 'renesas,r9...'
> > 
> > > > >
> > > > >    reg:
> > > > >      maxItems: 1
> > > > > @@ -64,8 +68,7 @@ properties:
> > > > >    '#address-cells':
> > > > >      const: 0
> > > > >
> > > > > -  '#interrupt-cells':
> > > > > -    const: 1
> > > > > +  '#interrupt-cells': true
> > > > >
> > > > >    interrupt-controller: true
> > > > >
> > > > > @@ -91,6 +94,35 @@ required:
> > > > >    - interrupts-extended
> > > > >    - riscv,ndev
> > > > >
> > > > > +if:
> > > > > +  properties:
> > > > > +    compatible:
> > > > > +      contains:
> > > > > +        const: renesas-r9a07g043-plic
> > > > > +then:
> > > > > +  properties:
> > > > > +    clocks:
> > > > > +      maxItems: 1
> > > > > +
> > > > > +    resets:
> > > > > +      maxItems: 1
> > > > > +
> > > > > +    power-domains:
> > > > > +      maxItems: 1
> > > >
> > > > Did you test this? The above properties won't be allowed because of
> > > > additionalProperties below. You need to change it to
> > > > 'unevaluatedProperties' or move these to the top level.
> > > >
> > > Yes I have run the dt_binding check.
> > > 
> > > So with the below diff it does complain about the missing properties.
> > > 
> > > prasmi@prasmi:~/work/renasas/renesas-drivers$ git diff
> > > Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > index 20ded037d444..bb14a4b1ec0a 100644
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > @@ -130,7 +130,7 @@ examples:
> > >      plic: interrupt-controller@c000000 {
> > >        #address-cells = <0>;
> > >        #interrupt-cells = <1>;
> > > -      compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
> > > +      compatible = "renesas-r9a07g043-plic";
> > >        interrupt-controller;
> > >        interrupts-extended = <&cpu0_intc 11>,
> > >                              <&cpu1_intc 11>, <&cpu1_intc 9>,
> > > prasmi@prasmi:~/work/renasas/renesas-drivers$ make ARCH=riscv
> > > CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check
> > >   LINT    Documentation/devicetree/bindings
> > >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > >   DTEX    Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dts
> > >   DTC     Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb
> > >   CHECK   Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb
> > > /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
> > > interrupt-controller@c000000: #interrupt-cells:0:0: 2 was expected
> > >     From schema:
> > > /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
> > > interrupt-controller@c000000: 'clocks' is a required property
> > >     From schema:
> > > /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
> > > interrupt-controller@c000000: 'resets' is a required property
> > >     From schema:
> > > /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.example.dtb:
> > > interrupt-controller@c000000: 'power-domains' is a required property
> > >     From schema:
> > > /home/prasmi/work/renasas/renesas-drivers/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > prasmi@prasmi:~/work/renasas/renesas-drivers$
> > > prasmi@prasmi:~/work/renasas/renesas-drivers$
> > > 
> > > Is there something I'm missing here?
> > 
> > You've said these properties are required, but you didn't add them.
> > 
> > If you don't have the above 3 properties, then it's not going to 
> > complain that they are present. But it will when you do add them for the 
> > reason I gave.
> 
> Can you please have a look at the latest instance[1][2] of this
> series, as posted by Samuel? I've provisionally queued it, but only on
> the provision that you would eventually ack these patches.

I did already[1]. They passed checks, were already in linux-next, and I 
didn't see anything major needing comments, so I marked it N/A (meaning 
someone else applies it) without comment.

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220630100241.35233-2-samuel@sholland.org/
