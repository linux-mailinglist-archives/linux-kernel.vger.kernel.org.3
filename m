Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160615192DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbiEDAhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243416AbiEDAhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:37:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50191AF03;
        Tue,  3 May 2022 17:33:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 85EF91F444CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651624424;
        bh=TylGFKA0mcDRkdBchYF01blEZNeR3QM7S0kr0QFnDGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vq6G2DgbhFyEjIpWgnVbtXcEPE2N76ZLLeMs5umG13ZdJRuxX48zw3XoQfYnVbVad
         fhuowVUpQVkRfXZnhOzP9Ywe9uOtTbwnnGuK/CfGBV5DUodZq0bZfRZ4kj/f4s40iJ
         Z3XJgU1ycDccCFAw8+LLasM0x1wjreyEF5RT6W3D3Bko9zNddR8vm1mUdyni4Fbe52
         lKHStXiEzoLqM7ONLuro3r2oyKhJSOhvZmcdCUdSeVLlabhGlVp216B0V3L+M2F8vU
         mWYEzlu5sfKdahIhTHRTyyPWWnkxVXkJt++9GYV/nc7A5QNOYs6Rw1l9xZlfJ0jz6K
         QpDHiWLBqeckA==
Date:   Tue, 3 May 2022 20:33:40 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sean.wang@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl
 bindings
Message-ID: <20220504003340.224exvr33qevi3sj@notapiano>
References: <20220503142537.152499-1-angelogioacchino.delregno@collabora.com>
 <20220503142537.152499-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503142537.152499-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Tue, May 03, 2022 at 04:25:36PM +0200, AngeloGioacchino Del Regno wrote:
> Add devicetree and pinfunc bindings for MediaTek Helio X10 MT6795.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 224 +++++
>  include/dt-bindings/pinctrl/mt6795-pinfunc.h  | 908 ++++++++++++++++++
>  2 files changed, 1132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mt6795-pinfunc.h
> 

...

> +
> +          bias-pull-down:
> +            oneOf:
> +              - type: boolean
> +              - enum: [100, 101, 102, 103]
> +                description: mt6795 pull down PUPD/R0/R1 type define value.
> +            description: |
> +               For normal pull down type, it is not necessary to specify R1R0
> +               values; When pull down type is PUPD/R0/R1, adding R1R0 defines
> +               will set different resistance values.
> +
> +          bias-pull-up:
> +            oneOf:
> +              - type: boolean
> +              - enum: [100, 101, 102, 103]
> +                description: mt6795 pull up PUPD/R0/R1 type define value.
> +            description: |
> +               For normal pull up type, it is not necessary to specify R1R0
> +               values; When pull up type is PUPD/R0/R1, adding R1R0 defines
> +               will set different resistance values.
> +
> +          bias-disable: true
> +
> +          output-high: true
> +
> +          output-low: true
> +
> +          input-enable: true
> +
> +          input-disable: true
> +
> +          input-schmitt-enable: true
> +
> +          input-schmitt-disable: true
> +
> +          mediatek,pull-up-adv:
> +            description: |
> +              Pull up setings for 2 pull resistors, R0 and R1. User can
> +              configure those special pins. Valid arguments are described as below:
> +              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
> +              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
> +              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
> +              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3]
> +
> +          mediatek,pull-down-adv:
> +            description: |
> +              Pull down settings for 2 pull resistors, R0 and R1. User can
> +              configure those special pins. Valid arguments are described as below:
> +              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
> +              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
> +              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
> +              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3]

I'm actually myself trying to figure out why there are two ways of setting
R0/R1 in the dt-binding (and which should preferred for mt8192 and others):
1. passing 0-3 to mediatek,pull-{up,down}-adv
2. passing one of the MTK_PUPD_SET_R1R0_** flags to bias-pull-{up,down}

When the pin is of type MTK_PULL_PUPD_R1R0_TYPE (which should be the only case
in which it makes sense to consider mediatek,pull-{up,down}-adv AFAIU), they end
up doing the same thing, it's:

mtk_pinconf_bias_set_combo() -> mtk_pinconf_bias_set_pupd_r1_r0()
vs
mtk_pinconf_adv_pull_set()

... and they write to the same registers.

Unless I'm missing something here.

Thanks,
Nícolas
