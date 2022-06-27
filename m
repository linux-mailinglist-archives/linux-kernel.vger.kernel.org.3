Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA4555C49A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiF0M2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiF0M2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:28:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976E363F4;
        Mon, 27 Jun 2022 05:28:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ay16so18822773ejb.6;
        Mon, 27 Jun 2022 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Elsn1kdcp1T0aFss4s1Yn5n0Fewq2VGTa3vav17sj6c=;
        b=T++L9c9Wrp7TLX3Coa2qMb2pFJ7wXTapRDHRv6uk6BV75+qlhlNOoLuXpRecpu4W4v
         y6AUq2ckXD8LCT52aOCtqHxHtjwSGNIgpUr+S6cbXtL5gxkxOtxwlUMrRxvw8MQ5ZgCm
         onofVTt+wbq4XQ58cUuY1hq520R6YjogzN+E6pzeS2uipAb1LxfCWhJf5g4Xx5frrrwj
         jC0PrEkBRYG8d528lrEHQIwhV0XOgFVjYJoHnNGKsGTaJoiQ/LoDcClnXLG6bPNfPxie
         oSaikNWNcscK4cjfAAphFn9wqbZkEMmNC5Y0ngxLXZBZp2H95SKOvvaWskvvQ4BlDyRe
         vvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Elsn1kdcp1T0aFss4s1Yn5n0Fewq2VGTa3vav17sj6c=;
        b=uocuFIiZR8Mj9tBz5g2ejmolunwy/EUY/fGp+Wa5QowGVrJrF5OK1nKf0BiBMvR7IM
         onQRdAnkQ0VzYmBgtExNonZFYNBS4SdrZSVXuzeXrhVsE+ocBPFJm5oGFa1DYJznAmSE
         M+XyihObXODXKI30u7StUgnGvyVBb1VqoxWlZzP2NaDB+CDd9KtmMvhMvESZweTZTDy7
         qXUk4WDi0INoashYY0Sgl4FiLQXB05zqAOuF+Ij12Y4JETNlp0AOPaEcauqMkjZfKtle
         o8yzHD1ZvxsnzjG0+grpn9VakJUPeM9BnJ8CQegaMkL4LsqCgPKZ59c8Ky2UzH26IGM4
         ZwzA==
X-Gm-Message-State: AJIora/rbZsJgBt52pytzziqWiO+KJ/dx4IV+82D3A/NirXsgJ6o7rC7
        3UtoFHtcMSCqZsp8ahx/i2B0jrCA07EN3ccw4QpaX3tqAME=
X-Google-Smtp-Source: AGRyM1sVp1iVWM23LPMLvWA8ATPnDg1VhspCYWfwAdDmgWn2gEDaIH/aDkyrg7GJPh57jqsKQn+pRxKUCbei30tyBbY=
X-Received: by 2002:a17:907:72c4:b0:726:9406:f760 with SMTP id
 du4-20020a17090772c400b007269406f760mr9104598ejc.247.1656332892065; Mon, 27
 Jun 2022 05:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220626004326.8548-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <87tu87eh5h.wl-maz@kernel.org>
In-Reply-To: <87tu87eh5h.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 27 Jun 2022 13:27:45 +0100
Message-ID: <CA+V-a8sihw9=Ychakh6tV+1+MpRayr=1VSnhSYZNp0F+f4Hdnw@mail.gmail.com>
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

Thank you for the review.

On Sun, Jun 26, 2022 at 1:35 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 26 Jun 2022 01:43:25 +0100,
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Document Renesas RZ/Five (R9A07G043) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > * Fixed binding doc
> > * Fixed review comments pointed by Krzysztof.
> >
> > RFC->v1:
> > * Fixed Review comments pointed by Geert and Rob
> > ---
> >  .../sifive,plic-1.0.0.yaml                    | 44 +++++++++++++++++--
> >  1 file changed, 41 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > index 27092c6a86c4..59df367d1e44 100644
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
>
> Since it is the NCEPLIC100 that is broken, shouldn't the compatible
> string actually reflect that? I'd rather see 'andes,nceplic100' once
> and for all instead of starting with Renesas, quickly followed by all
> the other licensees that will inevitably integrate the same IP (which
> isn't even specific to the AX45MP).
>
> This IP also comes with all sort of added (mis-)features, which may or
> may not be used in the future, and it would make sense to identify it
> specifically.
>
Agreed, I'll update it as above.

Cheers,
Prabhakar
