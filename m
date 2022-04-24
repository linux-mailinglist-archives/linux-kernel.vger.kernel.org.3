Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B86650CE1E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 02:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbiDXAVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 20:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbiDXAVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 20:21:50 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600741B5D43;
        Sat, 23 Apr 2022 17:18:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 889C65C0148;
        Sat, 23 Apr 2022 20:18:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 23 Apr 2022 20:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650759528; x=
        1650845928; bh=5Mw28BcCAs1ec03+wJe1J27sj9VeRk1IJNDibW8ks4M=; b=D
        qrgUrVg8rDZAwBEFfTipDZmPVH2BkMwnwTGgaU0bgzFGN0B/AiK1gHbC8NV12+4l
        HiSu0hyw+Rr3CJHUerVWAtMkeGyxYPheG80kjzb8QsqGvn5Wd3dbmrYv0xKoVyCG
        aCjXuwmXmOPkkkOdysL0+t9VqA3ZHXiU0CziF3FihobniTJ/pKOhDbH1WeU3bYNl
        X9/OWV5jX1N6IHjOKIx1tAOy1VxgHrnYaY8pBTSuHUAlaBjOqmYRWvu3scixxvEB
        6bj4EARM+qigHAJHhuwuNRjpjHeBuyvQm5NHwf6g3Jqxh1RzvQSwo9H6mbF2wm77
        uzAlpwSWvrZhRIbSFmZmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650759528; x=1650845928; bh=5Mw28BcCAs1ec
        03+wJe1J27sj9VeRk1IJNDibW8ks4M=; b=sLMW7aaT5ZA2/WtxELiANJZFgI74b
        ddeOGyM17eejT5VCxN1IPTqSdq/b9Nw9hVxdS5G+LBA9MX+1woBiyX1mIemIf1vL
        xjNeYMZQdLJlFB/U/L2JqwbLNdpbpdDbrwQC/P89c002Y+Qf0eYEbnH8+mub+Go4
        DIYX28bOn1RBBbogRN+ilRaZjbhPUyoX5aiw68s9pz6zHEYR/ECLqW+CoYiZlGA/
        l58MEuopJep2xIKTzJpaF+wE6x/QWHSRyVpA0sUTo/K3VGDC/tl9WdUITtqbO8xV
        IfjjCQTCXZEMNbRbe2scoi5TJ+LesmdLX7KVYCR6r879gOkkQmIZlhqVQ==
X-ME-Sender: <xms:Z5dkYisdCik2oVwunQCjV5z78XW4vsSsxoNEyMCSdIl6W72pp-uo8A>
    <xme:Z5dkYncpHQV81SUSeBT-Tj9319D0wcyQZGgTLd37hX9sFbq0FbKEKXAUhvPe8xlbc
    D1N5N5jKs9uG2kTng>
X-ME-Received: <xmr:Z5dkYtzpv8MjNyZIcsZLf9Etq4704evXUf93L1aSCu3U0bW-5ux27ksRjekwxk_5boAzh7AShXfyNzvgL997Us85JDoQCG77A9Tgc9mA2ytGrKFeB0aqBnXLHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdejgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:aJdkYtOmhWiLYJD2AzU_sPEaSIfH3ZGwwFCef3YKNpFhIcfrtqyoTQ>
    <xmx:aJdkYi9ekZVwNluQGrCKwdQQ8NYfopfOyN4LxoW2_DzbKMzhLqrobg>
    <xmx:aJdkYlXwvV9ALzJsoN17uOmjkfv6B43Jg7KciEqksITqlWoespNgZg>
    <xmx:aJdkYj3aV_ptBOQH3WPVi6GE_KXc5qY6fuv_9yAgPzrP7A6cL64Z0w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 20:18:46 -0400 (EDT)
Subject: Re: [PATCH 05/12] dt-bindings: clock: sunxi-ng: add bindings for R329
 CCUs
To:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <BYAPR20MB2472A5F7269F56C2C6BB3104BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0cb56abd-9f4a-24ec-7b6e-71ac56ee53db@sholland.org>
Date:   Sat, 23 Apr 2022 19:18:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB2472A5F7269F56C2C6BB3104BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:41 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> R329 has a CPUX CCU and a R-CCU, with all PLLs in R-CCU.
> 
> Add bindings for them, with R-CCU only taking 3 oscillators as input and
> main CCU taking oscillators + PLLs as input.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../clock/allwinner,sun4i-a10-ccu.yaml        | 62 ++++++++++++++--
>  include/dt-bindings/clock/sun50i-r329-ccu.h   | 73 +++++++++++++++++++
>  include/dt-bindings/clock/sun50i-r329-r-ccu.h | 45 ++++++++++++
>  include/dt-bindings/reset/sun50i-r329-ccu.h   | 45 ++++++++++++
>  include/dt-bindings/reset/sun50i-r329-r-ccu.h | 24 ++++++
>  5 files changed, 241 insertions(+), 8 deletions(-)
>  create mode 100644 include/dt-bindings/clock/sun50i-r329-ccu.h
>  create mode 100644 include/dt-bindings/clock/sun50i-r329-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-r329-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-r329-r-ccu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
> index 15ed64d35261..c7a429e55483 100644
> --- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
> +++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
> @@ -45,6 +45,8 @@ properties:
>        - allwinner,sun50i-h6-r-ccu
>        - allwinner,sun50i-h616-ccu
>        - allwinner,sun50i-h616-r-ccu
> +      - allwinner,sun50i-r329-ccu
> +      - allwinner,sun50i-r329-r-ccu
>        - allwinner,suniv-f1c100s-ccu
>        - nextthing,gr8-ccu
>  
> @@ -106,6 +108,7 @@ else:
>            - allwinner,sun50i-a100-ccu
>            - allwinner,sun50i-h6-ccu
>            - allwinner,sun50i-h616-ccu
> +          - allwinner,sun50i-r329-r-ccu
>  
>    then:
>      properties:
> @@ -118,14 +121,57 @@ else:
>          maxItems: 3
>  
>    else:
> -    properties:
> -      clocks:
> -        minItems: 2
> -        maxItems: 2
> -
> -      clock-names:
> -        minItems: 2
> -        maxItems: 2
> +    if:
> +      properties:
> +        compatible:
> +          const: allwinner,sun50i-r329-ccu
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 13
> +          maxItems: 13

The conditional part of the binding can only be more restrictive than the main
binding. So you need to increase maxItems above.

Also, I believe minItems/maxItems in this section is not needed when specifying
a list of items.

> +          items:
> +            - description: High Frequency Oscillator (usually at 24MHz)
> +            - description: Low Frequency Oscillator (usually at 32kHz)
> +            - description: Internal Oscillator
> +            - description: CPUX PLL
> +            - description: Peripherals PLL
> +            - description: Peripherals PLL (2x)
> +            - description: Peripherals PLL derivated 800MHz clock
> +            - description: Audio PLL 0
> +            - description: Audio PLL 0 (/2)
> +            - description: Audio PLL 0 (/5)
> +            - description: Audio PLL 1
> +            - description: Audio PLL 1 (2x)
> +            - description: Audio PLL 1 (4x)
> +
> +        clock-names:
> +          minItems: 13
> +          maxItems: 13
> +          items:
> +            - const: hosc
> +            - const: losc
> +            - const: iosc
> +            - const: pll-cpux
> +            - const: pll-periph
> +            - const: pll-periph-2x
> +            - const: pll-periph-800m
> +            - const: pll-audio0
> +            - const: pll-audio0-div2
> +            - const: pll-audio0-div5
> +            - const: pll-audio1
> +            - const: pll-audio1-2x
> +            - const: pll-audio1-4x
> +
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +
> +        clock-names:
> +          minItems: 2
> +          maxItems: 2
>  
>  additionalProperties: false
>  
> diff --git a/include/dt-bindings/clock/sun50i-r329-ccu.h b/include/dt-bindings/clock/sun50i-r329-ccu.h
> new file mode 100644
> index 000000000000..116f8d13a9b3
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun50i-r329-ccu.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 Sipeed
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_SUN50I_R329_CCU_H_
> +#define _DT_BINDINGS_CLK_SUN50I_R329_CCU_H_
> +
> +#define CLK_CPUX		1
> +
> +#define CLK_APB1		5
> +
> +#define CLK_CE			7
> +#define CLK_BUS_CE		8
> +#define CLK_AIPU		9
> +#define CLK_BUS_AIPU		10
> +#define CLK_BUS_DMA		11
> +#define CLK_BUS_MSGBOX		12
> +#define CLK_BUS_SPINLOCK	13
> +#define CLK_BUS_HSTIMER		14
> +#define CLK_AVS			15
> +#define CLK_BUS_DBG		16
> +#define CLK_BUS_PWM		17
> +
> +#define CLK_MBUS_DMA		19
> +#define CLK_MBUS_CE		20
> +#define CLK_MBUS_R_DMA		21
> +#define CLK_MBUS_NAND		22
> +#define CLK_MBUS_AIPU		23
> +
> +#define CLK_NAND0		25
> +#define CLK_NAND1		26
> +#define CLK_BUS_NAND		27
> +#define CLK_MMC0		28
> +#define CLK_MMC1		29
> +#define CLK_BUS_MMC0		30
> +#define CLK_BUS_MMC1		31
> +#define CLK_BUS_UART0		32
> +#define CLK_BUS_UART1		33
> +#define CLK_BUS_UART2		34
> +#define CLK_BUS_UART3		35
> +#define CLK_BUS_I2C0		36
> +#define CLK_BUS_I2C1		37
> +#define CLK_BUS_SCR		38
> +#define CLK_SPI0		39
> +#define CLK_SPI1		40
> +#define CLK_BUS_SPI0		41
> +#define CLK_BUS_SPI1		42
> +#define CLK_EMAC_25M_DIV	43
> +#define CLK_EMAC_25M		44
> +#define CLK_BUS_EMAC		45
> +#define CLK_IR_RX		46
> +#define CLK_BUS_IR_RX		47
> +#define CLK_IR_TX		48
> +#define CLK_BUS_IR_TX		49
> +#define CLK_I2S0		50
> +#define CLK_I2S1		51
> +#define CLK_BUS_I2S0		52
> +#define CLK_BUS_I2S1		53
> +#define CLK_SPDIF		54
> +#define CLK_BUS_SPDIF		55
> +#define CLK_USB_OHCI0		56
> +#define CLK_USB_PHY0		57
> +#define CLK_USB_OHCI1		58
> +#define CLK_USB_PHY1		59
> +#define CLK_BUS_OHCI0		60
> +#define CLK_BUS_OHCI1		61
> +#define CLK_BUS_EHCI0		62
> +#define CLK_BUS_OTG		63
> +#define CLK_LEDC		64
> +#define CLK_BUS_LEDC		65
> +
> +#endif /* _DT_BINDINGS_CLK_SUN50I_R329_CCU_H_ */
> diff --git a/include/dt-bindings/clock/sun50i-r329-r-ccu.h b/include/dt-bindings/clock/sun50i-r329-r-ccu.h
> new file mode 100644
> index 000000000000..c327d1a1b602
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun50i-r329-r-ccu.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 Sipeed
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_SUN50I_R329_R_CCU_H_
> +#define _DT_BINDINGS_CLK_SUN50I_R329_R_CCU_H_
> +
> +#define CLK_PLL_CPUX		0
> +#define CLK_PLL_PERIPH_2X	2
> +#define CLK_PLL_PERIPH_800M	3
> +#define CLK_PLL_PERIPH		4
> +#define CLK_PLL_AUDIO0		5
> +#define CLK_PLL_AUDIO0_DIV2	6
> +#define CLK_PLL_AUDIO0_DIV5	7
> +#define CLK_PLL_AUDIO1_4X	8
> +#define CLK_PLL_AUDIO1_2X	9
> +#define CLK_PLL_AUDIO1		10
> +
> +#define CLK_R_AHB		11
> +#define CLK_R_APB1		12
> +
> +#define CLK_R_BUS_GPADC		14

These are a bit backward. For example, this is the bus clock for the R_GPADC
peripheral. So I would recommend s/R_BUS/BUS_R/ here and for the resets. At
least that's what I did for D1.

Regards,
Samuel

> +#define CLK_R_BUS_THS		15
> +#define CLK_R_BUS_DMA		16
> +#define CLK_R_PWM		17
> +#define CLK_R_BUS_PWM		18
> +#define CLK_R_CODEC_ADC		19
> +#define CLK_R_CODEC_DAC		20
> +#define CLK_R_BUS_CODEC		21
> +#define CLK_R_DMIC		22
> +#define CLK_R_BUS_DMIC		23
> +#define CLK_R_BUS_LRADC		24
> +#define CLK_R_I2S		25
> +#define CLK_R_I2S_ASRC		26
> +#define CLK_R_BUS_I2S		27
> +#define CLK_R_BUS_UART		28
> +#define CLK_R_BUS_I2C		29
> +#define CLK_R_IR		30
> +#define CLK_R_BUS_IR		31
> +#define CLK_R_BUS_MSGBOX	32
> +#define CLK_R_BUS_SPINLOCK	33
> +#define CLK_R_BUS_RTC		34
> +
> +#endif /* _DT_BINDINGS_CLK_SUN50I_R329_R_CCU_H_ */
> diff --git a/include/dt-bindings/reset/sun50i-r329-ccu.h b/include/dt-bindings/reset/sun50i-r329-ccu.h
> new file mode 100644
> index 000000000000..bb704a82443f
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun50i-r329-ccu.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> +/*
> + * Copyright (c) 2021 Sipeed
> + */
> +
> +#ifndef _DT_BINDINGS_RST_SUN50I_R329_CCU_H_
> +#define _DT_BINDINGS_RST_SUN50I_R329_CCU_H_
> +
> +#define RST_MBUS		0
> +#define RST_BUS_CE		1
> +#define RST_BUS_AIPU		2
> +#define RST_BUS_DMA		3
> +#define RST_BUS_MSGBOX		4
> +#define RST_BUS_SPINLOCK	5
> +#define RST_BUS_HSTIMER		6
> +#define RST_BUS_DBG		7
> +#define RST_BUS_PWM		8
> +#define RST_BUS_DRAM		9
> +#define RST_BUS_NAND		10
> +#define RST_BUS_MMC0		11
> +#define RST_BUS_MMC1		12
> +#define RST_BUS_UART0		13
> +#define RST_BUS_UART1		14
> +#define RST_BUS_UART2		15
> +#define RST_BUS_UART3		16
> +#define RST_BUS_I2C0		17
> +#define RST_BUS_I2C1		18
> +#define RST_BUS_SCR		19
> +#define RST_BUS_SPI0		20
> +#define RST_BUS_SPI1		21
> +#define RST_BUS_EMAC		22
> +#define RST_BUS_IR_RX		23
> +#define RST_BUS_IR_TX		24
> +#define RST_BUS_I2S0		25
> +#define RST_BUS_I2S1		26
> +#define RST_BUS_SPDIF		27
> +#define RST_USB_PHY0		28
> +#define RST_USB_PHY1		29
> +#define RST_BUS_OHCI0		30
> +#define RST_BUS_OHCI1		31
> +#define RST_BUS_EHCI0		32
> +#define RST_BUS_OTG		33
> +#define RST_BUS_LEDC		34
> +
> +#endif /* _DT_BINDINGS_RST_SUN50I_R329_CCU_H_ */
> diff --git a/include/dt-bindings/reset/sun50i-r329-r-ccu.h b/include/dt-bindings/reset/sun50i-r329-r-ccu.h
> new file mode 100644
> index 000000000000..40644f2f21c6
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun50i-r329-r-ccu.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> +/*
> + * Copyright (c) 2021 Sipeed
> + */
> +
> +#ifndef _DT_BINDINGS_RST_SUN50I_R329_R_CCU_H_
> +#define _DT_BINDINGS_RST_SUN50I_R329_R_CCU_H_
> +
> +#define RST_R_BUS_GPADC		0
> +#define RST_R_BUS_THS		1
> +#define RST_R_BUS_DMA		2
> +#define RST_R_BUS_PWM		3
> +#define RST_R_BUS_CODEC		4
> +#define RST_R_BUS_DMIC		5
> +#define RST_R_BUS_LRADC		6
> +#define RST_R_BUS_I2S		7
> +#define RST_R_BUS_UART		8
> +#define RST_R_BUS_I2C		9
> +#define RST_R_BUS_IR		10
> +#define RST_R_BUS_MSGBOX	11
> +#define RST_R_BUS_SPINLOCK	12
> +#define RST_R_BUS_RTC		13
> +
> +#endif /* _DT_BINDINGS_RST_SUN50I_R329_R_CCU_H_ */
> 

