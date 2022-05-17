Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD135295B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350541AbiEQACL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347394AbiEQAB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:01:58 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E216240A08;
        Mon, 16 May 2022 17:01:55 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id w123so20590886oiw.5;
        Mon, 16 May 2022 17:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hk36ziFXO9TalU4BGZkjhExbMm1QNoPw9Ie36IVTwNw=;
        b=2LEK5KD8Kr9QztMwl7tFNasiJ1pwFBWvN9a/FQeOVv3g4ic/CTF76yUDXA8fS8QKNU
         Y7vxbxGFokY6cnm23iLBsRV7CGGT8F2FZDuqdmwtDQX/emD5Sxcf+HZlA+Z1jSmym4sg
         h+QEj34mk46VLE/7UykAGn6eccF4ScVYiFSGOXVZay3ZGpfQi27NTvLgabZpTSPLd2u6
         1Y2BalTKXL7LuL6MWe8vqQQRUYbWVcxE87Rf7dz4XY14+0wj33+ER0pFdb1gmq9kaN/x
         SX8cm0htaaBOEGRx3CH/J6r1670zbC+OiFhXgfGMLGX8tWPoYCf1nnV10u1iVRJpH7tY
         UKFA==
X-Gm-Message-State: AOAM533h/ptK3vHSoIYXYjgjylj8C4Wa21UtAltfrtSLrQ6CZMi9U8G9
        rXv6TCTrFaBWnyaw+5Wl3w==
X-Google-Smtp-Source: ABdhPJxNS1w1V4Tgb8Bfadl7HxB3INT74jHp2qXeUshOlyFbHb2JkvEfkCuZymuaXD8jWIfZcHIUqQ==
X-Received: by 2002:a05:6808:1781:b0:326:d85f:b00d with SMTP id bg1-20020a056808178100b00326d85fb00dmr14638011oib.113.1652745715123;
        Mon, 16 May 2022 17:01:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 97-20020a9d0eea000000b00605da994088sm4420874otj.2.2022.05.16.17.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:01:54 -0700 (PDT)
Received: (nullmailer pid 3601836 invoked by uid 1000);
        Tue, 17 May 2022 00:01:53 -0000
Date:   Mon, 16 May 2022 19:01:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
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
Subject: Re: [PATCHv2 03/21] dt-binding: clock: Document rockchip,rk3588-cru
 bindings
Message-ID: <20220517000153.GA3593598-robh@kernel.org>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
 <20220504213251.264819-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504213251.264819-4-sebastian.reichel@collabora.com>
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

On Wed, May 04, 2022 at 11:32:33PM +0200, Sebastian Reichel wrote:
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
> index 000000000000..6e65ee7b0092
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3588-cru.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3588-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip rk3588 Family Clock Control Module
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
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: >
> +      phandle to the syscon managing the "general register files". It is used
> +      for GRF muxes, if missing any muxes present in the GRF will not be
> +      available.
> +
> +  clocks: true

You have to define how many clocks and what they are.

> +  assigned-clocks: true
> +  assigned-clock-rates: true

You don't need these. They are allowed in any node with 'clocks' or now 
'#clock-cells'.

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
> -- 
> 2.35.1
> 
> 
