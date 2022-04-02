Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FD74F012E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbiDBLkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbiDBLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:40:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2751DECA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:38:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r13so7594785wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8FFVolbjt7YQtgOwSMGhmxxnSOZEEydEW3XCqGYcvHI=;
        b=e6+pufWUWXMYXP2ayV2VVAJMz1VRBg6uRkjboRcQIz+HUhpny5gKBWS1u6h0hBubf6
         VQRvvmEasxGHwA4YloPoMW1pOXmn+nVScFSVI8SGHv2gx5rFxGiZqX6yhbQ7F9R3/HKj
         /d4BW7h6PYY8/H8zZeOlymb/0qLB2u0RneOkDDMU/6P0Gj2cF5hsKeullDmLlaRCksLQ
         LR7YlWQd6Cx87wlBCcnaIyDtweohWF8yoeSKH6hdNZKTNl80BTslil2CpCgOWob1DxRP
         ZkVZbN+0QTuWX9yg/SlBSTufRF6GYF3bFmA6axIrYq30xIbcG12alnNXz6Z2MI74Xf2Z
         R8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8FFVolbjt7YQtgOwSMGhmxxnSOZEEydEW3XCqGYcvHI=;
        b=Q003CJBQae4NOfqE44UvApkxxzexWLyaTWnRvvn1+kEweG+TVlcyAF3nplIeMt83+G
         MFYwguiwZmg0F+W+BcRaRqGMaGiyJ78vCHzo/3FScT2aTme/4ZNseTT2F6dPKcLFEuHp
         QlOl52HdyMWFMpWXr+LHvnFJYdNTTrgBgHQjdEYAFWTdBz6pNVZceVTaPUojlZKNAF/T
         jUI13QLIQ3yEud3YlkTnLyIh5qpmoo7cHlg3lkXMqLwX4Z+Fm8+jRv3jPun/JhkcEWp2
         Hklo+PqM655DC51BjyFW6y8RdthyQAdKruV8FAo6VKR2LvyX9p2Dl32TU5EB+AuHP34M
         QwWA==
X-Gm-Message-State: AOAM531MwUEt4XP1xYQqkSYQ3xKLJLXb0/BPjvc/cDa6sSd6wZAQwMoI
        AdbjBvags07O2caahQO+1Isr3PKvQkr3rbBQ
X-Google-Smtp-Source: ABdhPJzieEb8o87Ny7opSK6xjHHmcl1p7dLVnehn/hiuzdAE+8zJ43hgHIA62CpYaa+w0Zmx73s6Kw==
X-Received: by 2002:adf:ee87:0:b0:203:de0b:b236 with SMTP id b7-20020adfee87000000b00203de0bb236mr10658770wro.337.1648899522201;
        Sat, 02 Apr 2022 04:38:42 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id y13-20020adffa4d000000b00203e3ca2701sm5909866wrr.45.2022.04.02.04.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 04:38:41 -0700 (PDT)
Message-ID: <8588a941-6d3e-9e14-cb21-d7af29b4b2bd@linaro.org>
Date:   Sat, 2 Apr 2022 13:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dt-bindings: mfd: syscon: Add support for regmap
 fast-io
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        kernel@collabora.com
References: <20220401135048.23245-1-angelogioacchino.delregno@collabora.com>
 <20220401135048.23245-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401135048.23245-3-angelogioacchino.delregno@collabora.com>
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

On 01/04/2022 15:50, AngeloGioacchino Del Regno wrote:
> The syscon driver now enables the .fast_io regmap configuration when
> the 'fast-io' property is found in a syscon node.
> 
> Keeping in mind that, in regmap, fast_io is checked only if we are
> not using hardware spinlocks, allow the fast-io property only if
> there is no hwlocks reference (and vice-versa).

I have doubts you need a property for this. "fast" is subjective in
terms of hardware, so this looks more like a software property, not
hardware.

I think most of MMIOs inside a SoC are considered fast. Usually also the
syscon/regmap consumer knows which regmap it gets, so knows that it is
fast or not.

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 13baa452cc9d..85a2e83b5861 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -83,11 +83,26 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [1, 2, 4, 8]
>  
> +  fast-io:
> +    description:
> +      Indicates that this bus has a very fast IO, for which
> +      acquiring a mutex would be significant overhead.
> +      When present, regmap will use a spinlock instead.

Regmap is current implementation behind this, but it's not related to
hardware, so how about removing it from the description? Something like:
"..., for which different locking methods should be used to reduce
overhead (e.g. spinlock instead of mutex)."

> +    type: boolean
> +
>    hwlocks:
>      maxItems: 1
>      description:
>        Reference to a phandle of a hardware spinlock provider node.
>  
> +if:
> +  required:
> +    - hwlocks
> +then:
> +  not:
> +    required:
> +      - fast-io
> +
>  required:
>    - compatible
>    - reg


Best regards,
Krzysztof
