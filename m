Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC258A638
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiHEG4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbiHEG4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:56:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584473923
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 23:56:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m22so2146218lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l57jcSucFlto9PnftAtzBZFwojE9V65pDuDRB548mYY=;
        b=Y2oJ+watspFdbWHbixkBDHkyslRi3U5XS0hPKFP6gn6IV6FwU42VmgkRbRHe9GJ6Fy
         1bCfD7RRN8zcLHeUw2j016owd45EIivNMN3UeK0liosAQ+7vsYr4ZbrILycpyo9543ck
         WLEh4FSuQSjrxXzXWNxVNszrf37sH/fphM7HJ3nhk+K6MXTtOU2t4hBNrgMaSc1lurmq
         ZxXFL1qF28VupoDAhphaDbgrIYxHoDBeOsH7EFEszuD0MOhE7u8pkQa94K4pk+v99jS3
         Hyd2FKnJSPHGZzqxSKo3+PGJ0Wz/asmH07ADr1nesX1kJsV7U8hJQx5iwVnIdW+S/Y15
         uijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l57jcSucFlto9PnftAtzBZFwojE9V65pDuDRB548mYY=;
        b=6ev1uuWFhVk3EezUkKCh1HEgz3LRGmANwhhLLOsELsDOZjm/eI+zMVaBXa5vjss55C
         HDoSXNWsRLBmQdmiI6jX8uE2j/2HVj3b3AsJ96AbubURXvqpmJZAiuCQ/HC/Aiuty+ee
         j0IPebbUGWh6FsvJEr/p0EIFTq1oN4IcWnt41Z4gSD0IYjulzhLjbfrKSdsG+0jtWH2Y
         XOBUdtc9tQUBWI/9JkLEZFNAtrI2lhuk0sutCAsfl1+SWzDtT/eereigQpu5KwnvDaXQ
         DKLWmyl/lXZ+fKQcc5++gvABgQDF6AhxNPU3ve+xwyDgTKNqCtgeuzDk0FZb7FUn2gSt
         OZ1Q==
X-Gm-Message-State: ACgBeo0rWIYWO6BcrtrnnM62yOBO++A6Z4I25TygN7stSJjv93/1bJ3M
        t6h8VlziGip6WaSpLLdFeyN++C9gOnnhiSdIwjo=
X-Google-Smtp-Source: AA6agR40n/dIQO1t2yGF9KYLGrS7ajXiNjKSG7O0uXUqKXUBnJjuwgxe6X6XN+0yzw81AVFhcMcPsg==
X-Received: by 2002:a05:6512:3409:b0:48a:ef20:dda with SMTP id i9-20020a056512340900b0048aef200ddamr2084004lfr.649.1659682592145;
        Thu, 04 Aug 2022 23:56:32 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id w19-20020a194913000000b0048ad3d1a058sm367101lfa.52.2022.08.04.23.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 23:56:31 -0700 (PDT)
Message-ID: <8e1ffa95-686b-ca4b-1a2b-b7115dc41c98@linaro.org>
Date:   Fri, 5 Aug 2022 08:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 2/3] dt-bindings: firmware: imx: Add imx-scu gpio node
Content-Language: en-US
To:     Shenwei Wang <shenwei.wang@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220804184908.470216-1-shenwei.wang@nxp.com>
 <20220804184908.470216-3-shenwei.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804184908.470216-3-shenwei.wang@nxp.com>
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

On 04/08/2022 20:49, Shenwei Wang wrote:
> Add the description for imx-scu gpio subnode.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/firmware/fsl,scu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> index b40b0ef56978..080955b6edd8 100644
> --- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> +++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> @@ -30,6 +30,11 @@ properties:
>        Clock controller node that provides the clocks controlled by the SCU
>      $ref: /schemas/clock/fsl,scu-clk.yaml
>  
> +  gpio:
> +    description:
> +      GPIO control over the SCU firmware APIs

I don't understand this description. How GPIO can control some API?

Best regards,
Krzysztof
