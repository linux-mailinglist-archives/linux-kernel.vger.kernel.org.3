Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2443D5447DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbiFIJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbiFIJmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:42:31 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9065B50B14;
        Thu,  9 Jun 2022 02:42:24 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id k6so14280624qkf.4;
        Thu, 09 Jun 2022 02:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdScqDIt7cletpD0dszRyDkdpl0EPlQmkhSL9q4U+Ck=;
        b=ceds/elGnpkjID5ZoIdSwaSld41Dac4zAVRQ+xs7tmk+Cu6VrDmMqe0S4dyQ0J0rHd
         aFt8KDxCidnvaEVsMV69K+rr9G8Au5rTM1fNo2LfJsheidTmFO4s4J/I9YBj9ENbBByE
         7I5dy9RM1L8zRBHMWc7pFZvUS7DA89qqAQpT2AXRZ669ZsK4MmDGtUE970sV2aZPePf3
         ksoz/BZWSwq8zDJaTr90X+/9OrcH9e58QSa3NmuHCv5zW3KSKCrP9SyFciTWkHLwONJ2
         Nn4jR4WXsT3Ls45G7lBmAE5WXBKlXH842DSDuLiYsteSHfoP7vgNh8b4otbfE+BIJIN4
         bo7A==
X-Gm-Message-State: AOAM531toxFFOFWJQb68P+/O2L/+fxx1UaAKx52Kr1ungv3mbZSQx3wb
        w8VK5aYSVoNtCucMKidh863QQNBZJQxNgQ==
X-Google-Smtp-Source: ABdhPJzY6ooSfoUi3N1kpt/bhEZP6s3kjylbACz/P3zuPsnkekUsrz8vJaSsT/CbY55BIMPgEz9eaA==
X-Received: by 2002:a37:5ac4:0:b0:69a:1423:4cac with SMTP id o187-20020a375ac4000000b0069a14234cacmr25828294qkb.41.1654767743443;
        Thu, 09 Jun 2022 02:42:23 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id f9-20020ac80689000000b002f3e127be41sm15723549qth.20.2022.06.09.02.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 02:42:22 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31336535373so84198547b3.2;
        Thu, 09 Jun 2022 02:42:22 -0700 (PDT)
X-Received: by 2002:a81:1dd2:0:b0:30f:a4fc:315e with SMTP id
 d201-20020a811dd2000000b0030fa4fc315emr43772632ywd.383.1654767742001; Thu, 09
 Jun 2022 02:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220524172214.5104-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220524172214.5104-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jun 2022 11:42:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVos-hVhGar91oBvZaCOLfjdsNR7vRGnX-KuNt0UX3xWQ@mail.gmail.com>
Message-ID: <CAMuHMdVos-hVhGar91oBvZaCOLfjdsNR7vRGnX-KuNt0UX3xWQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Document Renesas RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, May 24, 2022 at 7:22 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document Renesas RZ/Five (R9A07G043) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -28,7 +28,10 @@ description:
>
>    While the PLIC supports both edge-triggered and level-triggered interrupts,
>    interrupt handlers are oblivious to this distinction and therefore it is not
> -  specified in the PLIC device-tree binding.
> +  specified in the PLIC device-tree binding for SiFive PLIC (and similar PLIC's),
> +  but for the Renesas RZ/Five Soc (AX45MP AndesCore) which has NCEPLIC100 we need
> +  to specify the interrupt type as the flow for EDGE interrupts is different
> +  compared to LEVEL interrupts.
>
>    While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
>    "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
> @@ -57,6 +60,7 @@ properties:
>            - enum:
>                - allwinner,sun20i-d1-plic
>            - const: thead,c900-plic
> +      - const: renesas-r9a07g043-plic

renesas,r9a07g043-plic

>
>    reg:
>      maxItems: 1
> @@ -64,8 +68,7 @@ properties:
>    '#address-cells':
>      const: 0
>
> -  '#interrupt-cells':
> -    const: 1
> +  '#interrupt-cells': true
>
>    interrupt-controller: true
>
> @@ -91,6 +94,35 @@ required:
>    - interrupts-extended
>    - riscv,ndev
>
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: renesas-r9a07g043-plic

renesas,r9a07g043-plic

> +then:
> +  properties:
> +    clocks:
> +      maxItems: 1
> +
> +    resets:
> +      maxItems: 1
> +
> +    power-domains:
> +      maxItems: 1
> +
> +    '#interrupt-cells':
> +      const: 2
> +
> +  required:
> +    - clocks
> +    - resets
> +    - power-domains
> +
> +else:
> +  properties:
> +    '#interrupt-cells':
> +      const: 1
> +
>  additionalProperties: false
>
>  examples:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
