Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7357DF9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiGVKVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiGVKVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:21:41 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBF688E00;
        Fri, 22 Jul 2022 03:21:40 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i206so7287278ybc.5;
        Fri, 22 Jul 2022 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUOmZaaWZdL4aHrPnrxvArp44HB6G38b625uNkKyttY=;
        b=cvAX/C3FinUOHgPxFegdanpzYVu5UcB2TLSYzGaEHJMgUpT6TzBiwDMUbuJzHuOfyr
         BauYQxokp4b9lCGQApaY8Mx3cggaMLuTI64e6+ilSrywRDMQMRn0jhNbQopYxUXEYvI7
         H+sq/yGMAVnBsxm/D4G8U7oO61kLSS1AtNP5iiWqG6djF76er68DOmPsqvktM/fSuB9g
         xtCJB8+k/jK3j/r3oVeCzALNlSnqDUkEbv8CkLiH9389rC8tAleJuKfhGFJq5HG7gB8e
         sDzFYvyO5OPQvFGIUPZ5uuu2ZzKfjn04nkKL3BxSjLqq13OVvVe/gdZBqgHTXzXYtC0y
         46Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUOmZaaWZdL4aHrPnrxvArp44HB6G38b625uNkKyttY=;
        b=QhRofE5k6rZWbAW24pUJRUMZiEyd2eu7pJc2ODWfrlv2HMIoXJ8ajq8bZ8BiJJSsbI
         5Tp6ExxVaTY8rUF8P8fXPy6x2e/m3t52WYebcDGTzuB3gFTd1iG+td6iGDM0NKFWQBPR
         g0Io+rhKH5SOMlZpzWPReSUJ8bw9QLiXOjkPsVknAbH9NTgnEli1RNwW6si6WwHLw1Qy
         sMR+uUUkDkbVQh16Q6RAww80WTJRWHeAHBpJVVvuWP2WHEnPEOlK0YKSHpY4dYZuG1hv
         VAg5uHeEuWt5my0z0lN+jRF6Ca6bKd01CBA1UduhVOH85bNsaX1+ReKApKtI9rtfgOwx
         KSeg==
X-Gm-Message-State: AJIora8yeKayu5nqYwKlXBi8b2l/RZUAIIROsQSOynj3FWfxdCwKPftz
        3dxB4NENh+Ee3gj0GXicY5h6ziLyITbIhmNiGqAKXVIQd3JsqA==
X-Google-Smtp-Source: AGRyM1veOXbJyzBK5syagjCutWL1b5Kz2CIv95zfFti52FbUDh1LGzmd7krIAEzczpn/ldlFKn7aZl//rca/b9WXHA8=
X-Received: by 2002:a5b:508:0:b0:66e:db78:cc3f with SMTP id
 o8-20020a5b0508000000b0066edb78cc3fmr2397728ybp.299.1658485299630; Fri, 22
 Jul 2022 03:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220721221212.18491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220721221212.18491-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVy0w8Y-+MegHnjdFkQ7vB1Y=jPY-9atTFT_WTVYOiGLg@mail.gmail.com>
In-Reply-To: <CAMuHMdVy0w8Y-+MegHnjdFkQ7vB1Y=jPY-9atTFT_WTVYOiGLg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 22 Jul 2022 11:21:12 +0100
Message-ID: <CA+V-a8tddFVQnJjKSg9MTKB-Hh3X=2OwsU+THis+KFEfz7KB=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: renesas: renesas,rzg2l-sysc:
 Document RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Hi Geert,

Thank you for the review.

On Fri, Jul 22, 2022 at 10:31 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Jul 22, 2022 at 12:15 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Document RZ/Five (R9A07G043) SYSC bindings. SYSC block found on the
> > RZ/Five SoC is almost identical to one found on the RZ/G2L (and alike)
> > SoC's. To differentiate RZ/G2UL from RZ/Five, "-rzfive" is included in
> > the compatible string for the RZ/Five SoC as there are no interrupts
> > from the SYSC block to the core.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > ---
> >  .../soc/renesas/renesas,rzg2l-sysc.yaml       | 56 +++++++++++++------
> >  1 file changed, 39 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
> > index ce2875c89329..bdaf05f8b29b 100644
> > --- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
> > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
> > @@ -20,35 +20,57 @@ description:
> >  properties:
> >    compatible:
> >      enum:
> > -      - renesas,r9a07g043-sysc # RZ/G2UL
> > -      - renesas,r9a07g044-sysc # RZ/G2{L,LC}
> > -      - renesas,r9a07g054-sysc # RZ/V2L
> > +      - renesas,r9a07g043-rzfive-sysc # RZ/Five
>
> renesas,r9a07g043f-sysc?
>
Agreed.

> But I'm wondering if we really need a different compatible value?
> It looks like both blocks differ only in external wiring, so if
> anything needs to be handled differently (the removed/added registers
> are related to CPU topology), that can be inferred from the system
> topology (or even #ifdef CONFIG_{ARM64,RISCV} ;-)
>
Good point, but I wonder if we would end up in too many #ifdef
CONFIG_{ARM64,RISCV} checks. If thats OK I will stick with
"renesas,r9a07g043-sysc"

> > +      - renesas,r9a07g043-sysc        # RZ/G2UL
> > +      - renesas,r9a07g044-sysc        # RZ/G2{L,LC}
> > +      - renesas,r9a07g054-sysc        # RZ/V2L
> >
> >    reg:
> >      maxItems: 1
> >
> > -  interrupts:
> > -    items:
> > -      - description: CA55/CM33 Sleep/Software Standby Mode request interrupt
> > -      - description: CA55 Software Standby Mode release request interrupt
> > -      - description: CM33 Software Standby Mode release request interrupt
> > -      - description: CA55 ACE Asynchronous Bridge Master/Slave interface deny request interrupt
> > +  interrupts: true
> >
> > -  interrupt-names:
> > -    items:
> > -      - const: lpm_int
> > -      - const: ca55stbydone_int
> > -      - const: cm33stbyr_int
> > -      - const: ca55_deny
> > +  interrupt-names: true
> >
> >  required:
> >    - compatible
> >    - reg
> > -  - interrupts
> > -  - interrupt-names
> >
> >  additionalProperties: false
> >
> > +allOf:
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              enum:
> > +                - renesas,r9a07g043-rzfive-sysc
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          items:
> > +            - description: CA55/CM33 Sleep/Software Standby Mode request interrupt
> > +            - description: CA55 Software Standby Mode release request interrupt
> > +            - description: CM33 Software Standby Mode release request interrupt
> > +            - description: CA55 ACE Asynchronous Bridge Master/Slave interface deny request interrupt
> > +
> > +        interrupt-names:
> > +          items:
> > +            - const: lpm_int
> > +            - const: ca55stbydone_int
> > +            - const: cm33stbyr_int
> > +            - const: ca55_deny
> > +
> > +      required:
> > +        - interrupts
> > +        - interrupt-names
> > +
> > +    else:
> > +      properties:
> > +        interrupts: false
> > +        interrupt-names: false
>
> Do all interrupts{,-names} have to be moved?
> Wouldn't it be sufficient to just have
>
Agreed.

>     if [...]
>     then:
>         required:
>           - interrupts
>           - interrupt-names
>     else:
>         properties:
>             interrupts: false
>             interrupt-names: false
>
> ?
>
> But again, without a new compatible value, you could just make
> interrupts{,-names} not required?
>
You mean we just make it optional for all the SoC's?

Cheers,
Prabhakar
