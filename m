Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091CC582298
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiG0JAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiG0JAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:00:48 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A26459;
        Wed, 27 Jul 2022 02:00:47 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id r3so29220682ybr.6;
        Wed, 27 Jul 2022 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lp2UjJeoZNtF3jPddaeCcZ2oTGYQdnwK+wO4WeAagn8=;
        b=XSbIlFiwirHn32plE+wRVIidNeyGwGE7rZrO/FxalW9hGgD1B9ySrWfh7gdqqFTZVY
         H0IejLiZa0buXTKLM1YPKWBU91ytBxfhcdenftN4TD9ztWV/Fdg66hs7YkNaspOMKUly
         7Sw+B7WD/IsXkTMpXtLW7SkG9qfM8tf/lYzBfRtwO56Wjci9sTysluMbYUgld7IzNeA4
         gOYFUXNc3FhUpXS4jZwP76jeObHD5HwiL7+8RIRlGS0t5bg5wdoTmr6Y3ls4q/3UP1kO
         lm8oCE9OvlCbXqnYkYmQzq/H9jCWjI6f2JiJMxMusR5mu2HmG+gEXPqV+mfVT6AmcGDT
         M89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lp2UjJeoZNtF3jPddaeCcZ2oTGYQdnwK+wO4WeAagn8=;
        b=rMYZI8hoFpnS+K5MZOv6Q9xbFh1V9zPwAXDb/VtoCxfSqcmf7gtN26SS5MqbptSLIj
         HYrobI6/xneO5fR+Yxnj8ngEifEKE/dSEMxc+u81DJL5b5kTY7v9tpiuD44NJGqCpBjH
         7BiWQ/JK0/csGQd3qus2J16aXYpwEG89zbhNbkZhmpCDxEIv6QluZ4HO6o1Z5T32DGB1
         sMCjBVlCKBPoSRIhV8ekV+vXb2r7VSULtDbdW5z18V+L1KipcimTzUQB4BIWH0+tj8e3
         vkHe9LBOuNmaszhfSjbfeb+GcCQib3Hzeoxvne+V0Xk580XAXoEsQvl+uko3hR/jbkXV
         3kVg==
X-Gm-Message-State: AJIora+CAWmdgMd0yuX8FD0OqylwpiOooqn22NmZGmsiVLYqD5g3BzNz
        lTQbAoJ5tdG9LWh3OGPRQJ/wRtKNLcmff+VQQuc=
X-Google-Smtp-Source: AGRyM1ueFJysPUexyidBDBCQ2Ajm5GpI2JfoVj8pVsuoL+AzQRgL3tl0GMPhkouwXL5dOZX4XHhkjaJbr0lJsLccxPg=
X-Received: by 2002:a05:6902:20a:b0:670:c563:9180 with SMTP id
 j10-20020a056902020a00b00670c5639180mr16432213ybs.401.1658912446846; Wed, 27
 Jul 2022 02:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <952a85ec-d1e9-7c14-6404-bc087723252f@linaro.org>
In-Reply-To: <952a85ec-d1e9-7c14-6404-bc087723252f@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 10:00:19 +0100
Message-ID: <CA+V-a8vb+za1Zckk5aTxz0hKkd5fHQk7gtfV+HR_2YMZ5JuJEQ@mail.gmail.com>
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

On Wed, Jul 27, 2022 at 9:53 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/07/2022 20:06, Lad Prabhakar wrote:
> > Ignore the ARM renesas.yaml schema if the board is RZ/Five SMARC EVK
> > (RISC-V arch).
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
> > +            - const: renesas,r9a07g043f01
>
> Second issue - why not renesas,r9a07g043?
>
We have two R9A07G043 SOC'S one is based on ARM64 and other on RISC-V.

RZ/G2UL ARM64:
Type-1 Part Number: R9A07G043U11GBG#BC0
Type-2 Part Number: R9A07G043U12GBG#BC0

RZ/Five RISCV:
13 x 13 mm Package Part Number: R9A07G043F01GBG#BC0

So to differentiate in ARM schema I am using  renesas,r9a07g043f01.

Cheers,
Prabhakar
