Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B916E585C27
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiG3Uvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiG3Uvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 16:51:48 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F85E15FF5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 13:51:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n133so9251479oib.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PfxXgTMaVS1zqBOtxdrAodGDk/WO8mfNukzFQAlkbhk=;
        b=bFLTwariZNRkilzCw5raT6AzKzOsusiXV3i+15LhXJfcdkp7moS7eVfDi8czUIqSMD
         q46pidbcp2sYbHkY49jtfkhS0BpFJc6+sMchHZ5Asf5mHQF3P53trVPoIu5LJC799eG3
         +e4rMHjqU/2tZOiCixpqEA84rH4XlkWr4YgI7SIG8SUVrrEyL8XCIqKMfcC1xiPqVfjn
         KptZxjKyJ1qIQKHzl3ZO6+LnTuzlfDwAB4YuWD67V3GukE8HSTc39HiVmy2rFhmH164W
         X6fygSdB1Fa9TUF0AjmAP5fQ2AQK5n7ZZSrimT1R1+4/CkC6hes1Yom903JwjhnQqSgz
         c/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PfxXgTMaVS1zqBOtxdrAodGDk/WO8mfNukzFQAlkbhk=;
        b=qEvnU4GLTQXxNoUdmg24x8gMZq1BNHYB8QafztirriGetyG2B+RKcybSsmItvvEBjm
         E7ZUWBzZONZ/5zPaX+KDuBZTxQdpCrHFBbE+X8aolTK8A6RmgPWoUljq0UK8pSQv82oK
         Y5N4fbOJ15v7z3Qyj/SS9NM7UzvpM8w484073iTBouGIPI0qFcI8+8YIMJ+vgHOeNrUF
         kbLVFWXXR/7Y1sJ52nURtc9+tIwbUr567hTbJhspUTOuOX+WrE4tc5qeU/NzqM6+EYLN
         YoSmTaZ8wmw0lzt+OFH1RemBbTCHi7G7Jj1Tpbh2wmMe8gIsmZCRnWJYnMarhu0evrSx
         rUSA==
X-Gm-Message-State: AJIora9xfoBlcm0BHC2EnTt0HN2XFCQ4dpJ09BIuAQYLHsc+ddne44oC
        7Ibb1vzoZ7jPNlNbaksfpJj/RQ==
X-Google-Smtp-Source: AGRyM1szfJX93ss/HfclQjRE1Hfq7DtLy6G+zPjwpChbPiKbGBSVK0Ip/q5VuGsl5gqcqQd+GaSH/g==
X-Received: by 2002:aca:1103:0:b0:33a:c295:f483 with SMTP id 3-20020aca1103000000b0033ac295f483mr4503829oir.80.1659214305960;
        Sat, 30 Jul 2022 13:51:45 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id v35-20020a056830092300b0061c9ccb051bsm1911249ott.37.2022.07.30.13.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 13:51:45 -0700 (PDT)
Message-ID: <444b9cdc-c536-9f7d-1e80-31cb9b9a155f@kali.org>
Date:   Sat, 30 Jul 2022 15:51:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: Add LID
 switch
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220730193617.1688563-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220730193617.1688563-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 7/30/22 2:36 PM, Bjorn Andersson wrote:
> Add gpio-keys for exposing the LID switch state.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 84dc92dda0b8..f3246cc13d15 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -7,6 +7,8 @@
>   /dts-v1/;
>   
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>   
>   #include "sc8280xp.dtsi"
> @@ -26,6 +28,21 @@ backlight {
>   		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
>   	};
>   
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hall_int_state>;
> +
> +		switch-lid {
> +			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			wakeup-source;
> +			wakeup-event-action = <EV_ACT_DEASSERTED>;
> +		};
> +	};
> +
>   	vreg_edp_bl: regulator-edp-bl {
>   		compatible = "regulator-fixed";
>   
> @@ -347,6 +364,14 @@ reset {
>   		};
>   	};
>   
> +	hall_int_state: hall-int-state {
> +		pins = "gpio107";
> +		function = "gpio";
> +
> +		input-enable;
> +		bias-disable;
> +	};
> +
>   	qup0_i2c4_default: qup0-i2c4-default-state {
>   		pins = "gpio171", "gpio172";
>   		function = "qup4";

Tested on the Lenovo Thinkpad X13s

Tested-by: Steev Klimaszewski <steev@kali.org>

