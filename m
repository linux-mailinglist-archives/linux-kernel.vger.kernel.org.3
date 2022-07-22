Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4557DF4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiGVJmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiGVJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:42:01 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADD6CC6;
        Fri, 22 Jul 2022 02:31:40 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id bz13so3099329qtb.7;
        Fri, 22 Jul 2022 02:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/eKtb1gRHrco8cantWWpSRLNBaxxulEKH0F25Dqd8nk=;
        b=eLtx8SxvSjynZPSDhTIbmnKIXrYffNIICknXUpmLVWPLilFir4eklz65BCfeqdUtI/
         2OfEefsNyLWzmXHQ9qGnLrVvnLz8b0AVaOL3rH3Q+imUf2BlAY1QtUQgZCRWHB76wOvg
         HoOsotx9y4Q24H9lYXwh1i3QXndsEw/Xk/nNx6mnr8boyhLk2pntiuTRKEi9rWdW8XOg
         x7jXdWOP6ebDa5t/PBA6x6sXubIwcG0uSe5bSTCFxIEoVNZkhXUtKJrwtoB0WdOynDSQ
         6Zjk6h7Vvm8bt/fTi4lIkXa/NMJ7v3z2eg837E9IIQcxmMXAkKqAAKiiMEgvZ8yfMcjP
         g/Dg==
X-Gm-Message-State: AJIora82l+B2ekU0kilrAsyNNEHeyRjcEzaylJtSBTQRN9ZvxcBHpL/n
        HC8J8J/vIWnRQ7Dfu/8aoPRP6oB20PPc+g==
X-Google-Smtp-Source: AGRyM1sIWrdIdsDIAWqQgpIrcaCr9h2OtFlh44rPh4GfA1rrnP44h9Z+1dmaA27gB7mymKJ/Wcwhxw==
X-Received: by 2002:a05:622a:5d2:b0:31f:229d:441d with SMTP id d18-20020a05622a05d200b0031f229d441dmr911312qtb.277.1658482298812;
        Fri, 22 Jul 2022 02:31:38 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id t28-20020a37ea1c000000b006b58d8f6181sm3195045qkj.72.2022.07.22.02.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 02:31:38 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id r3so7102300ybr.6;
        Fri, 22 Jul 2022 02:31:38 -0700 (PDT)
X-Received: by 2002:a25:aacc:0:b0:66f:f1ca:409c with SMTP id
 t70-20020a25aacc000000b0066ff1ca409cmr2301873ybi.36.1658482297883; Fri, 22
 Jul 2022 02:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220721221212.18491-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220721221212.18491-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220721221212.18491-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jul 2022 11:31:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVy0w8Y-+MegHnjdFkQ7vB1Y=jPY-9atTFT_WTVYOiGLg@mail.gmail.com>
Message-ID: <CAMuHMdVy0w8Y-+MegHnjdFkQ7vB1Y=jPY-9atTFT_WTVYOiGLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: renesas: renesas,rzg2l-sysc:
 Document RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jul 22, 2022 at 12:15 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/Five (R9A07G043) SYSC bindings. SYSC block found on the
> RZ/Five SoC is almost identical to one found on the RZ/G2L (and alike)
> SoC's. To differentiate RZ/G2UL from RZ/Five, "-rzfive" is included in
> the compatible string for the RZ/Five SoC as there are no interrupts
> from the SYSC block to the core.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> ---
>  .../soc/renesas/renesas,rzg2l-sysc.yaml       | 56 +++++++++++++------
>  1 file changed, 39 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
> index ce2875c89329..bdaf05f8b29b 100644
> --- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
> @@ -20,35 +20,57 @@ description:
>  properties:
>    compatible:
>      enum:
> -      - renesas,r9a07g043-sysc # RZ/G2UL
> -      - renesas,r9a07g044-sysc # RZ/G2{L,LC}
> -      - renesas,r9a07g054-sysc # RZ/V2L
> +      - renesas,r9a07g043-rzfive-sysc # RZ/Five

renesas,r9a07g043f-sysc?

But I'm wondering if we really need a different compatible value?
It looks like both blocks differ only in external wiring, so if
anything needs to be handled differently (the removed/added registers
are related to CPU topology), that can be inferred from the system
topology (or even #ifdef CONFIG_{ARM64,RISCV} ;-)

> +      - renesas,r9a07g043-sysc        # RZ/G2UL
> +      - renesas,r9a07g044-sysc        # RZ/G2{L,LC}
> +      - renesas,r9a07g054-sysc        # RZ/V2L
>
>    reg:
>      maxItems: 1
>
> -  interrupts:
> -    items:
> -      - description: CA55/CM33 Sleep/Software Standby Mode request interrupt
> -      - description: CA55 Software Standby Mode release request interrupt
> -      - description: CM33 Software Standby Mode release request interrupt
> -      - description: CA55 ACE Asynchronous Bridge Master/Slave interface deny request interrupt
> +  interrupts: true
>
> -  interrupt-names:
> -    items:
> -      - const: lpm_int
> -      - const: ca55stbydone_int
> -      - const: cm33stbyr_int
> -      - const: ca55_deny
> +  interrupt-names: true
>
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-names
>
>  additionalProperties: false
>
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - renesas,r9a07g043-rzfive-sysc
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: CA55/CM33 Sleep/Software Standby Mode request interrupt
> +            - description: CA55 Software Standby Mode release request interrupt
> +            - description: CM33 Software Standby Mode release request interrupt
> +            - description: CA55 ACE Asynchronous Bridge Master/Slave interface deny request interrupt
> +
> +        interrupt-names:
> +          items:
> +            - const: lpm_int
> +            - const: ca55stbydone_int
> +            - const: cm33stbyr_int
> +            - const: ca55_deny
> +
> +      required:
> +        - interrupts
> +        - interrupt-names
> +
> +    else:
> +      properties:
> +        interrupts: false
> +        interrupt-names: false

Do all interrupts{,-names} have to be moved?
Wouldn't it be sufficient to just have

    if [...]
    then:
        required:
          - interrupts
          - interrupt-names
    else:
        properties:
            interrupts: false
            interrupt-names: false

?

But again, without a new compatible value, you could just make
interrupts{,-names} not required?

> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
