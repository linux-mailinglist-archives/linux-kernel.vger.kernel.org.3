Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65F258DA24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbiHIOQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiHIOQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:16:37 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB746453;
        Tue,  9 Aug 2022 07:16:37 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id b12so6567081ils.9;
        Tue, 09 Aug 2022 07:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Q9mXyBIsDcHFkxvhhPAewKIvUVNC7xu4zQ9cHub7pU8=;
        b=L+Q0xSno4l3YN7yCMKBA9ezYbfeRxMhcAL/zOwqBID+fz4/6w+PCUMTYvngTQOHkm/
         SZb7S1R2MQox/aICzMwzHtiYtG7F/lpkyZwgkbvzXXIszvTWhYYwh5d/MER6faI2o8Wb
         odmg2Ln8O/98BMYd9xxVTRm3XGJIpYCjoEwEnlRPsMzTwCZRtHO8YC5npybnIQUD03+L
         F4PjsgfcNLevkQIY01EHjwqnsoSbh2RDRhappV0oQhawRO9LuG5UsHR1nAXPiRuVMHxM
         mK+88zrwn36rOuvwZHxH4XEZavhqnz/Frf7fkaLJnlEhFt+PdWqGo+XIJyTHg3rQbUUL
         x40Q==
X-Gm-Message-State: ACgBeo3uaLP4Wacg+T2YV8HZRZQsi474IplvcWgMUvzGjmc93WDGSTBm
        lpnOynW+YRa0QRTkLLiAOQ==
X-Google-Smtp-Source: AA6agR5sKNiD1jY7asRAYAJjA4Ioov1LBgXDA+f5syLv9nnxp52HOBVCeed/e86Hnn99NJMdjRx1Dw==
X-Received: by 2002:a92:c247:0:b0:2df:2e4d:5930 with SMTP id k7-20020a92c247000000b002df2e4d5930mr10661115ilo.229.1660054596321;
        Tue, 09 Aug 2022 07:16:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b16-20020a05660214d000b00684a7617f14sm1144598iow.10.2022.08.09.07.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 07:16:35 -0700 (PDT)
Received: (nullmailer pid 1749632 invoked by uid 1000);
        Tue, 09 Aug 2022 14:16:32 -0000
Date:   Tue, 9 Aug 2022 08:16:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH 1/3] dt-bindings: timer: sifive,clint: add legacy riscv
 compatible
Message-ID: <20220809141632.GB1706120-robh@kernel.org>
References: <20220805162844.1554247-1-mail@conchuod.ie>
 <20220805162844.1554247-2-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805162844.1554247-2-mail@conchuod.ie>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:28:43PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> While "real" hardware might not use the compatible string "riscv,clint0"
> it is present in the driver & QEMU uses it for automatically generated
> virt machine dtbs. To avoid dt-validate problems with QEMU produced
> dtbs, such as the following, add it to the binding.
> 
> riscv-virt.dtb: clint@2000000: compatible:0: 'sifive,clint0' is not one of ['sifive,fu540-c000-clint', 'starfive,jh7100-clint', 'canaan,k210-clint']
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/timer/sifive,clint.yaml           | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index e64f46339079..9fcf20942582 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -22,12 +22,18 @@ description:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - sifive,fu540-c000-clint
> -          - starfive,jh7100-clint
> -          - canaan,k210-clint
> -      - const: sifive,clint0
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sifive,fu540-c000-clint
> +              - starfive,jh7100-clint
> +              - canaan,k210-clint
> +          - const: sifive,clint0
> +      - items:
> +          - const: sifive,clint0
> +          - const: riscv,clint0
> +        deprecated: true
> +        description: For legacy systems & the qemu virt machine only

I would drop 'legacy systems'.

>  
>      description:
>        Should be "<vendor>,<chip>-clint" and "sifive,clint<version>".
> -- 
> 2.37.1
> 
> 
