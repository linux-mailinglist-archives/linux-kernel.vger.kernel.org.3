Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402AC57CE73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiGUPDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiGUPDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:03:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291178051B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:03:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a9so3192624lfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m05PEyvJBYLcYra9LMLRdpgjWFku28DAaTL3racaqfM=;
        b=Lt+z+MBCeRp3hGmYfqSLLAvTq+SIesg0kA1+/Pf//FjQK64CsrcgvWjb4GBZ5BgfcO
         qJ/sm9dCxF721aSgJ6p64Exooj9gc8NVka8dLAiMTbYlWwBPVNTFJDmDynnsvxyJMbtZ
         5gwxhai9yzcuxGwMt7a+KIQKXQErLXTYoFmJP9zTCY1B312eTdtrhM382FzxIAeUDzKU
         d/vhHzgfAlFbBLOOXS/JHn7NiHO3pBQv5B7x8Vk5OwQsE4Xyez+PUc3tMWcPpA9H3GeW
         rrfxGZex+CG5oiVSC/KJJyh1fR7UQoS2dR6ZAtNnJrhpxR7GboUUrgkEIjBcR7R5ILwl
         hAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m05PEyvJBYLcYra9LMLRdpgjWFku28DAaTL3racaqfM=;
        b=GGh3XTsvF8d2pr3N4M9mGlIu8A5H0KknH4XIMYhdl3EBzZzXtD3CUkh5RiIIm5mMvy
         porXDz0nA3JZgDsM6LK/71uqSUTQLoU8XAO0VFyl8vTT6QTmDMCMPM4wj9oroN7ySJfD
         QJrKAXzYJBv/ioa5Df+ZLrYOVyA3I61d86BhVi9mQxC9WZPwMg3ksMAr3WnzS513Hvyz
         cwq+6pzIbCB3yfbEsqHsulCtuBWSkuKVa74ptMo7eNZd0uG5OBy2TVrkHzXwcBCeJOOg
         67Tln6ip9dDK8WO9A9xrqaLimtndTpa25Uiz/zr5mc8RQu44F6jm9IF5I57KWL90KEOv
         oCjw==
X-Gm-Message-State: AJIora8A35TQTjuROPgkcX9Y2HebY7o9SHTyvWsfnqBhzhcUHA7piIkm
        IEblDjuEMqiEB8dpr3fnnIc4UA==
X-Google-Smtp-Source: AGRyM1sqKVlEQOUF795yDcSRQaIv3ciKoAcJO5S/kHh92tapiiNfkBj1eBuHKJQ04pN/AnaPgicRtA==
X-Received: by 2002:a05:6512:3b2a:b0:489:fa6d:8059 with SMTP id f42-20020a0565123b2a00b00489fa6d8059mr24227382lfv.677.1658415788321;
        Thu, 21 Jul 2022 08:03:08 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id i12-20020a2ea36c000000b0025d4974a12asm568531ljn.26.2022.07.21.08.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 08:03:07 -0700 (PDT)
Message-ID: <991334b7-0073-c647-b762-3681b79d6171@linaro.org>
Date:   Thu, 21 Jul 2022 17:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/5] spi: dt-bindings: add documentation for
 hpe,gxp-spifi
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
References: <20220720201158.78068-1-nick.hawkins@hpe.com>
 <20220720201158.78068-3-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720201158.78068-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 22:11, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create documentation for the hpe,gxp-spifi binding to support access to
> the SPI parts
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/spi/hpe,gxp-spifi.yaml           | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml b/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
> new file mode 100644
> index 000000000000..015130ecf971
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/hpe,gxp-spifi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP spi controller flash interface
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-spifi
> +
> +  reg:
> +    items:
> +      - description: cfg registers
> +      - description: data registers
> +      - description: mapped memory
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +
> +    spi@200 {
> +        compatible = "hpe,gxp-spifi";
> +        reg = <0x200 0x80>, <0xc000 0x100>, <0x38000000 0x800000>;
> +        interrupts = <20>;
> +        interrupt-parrent = <&vic0>;

Wrong property.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +                reg = < 0 >;

Wrong indentation, no spaces for <.


Best regards,
Krzysztof
