Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D1B547AA9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiFLPJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbiFLPJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:09:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A525EDD8;
        Sun, 12 Jun 2022 08:09:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g25so3831168ljm.2;
        Sun, 12 Jun 2022 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kR1FFXBNuVcnI+XFY+UkNzwK+20t6KACUWQ6sh+8W7w=;
        b=WfraHZESA0Ns7l45yKXsRgqhPj9UEGMkb4W3PHOlB5YUfLBdjEXyXoQWqAyC5NrrKG
         UlHC0uTDbvzVcGAJsGuVa7FEcCfd95CKX77qu1foVsL3VnAUbf76XGPp8r4VHmRpL7Az
         lJcG7P5Xdm1PcJFhlUoZPr/q2345HtFzIOXXtmMkXUH00EiSksXaqt/ivRkuk/gu9AEg
         SDdKZrYfttipfh/chG8wOEhamYi2mNghpO9Y+Idku5yHoYiUazlqR09NlPw4YEf/jJXX
         eX1qcPeq4ZUL0nEBOlOelXFfMYkfo3ZzTFoT0q4+uTVB/kLkQ+1ZXWzmW/XSw1imA9aH
         dhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kR1FFXBNuVcnI+XFY+UkNzwK+20t6KACUWQ6sh+8W7w=;
        b=uVo7hC4U1WGWK5tmqT9fXtEcXdYC76kMN7XMzuwQ9x6EkZEeIbtNLERQcr6rbrpHIG
         SRtwxygV0w4Nbatp1/hoycYAS3J8jK9EDyQOcQ8qhiJnn5dYgUORnT8w1ud8CaTv/Mbu
         uljekD+sTgYSK2qf/EeBlnAI3zNlEePLzedtkXZ/1gI4ErcEQy7gTNCyAVmsSn5JPS89
         1dpe6IbYZP9uO+FSDJ2t9e+WHc64Qb7whrO1h3ELg2xxVUr6BQ3SL1uTd+nd+0o5Uf33
         oH9iUOIWQ3D43epy1v48BRfzrzCnGqvO1ARYTaQC1fi7Sgpmw9/E1DUSI4nbHIDNzi/y
         RJ5w==
X-Gm-Message-State: AOAM5304SYfaiA1LuwCjiqdVD5Nq0z0Otv6fJoIw+sTOkqhL9LbMEdwN
        P34Gn6lyhtzwRhk9ou/YZYg=
X-Google-Smtp-Source: ABdhPJwUeaIP09kg///zZLbr4I7t7Kkm58sR3kj+eU1oSGhbUcursPA4tzEXpO1EP0GCLBmzgRzo9w==
X-Received: by 2002:a2e:8501:0:b0:249:17a0:ebf8 with SMTP id j1-20020a2e8501000000b0024917a0ebf8mr67356763lji.125.1655046589721;
        Sun, 12 Jun 2022 08:09:49 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id q11-20020ac2510b000000b00478f739f1fdsm640278lfb.103.2022.06.12.08.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 08:09:49 -0700 (PDT)
Message-ID: <f1402a1d-a74d-f7b9-b9e2-fc3991781e64@gmail.com>
Date:   Sun, 12 Jun 2022 17:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/3] ARM: dts: exynos: add function and color to aat1290
 flash LED node in Galaxy S3
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220607085343.72414-1-krzysztof.kozlowski@linaro.org>
 <20220607085343.72414-3-krzysztof.kozlowski@linaro.org>
 <4a7f8ab6-c061-3861-5790-b6c0fbd7cad1@gmail.com>
 <ef62a7bb-2217-2947-17dd-fc4a51acdea5@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <ef62a7bb-2217-2947-17dd-fc4a51acdea5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 12:14, Krzysztof Kozlowski wrote:
> On 09/06/2022 22:31, Jacek Anaszewski wrote:
>> Hi Krzysztof,
>>
>> On 6/7/22 10:53, Krzysztof Kozlowski wrote:
>>> Add common LED properties - the function and color - to aat1290 flash
>>> LED node in Galaxy S3.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
>>> index 72901772fcad..d76f3678dcab 100644
>>> --- a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
>>> @@ -7,6 +7,7 @@
>>>     */
>>>    
>>>    /dts-v1/;
>>> +#include <dt-bindings/leds/common.h>
>>>    #include "exynos4412-midas.dtsi"
>>>    
>>>    / {
>>> @@ -27,6 +28,8 @@ led-controller {
>>>    
>>>    		led {
>>>    			label = "flash";
>>> +			function = LED_FUNCTION_FLASH;
>>> +			color = <LED_COLOR_ID_WHITE>;
>>
>> Addition of these two properties will not change anything because
>> the label has precedence. It is deprecated, but if you introduce
>> function and color to the binding instead of the label, the resulting
>> LED class device name will change.
> 
> Which is not necessarily what we want, right? Adding these properties is
> a proper description of hardware, regardless whether current Linux
> implementation uses them or not.

Actually I'd just drop label in addition to your change.
I don't think it would break anybody seriously - not expecting it has
any larger group of users and having uniformly constructed DTS files
in the mainline has greater value.

-- 
Best regards,
Jacek Anaszewski
