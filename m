Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3E554D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358696AbiFVOg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357288AbiFVOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:36:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE323BA5A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:36:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mf9so14371232ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sVFftXXsJ84XlZCYREHvxrVknOai2VbLYQhFhTdEQV8=;
        b=kCCLYtTs6BdRbsM5Q0vOu3Q+GqBQSSoCoxrkNY67vt5/v8Y+FLPyAPWL+60+TTrauL
         zh5iWxu+fyZUHdhWURnBLMd7LkBWf2KzQAcjeg0q1qq5bsV9ILBN2yrHkmml9aT9YybS
         0eZbAGbasOOHwg4W6SglS3Zc4JF7FjvtuJoZ/DjKzytVWkUKPfalnmuL2QrF6xdJaJw1
         laFmIKzsamSlwgXdme0Sjl9bURcXDVshCrAO7XuWFFCFrZbaumW4qassy2Up6uQrQejT
         p6FtvyA5Ql304V19AtHWsaJbdVL2KWqwKwkDtWPXdzDCGWQa9lXCDyz3zFm+l9RcE5dK
         8Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sVFftXXsJ84XlZCYREHvxrVknOai2VbLYQhFhTdEQV8=;
        b=hjZwzF4S4oa4e81tn+EN/mOVnVqvvLFLf2MADrNFV4fwhamsAK2S2xRG82mNm5RBbo
         PKnKgpQ/lDOzcgG6kE3OYp0hFIaMhL23+sAPboAfVc04nzAn5Uj9UisKgrdrcc2roSm5
         WDC8wh9wCDnfSmO6sH7eCvoK+DFP2LdtFw7f+tcXDKFoegZGAHlMa3YBQ3+zEbqqrGne
         axZxWqiAesRQTR0eQRvDdz1263Pr6nY1906XhMj3q1M+1f2sVpwlHggrGfs6sNpBoVQz
         +fE0IKOGt5q9zDM0TaIbyO0GJAj3broHkW9aFjD+exoy2CDxjm+kVkevsbLJ2Slsjv/7
         VriQ==
X-Gm-Message-State: AJIora9MpZLgM9TcttmoTGpb0paEFWZWng5yulgZJIrbk5OxP4AHOFmT
        T8XuJIKOwFIarYJ5RyLWdpATIA==
X-Google-Smtp-Source: AGRyM1uwFC++Lw8p9dKz+mshKztzdMs8eIfV+UxHrUOLIytswwE0ZWXzW6oujtExt49x6Sg3trORlQ==
X-Received: by 2002:a17:906:1109:b0:711:da3b:bdcb with SMTP id h9-20020a170906110900b00711da3bbdcbmr3257318eja.210.1655908583962;
        Wed, 22 Jun 2022 07:36:23 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c5-20020a056402158500b004356b8ad003sm11041051edv.60.2022.06.22.07.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:36:23 -0700 (PDT)
Message-ID: <60b0074f-f29b-da1f-d6d0-0085e17e5dcb@linaro.org>
Date:   Wed, 22 Jun 2022 16:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Use WCD9335 DT bindings
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622064758.40543-1-y.oudjana@protonmail.com>
 <20220622064758.40543-4-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622064758.40543-4-y.oudjana@protonmail.com>
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

On 22/06/2022 08:47, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Replace DAI indices in codec nodes with definitions from the WCD9335
> DT bindings for devices that use WCD9335.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts         | 5 +++--
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts  | 5 +++--
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> index 49afbb1a066a..ff915cd8e5a6 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
> +#include <dt-bindings/sound/qcom,wcd9335.h>
>  
>  /*
>   * GPIO name legend: proper name = the GPIO line is used as GPIO
> @@ -1009,7 +1010,7 @@ platform {
>  	};
>  
>  		codec {
> -			sound-dai = <&wcd9335 6>;
> +			sound-dai = <&wcd9335 AIF4_PB>;
>  		};
>  	};
>  
> @@ -1024,7 +1025,7 @@ platform {
>  		};
>  
>  		codec {
> -			sound-dai = <&wcd9335 1>;
> +			sound-dai = <&wcd9335 AIF1_CAP>;
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> index 22978d06f85b..261f2ea7def0 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include <dt-bindings/input/ti-drv260x.h>
> +#include <dt-bindings/sound/qcom,wcd9335.h>

Keep the order, so this goes before input (even though it is not really
alphabetical, but that's life...).

>  
>  / {
>  	model = "Xiaomi Mi 5";
> @@ -193,7 +194,7 @@ platform {
>  		};
>  
>  		codec {
> -			sound-dai = <&wcd9335 6>;
> +			sound-dai = <&wcd9335 AIF4_PB>;
>  		};
>  	};
>  
> @@ -208,7 +209,7 @@ platform {
>  		};
>  
>  		codec {
> -			sound-dai = <&wcd9335 1>;
> +			sound-dai = <&wcd9335 AIF1_CAP>;
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
> index 1e2dd6763ad1..c9f935cfb587 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
> @@ -9,6 +9,7 @@
>  #include "pmi8996.dtsi"
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
> +#include <dt-bindings/sound/qcom,wcd9335.h>
>  
>  / {
>  	model = "Xiaomi Mi Note 2";
> @@ -171,7 +172,7 @@ platform {
>  		};
>  
>  		codec {
> -			sound-dai = <&wcd9335 6>;
> +			sound-dai = <&wcd9335 AIF4_PB>;
>  		};
>  	};
>  
> @@ -186,7 +187,7 @@ platform {
>  		};
>  
>  		codec {
> -			sound-dai = <&wcd9335 1>;
> +			sound-dai = <&wcd9335 AIF1_CAP>;
>  		};
>  	};
>  };


Best regards,
Krzysztof
