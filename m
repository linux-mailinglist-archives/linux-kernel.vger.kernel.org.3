Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECC15B1BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIHLyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiIHLyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:54:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618BA11C7E4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:54:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq23so27310311lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VQGJlHRUp9nhyc0mzEwq4F9INwDBtUr5VdutZE2f0C0=;
        b=rpOWzDfsWc/FX3v+6r9PYQh7U5C1YOoTSXb4txAsmoBQGG3ORBVLbBqvRIDdYVpFPY
         t115kYTzdwfuixU/4HZIsr5zkGaN68n2B0DoEP1z5MM9pKZKuP4NIJmNfhvCw9X+Sc7z
         PDI+/+OhZucTNjh6kzCSGVKicS0be6JqB0iMm7ALH8KKSZW5sPfSMOGznKBiHBSxvk5C
         xjJIC9J3jw9cWTaHgS2O8bbAROKO7fYmZXCLPSEsElj7SMMte8pY6XU5UH8zD4dRe3RY
         XCCKmdAtnSxG6PpMuZP/D8DVBoMYxRPkik02ETeOtYTfbhKn8J+ebinCesIW28MgpZEf
         xW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VQGJlHRUp9nhyc0mzEwq4F9INwDBtUr5VdutZE2f0C0=;
        b=ldH15MiDdH8maqjK9VmpXJa7QcRPTLKz8MCbR5t9D6bzWz1EKB3WcJsJG1zLF5cP2Y
         1hiZ3oc+bf2HrUc5X/1Hcw7V5C4VXN7yTI6+TAZr800jkiT1tyjX7gDteGYBeMoPPo/S
         XSHMR+VrjIeRmnQ8s9Iw35ZxsZ6SFB2g87D03KwuMZB9zBf2Jo9o6UsIuR0KIl6xHQAh
         NhK+O8tfcgZu/lMcHlnnLi/CYhfcf3yfPreQj2/b+O7Bdi8ZvCRZ1dPBPygacZnNC4tz
         fnInbrX8ENmN1n7VkMEyYIgWjY4BsNYy3zQG1xqJCvAf238hZeGdI+iCXbOfI6PE1qua
         IuNg==
X-Gm-Message-State: ACgBeo0XXr+izwjqcVzEtHblsF37btZZoA/Xunp+CYPGnZNj/HWOqSz+
        cx7J5/F4Wf66a7fbwo8KUmMQ3w==
X-Google-Smtp-Source: AA6agR55o8YlOLOcDDvDdE3Ln5Z6r6dux+o/bKmvUpIRktp1YWOKL8JyrdpmTvZvgjal7Wn8hbwa3Q==
X-Received: by 2002:a05:6512:1581:b0:492:8c61:5bef with SMTP id bp1-20020a056512158100b004928c615befmr2732713lfb.518.1662638040100;
        Thu, 08 Sep 2022 04:54:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u9-20020a056512094900b0048b143c09c2sm3001480lft.259.2022.09.08.04.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:53:59 -0700 (PDT)
Message-ID: <c9adeeeb-8edd-f912-1aab-b19508187eef@linaro.org>
Date:   Thu, 8 Sep 2022 13:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/8] arm64: dts: rockchip: add the internal audio codec
Content-Language: en-US
To:     luca.ceresoli@bootlin.com, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
 <20220907142124.2532620-5-luca.ceresoli@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907142124.2532620-5-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 16:21, luca.ceresoli@bootlin.com wrote:
> From: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> The RK3308 has a built-in audio codec that connects internally to i2s_8ch_2
> or i2s_8ch_3.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3308.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index 093b70563b23..221cde49dc98 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -808,6 +808,20 @@ cru: clock-controller@ff500000 {
>  		assigned-clock-rates = <32768>;
>  	};
>  
> +	acodec: acodec@ff560000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof
