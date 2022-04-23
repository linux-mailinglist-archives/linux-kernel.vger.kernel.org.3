Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2682250C900
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiDWKEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiDWKEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:04:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDD616664B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:01:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y20so20693147eju.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yMGG+zyUqngKlUh1IoJ7uZEj7Hkk7vR8Bqm6uTHC9YY=;
        b=VdkCVDZAvN4RNtsDNBvJD/u8yxTwvhngmT9LXS+yNnFusdRs16u4cjFr5irHyvFgHq
         L87iry65Vj5kDYAKmCA4+vXu2x/ay6/vVainiECGOlcKz9yxcgB5wOt1kjp6RJxVQzSS
         SSJL0/pP6MefV2saz6nmmICtwBRiuiUm/ekZvTOZdMVVFv7R/0FbSM7pK1VHGZu4nVYr
         x6Xajdhm478/6h5MzyjfAsM2wPjrZ3iDjqortIKw39EUo2EK/CUZvcb0jqUXfB4Lyh/4
         N6gelxgv+CoNoOfcH8ILrAgc4408xOOgrL6sE/44IPl6qa1/NxdBsxUhS75l8PrHYF67
         po7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yMGG+zyUqngKlUh1IoJ7uZEj7Hkk7vR8Bqm6uTHC9YY=;
        b=UmaDkMYn1ZpzI+mSwVX+RahQMaKgSKdChNoZ4lXLU5drDhRNMwMnG02Q0r5+oBFyIO
         JL27exu6gYfjxCq9buZHdHMQozFALIQ8ch9fQ6Vjp/u7yqANo2iE1XszHwkLvSD+H6Xj
         l24AhtCjXT7fcCkESmzRBiecJpE9IaHfZUDtJYxZBIcU17IBtFY3C5aSwQHBs6Rl1JwC
         x0LYnGQHYtjbFHuKWt9SJUyuwJ4VU6fbA0964gWeSdp+NmpH9o9T7dIFeyrmz1PraAnZ
         1lgns55GP0VqUbXa2E7ja43+xCT8/IS+y6mytHdrfxPii+F7TcAuz9t3sjF4wnSeSZjP
         GfDQ==
X-Gm-Message-State: AOAM532VO6NGC8Rt6y+kz2959bvaI6wI/0cywCz7PYXkTv4B+vi5R4le
        56mJIC017j5IvDDkGrHQc8cjzw==
X-Google-Smtp-Source: ABdhPJzHcV7ul2x/Jmn2zCbAwdMzU3MG3+f/janVAUgWm+zXoVg8O3JiRyXSQtQT+AfHfvQ05S+tOA==
X-Received: by 2002:a17:907:7ea6:b0:6ef:f384:15b4 with SMTP id qb38-20020a1709077ea600b006eff38415b4mr8091838ejc.91.1650708076601;
        Sat, 23 Apr 2022 03:01:16 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640204d000b0042062f9f0e1sm1963756edw.15.2022.04.23.03.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:01:16 -0700 (PDT)
Message-ID: <67a03d14-7d83-2aec-ee60-82b142450512@linaro.org>
Date:   Sat, 23 Apr 2022 12:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv1 01/19] dt-binding: clock: Document rockchip,rk3588-cru
 bindings
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Elaine Zhang <zhangqing@rock-chips.com>, kernel@collabora.com
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-2-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422170920.401914-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 19:09, Sebastian Reichel wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> Document the device tree bindings of the rockchip Rk3588 SoC
> clock driver.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/clock/rockchip,rk3588-cru.yaml   | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml
> new file mode 100644
> index 000000000000..dec2ae8c7970
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3588-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROCKCHIP rk3588 Family Clock Control Module Binding

s/ROCKCHIP/Rockchip/
(that's the most common name used here and also on company website)

s/Binding//

> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  The RK3588 clock controller generates the clock and also implements a
> +  reset controller for SoC peripherals.
> +  (examples: provide SCLK_UART2\PCLK_UART2 and SRST_P_UART2\SRST_S_UART2 for UART module)
> +  Each clock is assigned an identifier and client nodes can use this identifier
> +  to specify the clock which they consume. All available clocks are defined as
> +  preprocessor macros in the dt-bindings/clock/rk3588-cru.h headers and can be
> +  used in device tree sources.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3588-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  clocks: true

Need to define how many and what clocks are coming here.

> +
> +  assigned-clocks:
> +    minItems: 1
> +
> +  assigned-clock-parents:
> +    minItems: 1
> +
> +  assigned-clock-rates:
> +    minItems: 1

You normally don't need these in the bindings, they come from the schema.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    cru: clock-controller@fd7c0000 {
> +      compatible = "rockchip,rk3588-cru";
> +      reg = <0xfd7c0000 0x5c000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };


Best regards,
Krzysztof
