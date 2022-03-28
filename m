Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ABA4E9ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiC1PXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiC1PXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:23:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB155606F1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:21:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h16so8612884wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PZWlyCR8RIffz/f2sY4GUYgzj4rvKU4uLGLRLUB90y4=;
        b=OoYNFbd8zx/BMr8QkMbYEBa2B021HxCjasgBPgapg01RGlThBwfa6c0nxRtdKc2P2I
         4UpIsK3rsSNi5qVNSO+Dq83JlVeM0NewN6g4Yn+YDbGf4Mz+T5Ju+gDoD0tunJsj9Zru
         8ZdDeIPUwkOWChS2JierT326tsttT3NmrEDI1zFHb5T180bZO9HbS2zf4WSOOzP3h/gY
         bDw5kOhBvljVkRfrWh7Wd1y22gfZOVr6uKDmJpDd39fn1B9SwX9+3jGkb8Zmy6cdpQlo
         6BW4YETpGoM1Ki4KXU8VSbJhti44GG2t+JUkQJnBst/t7qkR3zrMpnf1aJdehzbVfteX
         lnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PZWlyCR8RIffz/f2sY4GUYgzj4rvKU4uLGLRLUB90y4=;
        b=OK2Njx2lM2I4rzoaFa0dabrx0fifamHX76aBrgbBR7o9MDdJ5VxejSrmU0CzP1xTC/
         9fVJBGaKFvavBKlaMWDFoFpqXSlwofHi8497np0NusvchnxUGxWaFGeobX53YrZHE6O1
         kb1fJbsIpyGX2UgtLMCc63BW7Fckl9HKYWn68fhRhj0Of4TRLunzJ9z043JdpziJ+bRB
         HAbpnJk6/sH5sjX/onI9zv7t/grkEr46VRGQT7hVZX5krD322WaGWlGL6mrfLl+Xeh4T
         ZD/7aT2lI1QXsmnRjSTHviEXrc18Bef43bjWpwMmBZ+sPAHUvSCAgu1Q25ZxKjaa2Pk8
         K6XA==
X-Gm-Message-State: AOAM5337JhjJkfunTTUyqp5LfOH06LyhxIfokVK/kG8PqtSqPoI0vqbO
        zv9DZ7cWaw+XQtb5c1fq+GOLCg==
X-Google-Smtp-Source: ABdhPJydBcYSQSUtcWnYUf9bzEsY5cO4MyEDl6S7BXq/uNhLHyCTJ4VsJXplqqScRn5GN5UsQI0sSw==
X-Received: by 2002:a05:600c:2188:b0:38c:9a21:9c95 with SMTP id e8-20020a05600c218800b0038c9a219c95mr35225744wme.87.1648480889531;
        Mon, 28 Mar 2022 08:21:29 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d59a8000000b00204178688d3sm13953603wrr.100.2022.03.28.08.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 08:21:29 -0700 (PDT)
Message-ID: <0b43c297-d0d6-f38f-9609-47fca856aa6d@linaro.org>
Date:   Mon, 28 Mar 2022 17:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250: move wcd938x node out of
 soc node
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220328143035.519909-1-vkoul@kernel.org>
 <20220328143035.519909-6-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220328143035.519909-6-vkoul@kernel.org>
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

On 28/03/2022 16:30, Vinod Koul wrote:
> The soc node expects all the nodes to have unit addresses. The wcd codec
> node does not have that which causes warnings:
> 
> arch/arm64/boot/dts/qcom/sm8250-mtp.dts:631.17-648.4:
> Warning (simple_bus_reg): /soc@0/codec: missing or empty reg/ranges property
> 
> Move wcd node out of soc to fix this
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> index fb99cc2827c7..3876a94b49a9 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> @@ -156,6 +156,25 @@ vreg_s6c_0p88: smpc6-regulator {
>  		regulator-always-on;
>  		vin-supply = <&vph_pwr>;
>  	};
> +
> +	wcd938x: codec {

This probably should be under "sound" node. Anyway having it under soc
seemed incorrect.

I actually wonder where this wcd9380 sits? What type of bus?


> +		compatible = "qcom,wcd9380-codec";
> +		#sound-dai-cells = <1>;
> +		reset-gpios = <&tlmm 32 0>;
> +		vdd-buck-supply = <&vreg_s4a_1p8>;
> +		vdd-rxtx-supply = <&vreg_s4a_1p8>;
> +		vdd-io-supply = <&vreg_s4a_1p8>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;
> +	};
>  };
>  
>  &adsp {
> @@ -627,27 +646,6 @@ &slpi {
>  	firmware-name = "qcom/sm8250/slpi.mbn";
>  };
>  
> -&soc {
> -	wcd938x: codec {
> -		compatible = "qcom,wcd9380-codec";
> -		#sound-dai-cells = <1>;
> -		reset-gpios = <&tlmm 32 0>;
> -		vdd-buck-supply = <&vreg_s4a_1p8>;
> -		vdd-rxtx-supply = <&vreg_s4a_1p8>;
> -		vdd-io-supply = <&vreg_s4a_1p8>;
> -		vdd-mic-bias-supply = <&vreg_bob>;
> -		qcom,micbias1-microvolt = <1800000>;
> -		qcom,micbias2-microvolt = <1800000>;
> -		qcom,micbias3-microvolt = <1800000>;
> -		qcom,micbias4-microvolt = <1800000>;
> -		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> -		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> -		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> -		qcom,rx-device = <&wcd_rx>;
> -		qcom,tx-device = <&wcd_tx>;
> -	};
> -};
> -
>  &sound {
>  	compatible = "qcom,sm8250-sndcard";
>  	model = "SM8250-MTP-WCD9380-WSA8810-VA-DMIC";


Best regards,
Krzysztof
