Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D554893DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbiAJInH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:43:07 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:36570 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbiAJIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:41:16 -0500
Received: by mail-ed1-f53.google.com with SMTP id 30so48860667edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=un2mvr4VqMhvI9NwYFd0JoMH/h5euFiFUR2JJUFZ+6w=;
        b=yQ8EVUcRh+j5nwHkGhR4p6waxiAW4qsAOn522w5LtXxN7beczRxugljapKNcNmxply
         VO4a0z8Su4B8cq6Jj/ka+sg65ftpLhewRnifeIH3U689yIlfm//eJ9sLYKuE1ESTI2MK
         9uo6HYWyKUh8aPU/qrLjG8JubINZiriKkTEMN0zxdrJuaeNqoopllSo0Lyj9PRqnUIox
         fqWLMHoz+n/dsbsJb/2d92PE3HNhKSE0rO2kCvNRu7Ybz1WZfbqKZ/BYQ6S+fIBhojZy
         EzYbsEW+THNmcEPLdTVG/g6WtnJHYv/xqS5sE4BbD9WmdwICV0LRqwPipcysZJbcDohf
         ZHHA==
X-Gm-Message-State: AOAM532x7dzAQZtcBWDOmkAJEqndn6/4NpeP2wa2rf3CCbFZRu2S8Yau
        QKl8bgXfgz/ig9pH3Hv8POY=
X-Google-Smtp-Source: ABdhPJwUG7RBPKOv3HseIRWV/X7k6ByBafNVo9Y1Zz3veotWeabwxMLa5SNcFf4NmpoiwFOBgzji6w==
X-Received: by 2002:a05:6402:190a:: with SMTP id e10mr856255edz.135.1641804075176;
        Mon, 10 Jan 2022 00:41:15 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id 5sm2158478eji.104.2022.01.10.00.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:41:14 -0800 (PST)
Message-ID: <7b46e580-269c-bbf5-1319-47f91e2e89fa@kernel.org>
Date:   Mon, 10 Jan 2022 09:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v1 07/14] arm64: defconfig: build ads1015 adc driver as a
 module
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220107180314.1816515-1-marcel@ziswiler.com>
 <20220107180314.1816515-8-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220107180314.1816515-8-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 19:03, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Build Texas Instruments ADS1015 ADC IIO driver as a module.

This should be probably squashed with several others of such changes
because probably the answer to "why" is the same.

Anyway: why?

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 86d39d8456c1..1d0fe0bd0059 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1071,6 +1071,7 @@ CONFIG_QCOM_SPMI_VADC=m
>  CONFIG_QCOM_SPMI_ADC5=m
>  CONFIG_ROCKCHIP_SARADC=m
>  CONFIG_RZG2L_ADC=m
> +CONFIG_TI_ADS1015=m
>  CONFIG_IIO_CROS_EC_SENSORS_CORE=m
>  CONFIG_IIO_CROS_EC_SENSORS=m
>  CONFIG_IIO_ST_LSM6DSX=m
> 


Best regards,
Krzysztof
