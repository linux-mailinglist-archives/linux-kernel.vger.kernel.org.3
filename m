Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4871653DC37
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbiFEOXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiFEOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:23:41 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA8D2CC8B;
        Sun,  5 Jun 2022 07:23:40 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso9035415otp.8;
        Sun, 05 Jun 2022 07:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7/oQ7IZ5egFH+OJP2S8YphbstrwI+fledauf//tGjcw=;
        b=QcbENaIONMr6Riea3pUe5Wak9tHddn9Tv1cRHPqdV4STAwaCmZ8rk4XR0rRiWwYYVa
         tdwKvH6Iyk4cYMhX2KATGE2gILmnvwDzFLs6d78DPMJBXiE191BvN013+wit+V2gKWwD
         drbAgsnI1ep2v2nXfd3ooSiW16ZqFyaaDHS7Zlk8tYsLzQJsdXE0qdu+I5UDLhcTbc1B
         jxmsln2I2bz658S62W2nxRLMvYApNiw34hs8+RiScMTQAwQLfLWnhMeW7mYZ8iSocAje
         QfnY8EBtpmlK3kFVUgF30tt+4DqKblFldZ+jzu2B4Xy0wfG1BpaKyQrg6Ti0aUVViAfN
         gvjw==
X-Gm-Message-State: AOAM533YQslNz44fgLA+voqV3EMY+2HvyLbTHpG47udwDcMA17pO5rLp
        mgcz/ie/8af3oKIpemIFYCas+JeqtQ==
X-Google-Smtp-Source: ABdhPJzH3dROMoziYUT0tlw5oSYBMNk6UzhmF/L+8NgEmJUvFsSOW5Z2havorxwbLEmKpsG8wvOSqw==
X-Received: by 2002:a05:6830:1bee:b0:60b:25bc:d8e1 with SMTP id k14-20020a0568301bee00b0060b25bcd8e1mr8118985otb.164.1654439019646;
        Sun, 05 Jun 2022 07:23:39 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fed:bdd:4931:91d5:7dbb:83fc])
        by smtp.gmail.com with ESMTPSA id x25-20020a9d4599000000b0060603221258sm6673566ote.40.2022.06.05.07.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:23:39 -0700 (PDT)
Received: (nullmailer pid 3445384 invoked by uid 1000);
        Sun, 05 Jun 2022 14:23:33 -0000
Date:   Sun, 5 Jun 2022 09:23:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH RFC 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Document Renesas RZ/Five SoC
Message-ID: <20220605142333.GA3439339-robh@kernel.org>
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220524172214.5104-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524172214.5104-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 06:22:13PM +0100, Lad Prabhakar wrote:
> Document Renesas RZ/Five (R9A07G043) SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../sifive,plic-1.0.0.yaml                    | 38 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 27092c6a86c4..78ff31cb63e5 100644
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

Did you test this? The above properties won't be allowed because of 
additionalProperties below. You need to change it to 
'unevaluatedProperties' or move these to the top level.

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
> -- 
> 2.25.1
> 
> 
