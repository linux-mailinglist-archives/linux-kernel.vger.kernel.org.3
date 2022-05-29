Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9635370CE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiE2LiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiE2LiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:38:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812AB532E7
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:38:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y13so16199462eje.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RwKdhYbd7Up094DfFkqVUFbN5sVvLVP8wB5zTMbiHtg=;
        b=qLhQwI7eVUSTCEREfwjTcC3WtB+jsRCl3F/107SfXKkvRAjV5DopBZy2icKLDiv0/P
         kzDLQvG7oHG8aLiZqzN+XkT01OXEnF7V9UfZniD4O9few1SMOf7zYtN9xsJT2U1+UP7n
         FJdQCn8afb7E4+t1vqvb5d2dVYMmKICLnqSeAQBMcvfG5Frv0uCDeO60d4uF5XKikuga
         OzakFqEVWOZcyHjvzGZW/jXCe2FVmoBVEZm6lHPmL8bQKcxiSZYgCcWzSAtOa5DlbA/D
         OptHo7mv3k+IfLJHTXpHYEGGSZTLmPr/MBknAX4inApcVmpLzAJpMjCb25uFfrbs17+y
         efrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RwKdhYbd7Up094DfFkqVUFbN5sVvLVP8wB5zTMbiHtg=;
        b=TyrkYHtvXcBfSfhRvUJA2S8N6lvGgyXwcxKGmc54Xq7gcB7ggbTbDEypbjrBXnU8OV
         gQJWh8ja+Awt9r3OvrdPIxy4AOA5aVVWS/j5ftQ+8auSnaV2FoAyNxJbcYUcnSed+rNw
         Dvgpqj6p1RUCHAc3gQu/0TNhTW6W8soALRf9Da9LbZdHLot3nszpvcGh1T+yZZLpC26j
         7Zbq/7zmHVCzyqjYh4EZlWmgE905nRwlxubg8YRyVP8IwDn7XO3dcLWS54yPgJGU98uS
         X6mEBwmvVWRV1DPEfrg4+ZdCy9e5QRKquZBX0hN7eVN2xlJhvi+HPM8vlWe1XBI6j1tU
         6fGg==
X-Gm-Message-State: AOAM533i6Nj0b1pURcx1zZdTQ807tKlgmGhVoH2q7WyV9cJWEfvfgGPh
        vO1GDMW0gOE8UXJXN87NiXQd/w==
X-Google-Smtp-Source: ABdhPJw7UadcB4edQgPLez21i29gjHElx2z0mV3AENt0nrJMrcxU+BQLUgDW9fXMttdkXW+On4OpOw==
X-Received: by 2002:a17:906:4fd1:b0:6f3:be23:7ad5 with SMTP id i17-20020a1709064fd100b006f3be237ad5mr45065389ejw.264.1653824280073;
        Sun, 29 May 2022 04:38:00 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906844600b006fee13caaeasm3060837ejy.190.2022.05.29.04.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 04:37:59 -0700 (PDT)
Message-ID: <8878f52b-7527-ece2-47d6-5b567ce301ad@linaro.org>
Date:   Sun, 29 May 2022 13:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/3] dt-bindings: uwb: Device tree information for Nxp
 SR1XX SOCs
Content-Language: en-US
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, ashish.deshpande@nxp.com,
        rvmanjumce@gmail.com
References: <20220527184351.3829543-1-manjunatha.venkatesh@nxp.com>
 <20220527184351.3829543-2-manjunatha.venkatesh@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220527184351.3829543-2-manjunatha.venkatesh@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2022 20:43, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol.
> 
> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 
> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> Interface (UCI).  The corresponding details are available in the FiRa
> Consortium Website (https://www.firaconsortium.org/).
> 
> Message-ID: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>

This is a confusing tag... Why do you need it and what does it mean in
Linux kernel process?

> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---
>  .../bindings/uwb/nxp,uwb-sr1xx.yaml           | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml b/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> new file mode 100644
> index 000000000000..226fec908968
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/uwb/nxp,uwb-sr1xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ultra Wide Band(UWB)driver support for NXP SR1XX SOCs family

No references to driver. Please describe here the title of the hardware.

> +
> +maintainers:
> +  - Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> +
> +description: The sr1xx driver work for the NXP SR1XX Family of Ultra Wide
> +    Band Subsystem(UWBS), and uses UWB Controller Interface(UCI).
> +    The corresponding details are available in the FiRa Consortium Website
> +    (https://www.firaconsortium.org/).More details on the SR1XX Family can be
> +    found at https://www.nxp.com/products/:UWB-TRIMENSION

The same. Additionally use proper white-spaces. Before every '('. After
every '.'.

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - nxp,sr1xx
> +
> +      - const: nxp,sr1xx

This is wrong and does not make any sense. You also did not test the
bindings.

Please test them before submitting. No need to waste reviewers time for
basic automation tasks.

Also do not include any wildcards (1xx) but specific model name.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi2: spi@ffd68000 {

No need for alias.

> +		compatible = "arm,pl022", "arm,primecell";
> +		reg = <0x0 0xffd68000 0x0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&crg_ctrl HI3660_CLK_GATE_SPI2>;
> +		clock-names = "apb_pclk";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spi2_pmx_func &spi2_cfg_func>;
> +		num-cs = <1>;
> +		cs-gpios = <&gpio27 2 0>;
> +		status = "ok";

No point of enabling this.

> +	sr1xx@0 {

The indentation and look of it is unacceptable...

> +	 compatible = "nxp,sr1xx";
> +	 reg = <0>;
> +	 nxp,sr1xx-irq = <&gpio26 1 0>;
> +	 nxp,sr1xx-ce = <&gpio2 5 0>;
> +	 nxp,sr1xx-ri = <&gpio24 1 0>;
> +	 spi-max-frequency = <20000000>;
> +	};
> +    };
> +
> +...


Best regards,
Krzysztof
