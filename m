Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA91533B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242832AbiEYLPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiEYLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:14:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571ED91547
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:14:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so40957488ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8swa35MPUNELty3MCkIwQ2icwZshaqptksBqIqPidY8=;
        b=dKYynXllLtYc3gLE0PYaiWkrttPmq3Cgdv/TmQ4Ueg8HylgrxC1JeCwHZfSus5gCKC
         r/Fs3IlK+v0wXFm4HJyPhATVRoNSUGnJkEgsjtSg3p7VQnUpyV+0iY2YXJdn4RxzfMBo
         7cGVSmOUXaC5GLmWaQ43Ws+O9ZdtOO15v11bY+9dXy3UMQR6UwS7gCgVU9X/V6D2Jrrw
         MzVTEYdSOTBa/NSiMxJKZ7P5rl3qHAk9Ooy0Uo7N27OZpLKnHl9gjXgMNk0vWvFz3G59
         3tPD4iosKeVDa11G2Nw/7c7X2/RS4HGMIjQ1TVD4V7ICvgoWjJTGRcJu6iMn6Mi1KS16
         AypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8swa35MPUNELty3MCkIwQ2icwZshaqptksBqIqPidY8=;
        b=Oh3rf6RuIC6hZeustqlCcPkEc9GYcSm799PkvrQrQS0+pi7EK2fSWEO3D+m7BCWV/C
         0cQFd2cNPKbLl+y85aqItoi7n2zvjtmIsal0ri84yElqudJ8UGRsRYjvZXzMKlWyKq41
         v+qEZ+6tQxAH1jfw1M1xG4//Nkv39gfaASm1fCaxkcbnI9FGzzQ3ZpvaV+5RXHYbumb1
         xUA32R5Gcfry8gLNQYHxB/tzfG7twHeqYcqFv+hm4X6N3MuzbN0zGVYfRuoCs64W77y0
         5vxMTKfUmqbb6+BXRfqjKd8FDI7/wc5ZtAZDnIFruDH4+OjvW8lAZubE1D9mwCIlvYDe
         8ZnA==
X-Gm-Message-State: AOAM5334WpZcqsOHxtMfqq91VnKW9rRxRjERN4gZ4yPbhwxAg/KRTBhF
        G25ug/oGNWnkAVOmq4xO6h7qbg==
X-Google-Smtp-Source: ABdhPJzMEAc82wkyjnUvSjSOB8E5Fvqg3XAZCSa9kB8cKoxi4uu+bSEq7cral2zpUXBr4iRUM+G7Ow==
X-Received: by 2002:a17:907:2cc7:b0:6fa:88cf:c31a with SMTP id hg7-20020a1709072cc700b006fa88cfc31amr28099898ejc.471.1653477286871;
        Wed, 25 May 2022 04:14:46 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gh17-20020a170906e09100b006fec56c57f3sm4092783ejb.178.2022.05.25.04.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 04:14:45 -0700 (PDT)
Message-ID: <45ae3d85-d005-f6d3-1229-afc5db303c61@linaro.org>
Date:   Wed, 25 May 2022 13:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dt-bindings: arm: add BCM6846 SoC to device tree
 binding document
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     samyon.furman@broadcom.com, philippe.reynes@softathome.com,
        kursad.oney@broadcom.com, florian.fainelli@broadcom.com,
        joel.peshkin@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, tomer.yacoby@broadcom.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220525003236.2699-1-william.zhang@broadcom.com>
 <20220525003236.2699-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220525003236.2699-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2022 02:32, William Zhang wrote:
> Add BCM6846 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> index 5fb455840417..93eb30422dd6 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> @@ -27,6 +27,12 @@ properties:
>                - brcm,bcm947622
>            - const: brcm,bcm47622
>            - const: brcm,bcmbca

New line here.

With that:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
