Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF16587978
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiHBI7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbiHBI7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:59:14 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53924E85E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:59:12 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bx38so5059686ljb.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rDww99bxZ2K/yqjmoq3VMhTRa5h4h8Y1EfcjnZHfk94=;
        b=P/jl4sFtz1DbCpP1Q7lGN97y4/R9mecC9JwtO80y4ggDk15tvzJrsxnyKC62COQETW
         v8MLmUHK20P81S4TLUGEoqR/POhXAReg4qYYUl1rRfJ4DLT5N5/uE/4tUL0AIxY6LV/n
         e+xAgt6br1ENb/zETwDDrS0luENfM9kMwNDSxcSiAuL3AKjJoGPROydxlVkm1wgn/lsD
         NSyCBNThJ3/wU9+q61xEPyIp+Z26OHa3FvMLkb2lDXr/+oyu6R25Zb2aZmEJ99BivGzf
         q7rQr5pc5OTE7R/ttOiG8yKwta95k5djwaOWQW3xNmzFypfZZ5SF9MdulDizkoWYGmZy
         2m0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rDww99bxZ2K/yqjmoq3VMhTRa5h4h8Y1EfcjnZHfk94=;
        b=qfk1qY8LZmb1ebFoDpbH1sQRNZrUBIQfW0YD47Fs4z9hNb7c3MOJlsHiqsHy5PkX/b
         FuYM1QWUOD68c33KCsmiV/NE5zoXozh18Te4gPgNmJov9tvUAiZGhUAq2VXunAPtDTNY
         YJQ0/KpwdoXpQ2omcM39CG9hTeNOElENJrbqV3+h6bczus8qOFdDW0IHdIUG8q4ZVTZm
         ap7bAtvJyx48IZ+mFlwosCh7OJUI/qGgYeuz5FENwZnrcX7kve2YAhnRQuPsz1ic9H2v
         L659T5MSOelKhoHgk5KX/f8JfmN7PYw0BX6/dvozbJg3eCru+huGDUScd7fqpJAyFA9B
         aj7w==
X-Gm-Message-State: AJIora+fQ79SGcLvoSSLMvv3MdtNB4udR7UB13xt/QiQpRX56+VvfQ+8
        DiXBG965A1vXxAExsxyRUWW9kSHph67uAaHE
X-Google-Smtp-Source: AGRyM1uOWqNPMAzWytOXQR2J61sWqAunSBTaLh3kg+0TBkWkquMqqEGhG2ByS32YRfZ/WqjuKxpL8w==
X-Received: by 2002:a2e:96c1:0:b0:258:e8ec:3889 with SMTP id d1-20020a2e96c1000000b00258e8ec3889mr6323278ljj.6.1659430751040;
        Tue, 02 Aug 2022 01:59:11 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id u8-20020a056512128800b0048ae316caf0sm1524349lfs.18.2022.08.02.01.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:59:10 -0700 (PDT)
Message-ID: <cd9518e3-9cb4-5165-af03-00e5300ab927@linaro.org>
Date:   Tue, 2 Aug 2022 10:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8188 and MT8195
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>, Rex-BC.Chen@mediatek.com,
        TingHan.Shen@mediatek.com, Liju-clr.Chen@mediatek.com,
        Jian.Yang@mediatek.com
References: <20220801113709.12101-1-jianjun.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801113709.12101-1-jianjun.wang@mediatek.com>
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

On 01/08/2022 13:37, Jianjun Wang wrote:
> MT8188 and MT8195 are ARM platform SoCs with the same PCIe IP as MT8192.
> 
> Also add new clock name "peri_mem" since the MT8188 and MT8195 use clock
> "peri_mem" instead of "top_133m".
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
> Changes in v3:
> Use enum property to add the new clock name.
> 
> Changes in v2:
> Merge two patches into one.
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml           | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 0499b94627ae..a0ca9c7f5dfa 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -48,7 +48,14 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: mediatek,mt8192-pcie
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt8188-pcie
> +              - mediatek,mt8195-pcie
> +          - const: mediatek,mt8192-pcie
> +      - items:

You have one item, so this is just const. Or enum if  you expect it to
grow soon.

> +          - const: mediatek,mt8192-pcie
>  
>    reg:
>      maxItems: 1
> @@ -84,7 +91,9 @@ properties:
>        - const: tl_96m
>        - const: tl_32k
>        - const: peri_26m
> -      - const: top_133m
> +      - enum:
> +          - top_133m        # for MT8192
> +          - peri_mem        # for MT8188/MT8195

This requires allOf:if:then restricting it further per variant.



Best regards,
Krzysztof
