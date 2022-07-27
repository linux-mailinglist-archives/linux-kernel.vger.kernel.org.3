Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC158228F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiG0I4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiG0I4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:56:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316FB46DA9;
        Wed, 27 Jul 2022 01:56:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 7so29308744ybw.0;
        Wed, 27 Jul 2022 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkB6NL9eAnr19/TQLpmTufTfbZl37uoNWuGYLlmz/8k=;
        b=GqRkP7vFcAVq2DhhITbw1b0xfQ1uKUk6N6xmReUGdyyCKqbxM4CI7Fpe1h/97fSriA
         UrRy2LQNlfpk8GDHsobZT9fV74fJnv2kthAwTTDtdsT/nBhhH7KEfYbGkOsujUYJr2Tv
         eJjpGZpf7ScJwDsakDqoHDX5G2U5+pY83R03AJXK7iFTWfZJwSx1KvHpH5oNaTCAAWxw
         3ebU6Ts11JtpSpaHodhpQ6QeJCRTkyHJnUru1Xt5fJcTpMxS3bAgePlPON50cKKwGuB/
         QF5X14Q8ZVPhiozyWwGrZV3Q+F5tWEla7Lf29uSjyPmQzuOsaXChwzkm1evf60WcFtDT
         GaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkB6NL9eAnr19/TQLpmTufTfbZl37uoNWuGYLlmz/8k=;
        b=2KlHkDv4UY57abJxvkBg43srqyQiE3Y3OWuWnjQ98UYZLmjrXatKo7tfiGUPDXfiNg
         SJGHk/Qt5Hc60dEMIvqUrR0W06/9Ggl4VMwrWx1njYnGvoYMiUFnV8P5ZWk/RUkRshFk
         KFkFcxdpgPbISXyOyBa3kNjvupRTaC+sbR+ZNVwgl+L05Hzt69SWLh0tqLkJwKP8oL9u
         Qwcmux2I9yv9yU+Ik/inxO/kN02810pELTC+HSw2+tmtvvO55iQgOLRo9yO1DmVORfkS
         lDz45JxehUuoZIoaNutQqHYJOrZmNdG60KFznC4sMJHHFc1nOPXO6P29se+ev7jw5rqt
         b83w==
X-Gm-Message-State: AJIora/niA33ivCRpofMXUuD+/fvRNcuK9ZEqGrmC+qGsRBL2sGBRGVw
        UnuFXMwH4bd6J81ojHw1hS8Jn9Y1KJjmXWppwyY=
X-Google-Smtp-Source: AGRyM1vxCFNIpm4r9DElzmSmhQabM1an5qQ3zyXIaUD5kyzOkB0PNy9FkUfrry+SpKtM+GOzesxYN8vcgJD352Iqfbg=
X-Received: by 2002:a05:6902:1082:b0:670:9307:b0eb with SMTP id
 v2-20020a056902108200b006709307b0ebmr17460924ybu.335.1658912164494; Wed, 27
 Jul 2022 01:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <7a02225c-5c7b-f342-e29e-995d1ae0f4e3@linaro.org>
In-Reply-To: <7a02225c-5c7b-f342-e29e-995d1ae0f4e3@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 09:55:37 +0100
Message-ID: <CA+V-a8vCRNb9r8o=C97DV11ZA4Uf+7rHmbO6+Gjq+q=CUuDPRA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm: renesas: Ignore the schema for
 RISC-V arch
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

Thank you for the review.

On Wed, Jul 27, 2022 at 9:51 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/07/2022 20:06, Lad Prabhakar wrote:
> > Ignore the ARM renesas.yaml schema if the board is RZ/Five SMARC EVK
> > (RISC-V arch).
>
> Your commit msg says one, but patch ignores r9a07g043f01 which sounds
> entirely different for non-Renesas people. Be a bit more clear.
>
Sure will update the commit message.

> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/arm/renesas.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
> > index ff80152f092f..f646df1a23af 100644
> > --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> > +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> > @@ -9,6 +9,15 @@ title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> >  maintainers:
> >    - Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > +# We want to ignore this schema if the board is of RISC-V arch
> > +select:
> > +  not:
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          items:
>
> It is only one item, so I guess you wanted here enum.
>
> Just like syscon is doing...
>
Ok I will switch to enum.

Cheers,
Prabhakar
