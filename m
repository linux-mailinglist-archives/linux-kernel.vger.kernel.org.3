Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E862B5829E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiG0PoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiG0Pn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:43:58 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F898481F1;
        Wed, 27 Jul 2022 08:43:58 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id y10so1270430ili.3;
        Wed, 27 Jul 2022 08:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EBPsyq8xCTUIGHkDPSsIKhxwmfJ6F+duXUDyo4llVo0=;
        b=Dd4XhgcraxGfeXihvDttIG+3BJg7BPXpZA1zb+K7jHbf+jM4h/hfp1GdjhPONgOU7W
         sTcBHTgNh398/wuHvboiY5Zw3z+7bfReEeinFdVnOJYDWNPrhs1YjIbKPtSLB0KQgF3v
         P2xVKp/9laZY4RMNEABJCnhUl7JOkpcvyaxa+3G5aydbcp+eTr8znI7ditlN+1Nta57X
         aOALgIOe5FjMl/0re01w7VtFvc6MANsI0ejePTdFXBp0kWU3mtSwcMHOfqvYz5f6UCBX
         uCnkWmWpczUIFc0K5/ZlwnDyTbd9IZiEZVEW8Nf6CFgV+JnCbfDT+tpOc9PoGxC4xCTf
         TRww==
X-Gm-Message-State: AJIora9eFpBE3wkG46L7F2BztFPiRxRxK+YEZYKDHs2hWIftoJv5zXR4
        UykbjHY34a3PsuNGvamJLA==
X-Google-Smtp-Source: AGRyM1sP6a08WkTCUGcmRvfX3ijrTpt7NEQ6DQj6lTIcMRgPCXMgOcSJmDPAyD1mwUTjZKCujuIgzg==
X-Received: by 2002:a92:6504:0:b0:2dd:8201:fdeb with SMTP id z4-20020a926504000000b002dd8201fdebmr3968342ilb.98.1658936637261;
        Wed, 27 Jul 2022 08:43:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a20-20020a027a14000000b0033f5e8dab90sm8092861jac.143.2022.07.27.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:43:56 -0700 (PDT)
Received: (nullmailer pid 2728328 invoked by uid 1000);
        Wed, 27 Jul 2022 15:43:55 -0000
Date:   Wed, 27 Jul 2022 09:43:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm: renesas: Ignore the schema for
 RISC-V arch
Message-ID: <20220727154355.GA2723077-robh@kernel.org>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 07:06:18PM +0100, Lad Prabhakar wrote:
> Ignore the ARM renesas.yaml schema if the board is RZ/Five SMARC EVK
> (RISC-V arch).
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/renesas.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
> index ff80152f092f..f646df1a23af 100644
> --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> @@ -9,6 +9,15 @@ title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
>  maintainers:
>    - Geert Uytterhoeven <geert+renesas@glider.be>
>  
> +# We want to ignore this schema if the board is of RISC-V arch
> +select:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          items:
> +            - const: renesas,r9a07g043f01

As I've said, this doesn't work without tool changes I proposed.

Rob
