Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F985455AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbiFIUbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiFIUbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:31:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A921808;
        Thu,  9 Jun 2022 13:31:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w20so18092350lfa.11;
        Thu, 09 Jun 2022 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=CA2137blCv89eq2ZgR16JFTYhMBK9m/DAMtjtrUnzv4=;
        b=FNyhUSkOM7ITAVGM42a2lcYI7sMqsdl0l5PUJFKaAoyxqtp/3p7EMeU5IC1E/DLGTN
         lFmGYHU8olzBe1VrTMlwtGoLufWejlLWT3IoxvVDLA7fA96M9N3DyArbCRhj9J5BTi0y
         66tc0iPJyUKSeQNfOl5YWQAyoeFRDpT95Lw2i1DzMQ0sSdXFwyUarMLWXWBBhhcS4jz6
         svQcbwKYUzyq4m8WcM6yhHR50Lg3Uw1M4kx7kwKszV2XrqZO8g8J4rWI4N5IvNTPgTGV
         xCBD6S5Xq9y/UXULLjfiwt4AoyAhnRzEnd7ZZAmYgtIW4fLG6J+vbT/8IRmLlf9MG3kb
         SDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CA2137blCv89eq2ZgR16JFTYhMBK9m/DAMtjtrUnzv4=;
        b=Q6buC3mnk+spodJoYpS0iByHA8QJQuabEEBLPMSIyaDXzt133aQjnhnIQBhXgtQs4e
         W51zULw5WiVvuPe+wOhURoP6YiyinTC1/7gJloc8IXRUYkXfZciqT41o2f6QQT6zAqo0
         m2OdTg/qsGUEpE5K7GsRwnN64V9unNJdi9p2CzHxoZSvOLIhwpduH5EjgLnPUBtWbWwY
         cCT4ylmrDowmEDjm7Jk9T84h4np+GG1lqL27QCVbrAAZqrGQewTl63T4/v8g6/guoRJi
         kiwBe0r3ahoVEvww4mUYKfysH8ynM8CQdH5tBHzPDZnsj50DKr5a/ffTnDEpQ0xH2QZz
         mpbA==
X-Gm-Message-State: AOAM532j3nKIK6XWXuu7zLHP1pc40mfTOw69TlmXujAOVU+hq93DiyZF
        kOYmnTjYVzgJeIfV5xUMN9w=
X-Google-Smtp-Source: ABdhPJzhToDwB+G1T0rZoz9FzKJtAL3yXpSGu2fYpJJiJS5R8uUYEpkNX6PVk+RkVORC1F5SWSz7Bw==
X-Received: by 2002:ac2:4c50:0:b0:479:55a9:2e08 with SMTP id o16-20020ac24c50000000b0047955a92e08mr11574855lfk.642.1654806703162;
        Thu, 09 Jun 2022 13:31:43 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id q22-20020a194316000000b0047255d210e0sm4389159lfa.15.2022.06.09.13.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:31:42 -0700 (PDT)
Message-ID: <4a7f8ab6-c061-3861-5790-b6c0fbd7cad1@gmail.com>
Date:   Thu, 9 Jun 2022 22:31:41 +0200
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
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20220607085343.72414-3-krzysztof.kozlowski@linaro.org>
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

Hi Krzysztof,

On 6/7/22 10:53, Krzysztof Kozlowski wrote:
> Add common LED properties - the function and color - to aat1290 flash
> LED node in Galaxy S3.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
> index 72901772fcad..d76f3678dcab 100644
> --- a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
> @@ -7,6 +7,7 @@
>    */
>   
>   /dts-v1/;
> +#include <dt-bindings/leds/common.h>
>   #include "exynos4412-midas.dtsi"
>   
>   / {
> @@ -27,6 +28,8 @@ led-controller {
>   
>   		led {
>   			label = "flash";
> +			function = LED_FUNCTION_FLASH;
> +			color = <LED_COLOR_ID_WHITE>;

Addition of these two properties will not change anything because
the label has precedence. It is deprecated, but if you introduce
function and color to the binding instead of the label, the resulting
LED class device name will change.

>   			led-max-microamp = <520833>;
>   			flash-max-microamp = <1012500>;
>   			flash-max-timeout-us = <1940000>;

-- 
Best regards,
Jacek Anaszewski
