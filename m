Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC21D4F0618
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344283AbiDBUOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiDBUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:14:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796CE114354
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 13:12:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m67-20020a1ca346000000b0038e6a1b218aso858371wme.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=235ThmLY/OVM1F4sGmmgGyNEXw4TutBGz+wfTPM6Ezw=;
        b=Cas6JHBkmCdF0GwcUU5QKOb+Sux8akmYDZH6laNOP59TCjA0pxhAvURsbet2GknsEB
         0FylV/t4GYIz1vmY41D2vHCn3UzdxddfEveGTayYafYNRFwOmlAg73MnIZ1WoJ8p1J6M
         qmWhHwIgeBtEsq5UTufZH6+u9tARe1W2dMFu/3ofsFpGARJBhDFU6pBqIlUyn1AVfa8n
         DcAX9XeRxS89OjUS/fx/NlN+xRllNfMhPSjQDNu5MPwg2ppg+0wXJnUvKBDrJkUx8LxE
         lB+lTNiTWMF15TpY8bcAbCmRoLzlcesC1W7Z7GH6xY66f7zxFs4NuoSuxta8Klw3urbA
         zV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=235ThmLY/OVM1F4sGmmgGyNEXw4TutBGz+wfTPM6Ezw=;
        b=p+AObPoyw7jFNGyvSw0hV90pFi0ji7fUUcrmMsGU9iEEh43FzmnuYZcn3gPIQv7g3N
         oKXunk0cZy5LF/Vl4lLt70hBwhoa3PqYHEsjV8czNSmJE02IR3N/JtEKoAx9QVoQudSh
         WoEplv47LLamsB/5yyZZPYg8m6V3gzGlyGbyG4zAzlmFzcB3CZldpYHhkL4jyFJbhNxK
         MzBAL4lVR4yl+NmddpjlnYfqLn1sPy9DL94GBXtBJpuR7/A/f9Rzal9PmWdYszXyTdHC
         7b22JsTpbMU3ZZqiak9BCc8RZQnRwHMdsVaTviOFMKNerg8iZxLRi37LexqBINeQUSXU
         kAdA==
X-Gm-Message-State: AOAM532DMSxQpAQcYyClNsAjUg4t5ZN16jKWnwRgacO8bD8c4zaMs9dl
        DcKSQMXtjGWUQPvVjrT66TK1ow==
X-Google-Smtp-Source: ABdhPJyVuEQmPjKz6+OoclhGClbXdqVtWWvLy2mu+DTaZ4xpHRVhCMsAwmv2SlZXnn0GLs1qmJVe+g==
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id f19-20020a7bcd13000000b0038bf39c1181mr13973422wmj.20.1648930360071;
        Sat, 02 Apr 2022 13:12:40 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600018af00b002057c72d45fsm6675904wri.77.2022.04.02.13.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 13:12:39 -0700 (PDT)
Message-ID: <a66f17c6-cec6-3eb8-92df-9990d74dd122@linaro.org>
Date:   Sat, 2 Apr 2022 22:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 1/3] dt-bindings: mmc: imx-esdhc: Update compatible
 fallbacks
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, linux-mmc@vger.kernel.org
Cc:     haibo.chen@nxp.com, aford@beaconembedded.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220402193942.744737-1-aford173@gmail.com>
 <20220402193942.744737-2-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402193942.744737-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 21:39, Adam Ford wrote:
> The SDHC controller in the imx8mn and imx8mp have the same controller
> as the imx8mm which is slightly different than that of the imx7d.
> Using the fallback of the imx8mm enables the controllers to support
> HS400-ES which is not available on the imx7d. After discussion with NXP,
> it turns out that the imx8qm should fall back to the imx8qxp, because
> those have some additional flags not present in the imx8mm.
> 
> Suggested-by: haibo.chen@nxp.com
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  Marked the imx7d-usdhc as deprecated when there are better
>      fallback options or the fallback isn't needed.
>      Leave the deprecated fallback in the YAML to prevent errors
>      Remove Reviewed-by from Krzysztof Kozlowski due to the above
> 
> V2:  Update the table per recomendation from Haibo.
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 7dbbcae9485c..11f039320d79 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -34,23 +34,34 @@ properties:
>            - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
> +          - fsl,imx8mm-usdhc
> +          - fsl,imx8qxp-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
>        - items:
>            - enum:
>                - fsl,imx8mm-usdhc
> +              - fsl,imx8mq-usdhc
> +            # fsl,imx7d-usdhc fallback is deprecated for imx8mm-usdhc
> +          - const: fsl,imx7d-usdhc

Instead of comment use (I think on the same level as items):

deprecated: true

> +      - items:
> +          - enum:
>                - fsl,imx8mn-usdhc
>                - fsl,imx8mp-usdhc

So if this is a deprecated list, where is a proper one? The list with
this enum + imx8mm?

IOW, you need to list here:
1. Old combinations with "deprecated: true"
2. New combinations.

> -              - fsl,imx8mq-usdhc
> -              - fsl,imx8qm-usdhc
> -              - fsl,imx8qxp-usdhc
> +          - const: fsl,imx8mm-usdhc
> +            # fsl,imx7d-usdhc fallback is deprecated
>            - const: fsl,imx7d-usdhc
>        - items:
>            - enum:
> -              - fsl,imx93-usdhc
>                - fsl,imx8ulp-usdhc
> +              - fsl,imx93-usdhc
>            - const: fsl,imx8mm-usdhc
> -
> +      - items:
> +          - enum:
> +              - fsl,imx8qm-usdhc
> +          - const: fsl,imx8qxp-usdhc
> +            # fsl,imx7d-usdhc fallback is deprecated
> +          - const: fsl,imx7d-usdhc
>    reg:
>      maxItems: 1
>  


Best regards,
Krzysztof
