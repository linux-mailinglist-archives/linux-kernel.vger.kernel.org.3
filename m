Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B93051E84E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446573AbiEGPxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349496AbiEGPxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:53:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE66A39164
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 08:49:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y3so19393443ejo.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wQNlbBSnCGuXV/datAdDc/iLjhkXcPGRCGM9OyDI6Qs=;
        b=LnU74xen1fqtuwMfRKvPcwdHMwYCLrdLz5kRQusxol4JUF268MCt2KUk+ZyygvB/LC
         OJTrtjt2CYTq0mkxUYeCh1BvwrqN4KGJa8PI6D3D/nCLdcz9RyAeplZ+UhMAJX6c3opK
         ImgmlhJ6v0QRyzqhgfbKLysm/V8DeSV2srYqXjKUgrwo5eMPvb5P31X5bz8oXY3rEshV
         V7ytloxR+hvbK/aYIq+yQyugHbo5OG/UG59GLa0XD5WCkXpb/6vdIDfyUe7lC3+DAwp/
         9DTBW8uUJXp0spYRxrr16M3IlWDSn1+GWO0WMtTdPSx91Og2UoT6oBcGHesvAmxxWUGe
         Wcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wQNlbBSnCGuXV/datAdDc/iLjhkXcPGRCGM9OyDI6Qs=;
        b=SX6FBt7v0Txo+hyCRSh6EquWOVSK4gUYac2cnw0WD8bJi0eVtOaaOB4svpgDXXu0ZO
         4K/VhiG+Mbl0Wb67WUXRwWfiEQEswI5FV2S67/Ob4A9oDophKRmG36h3FsrROwr6z+Ff
         CQKt/Scs/3E6raaf7EQw/RX5wIYjhQoY5tgo9TRUgJsXg27bqrP3pPc+0Z+wFRZWquI5
         //llEC9VOWcePRY362v7vAY6T3abIGdsBqi5ygtXhLd3keSS7MCbpkmo9kYpE02oIs5B
         2SZgxEV0OAQq98+MkaMEk04A14R8usHKMnNvOELW0UP0ysoeBQ7usVjwQ+FZ43mV19Kh
         fRWg==
X-Gm-Message-State: AOAM530JpStt+Mw42Z8mlDjVlinDPas3Egd+ZFPPGzlEYsUjyrUZN9Gc
        4bbprGwPm/lrONNUMPTqlUg8IA==
X-Google-Smtp-Source: ABdhPJyXhwDuCCedPga35pewNG9zUQ8z3RpGmNnelHI+hcibXqKVkpzJ5d43tBc5tCS/VDUgROR2UQ==
X-Received: by 2002:a17:907:3da4:b0:6f4:ff2b:8299 with SMTP id he36-20020a1709073da400b006f4ff2b8299mr8184708ejc.109.1651938552405;
        Sat, 07 May 2022 08:49:12 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id yl26-20020a17090693fa00b006f3ef214de1sm3121877ejb.71.2022.05.07.08.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 08:49:12 -0700 (PDT)
Message-ID: <08383669-c56e-7956-d724-668e16ea2c98@linaro.org>
Date:   Sat, 7 May 2022 17:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 05/16] arm64: dts: mediatek: asurada: Add system-wide
 power supplies
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220505194550.3094656-1-nfraprado@collabora.com>
 <20220505194550.3094656-6-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220505194550.3094656-6-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2022 21:45, Nícolas F. R. A. Prado wrote:
> Add system-wide power supplies present on all of the boards in the
> Asurada family.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> (no changes since v1)
> 
>  .../boot/dts/mediatek/mt8192-asurada.dtsi     | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> index e10636298639..5cb7580a13cf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -19,6 +19,70 @@ memory@40000000 {
>  		device_type = "memory";
>  		reg = <0 0x40000000 0 0x80000000>;
>  	};
> +
> +	/* system wide LDO 1.8V power rail */

Generic node names, so regulator-[0-9], or regulator-suffix.

Best regards,
Krzysztof
