Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5769255A043
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiFXRb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFXRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:31:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5EF4B864
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:31:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c65so4438867edf.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CG/b0wH+UMkfYfXRKwVOJNE5zV94/elLpfi+TKsRhGM=;
        b=HfeGJVH/6ikCElyeTJ8/0fWURF3JP7NZ6Ap/LgH98OnZVu2834sBS7Hg9aSwneg2Iw
         FocaMnDw0144InTI5IQ3y7G1dgQf0fZ7uNMcWiEz1CMM0r/BHsS0eluk+6rGh4eBjn+V
         2aFBo5k+xlS6iK6r7Xgv9G08lDgcyOHg6f4b/igHfsvfIeGM7A20im/8uvoW9KkM4Vda
         k1iGOXtZvqDk6fvGGKZF5fF3P/EOTPfgysNCTf2pr6lo0+Wlw4a5HstKr4cCPQtGbvD6
         +dmCceck4GB2Gspt8xCuw+/9EO5/rw1Dq7nErlk5l5T5c6GyWVHSLzSVS8MMIY0nWHD5
         XILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CG/b0wH+UMkfYfXRKwVOJNE5zV94/elLpfi+TKsRhGM=;
        b=ulKZzmvbPMmjQFOMhuSfP4rPDQdM3Aq81fG0HDCxlDV9A8PybFu8vxKcJ460iLchUY
         RNA9uXVeY2kOsG8YpQ946QrC6b+hvHFFy9W5QaKIXu06yDkcKx1f45kYQ2u0pjLCQlDU
         Ip+3In262FBPk+yj21t25ioRgAxWaWGMyqp5wWBvLPiMyCJ+9oysBhHzxVWVaatQAe8s
         WHwwnET2rO6rmXqEq+CG6IGpGkusy7d6B/IKDPLabJkElaMHZh6mtZUrk71UXpO50Wz1
         7WWN6h3rHX8NykS/InkTqkezR0rCNWGjtanmLO+hUuGnMoPFRGgeUSx1aWKrowbQGdfj
         VRBA==
X-Gm-Message-State: AJIora8EN/bo9M/gApr6y5IIyaXgcpo9F3D/kQjYLjGq1ssGL8ZoaZBK
        xkSltALGf8R0kNOX2y/IDPtsaOVu1d+o5g==
X-Google-Smtp-Source: AGRyM1vqnT2ShJHGIA4aE9VkHlN9n8AHcyFDKauqLWZ+G5Irtlq8DjQRDf6siIWtS2A3Z+NcFLURLg==
X-Received: by 2002:a05:6402:414c:b0:435:1e2a:2c7f with SMTP id x12-20020a056402414c00b004351e2a2c7fmr249960eda.132.1656091880129;
        Fri, 24 Jun 2022 10:31:20 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id se13-20020a170906ce4d00b006fef0c7072esm1410177ejb.144.2022.06.24.10.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 10:31:19 -0700 (PDT)
Message-ID: <31f5f441-eba3-4ffb-cf68-159cd827ade7@linaro.org>
Date:   Fri, 24 Jun 2022 19:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: leds: lp50xx: fix LED children names
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220624111325.96478-1-krzysztof.kozlowski@linaro.org>
 <1656091594.405509.146345.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1656091594.405509.146345.nullmailer@robh.at.kernel.org>
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

On 24/06/2022 19:26, Rob Herring wrote:
> On Fri, 24 Jun 2022 13:13:25 +0200, Krzysztof Kozlowski wrote:
>> The lp50xx LEDs expects to have single-color LED children with unit
>> addresses.  This is required by the driver and provided by existing
>> DTSes.  Fix the binding to match actual usage.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Fixes: dce1452301e7 ("dt: bindings: lp50xx: Introduce the lp50xx family of RGB drivers")
>> ---
>>  Documentation/devicetree/bindings/leds/leds-lp50xx.yaml | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-lp50xx.example.dtb: led-controller@14: multi-led@2:#size-cells:0:0: 0 was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
> 

This is expected and fixed in:
https://lore.kernel.org/all/20220607075247.58048-1-krzysztof.kozlowski@linaro.org/

I did not combine this patch with above patchset because this one is a
fix and might be backported to stable.

Best regards,
Krzysztof
