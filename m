Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED3534A79
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346235AbiEZGts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiEZGto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:49:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CD034B80
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:49:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd25so688966edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7Bp9SA/1hFvtEI6hsrX+GVTXLacAaxb75saSLRSbPUs=;
        b=lZ0UFWMJZR/ScahCDhnrsdiqEMBsXhaUmxwPQYz8kGSkmNB/cfqAcxnwTVkp9xj0aE
         lsCoXp+eBgAG94q60rWQbm2Ev46NKSs7L0YuVDnsOuzPOSZw4gGFoRmjwrwitLfc/Q1u
         th3CE0lwu0KKph3kbzIli9VSAOxfe3FBTYhkQfWCArBTLj/bSslh3I5HWo53/4LUlp2Y
         EFr6Ux9jj1yIdsZLQ2Z0OF4eeKYkdllzrL3pr3b5ZFiR05utU1Q22S/gN01NaCibu8uA
         QiX4cooIXHCpWZc2KVRtRA0YzG91KtsCjTK6OcNFkVXfJD9Gs0VagoIP14zE/x1qcvgX
         f50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Bp9SA/1hFvtEI6hsrX+GVTXLacAaxb75saSLRSbPUs=;
        b=5SixJuRTaEr4c8zH8Q8ftb+zFlyTgO5poGtEA1fSxbeEVWpQpYTlMUWaWJrlV3d/SD
         /qHzcUqDw88XMOdfePDwYFUT54DCnWMqkJNIaQTJSZwLSu5/azMaVjLe3dOffDg0iNnh
         nhQAe49RrP+Gc1Av0Q1tlanTVlpVSATYsSkpoS4Jy+hRZCHTt1K34YsaFereK4ZqHz4O
         pMY8ffQxv1Nk9IGxI4eN13J4hMaZjwiw766eURSlSr1UCzK+MU+nQ7sXreaDRp3S6W+x
         qW139o7lCnMIDHq/ClLv9jmy2dNsfatx8E1p7UXssZ9u5HUocElSZy2qiIPBT7d2wz4i
         uizA==
X-Gm-Message-State: AOAM533vAlHsfiOXFxgUCRbbpRs99zLRJQaJ5PF7gaU4vvpl5GaKhUJ4
        iZFQ04SLam9CcqVQp+gZxs0oog==
X-Google-Smtp-Source: ABdhPJwr6AzAilZdcZEXaEVY/WvgakJfBGOFvOc7ZLnxseNZb9svTt9d2Rn3vt0YkLTvjnYO5aqOqg==
X-Received: by 2002:aa7:c4d0:0:b0:42a:ce47:e9c5 with SMTP id p16-20020aa7c4d0000000b0042ace47e9c5mr37950139edr.224.1653547781831;
        Wed, 25 May 2022 23:49:41 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kq21-20020a170906abd500b006f3ef214e0csm225570ejb.114.2022.05.25.23.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 23:49:41 -0700 (PDT)
Message-ID: <e8d854c0-e2a5-2382-4b54-c5e879170324@linaro.org>
Date:   Thu, 26 May 2022 08:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220509205847.607076-1-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220509205847.607076-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 22:58, Nícolas F. R. A. Prado wrote:
> The Mediatek AFE PCM controller for MT8192 allows two I2S interfaces to
> share the same clock and act as a single interface with both input and
> output. Add patterns for these properties in the dt-binding. The
> property is split into two patterns in order to allow all valid
> interface pairings.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> The series from v1 of this patch was merged although some changes were
> still needed in this patch, so the v1 of this patch was reverted [1] and
> this standalone commit addresses the feedback from v1 and readds the
> property.
> 
> [1] https://lore.kernel.org/all/20220509185625.580811-1-nfraprado@collabora.com
> 
> v1: https://lore.kernel.org/all/20220429203039.2207848-2-nfraprado@collabora.com/
> 
> Changes in v2:
> - Added "mediatek," prefix to property
> - Rewrote and added more information to property description
> - Split into two patterns to validate that output-input pairings are
>   done
> 
>  .../bindings/sound/mt8192-afe-pcm.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> index 7a25bc9b8060..2abf43c6c2c3 100644
> --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> @@ -54,6 +54,22 @@ properties:
>        - const: aud_infra_clk
>        - const: aud_infra_26m_clk
>  
> +patternProperties:
> +  "^mediatek,i2s[13579]-share$":
> +    description:
> +      Each I2S interface has a single data line, input if its index is even or
> +      output if the index is odd. An input and an output I2S interface can be
> +      used together as if they were a single I2S interface with both input and
> +      output data lines by sharing the same clock. This property represents this
> +      pairing. The value should be the name of the interface whose clock is
> +      used, and the property name the other interface that depends on this
> +      clock.
> +    pattern: "^I2S[0268]$"
> +
> +  "^mediatek,i2s[0268]-share$":
> +    description: Same as above.
> +    pattern: "^I2S[13579]$"

Rob's question is still valid - why these are not phandles?

In any case you miss $ref.


Best regards,
Krzysztof
