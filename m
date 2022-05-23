Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D139530AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiEWHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiEWHgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:36:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D092175B3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:36:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m6so16185733ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qmrYGzbTeRg5FU7A/ql9JWJcJRbcLIxw9Fcrnsg+ns8=;
        b=Fl7f2PZH8OhJHy8f17bmryFs5fsjlDhnBa3ivK24I6TBCQhc8GhKXVdzxqucVqzfN5
         7A1r5ykV1QXG8c0agNo0C4Ec61YqtR6hLin7VmFsmVrQdn+XrgV6BejklmNbU4BD/cWu
         GGcwMqomyEtuHLfe0hGop+cc+4YKnQiNS02Z8SReHRlLkACfkdEeCvdp+MuRIv4PHe+v
         JZ4S5qYTbyrN5EqdE8Bj0qzrHDa1emDKHD//aLUuB27ncV37GOHPYCINpH3sARw/gNge
         CfNrXB1NH+VGrU+lWyBYoLo1v8z/1XOUTQx+Gb7Iv5JVDDLffDX7aQDC/MQFLB5RrZcQ
         F3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qmrYGzbTeRg5FU7A/ql9JWJcJRbcLIxw9Fcrnsg+ns8=;
        b=l9Z5JJTOpi2sgdRpS9u5wAqM3J5EGS7cUAf9TtiwLa9kdvkyFFrzxUy01pDPYss/PW
         Nd0dDLGEpMryOujx31sSHTGIri7mOpzL2eTr17ulot/LivRWSVbbcHH1zRR8q5fwdAwF
         98YRD5Cv5lTVBoszYND9x92KiLmQxiUwnV18EPoTLHHg5gFGDunwXQ6TeX2tgmCxfjQe
         u8OjROAQjJYtc/Ue2t9B2/PQhT6/WZ4SgPaAzmjU4q+sAKxCgMDCepVZA7uscbwZ1wfH
         fad2DKWp6J9h39bxIujgtaEBsPsGpiNuFZqPHzwvnbpwq6U4e2qdw0VYq/7L5QIYdtLA
         f9zA==
X-Gm-Message-State: AOAM532lfFb5inMmVGd15DlduZ/lkkC1oQXRfXk/4wASc9YNK0kMCWLE
        khQF1ZlE6lyQhkS71JiSW2R3/A==
X-Google-Smtp-Source: ABdhPJz9EPJXuOVRuS5VdPVoeY78CEYAgVvIWJjPvdL+tR38wwBV34jcxYcysL8nx4bNecTwcODNuA==
X-Received: by 2002:a2e:bba2:0:b0:253:cccf:a967 with SMTP id y34-20020a2ebba2000000b00253cccfa967mr12570352lje.298.1653291361632;
        Mon, 23 May 2022 00:36:01 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v19-20020a05651203b300b00477c583e757sm1809868lfp.275.2022.05.23.00.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 00:36:01 -0700 (PDT)
Message-ID: <edf1faf3-178c-bc89-148d-892f41492d26@linaro.org>
Date:   Mon, 23 May 2022 09:35:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 07/19] dt-binding: clk: npcm845: Add binding for
 Nuvoton NPCM8XX Clock
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-8-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-8-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2022 17:50, Tomer Maimon wrote:
> Nuvoton Arbel BMC NPCM7XX contains an integrated clock controller, which
> generates and supplies clocks to all modules within the BMC.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 68 +++++++++++++++++++
>  .../dt-bindings/clock/nuvoton,npcm8xx-clock.h | 50 ++++++++++++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> new file mode 100644
> index 000000000000..f305c7c7eaf0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM8XX Clock Controller Binding
> +
> +maintainers:
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +
> +description: |
> +  Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller, which
> +  generates and supplies clocks to all modules within the BMC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm845-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      specify the external clocks used by the NPCM8XX clock module.

Skip description, it's obvious.

> +    items:
> +      - description: 25M reference clock
> +      - description: CPU reference clock
> +      - description: MC reference clock
> +
> +  clock-names:
> +    description:
> +      specify the external clocks names used by the NPCM8XX clock module.

Skip description, it's obvious.

> +    items:
> +      - const: refclk

Just "ref"

> +      - const: sysbypck
> +      - const: mcbypck

Is "ck" short for "clk"? If yes, then just skip the suffix.

> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See include/dt-bindings/clock/nuvoton,npcm8xx-clock.h for the full
> +      list of NPCM8XX clock IDs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +

No need for blank line.

> +    ahb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clk: clock-controller@f0801000 {
> +            compatible = "nuvoton,npcm845-clk";
> +            reg = <0x0 0xf0801000 0x0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> new file mode 100644
> index 000000000000..d76f606bf88b
> --- /dev/null
> +++ b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h

Filename - same as bindings, so nuvoton,npcm845-clk.h

> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license, same as bindings.

> +/*
> + * Nuvoton NPCM8xx Clock Generator binding
> + * clock binding number for all clocks supportted by nuvoton,npcm8xx-clk
> + *
> + * Copyright (C) 2021 Nuvoton Technologies tomer.maimon@nuvoton.com
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_NPCM8XX_H
> +#define __DT_BINDINGS_CLOCK_NPCM8XX_H
> +
> +#define NPCM8XX_CLK_CPU		0
> +#define NPCM8XX_CLK_GFX_PIXEL	1
> +#define NPCM8XX_CLK_MC		2
> +#define NPCM8XX_CLK_ADC		3
> +#define NPCM8XX_CLK_AHB		4
> +#define NPCM8XX_CLK_TIMER	5
> +#define NPCM8XX_CLK_UART	6
> +#define NPCM8XX_CLK_UART2	7
> +#define NPCM8XX_CLK_MMC		8
> +#define NPCM8XX_CLK_SPI3	9
> +#define NPCM8XX_CLK_PCI		10
> +#define NPCM8XX_CLK_AXI		11
> +#define NPCM8XX_CLK_APB4	12
> +#define NPCM8XX_CLK_APB3	13
> +#define NPCM8XX_CLK_APB2	14
> +#define NPCM8XX_CLK_APB1	15
> +#define NPCM8XX_CLK_APB5	16
> +#define NPCM8XX_CLK_CLKOUT	17
> +#define NPCM8XX_CLK_GFX		18
> +#define NPCM8XX_CLK_SU		19
> +#define NPCM8XX_CLK_SU48	20
> +#define NPCM8XX_CLK_SDHC	21
> +#define NPCM8XX_CLK_SPI0	22
> +#define NPCM8XX_CLK_SPI1	23
> +#define NPCM8XX_CLK_SPIX	24
> +#define NPCM8XX_CLK_RG		25
> +#define NPCM8XX_CLK_RCP		26
> +#define NPCM8XX_CLK_PRE_ADC	27
> +#define NPCM8XX_CLK_ATB		28
> +#define NPCM8XX_CLK_PRE_CLK	29
> +#define NPCM8XX_CLK_TH		30
> +#define NPCM8XX_CLK_REFCLK	31
> +#define NPCM8XX_CLK_SYSBYPCK	32
> +#define NPCM8XX_CLK_MCBYPCK	33
> +
> +#define NPCM8XX_NUM_CLOCKS	(NPCM8XX_CLK_MCBYPCK + 1)
> +
> +#endif


Best regards,
Krzysztof
