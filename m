Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9289952A42B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbiEQODh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348398AbiEQODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:03:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664924D279
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:03:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w14so1053160lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PikebDafotl3bpR+Ku+atSXQOd5Oqh//HdBV+Vc1H30=;
        b=G4teg5mtaHgDGlR63c7zTZ3+tfwXyzsV80lLzvT7ILz3lDisu2Y2k/nRN2MoBD6Oq/
         flkrfHWKFHBMwy7VX97XzluZqol0Oo7PVJNa2Z0KUQQyei3HfR36UscIJPReE2nNrvUU
         KLzCma9Ra10RqkF/4HgTuak0Jqp1tdv8f4WKe0Uqfq6oNJYXIT1jHcesN2TFMOd0DXnR
         vcdnnS1hDbNbkczBgOpKR1o3JWcmrvN5a/H+trDoShbqLmZnbyuVuGb89ks5GPorzqqx
         jB4jGrko680BuJaEZVC/JZOQQgS4JDjWQQKe5TR1MXRlKBwNwCvUgTr5gV01qHb3svYZ
         8u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PikebDafotl3bpR+Ku+atSXQOd5Oqh//HdBV+Vc1H30=;
        b=669BmbCr8O38SI5Ex40VyFWi3OjcacNteeDN07Xm6wKtki3KjIDj6+HeDhaES/dulm
         arMLyW5VxVS1uKqUVCG5n832B6oBb/4/eYJW3P6/P4dQviSmFJYNiGxMY64CU2DEA1rC
         IsOts0mkoleRquYWSp89G5LeLUuXLzWAWKPWUDjT4MNzIYd67lD6hOu1g/iCKs3SFGog
         r8hIaWoU3+tADXPc+PXiLF/+C96MSP5eyVPf9gAEoW3IGyB581dDv8Pz4FseDKjlJfgU
         kLHNUzHfHZe3wM3A/PhOQzDiApJf10BhBDs3eVK+rB5McQFCszC1pxKUjkYgUs0lnQVn
         7uzg==
X-Gm-Message-State: AOAM533lLFPI04VfyKxIZfh9fDE9MNqEvERVsEx907eSGbeFWiX80T1e
        SwcDDtCo5ghOX5h3PxI5QH/uCg==
X-Google-Smtp-Source: ABdhPJzl8gnJS1oWqrRUvRz4TkrvW/i0lsxk2snqO42tkzHmMr3F1rpyZa+rj7vBaJOLwOccVrwCPg==
X-Received: by 2002:ac2:5cc7:0:b0:472:5be:eb7b with SMTP id f7-20020ac25cc7000000b0047205beeb7bmr16290779lfq.663.1652796194758;
        Tue, 17 May 2022 07:03:14 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p18-20020a05651211f200b004764eecf6cdsm1495092lfs.224.2022.05.17.07.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:03:14 -0700 (PDT)
Message-ID: <ea4ba422-2ce7-21f8-808f-293e0fa43698@linaro.org>
Date:   Tue, 17 May 2022 16:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 20/20] arm64 defconfig: Add MFC in defconfig
Content-Language: en-US
To:     Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
References: <20220517125548.14746-1-smitha.t@samsung.com>
 <CGME20220517125659epcas5p4f344138f5b8a64f9e49c6cba4f0af92f@epcas5p4.samsung.com>
 <20220517125548.14746-21-smitha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517125548.14746-21-smitha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 14:55, Smitha T Murthy wrote:
> Add MFC into defconfig.

It was already there, so this is not correct.

> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  arch/arm64/configs/defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 50aa3d75ab4f..e35765f2d78f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -661,7 +661,7 @@ CONFIG_RC_DECODERS=y
>  CONFIG_RC_DEVICES=y
>  CONFIG_IR_MESON=m
>  CONFIG_IR_SUNXI=m
> -CONFIG_MEDIA_SUPPORT=m
> +CONFIG_MEDIA_SUPPORT=y
>  CONFIG_MEDIA_CAMERA_SUPPORT=y
>  CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
>  CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> @@ -678,7 +678,7 @@ CONFIG_VIDEO_SUN6I_CSI=m
>  CONFIG_VIDEO_RCAR_ISP=m
>  CONFIG_V4L_MEM2MEM_DRIVERS=y
>  CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
> -CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
> +CONFIG_VIDEO_SAMSUNG_S5P_MFC=y

No, change is neither justified nor explained.

>  CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
>  CONFIG_VIDEO_RENESAS_FDP1=m
>  CONFIG_VIDEO_RENESAS_FCP=m


Best regards,
Krzysztof
