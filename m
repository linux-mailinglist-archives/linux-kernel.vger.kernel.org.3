Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD0587971
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiHBI6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiHBI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:58:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77EE81
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:58:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h12so14913169ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=npQP1PTeFOBz/aH/qk/2cJgnMA7yHhXLpALhGeue+vw=;
        b=wrhadkP9rdiZt1XXIHzWWCrjD0rl5hQMS+ZHqpbiG8Bt2LLowIhnWcU7ppEYLP+n5h
         feQRYMFdysj8IjhdN8uy//PHWuS2s0gAwNG2Tl4bJRy/VJ9+pKLcCEgofn1G/zzwOdbc
         Bklq4hdGFHGafaOmpt8fbbRFgY2Swqfn0djw4xHaNIQUxdGw7fQt/cg6ATRE6IJ64N3u
         SJgUmnLAuwZUEPt3YYr+G8Cs5Yl1YdtfUahwTnkJ/1KXe+/za3ugN2PeP7+3or95tLx+
         zqcqdUUdODthmLA5lyqRvz90oSbF2qfLtF5jWkgC45Uoo1xD+XGM0+Lw/wJ93t2KtsXd
         AgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=npQP1PTeFOBz/aH/qk/2cJgnMA7yHhXLpALhGeue+vw=;
        b=SHhKm7QWHQcCCgkU3ePrXO3nW1zLPMoXXMG+bTIjmkKZzqWRAglB51MBCuKjVgwRbt
         dYSnAU1R3fJTzW6XJ60K80tq8yuCSea+7FTRBeWDcHX2mrzse2pbIw0ZAPnjzJsiptwO
         lnhQmftz4QDYqMWSFYYezRh05yOpIe9AiydSjpjXHFLRsrDbjxL0lNUfakMGcrrX/Sy6
         lULWfBTjGej54OXIBxFdm6d2K5Guamz42TdUn9y6Tt5Pi+UPyeWTuUy+O2wKtHjU3hTO
         zkroS6lMr0hb3JDqss7PUI1v224fHVideZ2B3G5jZa9TZbtAywH6nVuSREdYXwEaegiT
         TvEw==
X-Gm-Message-State: AJIora9L75L+6zOg/mSRd0VbIZIzLUIlhTFuFLr5EHJmD0h5jnl6WhS8
        Nr9/TFGODlikxczmsehmLrzeibScc3VkIOhs
X-Google-Smtp-Source: AGRyM1s6TASgKeoeefB3kojxmqJkb8Ddf94gvx/txy9BStGigDLYfFEvUo1PUBytil1oYOafbF8+hQ==
X-Received: by 2002:a05:651c:179f:b0:25d:ba24:2e16 with SMTP id bn31-20020a05651c179f00b0025dba242e16mr5887088ljb.422.1659430689430;
        Tue, 02 Aug 2022 01:58:09 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id bf43-20020a05651225ab00b0047fae90bfb4sm2033495lfb.56.2022.08.02.01.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:58:08 -0700 (PDT)
Message-ID: <b265c106-373f-3850-2933-9418c2b515f0@linaro.org>
Date:   Tue, 2 Aug 2022 10:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 06/20] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-7-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220729063208.16799-7-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2022 08:31, Tinghan Shen wrote:
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Thank you for your patch. There is something to discuss/improve.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    syscon@10006000 {
> +      compatible = "mediatek,mt8195-scpsys", "syscon", "simple-mfd";
> +      reg = <0x10006000 0x100>;
> +
> +      spm: power-controller {
> +        compatible = "mediatek,mt8195-power-controller";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #power-domain-cells = <1>;
> +
> +        /* sample of power domain nodes */
> +        power-domain@MT8195_POWER_DOMAIN_PCIE_PHY {
> +                reg = <MT8195_POWER_DOMAIN_PCIE_PHY>;

Wrong indentation.

Best regards,
Krzysztof
