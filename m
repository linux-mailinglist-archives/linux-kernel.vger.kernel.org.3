Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A77598AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345334AbiHRSPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbiHRSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:15:19 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EADBCACBC;
        Thu, 18 Aug 2022 11:15:18 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-335624d1e26so63287937b3.4;
        Thu, 18 Aug 2022 11:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=O+By8SMEsmKfUQcl5iTzfeSzCB2mzamR2FlbcS3iWL4=;
        b=OwJpheqT025swB+aQkicuRDS+5JK7bUrIY7PUJDoAKH86DJWZlcq6Pe9apJpXfgVqD
         adOT/+026BI4sRPQYb22IS/Qc9wiFvCfBhrjfuywrQfij9F3n8Ua7Hg2XIs5itKOSAUj
         lRfnUqtrh+K4hsTzYxzvNys4P/sksuatUIYrJ6Y/PMibiSF3ZZJ6H1ieERbMjlicpjyR
         n3Lbd7LCkcZePV37TLPniIPFYo9RPFK2RHBuuJ+oS4H2BigeX4Gwp3wMhEKaHknGNCw+
         +dUMMxCE1HHU8a/LA6Gx4/DNu9t8FN9wE+bNAzb8V+S3F2jUVSmyF4XKV/dMozVwEEpL
         Ovtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=O+By8SMEsmKfUQcl5iTzfeSzCB2mzamR2FlbcS3iWL4=;
        b=BbjWkVUQEtnrQ4xB1ta9wk2LT/yOMwkRtUU9DIXH9opTsa/MaaYbYARfFied5JHTNf
         F7AKDZENpuqTyuudt017pNt5FHkAxa+TMwoRguAYDC56ZaJWLtKxBpJQDwnzd0rnCn/7
         E2eQSs0VssZWx5tTxiX2PPcmU5IMZWKSkzOzBePRF2Kwc7YxJas+heRuGXeh9mbUZQr9
         +vWPk957oExhrPX8tD3HTZO3mC+S8TAOTV1fu75zZkCcHgsNn3rakXNHFBjUAHkX8qq+
         YCOo+fjazwPvM7s6HO/ex2LYCBjHfWRaFyu/iu12P3E6wQ7S9g/lha0MpsQcZ0KIM61c
         PGkQ==
X-Gm-Message-State: ACgBeo3sXPkFJqbX77Uzn3d5bmz2Czi3eT6d1XK0cTXX5Fm8qPXd7GQc
        ew5iwdShDIz9dEMKUARx2anRyOX+lmcA/B/VZ7RjhmZLZ6rldQ==
X-Google-Smtp-Source: AA6agR7JYpjH33vGbyFyKa+MW4WlwRlRszKVF+PruKNgD58gus/PmNbDQfsg4w839r1gZXy45mqFPwFmt959K4pZJuo=
X-Received: by 2002:a25:8b8c:0:b0:67b:5c18:870 with SMTP id
 j12-20020a258b8c000000b0067b5c180870mr4072997ybl.244.1660846517231; Thu, 18
 Aug 2022 11:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUaketBpEfoSKeSJ4SuYwOTLoqJ_FCp=G8HmVudhv3zWw@mail.gmail.com>
In-Reply-To: <CAMuHMdUaketBpEfoSKeSJ4SuYwOTLoqJ_FCp=G8HmVudhv3zWw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 18 Aug 2022 19:14:49 +0100
Message-ID: <CA+V-a8tSWshjoEqq=bwsY8eMfTe_QkZ-Uv+c3QBvZtD0XXgA+g@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: soc: renesas: renesas.yaml: Document
 Renesas RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Thu, Aug 18, 2022 at 4:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Document Renesas RZ/Five (R9A07G043) SoC.
> >
> > More info about RZ/Five SoC:
> > https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
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
>
> Should we be consistent, and leave out the "(RISC-V core)" comment,
> or add it everywhere?
>
Rather leave it for now ;) . If Rob agrees on your suggestion on
splitting (renesas,{rmobile,rcar-gen[1234],rza,rzg,rzn,...}.yaml that
would make it cleaner.

> Note that several of the SoCs listed in this file have SuperH or
> RealTime ARM cores, so going for the former means a lot of work.
>
Agreed.

Cheers,
Prabhakar
