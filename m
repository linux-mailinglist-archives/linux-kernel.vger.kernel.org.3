Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30224AD965
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbiBHNRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357628AbiBHMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:35:13 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D5EC03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:35:11 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id r27so20349253oiw.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DCySzda80keBjyEDz1S/bpNT7VXpJeMj45VaQ6BvJBU=;
        b=GYXq0lDGikvfNxjZHaTsvUsWpAWeKdn/6UGfEb3FFoeFYlD6bUY/0nlap/7s/pq9z0
         3APdNRdEg8kXTQRccdTBPHnxP3GBaS0NEchX/eBUqUR4B92jiN87Z4wHKHI93W+h1GYZ
         O01ad+euhCHLjSgemVx7XVtX2vVMua5t5NA/HKNu/iBinrg6OW/pUCc0JBP8TDRLmCMr
         ZKk6vQVBcB2EhjBtCbdEacoZR+NRfxwQhTZxe37GS23drZkY2ti8E6eQYLVWDrMG1Vzo
         V5ubSMJ8oprLEnkCN0Jeu1iX3/Hc0ivMOH7TFz1fxkcyb/1RylYGfs6YEKfxH6vmadAF
         kx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DCySzda80keBjyEDz1S/bpNT7VXpJeMj45VaQ6BvJBU=;
        b=3uz5jl8yQu7S4x7ZLt8NeOJxfAI/Bc5IsGZFBg6kHujm1Dtzaj60HU+t7uCyoTYpfS
         HgdO4KCE9+VXkyux+TpW9vdIO5+60/Bjwiusn2TdBFguIX4CItoHeTh+L1WsqeQ3yX/d
         zzSgjmfVIiMTCQlrblbJ9L0MRsOekWWQMKtGmQgIACO7GyxjjP+Vfw0SJZMNYpcn1pQm
         tC1hW6kdMge2Jpz78pflzJBmzL2qkNbLuwikYSJ3j/Cxhbz31hdExBqwUNLXyHt1Kh6l
         q+n7Nw7kmaS32RhC3HTdDbH5K+tIdCms9p26RRWCgptG+9eUwOWyqkTtGk5CI9x0/OCH
         xMbw==
X-Gm-Message-State: AOAM532T/fpYAeQPZHyfC2v7SF/7D5NerxikzoxfoJgGT2iIhKIOTAaF
        FlW0eqFRxb+M6MxYsD6JEj7eAQ==
X-Google-Smtp-Source: ABdhPJxMAYh+r5RkZzZHsVmSNGS1wg9WOJ//Irolb0godaB76n0KtYv/ryyD2/ywrLKHBEIpmQyf+w==
X-Received: by 2002:a05:6808:211e:: with SMTP id r30mr411574oiw.6.1644323710858;
        Tue, 08 Feb 2022 04:35:10 -0800 (PST)
Received: from [192.168.11.51] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id bc36sm5211916oob.45.2022.02.08.04.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:35:10 -0800 (PST)
Message-ID: <300f9ec9-da52-235f-ea3c-b49bdc8bfb75@kali.org>
Date:   Tue, 8 Feb 2022 06:35:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: c630: Add backlight controller
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220208041606.144039-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220208041606.144039-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 2/7/22 10:16 PM, Bjorn Andersson wrote:
> The Lenovo Yoga C630 uses the PWM controller in the TI SN65DSI86 bridge
> chip to provide a signal for the backlight control and has TLMM GPIO 11
> attached to some regulator that drives the backlight.
>
> Unfortunately the regulator attached to this gpio is also powering the
> camera, so turning off backlight result in the detachment of the camera
> as well.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index 58845a14805f..55fb7302245b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -59,6 +59,7 @@ mode {
>   	panel {
>   		compatible = "boe,nv133fhm-n61";
>   		no-hpd;
> +		backlight = <&backlight>;
>   
>   		ports {
>   			port {
> @@ -98,6 +99,12 @@ sn65dsi86_refclk: sn65dsi86-refclk {
>   
>   		clock-frequency = <19200000>;
>   	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&sn65dsi86 1000000>;
> +		enable-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
> +	};
>   };
>   
>   &adsp_pas {
> @@ -419,6 +426,7 @@ sn65dsi86: bridge@2c {
>   		clock-names = "refclk";
>   
>   		no-hpd;
> +		#pwm-cells = <1>;
>   
>   		ports {
>   			#address-cells = <1>;
Tested-by: Steev Klimaszewski <steev@kali.org>
