Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9B450C976
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiDWLBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiDWLBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:01:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C8D8F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:58:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a1so7605747edt.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s8radedpzyLI4HDoWW69lEYh91W1j56nCvc9cs+YJf4=;
        b=f+1QC0z11D0dcebGt2VWGRFrDZdkfukZznanhVnVqzbFa8wIWHbcPbkvDEWNVtyhst
         8s2NczQTtq2QC+JpYxd/TASkMCIUmnVz5fJyne5/v8H504vCyh8oYcH3qxJO27Rat6gU
         konsyNv6wwihHH0rZcIzJWveUrA72x0Rm1OAIAnPQuMPxRBoqNx+GJ6O47KZOlbAYAMh
         12IGSRwMDLvPqAUtxiPTBORSQWvIPrRXhcQx99owgsLLGgT32rkVgHL0MtTBZnKHpqge
         WcRI5qXwNNLYRCJklloUjYKGAmhdFZyRq454WIBtUFwO/6+c4jVneBIi0Sb8DCosTAz2
         C1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s8radedpzyLI4HDoWW69lEYh91W1j56nCvc9cs+YJf4=;
        b=CP8k8epK+zEneuC2S5CP7RotBzuJAgwWcMyh7ymQkkwDj3HqXqsfz/BESJ9R7/u9WQ
         STcBXY/tObxbzmbfHuOI5ctkKtq4tpDdtyyD2NKbtR8j87im53kpRWYMYliWdd7VZ1/n
         Rw8zjKL7qBIW5Q2xSrYXKJs7Iwd3xBraR12AjvJF2/+IbRYlQ6s5XRUpn4VC5zxauDdN
         IWz/7vGCfX31cYUC3hiR9K3Dir2a7WrvFLG+KZWKO1P9aGG/0BcCmV2dRhSiLA0quzzn
         ZtjgGbMk0NIsEBcAzvvFXjnec556YGSFAWV1Lb2C/agFHo9S+f0r6rnWuej6ZE/ODtTY
         CFTQ==
X-Gm-Message-State: AOAM530GWuyV1pc55sbkdcFlGmb2ViFYY4rKhOHpo/IEdJZIGHLQHMpK
        yZzx3NCBHGgyobzfmaMawmltJNuzJjp2Kg==
X-Google-Smtp-Source: ABdhPJyBynvCg3KqONUzxY9h9+AK16bU/MfXMIpRGXRtMy8+m8Xuy7Z4CzO34NAen2NKE/SMnmQ40A==
X-Received: by 2002:a05:6402:5254:b0:424:78b:dfa4 with SMTP id t20-20020a056402525400b00424078bdfa4mr9604754edd.398.1650711498720;
        Sat, 23 Apr 2022 03:58:18 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y19-20020a056402359300b00423e51be1cesm2076104edc.64.2022.04.23.03.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:58:18 -0700 (PDT)
Message-ID: <2fdc71ed-b99c-22d9-c921-6eba134ee1f8@linaro.org>
Date:   Sat, 23 Apr 2022 12:58:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 07/11] dt-bindings: arm: Add HPE GXP Binding
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-8-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421192132.109954-8-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 21:21, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> This adds support for the hpe,gxp binding.

Just "Add support for HPE GXP".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

>  The GXP is based on
> the cortex a9 processor and supports arm7.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> v5:
> * Fix version log
> v4:
> * Removed gxp.yaml
> * Created hpe,gxp.yaml based on reviewer input
> v3:
> * Created gxp.yaml
> v2:
> * No change
> ---
>  .../devicetree/bindings/arm/hpe,gxp.yaml      | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/hpe,gxp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/hpe,gxp.yaml b/Documentation/devicetree/bindings/arm/hpe,gxp.yaml
> new file mode 100644
> index 000000000000..cd86b67ea207
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hpe,gxp.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/hpe,gxp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE BMC GXP SoC driver

This is not a SoC driver anymore, so instead maybe:
"HPE BMC GXP SoC platforms"
or
"HPE BMC GXP platforms"


> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +properties:
> +  compatible:
You do not allow any extension of this (no oneOf), which is fine if you
do not plan any other SoCs or SoMs. This is okay, but if there is a
chance list will grow, then you should have here oneOf, like other bindings.

> +    items:
> +      - enum:
> +          - hpe,gxp-dl360gen10
> +      - const: hpe,gxp
> +
> +additionalProperties: true
> +
> +...


Best regards,
Krzysztof
