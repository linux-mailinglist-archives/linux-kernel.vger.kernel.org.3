Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642C952B645
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiERJYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiERJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:24:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AAB344E5;
        Wed, 18 May 2022 02:24:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C7FA11F422B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652865864;
        bh=1M8epVbbhrfB5k/OezZImU9QLYUkLMpwpTMw3zQrCrU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O5+PqTxz/Us7pmb2QEwNAgTmsE8DICn3Cyx1r3kVPknydLuln1vHIiuFVlriMchZv
         SgA3HnMXkFxPXQGgR2P8D+Z9cyw7nGGVw7GdHxbBQapAjqJTyeDQN0fJE90yDOTnQc
         Bx9G08IYG2xlxYAUIbc2/skaG1SpFCP97KOOdoncXf58acKHglWFqjIvB38efhklGA
         Ha4qjHCXtKuxjiHMb/IsLr5rYJ17kPlUz024EcKXzTNw4qN/z3uVa261OZwBZ7bZah
         9x7xGeR3od5os0By7OZc8jn9KyuzW5d1uJxp3HcNjF+c+hchYg6NqI9Ncg6nkeB3Tl
         ATsAtZ8T+t80Q==
Message-ID: <5100b851-6787-fed8-a40f-7e6e64a123d8@collabora.com>
Date:   Wed, 18 May 2022 11:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/6] dt-bindings: arm: mt8186: Set #clock-cells as
 required property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sboyd@kernel.org, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, wenst@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
 <20220517101514.21639-3-angelogioacchino.delregno@collabora.com>
 <1cec6a09-9d80-99e7-ccc4-c918c6be7dbb@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1cec6a09-9d80-99e7-ccc4-c918c6be7dbb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/22 16:34, Krzysztof Kozlowski ha scritto:
> On 17/05/2022 12:15, AngeloGioacchino Del Regno wrote:
>> This is a clock-controller binding, so it needs #clock-cells, or
>> it would be of no use: add that to the list of required properties.
>>
>> Fixes: f113a51aa2cf ("dt-bindings: ARM: MediaTek: Add new document bindings of MT8186 clock")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml  | 1 +
> 
> If these are clock controllers and new bindings, why they were added to
> "arm" directory? arm is only for top-level stuff, not for devices.
> 
> In the future please put your bindings in respective subsystem matching
> the hardware. Fallback is soc directory, not arm.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Hello Krzysztof,

I agree with you about these bindings belonging to the clock directory.
Should I add a patch to this series that moves all of the mtxxxx-clock
and mtxxxx-sys-clock yaml files to the clock directory?

Regards,
Angelo
