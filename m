Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0B4EBB89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbiC3HOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243706AbiC3HO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:14:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B342B15AAF5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:12:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qa43so39571446ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5ug0Vb3n/y1kMz7s7i3LwK9TDhCTMMMovBQ50l01MHg=;
        b=atzlgvzvihkz9xDD+XoJpzmbD9wjky+0js/tcXak7y6EwOAw5ALVhRjF22BSYXIw8D
         u3L2YlB9BDgnkqmv1qW73BbVLyB0DE5MrSq/RFLlx9f18JSi8OqigESvvSVavkvfjzV1
         ocppm0wraVtHB979mqPPIh1Gre3jhpLOxt6eRJtl2sU4DvwVr6ECj1nui6nsRgvrswVv
         EJKI4V9v1XUUdooT9WtzBXT5ld5TC2bD7sDwPLDTW4Ai7Jf4QMZ86W3I4xCOMFaZ0d4u
         A69qY6XqZeaMSvc7nL4uzUqAbmLEcNHslJbNxhEv9QaqW5kERqwUGoEmHrFb4q8VA4Le
         eDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5ug0Vb3n/y1kMz7s7i3LwK9TDhCTMMMovBQ50l01MHg=;
        b=0R6oNGYONk75tMp6bYJwDQVBdMEk4niEMJ1OreWSQrmDE2ZoJRry3dchA86srSK7ge
         MXfsX9X2Oh7+/3K3DQ+lr2QHhuajx8+8TrCWd7qF3DmPzysmguZPfKD1afWfun9zeNlT
         bmnyljfhOhJE8qsorereAeo3yvDoqHYybro53b+1ajz7YTc3DTGEVX+Z19IdNkvWI+1Q
         h30CTYW7UMu/sQ/Z9xERpunJY+DzL4lpXP44LEgKi5bt6gg8TFhmCQ8r/X+XlN4PFPJ6
         zKvlD1ESXVMGKFLxKy6Nx1u0QxpuuXtXas+9H0JwJeLa3liTXswlFlXGjjtEfaiNNY17
         TSIA==
X-Gm-Message-State: AOAM532krcy0+yE489g2cyjMv4dYpuyBod1INBl7tsC7vcndmjrnk6yS
        ayHSC57iXxwhGL/Nph1jYWWKbA==
X-Google-Smtp-Source: ABdhPJxpMBRA7Iu+FkwPspTUBMkW5jdmZ4XJutw6rxD5PFu1SoJKSrXDDCjRaWv86N+ZQBZmm7xWzQ==
X-Received: by 2002:a17:906:5cb:b0:6cf:954:d84d with SMTP id t11-20020a17090605cb00b006cf0954d84dmr38804313ejt.560.1648624361193;
        Wed, 30 Mar 2022 00:12:41 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f17-20020a056402355100b0041925e80963sm9658657edd.41.2022.03.30.00.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 00:12:40 -0700 (PDT)
Message-ID: <63ad0846-8acd-1a9e-c625-9af3b073646c@linaro.org>
Date:   Wed, 30 Mar 2022 09:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,px30-cru.txt to
 YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329195057.15571-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329195057.15571-1-jbx6244@gmail.com>
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

On 29/03/2022 21:50, Johan Jonker wrote:
> Convert rockchip,px30-cru.txt to YAML.
> 
> Changes against original bindings:
>   Use compatible string: "rockchip,px30-pmucru"
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/clock/rockchip,px30-cru.txt      | 70 --------------
>  .../bindings/clock/rockchip,px30-cru.yaml     | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 70 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
> deleted file mode 100644
> index 55e78cdde..000000000
> --- a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -* Rockchip PX30 Clock and Reset Unit
> -
> -The PX30 clock controller generates and supplies clock to various
> -controllers within the SoC and also implements a reset controller for SoC
> -peripherals.
> -
> -Required Properties:
> -
> -- compatible: PMU for CRU should be "rockchip,px30-pmu-cru"
> -- compatible: CRU should be "rockchip,px30-cru"
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -- clocks: A list of phandle + clock-specifier pairs for the clocks listed
> -          in clock-names
> -- clock-names: Should contain the following:
> -  - "xin24m" for both PMUCRU and CRU
> -  - "gpll" for CRU (sourced from PMUCRU)
> -- #clock-cells: should be 1.
> -- #reset-cells: should be 1.
> -
> -Optional Properties:
> -
> -- rockchip,grf: phandle to the syscon managing the "general register files"
> -  If missing, pll rates are not changeable, due to the missing pll lock status.
> -
> -Each clock is assigned an identifier and client nodes can use this identifier
> -to specify the clock which they consume. All available clocks are defined as
> -preprocessor macros in the dt-bindings/clock/px30-cru.h headers and can be
> -used in device tree sources. Similar macros exist for the reset sources in
> -these files.
> -
> -External clocks:
> -
> -There are several clocks that are generated outside the SoC. It is expected
> -that they are defined using standard clock bindings with following
> -clock-output-names:
> - - "xin24m" - crystal input - required,
> - - "xin32k" - rtc clock - optional,
> - - "i2sx_clkin" - external I2S clock - optional,
> - - "gmac_clkin" - external GMAC clock - optional
> -
> -Example: Clock controller node:
> -
> -	pmucru: clock-controller@ff2bc000 {
> -		compatible = "rockchip,px30-pmucru";
> -		reg = <0x0 0xff2bc000 0x0 0x1000>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -	};
> -
> -	cru: clock-controller@ff2b0000 {
> -		compatible = "rockchip,px30-cru";
> -		reg = <0x0 0xff2b0000 0x0 0x1000>;
> -		rockchip,grf = <&grf>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -	};
> -
> -Example: UART controller node that consumes the clock generated by the clock
> -  controller:
> -
> -	uart0: serial@ff030000 {
> -		compatible = "rockchip,px30-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xff030000 0x0 0x100>;
> -		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&pmucru SCLK_UART0_PMU>, <&pmucru PCLK_UART0_PMU>;
> -		clock-names = "baudclk", "apb_pclk";
> -		reg-shift = <2>;
> -		reg-io-width = <4>;
> -	};
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
> new file mode 100644
> index 000000000..aa095f375
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,px30-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip PX30 Clock and Reset Unit (CRU)
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  The PX30 clock controller generates and supplies clocks to various
> +  controllers within the SoC and also implements a reset controller for SoC
> +  peripherals.
> +  Each clock is assigned an identifier and client nodes can use this identifier
> +  to specify the clock which they consume. All available clocks are defined as
> +  preprocessor macros in the dt-bindings/clock/px30-cru.h headers and can be
> +  used in device tree sources. Similar macros exist for the reset sources in
> +  these files.
> +  There are several clocks that are generated outside the SoC. It is expected
> +  that they are defined using standard clock bindings with following
> +  clock-output-names:
> +    - "xin24m"     - crystal input       - required
> +    - "xin32k"     - rtc clock           - optional
> +    - "i2sx_clkin" - external I2S clock  - optional
> +    - "gmac_clkin" - external GMAC clock - optional
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,px30-cru
> +      - rockchip,px30-pmucru
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
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: Clock for both PMUCRU and CRU
> +      - description: Clock for CRU (sourced from PMUCRU)
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: xin24m
> +      - const: gpll

You need allOf:if:then: constraining clocks and clock-names per compatible.


Best regards,
Krzysztof
