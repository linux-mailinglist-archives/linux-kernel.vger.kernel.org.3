Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E78D4E78DB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376746AbiCYQZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354899AbiCYQZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:25:44 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BAF70851;
        Fri, 25 Mar 2022 09:24:09 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id o10so16432911ejd.1;
        Fri, 25 Mar 2022 09:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=60DYi1ncM2j6YrJ9+xc2tJcVqmdNibjYDu1dqzMc90U=;
        b=6b+zWG0SPdul3gDL5kbK9ATbvXHjrfPbSn9TMz1h7BmiLU9PEI2utivYeYfEBVgCGI
         VyWuCxMVIkG08JR0zjny32sOUK7EREu5nXiTzRMmEm5gvezOGeqv5qFYaRrjnby7xzd4
         NHH1jPhP/0wNjyjf7yY6nvyc5XWT7VHqpRl1HIpclJ053LtLUwM21fw5CjcrBVYRCAMV
         zI5mrq/DTKfHALjXaZvoeDFEW8MXdsS8KEhVMeUbJURAxB8Tu7wqaieZI9ta6RSGC1hw
         IXYXnT9+lDWbM31FsiOT/nJwK/v2mSnzZ3tj7/UJngPCByYYU3GoXZ7fCz93I4ixoJ7M
         rVFA==
X-Gm-Message-State: AOAM531PQlWO+QvorPZBpf8KI06Pbc7O1Z6cyGlDiONdE+2SgV7cdqH9
        AnceS866rcZU95RkQtv6mQx9cZ8EiGA=
X-Google-Smtp-Source: ABdhPJzjldhgEdYua2CoNIuh/dJSlmVw42Q3Lpn4a09I41O1mZibUTcrs4YHyXIE0BApFuhGH4lXMA==
X-Received: by 2002:a17:907:9621:b0:6d7:355d:6da5 with SMTP id gb33-20020a170907962100b006d7355d6da5mr12540109ejc.195.1648225447869;
        Fri, 25 Mar 2022 09:24:07 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id d2-20020a1709067a0200b006df8c996b36sm2484988ejo.26.2022.03.25.09.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 09:24:07 -0700 (PDT)
Message-ID: <23160ef7-359e-40a6-847c-7547760f041a@kernel.org>
Date:   Fri, 25 Mar 2022 17:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: ti,elm: Convert to yaml
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220325123707.22020-1-rogerq@kernel.org>
 <20220325123707.22020-2-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325123707.22020-2-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 13:37, Roger Quadros wrote:
> Convert elm.txt to ti,elm.yaml.
> 
> hwmod framework use is deprecated for new platforms
> so mark it so.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/elm.txt | 16 -------
>  .../devicetree/bindings/mtd/ti,elm.yaml       | 47 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/elm.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,elm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/elm.txt b/Documentation/devicetree/bindings/mtd/elm.txt
> deleted file mode 100644
> index 59ddc61c1076..000000000000
> --- a/Documentation/devicetree/bindings/mtd/elm.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -Error location module
> -
> -Required properties:
> -- compatible: Must be "ti,am3352-elm"
> -- reg: physical base address and size of the registers map.
> -- interrupts: Interrupt number for the elm.
> -
> -Optional properties:
> -- ti,hwmods: Name of the hwmod associated to the elm
> -
> -Example:
> -elm: elm@0 {
> -	compatible = "ti,am3352-elm";
> -	reg = <0x48080000 0x2000>;
> -	interrupts = <4>;
> -};
> diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
> new file mode 100644
> index 000000000000..e36452b742c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/ti,elm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Error Location Module (ELM).
> +
> +maintainers:
> +  - Roger Quadros <rogerq@kernel.org>
> +
> +description:
> +  ELM module is used together with GPMC and NAND Flash to detect
> +  errors and the location of the error based on BCH algorithms
> +  so they can be corrected if possible.
> +
> +properties:
> +  compatible:
> +    const: ti,am3352-elm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +

make dtbs complains, but it will be fixed in patch #2, so looks good:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
