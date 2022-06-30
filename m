Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E6F56223B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiF3SmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiF3Sl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:41:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654623FDAF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:41:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ej4so30220edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r0BVI/sdd04/zhgmWH7aIaeeBm4+Vvke6BUCZyn3hyg=;
        b=uQTmE1Um4nOuhHiHeoUXDpZUYNgOcZG0vZxcrqiB1QeU5sNRVVLaPdb2o1oZqUOXfF
         A5sa7uthLkoOVgJDy+fMTIUpr6aOnUSjdNFaWhhriiLY4PiMOg3pIX8QBA4Uo4ssS/wV
         qp9uGYpWrM0dQxdlb11sJihLToqdMiZwOYQO4ufTpOpWqdCkRv66MabVG6kXOORGcoUY
         kvRRElmIve3QQM04NCRKPZh8sfP3QTPCwONY2feUHQZZVX01bwUxeWcEtrpYDlReQDz6
         N+7T0ZVmAdDC0isxLUhFpOERJZp15rEytx4xmTeeMioSZYJg8KxWis5O9Md+XRBYEoHa
         K5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r0BVI/sdd04/zhgmWH7aIaeeBm4+Vvke6BUCZyn3hyg=;
        b=qVPzNw678l15AMhVXDhZdxOmMMcuV8DBn9AFiIgVQzuov+njozD0D1dTgSJJOm/f8B
         bmF2qkuIBEak1DqboMnNNETKe1pYXrEYofMti/fg5K3fjhWd+EchqTSw7gLcC0AA1Jdf
         5JzFfgqhXeX7fOm9rzfLCv+bWPOwJKIGFb9TyHV27mR69USgHT0ExFWhPGsCVYOMn3Sl
         tN2TG3hQnhRgOCQE7R6AHQEnZ10IB2/UFED1psJSEg6AhEGXodofB8zUPQdsIX4+i8xo
         +gPYN7ItuJSbkjCXml9u2XeE1kzBMYS0yI7L8iSyg0T8Lr0nXM1Q2+nImQG/BDOcx3xT
         WNkA==
X-Gm-Message-State: AJIora+SeuqWbeviQtVxCeWlZaDuofJeCyaisfbObdfmMR6/pkIxWAvJ
        9kcN8nK9jLJcrqDZak+DA0zRug==
X-Google-Smtp-Source: AGRyM1vkKMX06qz0erPeOdymXkH8eYsVt8dkgi/ckKf9JT6cSQDwknrl7psQLouE7nProJTlZBG24g==
X-Received: by 2002:a05:6402:1c09:b0:435:6562:e70d with SMTP id ck9-20020a0564021c0900b004356562e70dmr13185356edb.203.1656614517044;
        Thu, 30 Jun 2022 11:41:57 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906614900b006f3ef214dc3sm9302978ejl.41.2022.06.30.11.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:41:56 -0700 (PDT)
Message-ID: <42b8bf2c-c343-8fd4-17fd-f22ed83d5d0d@linaro.org>
Date:   Thu, 30 Jun 2022 20:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] dt-bindings: mediatek: Add assigned clock property
 and axi clock in example
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bin.zhang@mediatek.com,
        benliang.zhao@mediatek.com, linux-mediatek@lists.infradead.org
References: <20220630090157.29486-1-xiangsheng.hou@mediatek.com>
 <20220630090157.29486-3-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630090157.29486-3-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 11:01, Xiangsheng Hou wrote:
> For mt8173, it is needed to add the axi clock for dma mode.
> And it is may needed to adjust default spi frequency.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>  .../devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml  | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> index 41e60fe4b09f..7523d992a614 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> @@ -61,6 +61,12 @@ properties:
>        - const: axi
>        - const: axi_s
>  
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    maxItems: 1
> +

There is usually no reason to put this in the bindings.

>  required:
>    - compatible
>    - reg
> @@ -82,8 +88,8 @@ examples:
>          compatible = "mediatek,mt8173-nor";
>          reg = <0 0x1100d000 0 0xe0>;
>          interrupts = <1>;
> -        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> -        clock-names = "spi", "sf";
> +        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>, <&pericfg CLK_PERI_NFI>;
> +        clock-names = "spi", "sf", "axi";
>          #address-cells = <1>;
>          #size-cells = <0>;
>  


Best regards,
Krzysztof
