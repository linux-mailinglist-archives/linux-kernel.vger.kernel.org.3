Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722994E72CE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358932AbiCYMQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbiCYMQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:16:10 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04434D624;
        Fri, 25 Mar 2022 05:14:36 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id pv16so15040595ejb.0;
        Fri, 25 Mar 2022 05:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8V5ivikltya3vIFHgv4xionf1dAlc1QnsjDXk5/7sVU=;
        b=QXnfFkH2//hgyHFOeUnOd0TCb2aFW+prNJ7T+iukI3pWRWIEc11uYRvPc8uqpuOMYR
         JeVCv/CvXYANvnOwRuHa976rASHz/MdbAsr/0hM/jo8NyKh5UMdPXgDLeDYOhu7NQJ5z
         CU3G0QoRJkKeksCUakqFKIz1U/5l4ak4Eu9PYvLhHThxFPfsTBYipFVt6yCYn0fMzl6u
         IjldXaocbcSw0UM7Xdjuh0wFB+kUm7Z6au1DH7e7ib1tI/0Se3C/Rs4SxJk3oLTbZZYf
         UVOfphDLlUvnNIvfke/OHWb+6iElc29ISB0sXFSJUNDcd7UK29nj0thhg/C1D6EY3yzg
         tGQQ==
X-Gm-Message-State: AOAM533FYzUNmbz7ocxJ7oRgVL3l3+ShzAokbp24JLsJjLZhJUfyN7Wk
        +ZtOgMJ57F5fHNrYVEmuquY=
X-Google-Smtp-Source: ABdhPJy8E5ALcm1XcsAwdMWd0q03ak98tgDhZsJLvOPk2ckVlPZmjqfKSCmL+g6/9BY00tyINQ8cGw==
X-Received: by 2002:a17:907:168a:b0:6da:9167:47dc with SMTP id hc10-20020a170907168a00b006da916747dcmr11130921ejc.126.1648210475303;
        Fri, 25 Mar 2022 05:14:35 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id p10-20020a17090664ca00b006df8869d58dsm2256573ejn.100.2022.03.25.05.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 05:14:34 -0700 (PDT)
Message-ID: <d9b883d2-8269-8419-3bcd-3761074bea96@kernel.org>
Date:   Fri, 25 Mar 2022 13:14:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add binding for Richtek
 RT5759 DCDC converter
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1648170401-6351-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 02:06, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add bindings for Richtek RT5759 high-performance DCDC converter.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../regulator/richtek,rt5759-regulator.yaml        | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
> new file mode 100644
> index 00000000..c24b583
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rt5759-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5759 High Performance DCDC Concverter

typo: Converter

> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  The RT5759 is a high-performance, synchronous step-down DC-DC converter that
> +  can deliver up to 9A output current from 3V to 6.5V input supply, The output
> +  voltage can be programmable with I2C controlled 7-Bit VID.
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RT5759/DS5759-00.pdf
> +
> +allOf:
> +  - $ref: regulator.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rt5759
> +      - richtek,rt5759a
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulator-allowed-modes:
> +    description: |
> +      buck allowed operating mode
> +        0: auto mode (PSKIP: pulse skipping)
> +        1: force pwm mode
> +    items:
> +      enum: [0, 1]
> +
> +  richtek,watchdog-enable:
> +    description: enable the external watchdog reset pin listening
> +    type: boolean
> +
> +if:

This should be inside allOf. Move allOf here,

> +  properties:
> +    compatible:
> +      contains:
> +        const: richtek,rt5759
> +then:
> +  properties:
> +    richtek,watchdog-enable: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  # example 1 for RT5759
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rt5759@62 {

Generic node name, so pmic.

> +        compatible = "richtek,rt5759";
> +        reg = <0x62>;
> +        regulator-name = "rt5759-buck";
> +        regulator-min-microvolt = <600000>;
> +        regulator-max-microvolt = <1500000>;
> +        regulator-boot-on;
> +      };
> +    };
> +  # example 2 for RT5759A
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rt5759a@62 {

Ditto

> +        compatible = "richtek,rt5759a";
> +        reg = <0x62>;
> +        regulator-name = "rt5759a-buck";
> +        regulator-min-microvolt = <600000>;
> +        regulator-max-microvolt = <1725000>;
> +        regulator-boot-on;
> +        richtek,watchdog-enable;
> +      };
> +    };


Best regards,
Krzysztof
