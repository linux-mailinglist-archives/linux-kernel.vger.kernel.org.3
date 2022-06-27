Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ACC55DF88
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiF0OaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbiF0O34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:29:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFE1B53;
        Mon, 27 Jun 2022 07:29:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so19536183eja.8;
        Mon, 27 Jun 2022 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RQuo68FMs3Ewydqyi9IiONXYW4rMeUPNWTwYPpOosc=;
        b=MzdoIB26iFVkILG/Mt1s4LYfQHztPMX/C175dvEV/uVJscpVucKtWQ97vnpCaAWfSU
         CpwChSeVLUhGL2n/eTsAriuJAwzs7oBqz24JQCXnw2p/Bnbr7ZZCpxnPM2GrK+74+NSN
         KewxQkzDoIgCIVL85Wk9C2SjShc6hPsL5iCNBCxgua3NId6txqObxC8rq1qWhRiOIFl8
         N0hnSamEe3u5/VIoR6JKFFEj8+xjXYdRw9Zsn2+M+jipeb7NlFK2V8HV+swBFEwdRkUs
         ftWitiLffThm52kMhgYnxog0xp2seWLjSpwIQ7bxCftk7UMtiId2MMuHS/1LYDgsNUqD
         Uxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RQuo68FMs3Ewydqyi9IiONXYW4rMeUPNWTwYPpOosc=;
        b=ZkyWkZQ9gP9ulm30pkQHnC2k1MRK+4Rc+gNKfrxR2sGGfqx9rlGdZ72pl3VSI+68WQ
         0rsOF0QNld/kd77wRXQjg1kUZR5rd49is0oeQmhZHfnjNwUPcoE645B7ZPY6KA+ElGpk
         d2Kw303QNOflweasg2CjtCFX+s1ru3xoO03E5yZuhzOEpwnqeLnFY4+zOmFvbj8+to61
         UzOdqDSf/5Dbn5VLZV7vaoJeh5pufpDvp0zjlcCzXRN18VJsK68xlOC51eE/0EoV49SJ
         kwY348ncD8W9VcdI8fBFvU3PNZZmw8b1lHGcRBdQt0MWOj+CW3poxox9L+36QJGIXYRm
         Ns7w==
X-Gm-Message-State: AJIora+6cjd4oBhGIsngjnqGadiWpZ/1V/q4/jPY0ZAF2OEpKmozU3/E
        LxJCL4DN4lLNApxYw4fR8ajVxkLeycWSt5LnlkM=
X-Google-Smtp-Source: AGRyM1v6HvBJpI2zjqwnkNHhBqV1cK4hlM/aYv8C+uEiiVwmn1Os3FAYlv54APEOIV/+t60608gsPU0byrK9p/yBglY=
X-Received: by 2002:a17:907:72c4:b0:726:9406:f760 with SMTP id
 du4-20020a17090772c400b007269406f760mr9624040ejc.247.1656340193621; Mon, 27
 Jun 2022 07:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220626004326.8548-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87tu87eh5h.wl-maz@kernel.org> <CA+V-a8sihw9=Ychakh6tV+1+MpRayr=1VSnhSYZNp0F+f4Hdnw@mail.gmail.com>
 <1eb7b6525a98b330894b6ce2f9167dc2@kernel.org>
In-Reply-To: <1eb7b6525a98b330894b6ce2f9167dc2@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 27 Jun 2022 15:29:27 +0100
Message-ID: <CA+V-a8upv16o86RFCcPVRjucM3WJUOwOejF_TzPwLibjq1_SXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Document Renesas RZ/Five SoC
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

Hi Marc,

On Mon, Jun 27, 2022 at 3:22 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-06-27 13:27, Lad, Prabhakar wrote:
> > Hi Marc,
> >
> > Thank you for the review.
> >
> > On Sun, Jun 26, 2022 at 1:35 PM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On Sun, 26 Jun 2022 01:43:25 +0100,
> >> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >> >
> >> > Document Renesas RZ/Five (R9A07G043) SoC.
> >> >
> >> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> > ---
> >> > v1->v2:
> >> > * Fixed binding doc
> >> > * Fixed review comments pointed by Krzysztof.
> >> >
> >> > RFC->v1:
> >> > * Fixed Review comments pointed by Geert and Rob
> >> > ---
> >> >  .../sifive,plic-1.0.0.yaml                    | 44 +++++++++++++++++--
> >> >  1 file changed, 41 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> >> > index 27092c6a86c4..59df367d1e44 100644
> >> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> >> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> >> > @@ -28,7 +28,10 @@ description:
> >> >
> >> >    While the PLIC supports both edge-triggered and level-triggered interrupts,
> >> >    interrupt handlers are oblivious to this distinction and therefore it is not
> >> > -  specified in the PLIC device-tree binding.
> >> > +  specified in the PLIC device-tree binding for SiFive PLIC (and similar PLIC's),
> >> > +  but for the Renesas RZ/Five Soc (AX45MP AndesCore) which has NCEPLIC100 we need
> >> > +  to specify the interrupt type as the flow for EDGE interrupts is different
> >> > +  compared to LEVEL interrupts.
> >> >
> >> >    While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> >> >    "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
> >> > @@ -57,6 +60,7 @@ properties:
> >> >            - enum:
> >> >                - allwinner,sun20i-d1-plic
> >> >            - const: thead,c900-plic
> >> > +      - const: renesas,r9a07g043-plic
> >>
> >> Since it is the NCEPLIC100 that is broken, shouldn't the compatible
> >> string actually reflect that? I'd rather see 'andes,nceplic100' once
> >> and for all instead of starting with Renesas, quickly followed by all
> >> the other licensees that will inevitably integrate the same IP (which
> >> isn't even specific to the AX45MP).
> >>
> >> This IP also comes with all sort of added (mis-)features, which may or
> >> may not be used in the future, and it would make sense to identify it
> >> specifically.
> >>
> > Agreed, I'll update it as above.
>
> Please synchronise with Samuel to have a common series that fixes
> both the Renesas and Thead platforms.
>
Yes Ive dropped an email to Samuel.

Cheers,
Prabhakar
