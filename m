Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3199565C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiGDQdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiGDQdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:33:39 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C127F62D1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:33:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a11so11667934ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A7qX2eyWUzHs7oEe1617ozyf3iq6Dmxh3c3+blIpj/Y=;
        b=hmyhPddNs1Y3fALBRZR1UPt5vTfh2rDqvxe++kSyCDpOk+P6vcmlvVJXsSP7MRrKfq
         b8cPR5AVcRt3B7hfFK6P/tnw0fwua6lX06IKpNca3NCwhDJgv3Yen1eW3TOr3yEjoC5z
         97i/GFedR25XlxP02YSbg7cT1JAIZIkODwyzYp3rFLVQvlGSP4zrYSq3HDde4QLqHMD6
         yC1qWpp77FbLakc1SMA5ODhIib+4vIKscK3a/VeSXh82VmJVi9x9Ken7k/mha+ElnJKM
         GlpzM7VIi6G9SD1/axXGfVHFoLn+X5ipyPRNZxTyJPJgMlFhna3aIPygTCxnETMf+lZo
         CKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A7qX2eyWUzHs7oEe1617ozyf3iq6Dmxh3c3+blIpj/Y=;
        b=QaOZ3Q83xztMAibcTtN9IB0XGtbE8jV7o+ci1A0DG/+ajBF1z0f5YJh4kBb+v3XEPG
         p/rsxR2WbZm4IZTPBgVhixDHKI5jyEQedLknCzd77b/FU/jfCWm31wUOX1wozeQObJQC
         F0ODtnagJsfXjYa5T8LSftJgZWTKVHEpwKxSZ/CF0QMZnee+ROZxhoLQXJ33Ke+rQGuS
         od1Ah5G3xltRndS9AvtMPDQDuELvLZ5ELp75Hn9ueq5wtOyWY2Q5S2ozDhoiVAD1PpV9
         ySkCNKZ98Pc8OyFMm+sefO8wMBIrg33v3Yj/MLO1U+ePw9chGDixu5nTU+fa1KHMjcGm
         V68A==
X-Gm-Message-State: AJIora/Ydkf2KoI+F1pQLuMI1jc6aOwdA0JFPhFGrX6DBAuiyox5XrUi
        hp4JQMaxo3+KZaLlnohuMiYtdgcv+gAYrg==
X-Google-Smtp-Source: AGRyM1tQvO8sTfWF60/e4tD2C6Tl+WYLmbUZ+g6+Nalcyp3YQJSdUIoNwXaACrVpEAnHQ/ZE8chHPw==
X-Received: by 2002:a05:651c:2317:b0:25b:fc32:906a with SMTP id bi23-20020a05651c231700b0025bfc32906amr12458628ljb.445.1656952417189;
        Mon, 04 Jul 2022 09:33:37 -0700 (PDT)
Received: from [192.168.1.212] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b0048110fd06c4sm4234870lfv.53.2022.07.04.09.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 09:33:36 -0700 (PDT)
Message-ID: <3a4ce2cc-5d2c-276c-1f60-be7cf686b8b9@linaro.org>
Date:   Mon, 4 Jul 2022 19:33:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: db820c: Add user LEDs
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220505022706.1692554-1-bjorn.andersson@linaro.org>
 <20220505022706.1692554-5-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220505022706.1692554-5-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 05/05/2022 05:27, Bjorn Andersson wrote:
> The db820c has 4 "user LEDs", all connected to the PMI8994. The first
> three are connected to the three current sinks provided by the TRILED
> and the fourth is connected to MPP2.
> 
> By utilizing the DTEST bus the MPP is fed the control signal from the
> fourth LPG block, providing a consistent interface to the user.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 56 +++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> index 56e54ce4d10e..e9039e68a095 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> @@ -10,6 +10,7 @@
>   #include "pmi8994.dtsi"
>   #include <dt-bindings/input/input.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>   #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>   #include <dt-bindings/sound/qcom,q6afe.h>
>   #include <dt-bindings/sound/qcom,q6asm.h>
> @@ -683,6 +684,61 @@ pinconf {
>   	};
>   };
>   
> +&pmi8994_lpg {
> +	qcom,power-source = <1>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pmi8994_mpp2_userled4>;
> +
> +	qcom,dtest = <0 0>,
> +		     <0 0>,
> +		     <0 0>,
> +		     <4 1>;
> +
> +	status = "okay";
> +
> +	led@1 {
> +		reg = <1>;
> +		color = <LED_COLOR_ID_GREEN>;
> +		function = LED_FUNCTION_HEARTBEAT;
> +		function-enumerator = <1>;
> +
> +		linux,default-trigger = "heartbeat";
> +		default-state = "on";
> +	};
> +
> +	led@2 {
> +		reg = <2>;
> +		color = <LED_COLOR_ID_GREEN>;
> +		function = LED_FUNCTION_HEARTBEAT;
> +		function-enumerator = <0>;
> +	};
> +
> +	led@3 {
> +		reg = <3>;
> +		color = <LED_COLOR_ID_GREEN>;
> +		function = LED_FUNCTION_HEARTBEAT;
> +		function-enumerator = <2>;
> +	};
> +
> +	led@4 {
> +		reg = <4>;
> +		color = <LED_COLOR_ID_GREEN>;
> +		function = LED_FUNCTION_HEARTBEAT;
> +		function-enumerator = <3>;
> +	};
> +};
> +
> +&pmi8994_mpps {
> +	pmi8994_mpp2_userled4: mpp2-userled4-state {
> +		pins = "mpp2";
> +		function = "sink";
> +
> +		output-low;
> +		qcom,dtest = <4>;
> +	};
> +};
> +
>   &pmi8994_spmi_regulators {
>   	vdd_s2-supply = <&vph_pwr>;
>   


-- 
With best wishes
Dmitry
