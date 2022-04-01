Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697534EEE60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiDANo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiDANo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:44:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E2027F4EB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:43:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dr20so5929986ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kRGQSHbNrQ56sbIjo0fVlJQ0u1ahcNvK7/rx7vN//fU=;
        b=POSigfPFudfJz+V4egSDKxGTnB5HpDAVi2PWRCIkSCMe6zHwz+M1g2gVx3gDoH+OfO
         fU3SrAFaU8TidUv3pLDTkLhlwi1F9PmR2bB0JD5cfPUBRVzdeldYspsi8SrqDWfW+qrf
         IiWaQ05EIeb4DFNYZr8fd9YxkJw+tHSkl1D4U/suibOuTuJoQ7RXlpBtpMhKCnjXOTKA
         c3Mjh6YF4Ic3cMf6WxFZ90yY8HmxJwu4dShVCPM3sVrieRAZLtAznwI8CRWzpH8ntGA0
         jlftKvgtiosy569jtbzNttfcORzAKdvnMHsSIOPWRjeKJN2RbfLZPi2KdPWBLSe0tarE
         ZkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kRGQSHbNrQ56sbIjo0fVlJQ0u1ahcNvK7/rx7vN//fU=;
        b=zlvPkq+E6PEWH5UyQFyt8sj+6ahXdmi1y+YivXA4seIOjPq77Vn9XtJ6sQEa0Wqgx6
         86xm+dqqMRH0JJ11mUM/ODiGFWH/4W+P+eWBYcG98XD898UaxXqlXylZfTDQiSqJq/vS
         YjtYpuFKWQ4Nf44qRamlYO7Jw2hUphRdcFK8+bduPxOzHYb3K9Jn6h9OhbZ7wMdaAiOh
         rcjqDUM8CzOdpZvu1VEEF/HaFulU0V+y7VBjolzgknuXUp0kLc/CxmkLN3GcvLIQGIDU
         1YzfVNHVEHRT3cTxXxU3CD/A1+I3bFCx45zp1LgDHQTBfI3A88hK+OLlnWpc/GKV9K6s
         xVdg==
X-Gm-Message-State: AOAM533LKtdKJFiE2VAhwvMLrtqvPAKx8EMUhil9r/1z0nd3URnwPZmw
        zYjo76H5jpq3OBHl8cGg8sbHoA==
X-Google-Smtp-Source: ABdhPJwQ1HtREvWS1HonL2xj33ywp4DkIJSz+zdns6tFyQ93YEsSmnal+eYCLtgrddAv08r12QNvTA==
X-Received: by 2002:a17:907:3f07:b0:6e0:2fa0:2482 with SMTP id hq7-20020a1709073f0700b006e02fa02482mr9289837ejc.766.1648820585959;
        Fri, 01 Apr 2022 06:43:05 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906145000b006bdaf981589sm1046344ejc.81.2022.04.01.06.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 06:43:05 -0700 (PDT)
Message-ID: <3d03bc18-dd42-002d-739b-230b4134b866@linaro.org>
Date:   Fri, 1 Apr 2022 15:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add prefix for SINO
 WEALTH Eletronics Ltd.
Content-Language: en-US
To:     Chen-Yu Tsai <wens@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220330190846.13997-1-wens@kernel.org>
 <20220330190846.13997-2-wens@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330190846.13997-2-wens@kernel.org>
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

On 30/03/2022 21:08, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Add a vendor prefix entry for SINO WEALTH Eletronics Ltd.
> (http://www.sinowealth.com).
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 01430973ecec..bb4ae59a3c89 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1128,6 +1128,8 @@ patternProperties:
>      description: Cypress Semiconductor Corporation (Simtek Corporation)
>    "^sinlinx,.*":
>      description: Sinlinx Electronics Technology Co., LTD
> +  "^sinowealth,.*":

Alphabetical order, so after sinovoip

> +    description: SINO WEALTH Electronic Ltd.
>    "^sinovoip,.*":
>      description: SinoVoip Co., Ltd
>    "^sipeed,.*":


Best regards,
Krzysztof
