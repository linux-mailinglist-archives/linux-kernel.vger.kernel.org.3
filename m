Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4C458C565
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbiHHJRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242218AbiHHJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:17:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7C613F4E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:17:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w15so9175889ljw.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pMpurfdUFUXUf7fmwUQBIqLSWGdQDW67AVZBUmy36+k=;
        b=r1xUYo+L0qxJxm9/dIt6wup1Dpe9Iqw3qDUSVLixLXaD9QnyWNaW4VNjsbYKbLWG3m
         +q1yNGFsnSUXflkalaqeWqEBgelbQNnpDPmaAoi6GLIcxwMfzVjgTYfmavGrl2i/pnW0
         ikrVqDzQ6vhUgeAjf9nvoPt6MqZeO8D5UKUItp34rlp2tWDJ7uRwbcWQAyK3Gw1Ftg1+
         6m+ezM2bRgBygZCRf5C2hNWtlDJkRL4OmClSWoOZTINDNnx7jHSWBdwCoZID2laakvdC
         d/yOvWPt7cwGbIwrby0E5TYRWXuW7NizeqFUpc2Xv0iV9pkmO0bEquvydNBKJAcXp9XD
         qG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pMpurfdUFUXUf7fmwUQBIqLSWGdQDW67AVZBUmy36+k=;
        b=nLp4kJy9w5VmUZWY4WOQOyXgISjucq9yYPSp4GN1riDMqBFLtGOedS9n/XZM2sW37a
         u7AqyM4pSSDRjSIUZVOkXqYP5HtrzoO41CCnmQGVsqmB6R+ohJVcdr5XAPqgBnqvI1Ja
         XZEvTRLz+B1MpSTrvjVFTqrav82180xllNxxth1rTyB8UCAlSnMQbQSVRAIwbQ7kwfAy
         KrNxtMQZ7M/xJutFfLla6E0/GR2Lfk0jvwNpy4C1VLjTTKsm0WC2LdwJIKiO7fsSc9XJ
         NCv5AJB0YOJUKdPUDaLHwgC/cVH6h06RREF9HBSe3UIsx2PNKVZwhVsPnb/6dkQwUsdL
         IECw==
X-Gm-Message-State: ACgBeo2vr66YeUDUk0Au5zfefotdGRzhr32Fy4TP5+K8EYNX58satnu9
        cRprPJ5P3I9nWNJlUjSqxTrUqA==
X-Google-Smtp-Source: AA6agR75FWgUDhN/Zq3dwh05o1Z/nJwA53vV5D3Tos8WHvDReDd8edBsXQCUqvN2Ob/upYWd966uvQ==
X-Received: by 2002:a2e:8404:0:b0:250:cde7:e9e3 with SMTP id z4-20020a2e8404000000b00250cde7e9e3mr5291223ljg.289.1659950230860;
        Mon, 08 Aug 2022 02:17:10 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id s13-20020a056512314d00b00477c0365b20sm1353560lfi.188.2022.08.08.02.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:17:09 -0700 (PDT)
Message-ID: <4cef00b4-c184-ae78-3709-5ed520ca3375@linaro.org>
Date:   Mon, 8 Aug 2022 12:17:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: Add PM6125 PMIC
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20220805135729.1037079-1-marijn.suijten@somainline.org>
 <20220805135729.1037079-4-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805135729.1037079-4-marijn.suijten@somainline.org>
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

On 05/08/2022 16:57, Marijn Suijten wrote:
> This PMIC is commonly used on boards with an SM6125 SoC and looks very
> similar in layout to the PM6150.
> 
> Downstream declares more nodes to be available, but these have been
> omitted from this patch: the pwm/lpg block is unused on my reference
> device making it impossible to test/validate, and the spmi-clkdiv does
> not have a single device-tree binding using this driver yet, hence
> inclusion is better postponed until ie. audio which uses these clocks is
> brought up.
> 

Thank you for your patch. There is something to discuss/improve.

> +
> +			xo-therm@4c {
> +				reg = <ADC5_XO_THERM_100K_PU>;
> +				qcom,pre-scaling = <1 1>;
> +				qcom,hw-settle-time = <200>;
> +				qcom,ratiometric;
> +			};
> +		};
> +
> +		pm6125_adc_tm: adc-tm@3500 {

Generic node names, so either this is adc or thermal-sensor. Looks like
thermal-sensor.

> +			compatible = "qcom,spmi-adc-tm5";
> +			reg = <0x3500>;
> +			interrupts = <0x0 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#thermal-sensor-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		pm6125_rtc: rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		pm6125_gpio: gpios@c000 {

s/gpios/gpio/

> +			compatible = "qcom,pm6125-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			gpio-ranges = <&pm6125_gpio 0 0 9>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pmic@1 {
> +		compatible = "qcom,pm6125", "qcom,spmi-pmic";
> +		reg = <0x1 SPMI_USID>;
> +	};
> +};


Best regards,
Krzysztof
