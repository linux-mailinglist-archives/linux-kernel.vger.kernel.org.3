Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8D5B1A73
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIHKtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIHKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:49:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AA613E0F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:49:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn9so19381365ljb.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FO9BCtAdjl5PI944Vegw3TyVJtWAoaowtQm2TG38rZo=;
        b=kVhIpvQcg33Vr8Tvlxq4JzJdu83HxShDz+VCPW+/zVSedQfV32YodjnRDz5Q0bEtF5
         neQnsoY6HrEu7ovhqpmFBcWjyBOSh3eA9ga3BaGL6YCsiOM5noaZysSDaMmyJ5GVk9S2
         3rt401hf15pvJVJLra4u8GQmIj4jDO66Ku51LZOiijwad16dJ8Mv0L0nNclGHIOpTfAT
         NOHRfeqEGhDcb3vhWKM+oHnne/hIbesCLTmJYH4rLqsHkiBDymzob7NbKP00PDqBIN3z
         D6HBruLXKqpOyA/6RV6DEV9fbJIDayrZc7aN3MQWxynlQATz8ooxPD8Uqj51JxLgPR8M
         8WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FO9BCtAdjl5PI944Vegw3TyVJtWAoaowtQm2TG38rZo=;
        b=JxJJjdlP2Zb8krAt3Ni1VEj+/2wZs/HVO2DMO8qCwf9clKOhH/uoHuleO8YcLrEq9B
         EcRUq35hkaWN9ZctmR8CSR48SuE5+GZeWCAZr4Om/+dcZprhf1t+jyISpxowCrQR6+Xq
         mcYNlf4L15aks0u0eusW/7Su1fQOCTebPbQ6tAgk2CodsD8ob+H+OzFU9u0Ugs9VY33Q
         O+WaV2ky0PrlOesinOqH0lYQY1QEfFj0DrAAS+TQ9tnKE0yWyhdosxjLTJxoIq95M9tA
         OCneFAUIkRUEXP0FrvWgDMLHpfUmfruOAVYGFx/gny/HDUqakh25fRWVmHQyTY0FCovQ
         ly2Q==
X-Gm-Message-State: ACgBeo04Zo2OpEj0gNwcFIwr5SwRerfG41H3C8xFv6DL/aNI5MPcrpMP
        37qRH/F0kLLuXB8FmHDAfgf/um6M7rmKgQ==
X-Google-Smtp-Source: AA6agR5enzuiL7nHDIxq2vO3krABgPwQHKwYJura+/kGgktQ0R6FajdwvACAYu1/LM8XDhJ33YwGsQ==
X-Received: by 2002:a2e:be9b:0:b0:25f:e027:4999 with SMTP id a27-20020a2ebe9b000000b0025fe0274999mr2353474ljr.395.1662634176744;
        Thu, 08 Sep 2022 03:49:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b0048b0696d0b1sm2983866lfr.90.2022.09.08.03.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 03:49:36 -0700 (PDT)
Message-ID: <2e575ed1-b82c-c7bd-3ddf-ccb6022b2461@linaro.org>
Date:   Thu, 8 Sep 2022 12:49:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To:     "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220831125502.7818-1-chengci.xu@mediatek.com>
 <20220831125502.7818-2-chengci.xu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831125502.7818-2-chengci.xu@mediatek.com>
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

On 31/08/2022 14:55, Chengci.Xu wrote:
> This patch adds descriptions for mt8188 IOMMU which also use ARM
> Short-Descriptor translation table format.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

>  
>      then:
>        required:
> diff --git a/include/dt-bindings/memory/mediatek,mt8188-memory-port.h b/include/dt-bindings/memory/mediatek,mt8188-memory-port.h
> new file mode 100644
> index 000000000000..9363e132c43a
> --- /dev/null
> +++ b/include/dt-bindings/memory/mediatek,mt8188-memory-port.h
> @@ -0,0 +1,482 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */

Why do you license it under BSD-3 clause?

Best regards,
Krzysztof
