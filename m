Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0C52A409
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348145AbiEQN6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347595AbiEQN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:58:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75B43C4A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:58:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c24so22004966lfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eVaeE8EmFrZMCLqtcrlHzNvDehbUwPxJkr68zMJQkE0=;
        b=keEYssJeA35i6Sta2I6KzzG+AyLAfGU3Lx5PpJy7XNJd46Oikjsl41K2FOclcNwgsf
         LqEnxpal51K+s3Phphr9gnko8bztzkVvQMsZQXRbcHbIr5ZnHY04mUhXClzZfjIpyvfu
         JN9u/WWFVTrS4rRPtrtQzTDX9UHmrPHcNwDmSP1Sf1+qW7loeTyBdIzkPd9y5JfV5bsS
         b9fc4HEg9c5FtmdbLVKOFO47fPPvdiC9fbVkmb7R8UW54e/N5wXAgSffVIgmIhziQj9q
         +Cfuea8uomdXM/3DRACVZLltyktTJwr4fDkOFZHDT75WmQilucE/VyjIzTvR+zh/8i15
         rLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eVaeE8EmFrZMCLqtcrlHzNvDehbUwPxJkr68zMJQkE0=;
        b=GMs0JIiCeKbAJl4dW5IyH0AScOtg6yWtWGcS/V1csH5slJLLP0IVsnDxlQoL6PiDDD
         GNoGTHP2gcTQ9RHnq8MiYz6hg9S3MwxsQTTL2c0X3dFerYUGuh8utlkWzgjDramAg8vu
         ocOOeYNUp0l8UJT7QaRhQCSkAGmwmXALvbk3hVWuu2mcV/1tmaUILPSWeQOWmTOzQfY6
         u5fdPjLuasKOxlyIeJeCaL1/+K8rdptvXK2Yx7ewwF/bVvDQu6Nvo2IT6/ELHkPQAdfr
         hauhigumx02wE6Gcd9aP0CrzbWnSI1uTug0CDdXMMWDGAgXNd2H3L3PJBvyisrGAlY82
         ye1A==
X-Gm-Message-State: AOAM531Z7SBnqZoetuYt5Wm5zjkY2tZwtDcHCyZ3lR6cE8boq1BAtXc+
        /6soTL+VK+vRiunwtfNGfkuE0w==
X-Google-Smtp-Source: ABdhPJxw8xo2pjvHxPlfO7zErtguu1LhEFbww2MX8pjsfBIN1zJWlGEkdKQlYDEvVNX2wu/6K/T+fw==
X-Received: by 2002:a05:6512:1399:b0:448:9f0b:bf4f with SMTP id p25-20020a056512139900b004489f0bbf4fmr16621673lfa.67.1652795884116;
        Tue, 17 May 2022 06:58:04 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t8-20020ac25488000000b0047255d21117sm1602236lfk.70.2022.05.17.06.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 06:58:03 -0700 (PDT)
Message-ID: <9606459e-7d9f-90af-1c5c-263e8ab1fae1@linaro.org>
Date:   Tue, 17 May 2022 15:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 03/20] dt-bindings: media: s5p-mfc: Add mfcv12 variant
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
 <CGME20220517125558epcas5p228cdf5f665468d3fd065d88a5d0ad157@epcas5p2.samsung.com>
 <20220517125548.14746-4-smitha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517125548.14746-4-smitha.t@samsung.com>
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
> Adds DT schema for s5p-mfc with a new compatible
> string for mfcv12 variant.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  Documentation/devicetree/bindings/media/s5p-mfc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.yaml b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> index fff7c7e0d575..209da53f3582 100644
> --- a/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> @@ -21,6 +21,7 @@ properties:
>        - samsung,mfc-v8                  # Exynos5800
>        - samsung,exynos5433-mfc          # Exynos5433
>        - samsung,mfc-v10                 # Exynos7880
> +      - samsung,mfc-v12                 # Tesla FSD

No. We moved already to SoC specific comaptibles. You introduced back
wrong pattern with MFCv10, but it should be rather fixed. Don't go back
to it...

Best regards,
Krzysztof
