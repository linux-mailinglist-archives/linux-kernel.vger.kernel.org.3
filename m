Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734CF5943E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 00:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbiHOWWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350365AbiHOWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:17:47 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E8108964;
        Mon, 15 Aug 2022 12:40:59 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-32868f43dd6so98317207b3.8;
        Mon, 15 Aug 2022 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kQ/IhR019ljA3X63/yMrUHDq4kWcLp+Cdb8xnxJdIe8=;
        b=JmDiztWPbZq81Psi3DSOmbF4xFuYHM/kwMW4YslCcRI7hsgm2Wu1dLgQfGdUe73420
         DrKRbbc7yoFQUhjiGBB3iKgOrMXp3DYGfdpfWnYmtQOYWru3ni92DgQWwNGtQQoFxkbx
         YXHwjctCq9bAaVbgcy+JMwLfms1rxJbT2ok2IdPBoZl5zlrNoypIv5IoIuuzLzhEUhXR
         LCYt8K9fCi/uyBtdi+kjQxmTzXHL80QtcAkg6pU9wYA7QL8Xq8dmV1MbVT1qLbQrgINb
         CQEuZxTSkgRyMiSKr+FVr0AEG2AD7JPkrmXIMOkaN48EO0xv5Evw0UHp46ZhZtWBRoqG
         HfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kQ/IhR019ljA3X63/yMrUHDq4kWcLp+Cdb8xnxJdIe8=;
        b=EnrzwZNSvtMg/KDmQGjrXEgVk+OMC2DeWO4Qg1JkFrr7awwXfswpDLMVUpDOKxhW92
         5ERHxuh+A27cpNiWIHEIlq93uBqEvcP66YYlmTg1+yXJ2+F9zRhDiywAI7uyvu3gsz+T
         3H0++ng6jgzkb2LN+zbHZoHw7tjm3Ky2kyz1VFMiu2L26LVYMard/5CKGlPBe1t1f+Ks
         UCanEy0s1jVCknDkKw287Fg8/1RmvRk2J7aDlAYq5CEzsL1mlWtoGyw95zkF6PmKsgcF
         ljU2k1rFVZ1cZfnZdaWV0Esl0GNXP2XN8LdqGm5iDW6OZbeXAFYnAVpJDfUXNt/htoTN
         ocsA==
X-Gm-Message-State: ACgBeo0jW5U/8679lYeqt3Os25P+MJxT12PcNRENclkLBCMdlOrINjpS
        XrHLlZ4zqim8TWDBcIns/xgKoIfoW2fzM3KkFSsPk8HWA/0=
X-Google-Smtp-Source: AA6agR4uS+P3maNGKYHw+fLkUXC5gJLnyocxV5/qKNpiP36yndjwPPhByTnKKGwIMes2mnwF9ZlvObWDTZg1BbkpLd4=
X-Received: by 2002:a0d:d60f:0:b0:325:1853:2b with SMTP id y15-20020a0dd60f000000b003251853002bmr14178469ywd.24.1660592457358;
 Mon, 15 Aug 2022 12:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <57e17d1e-e809-065e-831f-cdd3a8602e0a@microchip.com>
In-Reply-To: <57e17d1e-e809-065e-831f-cdd3a8602e0a@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 15 Aug 2022 20:40:30 +0100
Message-ID: <CA+V-a8vDP8k9c8VM++68uKjQLGURC=pe571+QrmPb+tBo0j7Jw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: soc: renesas: renesas.yaml: Document
 Renesas RZ/Five SoC
To:     Conor.Dooley@microchip.com
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
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

Hi Conor,

Thank you for the review.

On Mon, Aug 15, 2022 at 8:14 PM <Conor.Dooley@microchip.com> wrote:
>
> On 15/08/2022 16:14, Lad Prabhakar wrote:
> > dt-bindings: soc: renesas: renesas.yaml: Document Renesas RZ/Five SoC
>
> Hey Lad,
>
> Maybe I am missing something on the arm side, but "soc"?
> Was the intent to move this to Documentation/devicetree/bindings/soc
> but you moved it back to arm by accident?
>
Ouch I sent out the older version of my patch for this. I did actually
send out a patch which moves arm renesas.yaml to the soc folder.

Cheers,
Prabhakar

> Thanks,
> Conor.
>
>
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Document Renesas RZ/Five (R9A07G043) SoC.
> >
> > More info about RZ/Five SoC:
> > https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * New patch
> > ---
> >  Documentation/devicetree/bindings/arm/renesas.yaml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
> > index ff80152f092f..233847eb23fd 100644
> > --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> > +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> > @@ -415,11 +415,12 @@ properties:
> >                - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
> >            - const: renesas,r9a06g032
> >
> > -      - description: RZ/G2UL (R9A07G043)
> > +      - description: RZ/Five and RZ/G2UL (R9A07G043)
> >          items:
> >            - enum:
> >                - renesas,smarc-evk # SMARC EVK
> >            - enum:
> > +              - renesas,r9a07g043f01 # RZ/Five (RISC-V core)
> >                - renesas,r9a07g043u11 # RZ/G2UL Type-1
> >                - renesas,r9a07g043u12 # RZ/G2UL Type-2
> >            - const: renesas,r9a07g043
> > --
> > 2.25.1
> >
>
