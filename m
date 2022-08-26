Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6470C5A2132
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiHZGun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZGuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:50:40 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB10BB031
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:50:38 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by6so690657ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7ucuTjvwcIeRgdHUmyQVPcOH0rtFIB9s92k3HvPl+Lg=;
        b=UYyICR8Kxwxx3N+l7H9vpwbhmxjQgKuED9l4C3BW8de56rIH6/rCSVoGsirsqC/mlY
         HrUIIH136YrjQQs+UW8+I8ekNgXkQSZCQF4jkpaO7nwf98t8ccK4S7wUh9dHlDIR8eve
         UMSCAYrj8MenS4A6DSa5fgg//e/PFeYV6tXhiwRgfQLwWI1gPaITe3lGvI4a/TKiuIj1
         7kfY1ByEIJDuPuNsOGqZWdmgqY2brrV/nGQoHVebnrKB1m5aAB5i65lTaPXnziflxP7D
         bzOrlMOKv8+8alYcPSRsVmz+amuXm6ReASHU/u+5nq7OTJtARrH2ICC/kvxGZWE9LJPL
         rLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7ucuTjvwcIeRgdHUmyQVPcOH0rtFIB9s92k3HvPl+Lg=;
        b=MEF5wM/+fdD9LjXRukzOQA0bXghRMNRaPmcrlOjjztE7dfDxJLqT6Dsv9KIhfMDoOz
         w3cZH50j60VM1ZmQnkPkb53j7YkwYt0wKGf/KGAoSsyVQFcWNL9rkRvsEU9wSPztjkka
         xQGQ1xaGsjpsgJIqUe5ebZPLkKX8KGSmdnjwce/VxNt5J02rx+q+xPtUQEEqA+q7W2Gz
         t+vBGknv4tau+v8/ULP6YWC/p2IC1WUl/wydYRUHGbLglUZCvAvA47rr2+3kgxQt+3i+
         XTmgaiBBNcKOHUEWqR9/b+eR6Nfzd0VFiPvtH/IEoDRCDX9yi/gd624g89vUrf0ku1U+
         pAiQ==
X-Gm-Message-State: ACgBeo00ilSfnsXvjtSDK646347wVdUKCO4f3dT9NS7h1PYyLuWivId4
        Wu0pys13eW1h+l2USb9sex3mgw==
X-Google-Smtp-Source: AA6agR55muQUl0EGQptKMs7t57bYTpy+EF08JVpOQGsnvB+PmIqzUrrBi05Mcf4CLakmC5vokewSKg==
X-Received: by 2002:a2e:54d:0:b0:261:bbfc:23f8 with SMTP id 74-20020a2e054d000000b00261bbfc23f8mr1743546ljf.145.1661496636932;
        Thu, 25 Aug 2022 23:50:36 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id w27-20020ac2443b000000b00492faa68260sm258539lfl.229.2022.08.25.23.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 23:50:36 -0700 (PDT)
Message-ID: <cae915f6-c951-ba97-346d-00922c85067d@linaro.org>
Date:   Fri, 26 Aug 2022 09:50:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 5/5] arm64: dts: rockchip: Add PCIe v3 nodes to
 BPI-R2-Pro
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220825193836.54262-1-linux@fw-web.de>
 <20220825193836.54262-6-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220825193836.54262-6-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 22:38, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add Nodes to Bananapi-R2-Pro board to support PCIe v3 and
> set PCIe related regulators to always on.
> 
> Suggested-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v5:
> - rebase on 6.0-rc1
> - add pinctrl for pcie
> - fix ngff pwr_en_h gpio for hw ref 1.1
> 
> v4:
> - change u8 lane-map to u32 data-lanes
> 
> v3:
> - squash lane-map over bifurcation property
> - add comment which slot is M2 and which one if mPCIe
> - fixes from Peter:
>   - drop regulator-always-on/regulator-boot-on from regulators
>   - increase startup-delay-us for regulators
>   - set phy-mode on PCIe3-phy
>   - add num-lanes to PCIe overrides
>   - add usb node for to PCIe/m2
>   - move lane-map from PCIe controller to PCIe-phy
> 
> v2:
> - underscores in nodenames
> - rockchip,bifurcation to vendor unspecific bifurcation
> - fix trailing space
> ---
>  .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> index 93d383b8be87..40b90c052634 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> @@ -86,6 +86,66 @@ vcc5v0_sys: vcc5v0-sys {
>  		vin-supply = <&dc_12v>;
>  	};
>  
> +	pcie30_avdd0v9: pcie30-avdd0v9 {

Use consistent naming, so if other nodes have "regulator" suffix, use it
here as well.

> +		compatible = "regulator-fixed";
> +		regulator-name = "pcie30_avdd0v9";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	pcie30_avdd1v8: pcie30-avdd1v8 {

Ditto.


> +		compatible = "regulator-fixed";
> +		regulator-name = "pcie30_avdd1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	/* pi6c pcie clock generator feeds both ports */
> +	vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_pcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <200000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +

Best regards,
Krzysztof
