Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6604F8F2F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiDHHJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiDHHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:09:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DF2120B6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:07:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v2so565871wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mp8AKz8K41cLT9QaE01gtOHZTnNu/RtN4/UjWkNVNy0=;
        b=SFKjOb1+LQ+On9tuWlbzvLWmU83zcpFbckBiGKvp0ilgUXbVtPMD8SmBsaSUqU4c9E
         owsM54W+s+sc/BllxDBB1+UscvvGQ6keaivsJyqBwx/3babelpBJN4bfIKvnHX+dL9X8
         FZIuu+bLd+N6QMQO6Q31yIjq2QcJID6J63Ww76/5Z/VAuZpRMPNUSSq0wxnSfA6NOv6i
         J6t/4461KEoprjA2FHdubZF/Wnhf51aLxPeKXGsQ/8DBmDJJ6g9sz+HVFsJqH+yp+UGQ
         /bkTLLyXl5AWbkL/GyNgH5kOdLGr/7VKOv+heefuR/30W4uufiWD8KDC01D47vhhurlu
         fT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mp8AKz8K41cLT9QaE01gtOHZTnNu/RtN4/UjWkNVNy0=;
        b=RLRFOmrDidz4GisZAryfNQw2yHmhWMdnX+ldTOUaS4qjM/K4dqV5bTDr1+fJ28CNB+
         Iq72jvBhwfVMqCRXRnX2PAEm/7ce2xPRx8Agq3n4GAjNeUK3T3ece6M1JaqChlX1L9J3
         qiQQnv4WZ0gY5iJuqHBorsjo7ZuCziE9hPxdZ350AfDNXfbTqDWMfPQcaucWTYe5SQbU
         QK3hoyGj8ShBTE2N8Uex3AJUbNanrhxxgE/imawmS4hckIuOQYacDPvwLgxTClXYA0kD
         4hM4ve3hy0WeEwMYTEXVHQpakF/Ofpgi6XSym/XC1H/5AFVU/a/OBAnq8C6+3m7rhbZN
         dy7w==
X-Gm-Message-State: AOAM533p8pqZH53D9e63bEvGNFLVnHH15yi4qUSBjfcwYIQU9vOY+VSd
        Re3CGtl46Mdp6ZEXyfBEe4kPwQ==
X-Google-Smtp-Source: ABdhPJznzyNEN54Y7Er60mvM7FnB6xptOG0tRSbA0wfwdYv/+GY7vlxzX1H1JaGUjXYgApu/gWY2rw==
X-Received: by 2002:a5d:5955:0:b0:207:8444:203b with SMTP id e21-20020a5d5955000000b002078444203bmr6148468wri.433.1649401656222;
        Fri, 08 Apr 2022 00:07:36 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id d14-20020a056000186e00b0020405198faasm21831373wri.52.2022.04.08.00.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 00:07:35 -0700 (PDT)
Message-ID: <41bee12f-fa23-16d6-7244-1c4c543cbea0@linaro.org>
Date:   Fri, 8 Apr 2022 09:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add i.MX8M Plus Gateworks GW74xx
 board
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220407210411.8167-1-tharvey@gateworks.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407210411.8167-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 23:04, Tim Harvey wrote:
> Add DT compatible string for i.MX8M Plus based Gateworks GW74xx board.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 08bdd30e511c..c04203d537d0 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -860,6 +860,7 @@ properties:
>          items:
>            - enum:
>                - fsl,imx8mp-evk            # i.MX8MP EVK Board
> +              - gw,imx8mp-gw74xx          # i.MX8MP Gateworks Board

gateworks
You are using a deprecated vendor prefix.


Best regards,
Krzysztof
