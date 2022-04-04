Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCAF4F1EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349558AbiDDWKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382403AbiDDV3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:29:34 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C1B12AAB;
        Mon,  4 Apr 2022 14:14:11 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e1e5e8d9faso6978535fac.4;
        Mon, 04 Apr 2022 14:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVuOXu4skO0KO0zRxHy/3ZvkuPFL8d4lBRDXGGDlSqM=;
        b=1N/9jHG4OVse3UwStL16iBqNh+PTDxtKx1ThGsbLSxpIF/zlCFIQK11ypLb30AvLbi
         uIBFjivmdF/xgfGIf7mfbAiBxJi0ADpEpuWzDuLpPlodAPdXc6A6Z5vZr2RSbBkSp+ZZ
         w037bwWptpQXH7cX0S5IIKyDvkn/gASPcp4u5Oj0HH7M43ASQXYcRjs3S4/ZSQB4XccH
         zjvNrt0MpC57M6PCEeAukKVr1eYZ0XObG0y8GZM3+VpKPTDWzjmhgf3Wu/1sA4/SLfXJ
         kx0qPXCPombbF97LegaGW/DnTY0GD3NA11sjFHULIHona/yjt4digYVYnEOc7hFYhbww
         pG9Q==
X-Gm-Message-State: AOAM532w/KOdXKWsboqlgtKhT4ZJL8DhdRb7KoLnQdLCK1TGfecixCyP
        5ASPoJE8Ss3xjK/HC0Ecrg==
X-Google-Smtp-Source: ABdhPJwW06Gh52XovnnLG6nWBopSe+nYPMxX+MAIwfaTGUWYf0ht+tTGTZwWR4mHIt5utIJLPkL5MA==
X-Received: by 2002:a05:6870:785:b0:da:ac31:3e04 with SMTP id en5-20020a056870078500b000daac313e04mr66117oab.270.1649106850602;
        Mon, 04 Apr 2022 14:14:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p12-20020a4a95cc000000b003246cd15eaasm4324908ooi.2.2022.04.04.14.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:14:10 -0700 (PDT)
Received: (nullmailer pid 1989352 invoked by uid 1000);
        Mon, 04 Apr 2022 21:14:09 -0000
Date:   Mon, 4 Apr 2022 16:14:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: white-space cleanups
Message-ID: <Yktfof9/qSv4wGRw@robh.at.kernel.org>
References: <20220402192819.154691-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402192819.154691-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Apr 2022 21:28:19 +0200, Krzysztof Kozlowski wrote:
> Remove trailing white-spaces and trailing blank lines (yamllint when run
> manually does not like them).
> 
> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/clock/samsung,exynos4412-isp-clock.yaml          | 1 -
>  .../devicetree/bindings/crypto/allwinner,sun8i-ce.yaml        | 1 -
>  .../devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml    | 1 -
>  .../bindings/display/bridge/google,cros-ec-anx7688.yaml       | 1 -
>  Documentation/devicetree/bindings/display/bridge/ps8640.yaml  | 1 -
>  .../devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml      | 1 -
>  .../devicetree/bindings/display/mediatek/mediatek,merge.yaml  | 1 -
>  .../devicetree/bindings/display/panel/ilitek,ili9341.yaml     | 1 -
>  .../devicetree/bindings/display/panel/orisetech,otm8009a.yaml | 1 -
>  .../bindings/display/sprd/sprd,display-subsystem.yaml         | 1 -
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml  | 1 -
>  Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml    | 1 -
>  Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml      | 1 -
>  Documentation/devicetree/bindings/gpu/samsung-rotator.yaml    | 1 -
>  Documentation/devicetree/bindings/hwmon/adt7475.yaml          | 1 -
>  Documentation/devicetree/bindings/i2c/i2c-gate.yaml           | 1 -
>  Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.yaml      | 1 -
>  Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml     | 1 -
>  Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml   | 2 +-
>  Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml   | 1 -
>  .../devicetree/bindings/leds/backlight/qcom-wled.yaml         | 2 +-
>  .../devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml   | 1 -
>  Documentation/devicetree/bindings/media/microchip,xisc.yaml   | 1 -
>  Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml   | 1 -
>  .../devicetree/bindings/net/wireless/qcom,ath11k.yaml         | 2 +-
>  .../devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml     | 1 -
>  .../devicetree/bindings/power/supply/cw2015_battery.yaml      | 1 -
>  .../devicetree/bindings/power/supply/power-supply.yaml        | 1 -
>  Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml | 1 -
>  .../devicetree/bindings/power/supply/tps65217-charger.yaml    | 2 +-
>  .../bindings/regulator/socionext,uniphier-regulator.yaml      | 1 -
>  .../devicetree/bindings/regulator/st,stm32-vrefbuf.yaml       | 1 -
>  .../devicetree/bindings/reserved-memory/ramoops.yaml          | 1 -
>  Documentation/devicetree/bindings/reset/microchip,rst.yaml    | 1 -
>  Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml   | 1 -
>  Documentation/devicetree/bindings/serial/sprd-uart.yaml       | 2 +-
>  .../devicetree/bindings/soc/amlogic/amlogic,canvas.yaml       | 1 -
>  Documentation/devicetree/bindings/sound/adi,adau1372.yaml     | 1 -
>  .../devicetree/bindings/sound/amlogic,gx-sound-card.yaml      | 1 -
>  Documentation/devicetree/bindings/sound/maxim,max98520.yaml   | 1 -
>  Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml     | 2 +-
>  Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml     | 2 +-
>  .../devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml  | 1 -
>  .../devicetree/bindings/sound/samsung,aries-wm8994.yaml       | 1 -
>  Documentation/devicetree/bindings/sound/samsung,odroid.yaml   | 1 -
>  Documentation/devicetree/bindings/sound/tas2562.yaml          | 1 -
>  Documentation/devicetree/bindings/sound/tas2770.yaml          | 1 -
>  .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml       | 1 -
>  .../devicetree/bindings/spi/amlogic,meson6-spifc.yaml         | 1 -
>  Documentation/devicetree/bindings/spi/renesas,hspi.yaml       | 1 -
>  Documentation/devicetree/bindings/usb/dwc2.yaml               | 4 ++--
>  Documentation/devicetree/bindings/usb/smsc,usb3503.yaml       | 2 +-
>  52 files changed, 10 insertions(+), 53 deletions(-)
> 

Applied, thanks!
