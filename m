Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885C351E8AB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245709AbiEGQ5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiEGQ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:57:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65871E3E6
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 09:53:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t5so11822836edw.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mULbVU3wCOnYge1dYizSMDuB/AJIXOjjeNx0fYbxyYo=;
        b=jhnkW8uoHzd4WSqw2VVEUIJzyyCR33UqotHXtcZQhc7859tIdIU1TxEPWAQM0gMc4s
         +/vz47MJzAd+HCzh/kjl/escbiX74DNzXiLQdIDrsw2QQuzD1M5F2SLYM+SuTsmzyzd3
         vVPV8kMUxBsMyEuS2D+vIIw+TWvM7zPEyvFrJD9DuWOda/6Lh6ueFQUlTPufTxynoBDy
         iXSbwt/gDazMJY6R+B8+1hHJiSvHhsU42/5ASr6yrKfq9l+uWNq7ucn/lFVEz/WIsRYL
         UzhQEgSvRBHxaZ8s7la12Ny3Zk0dxjm8+9rJOVdmkWus2wuTVvRB1gzR8dpzMyz1EhJl
         RchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mULbVU3wCOnYge1dYizSMDuB/AJIXOjjeNx0fYbxyYo=;
        b=xV//1FTgOtTQu1JhmfnZkzwAmWe6J0nmdzblJfXbg+lDyV8Xk8fMtSnHFpoBz9H/Es
         tCVqO37iuuXK+odWiTetexK6H4dvNk4KDu1uYZ0dxOaMLTppea5qUUxa0GwpHoBETsa2
         SVt5vo0gzQWDDat852LmCndUj/J5u76qJ3yGD2cztoMW9EiBUge2WFGQ6aE8GD9AhDAk
         q598Stj7+dJkyTf7eJr1RBKPE9UQmaht5/+Ew6mXAAaY32nbYFgAkfnftNDR4D6QOUhE
         CRb+qSNv/8t8vzlpkqOC06Q839QxVVJq4AYVa+aDIasTiKBomTI7rCershI5ytBXxFuV
         AVKw==
X-Gm-Message-State: AOAM530Fs0TYfABRTKhhuilBNUvlDUxdpf6zhRNaQ8uiQjs7BFTKlmQy
        U64tmf8cjenbkZhgd+9SQlikJw==
X-Google-Smtp-Source: ABdhPJymWFf1Qr25QZQVvNUyaX7gOBGGoTFDURKo9c/7s/4051zUngEsdOBCijOEtBWIkL9lbvqJoA==
X-Received: by 2002:a05:6402:35c7:b0:427:d231:3740 with SMTP id z7-20020a05640235c700b00427d2313740mr9261858edc.40.1651942406548;
        Sat, 07 May 2022 09:53:26 -0700 (PDT)
Received: from [192.168.0.233] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h23-20020a1709070b1700b006f3ef214e3fsm3176517ejl.165.2022.05.07.09.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 09:53:26 -0700 (PDT)
Message-ID: <3a9f9bb5-45fa-3cfa-b7a3-f6c2e630de41@linaro.org>
Date:   Sat, 7 May 2022 18:53:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V3 1/4] dt-bindings: arm: fsl: add imx93 11x11 evk board
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20220507065309.3964937-1-peng.fan@oss.nxp.com>
 <20220507065309.3964937-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220507065309.3964937-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2022 08:53, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add the board imx93-11x11-evk in the binding docuemnt.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index b8b0efa55339..391f92282453 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -910,6 +910,11 @@ properties:
>                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
>            - const: fsl,imx8mp
>  
> +      - description: i.MX93 based Boards
> +        items:
> +          - const: fsl,imx93-11x11-evk    # i.MX93 11x11 EVK Board

This should be rather an enum, because there will be more boards. With
that change:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> +          - const: fsl,imx93
> +
>        - description: PHYTEC phyCORE-i.MX8MP SoM based boards
>          items:
>            - const: phytec,imx8mp-phyboard-pollux-rdk # phyBOARD-Pollux RDK


Best regards,
Krzysztof
