Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC448582376
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiG0Jsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG0Jsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:48:51 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA733E760;
        Wed, 27 Jul 2022 02:48:49 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31f64093c21so10597947b3.6;
        Wed, 27 Jul 2022 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ovc5shbS0fYZ1tyN3kjcZK0qy/VEjAYRKQdwOOz4xxc=;
        b=oOG3gcU1YIU4gwipAdyMVjIIY4vuN8EmL1P69THZ9JDcgvQhIl91DkkE7u3O3GXU6v
         PN9+tVxoHltovlvMGDqO7UZoKaB0KVhvVD9atC7yIBGCXTS5Sf37po1PmPdq4hrVSdSJ
         aPAIGz8SHv7gHEl5UySreFbYUe7EPkxuMO1hTW00IcS8nO8ck2NF3FmdOxjJMR1T+the
         sdTXGAGnqxtyF51xXMA6l9nrWwalSMf+cedREQ2xc2JOJgY/UxWD/kuJKN8l2igiLCHS
         D/y1wcCuZxD8+GQnp/DarW2RWIHEDWVUq7s6Hyd/isWgcDUlhv+kgCtYgZYP5WbvpQ0e
         nwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ovc5shbS0fYZ1tyN3kjcZK0qy/VEjAYRKQdwOOz4xxc=;
        b=ls3Dz2cvzNGAaACVOQzR8kREmay6eZGWWF5Rx42eJ6ujONfugELn167HzXj5cC/G2P
         J7b37CMOWIrDFL/nyIrb7y8XJro20RpPPrb5kL3yBTJzFThiLRKrs2G1VSV2fUVXFNAq
         EEcRuI8EI3niv6UO6l3qy1sxs92ab1CCh97xUEjjs+YQSWwVQwbev3cfgzVz2mCPyn0z
         6JxAC8/KqPD/kZSG0qDV7uw+QVJ4wWcwqDU637qpj+FY1JjJz7G6mqCU2KssoiG20wCX
         JbxvXUrhHcv4/MB5jpSiB2BkdxW3kzdt8d39tUXSorX3BDyITmxAm4xqNTb1G0h/ludn
         cuKQ==
X-Gm-Message-State: AJIora/QWSc8436j2AvkK6l8ZvQMOjYRr4f1NmhLKKVDLIQQQXI5sEDA
        nYydsb/uDPJHOlEWL2Jvn4R+Jx2rRaqkQSANNHw=
X-Google-Smtp-Source: AGRyM1u0MOdkXEb4VerU+w73qTk9PZ3K6+cMpGT4uhYq7ze96hmz4VQwbYEqEJulqEsZJfJtFTd8m0sGtcJXvGhmlSQ=
X-Received: by 2002:a81:168d:0:b0:31f:6595:4195 with SMTP id
 135-20020a81168d000000b0031f65954195mr1085301yww.355.1658915328722; Wed, 27
 Jul 2022 02:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <952a85ec-d1e9-7c14-6404-bc087723252f@linaro.org> <CA+V-a8vb+za1Zckk5aTxz0hKkd5fHQk7gtfV+HR_2YMZ5JuJEQ@mail.gmail.com>
 <3e3c0c80-48eb-098d-977d-a1801036fc0c@linaro.org>
In-Reply-To: <3e3c0c80-48eb-098d-977d-a1801036fc0c@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 10:48:21 +0100
Message-ID: <CA+V-a8tJVGz57FcJVnbksMot=pg5dXALo4QEyqO+57HnOTJLfQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm: renesas: Ignore the schema for
 RISC-V arch
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Krzysztof,

On Wed, Jul 27, 2022 at 10:31 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/07/2022 11:00, Lad, Prabhakar wrote:
> > Hi Krzysztof,
> >
> > On Wed, Jul 27, 2022 at 9:53 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 26/07/2022 20:06, Lad Prabhakar wrote:
> >>> Ignore the ARM renesas.yaml schema if the board is RZ/Five SMARC EVK
> >>> (RISC-V arch).
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/arm/renesas.yaml | 9 +++++++++
> >>>  1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
> >>> index ff80152f092f..f646df1a23af 100644
> >>> --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> >>> +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> >>> @@ -9,6 +9,15 @@ title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> >>>  maintainers:
> >>>    - Geert Uytterhoeven <geert+renesas@glider.be>
> >>>
> >>> +# We want to ignore this schema if the board is of RISC-V arch
> >>> +select:
> >>> +  not:
> >>> +    properties:
> >>> +      compatible:
> >>> +        contains:
> >>> +          items:
> >>> +            - const: renesas,r9a07g043f01
> >>
> >> Second issue - why not renesas,r9a07g043?
> >>
> > We have two R9A07G043 SOC'S one is based on ARM64 and other on RISC-V.
> >
> > RZ/G2UL ARM64:
> > Type-1 Part Number: R9A07G043U11GBG#BC0
> > Type-2 Part Number: R9A07G043U12GBG#BC0
> >
> > RZ/Five RISCV:
> > 13 x 13 mm Package Part Number: R9A07G043F01GBG#BC0
> >
> > So to differentiate in ARM schema I am using  renesas,r9a07g043f01.
>
> What is the point to keep then r9a07g043 fallback? The two SoCs are not
> compatible at all, so they must not use the same fallback.
>
Agreed, I wanted to keep it consistent with what was done with ARM64
(since both the SoCs shared R9A07G043 part number).

Geert - What are your thoughts on the above?

Cheers,
Prabhakar
