Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0653FB9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbiFGKnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241284AbiFGKnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:43:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA11D0C7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:43:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a2so27665914lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XdRg5mTQzw6nhVkPbcttepeHu1kmSLwBbs3fva93xc=;
        b=N1DSIYQ2tUBiiR928h/wpbuAkWoyNemmJ20vBlcsKVQyNN84AnPudb55G8X5EEHZc5
         VrfLCbnWDAtsrhHYhabH4L0BcK6Yj8HILDRD4QS8o9jivIkV09uQ9k8+flwSL9YhpfOf
         EKIY6RpNWcq9H5P5HOecjEdKbfbUTACnthsEE+FVdO9ZPFQkU20CO5hbDY+TsXwi7Gyk
         XR89OVy0Qnt+8Lqc8HgO4+mf7B2XbeP3Iw4IkdQhRpmxypzV+y4NmZjw14ztQ0cTRyjV
         Vc9XiSpbooXYnaIEGWYbXJ0j+c6+AycmpTWR911QhQRT0pklscDEgFFUW/dz8ZLGdIVr
         VVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XdRg5mTQzw6nhVkPbcttepeHu1kmSLwBbs3fva93xc=;
        b=U4Sf4W+66Ggw2fZ6+nx1USShH8nXRLG5iBoyUHR3c3sw5FWwjqtd3jdm37QTd3wt9j
         2N6gprv6IYGQM9jgLLIDCGc4c2IDuAswTZmie3oo2icOZunid95/tEe6+MswZn/wh9Wf
         dbFSWi+QsK9/dJ8SUAy9/LHG6BfYlflMDs4NDw1yLPNcZ2COsiNX9IuqR57ghaU3DJ9Z
         vHZwRpTUsVTgmDrqXqSwFPkiaQYBtgQBh7oLNFaNEDG1X/RzzwK8pj+fQaW2sF5tiulL
         G8xuBNbX4uYb4YRVV8GgwRFM8ZyRGKpRGfhghXTePycSQ2lM1Vk4wYDtDljwXJv89vlx
         zSDg==
X-Gm-Message-State: AOAM532+sT/lq5Qyt1Nn0BcyY0sNhOI1k9ZV6fTdCUdr9VWjiPUTMN/N
        QSeyPN2Xdn/psmHEFe1ZLEQV7n7m/NJEkkgKqyZReg==
X-Google-Smtp-Source: ABdhPJzxvjAZjQF6R+Mrr94IoW1X7wi8uwFKBgPf5GLnc+Gvu4doMpfp0SK0kukM6bfhDVOV0zyEW3g+vrtCParwkeY=
X-Received: by 2002:a05:6512:403:b0:479:1627:a9b7 with SMTP id
 u3-20020a056512040300b004791627a9b7mr15634227lfk.233.1654598595349; Tue, 07
 Jun 2022 03:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220606225137.1536010-1-robh@kernel.org>
In-Reply-To: <20220606225137.1536010-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 12:42:38 +0200
Message-ID: <CAPDyKFqNiJB_2aEaQpBo4=Vzc60-986=aKKw4JZtXvO=X9WTqQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop more redundant 'maxItems/minItems' in
 if/then schemas
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hu Ziji <huziji@marvell.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 at 00:51, Rob Herring <robh@kernel.org> wrote:
>
> Another round from new cases in 5.19-rc of removing redundant
> minItems/maxItems when 'items' list is specified. This time it is in
> if/then schemas as the meta-schema was failing to check this case.
>
> If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
> same size as the list is redundant and can be dropped. Note that is DT
> schema specific behavior and not standard json-schema behavior. The tooling
> will fixup the final schema adding any unspecified minItems/maxItems.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  .../bindings/memory-controllers/nvidia,tegra186-mc.yaml        | 3 ---
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 1 -
>  .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml  | 1 -
>  3 files changed, 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> index c7cfa6c2cd81..935d63d181d9 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> @@ -150,7 +150,6 @@ allOf:
>            description: 5 memory controller channels and 1 for stream-id registers
>
>          reg-names:
> -          maxItems: 6
>            items:
>              - const: sid
>              - const: broadcast
> @@ -170,7 +169,6 @@ allOf:
>            description: 17 memory controller channels and 1 for stream-id registers
>
>          reg-names:
> -          minItems: 18
>            items:
>              - const: sid
>              - const: broadcast
> @@ -202,7 +200,6 @@ allOf:
>            description: 17 memory controller channels and 1 for stream-id registers
>
>          reg-names:
> -          minItems: 18
>            items:
>              - const: sid
>              - const: broadcast
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index c79639e9027e..7a2b22dd6d05 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -145,7 +145,6 @@ allOf:
>            items:
>              - description: Xenon IP registers
>              - description: Armada 3700 SoC PHY PAD Voltage Control register
> -          minItems: 2
>
>          marvell,pad-type:
>            $ref: /schemas/types.yaml#/definitions/string
> diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> index cbcf19f51411..ed6c1ca80dcc 100644
> --- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> @@ -64,7 +64,6 @@ if:
>  then:
>    properties:
>      clocks:
> -      minItems: 2
>        items:
>          - description: High-frequency oscillator input, divided internally
>          - description: Low-frequency oscillator input
> --
> 2.34.1
>
