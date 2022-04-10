Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCC44FAB93
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiDJCmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbiDJClt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:41:49 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFEF18361;
        Sat,  9 Apr 2022 19:39:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bk12so8062733qkb.7;
        Sat, 09 Apr 2022 19:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4k9M3A5SaOTIoKov6CrPu7jYsykoDqASGcsbW1Bxs2g=;
        b=AHZSbnkdgSigwea2G56xzm53+YbTuhFFSPXwIgKn+Vviezo7xUX1B2Z5IYdWp+5z2b
         4rk4NO0j6irlPJ2XebeMhDD7nfoylM58cb2TQ15TLd4FN4mKLsMFzKNaBIIswUe025y+
         TRu3hCw5NeC4HSbbJTq20TmKkYuKk1yo5b99hpRfySbk+Szci0AHKV3qwekfuofJMyvR
         3GQnTbRs4lVWtGKCaw+hLKJz10LPMAUBzldPxQwxI6PkeqEq90yGYJcU5MkCTO/LsMhX
         E7xXxcI7UEq66//XhQXdxb9Zzk3xs/65tvDsOfkni4xZZvAIH9zzvDgJ3vue5cf55908
         g8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4k9M3A5SaOTIoKov6CrPu7jYsykoDqASGcsbW1Bxs2g=;
        b=MKIQUViXHiQ047vYQsuer38eJStqRrk46t5ggkKqJhVyjG17F42k7AZ1y6Y5w4Mn9k
         XoEwpNBkXHOEAkSIhGxMrmBT5sBQMZKMYpwo9rML7baoBSZmYWFitzbciGXoYtrJYmne
         mI4IbYKmDEcdx/ir+34qF8g8bR6whzZ23siIDywZgePpVfV/UlA931M6LOfCM+Gw2/CI
         f2PHKlKfu6NtQO6b32ZW/gAL4UoGW38LRCSfAJvGwUejW2ZBRTijKq3pDkkVTtl/oBhp
         CA8pJBF9YNY1mph68ebiRN5OZPrWMiC6BS0k+IRDVcNH6rgsrEQA7Xiahfo/syOQF3Js
         r//w==
X-Gm-Message-State: AOAM532P4hQ5LPU7ukWEpLXky3ruWBOcGZsL4LI9lJ2wPbB9scVflX7j
        zsd9QmjNd/EjMzyQkk0cHRE=
X-Google-Smtp-Source: ABdhPJwReclOWi6comV7f0t4FE3p7oaNQ35SJ8JbEQWYuT+E14luIOkj8va8kxoE4ZlzpOywqqEzKQ==
X-Received: by 2002:a37:f508:0:b0:69b:ed2f:e56 with SMTP id l8-20020a37f508000000b0069bed2f0e56mr5681454qkk.384.1649558360126;
        Sat, 09 Apr 2022 19:39:20 -0700 (PDT)
Received: from [10.4.10.38] (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id d3-20020a05622a15c300b002eb9af4c945sm24191439qty.3.2022.04.09.19.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 19:39:19 -0700 (PDT)
Message-ID: <8d6595d8-13c3-0f29-1a5e-e48e78b01f89@gmail.com>
Date:   Sat, 9 Apr 2022 22:39:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 00/12] Add support for the i.MXRT1170-evk
Content-Language: en-US
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/22 10:43, Jesse Taube wrote:
> This patch continues support for the imxrt series now with the imxrt1170
> 
> This patch contains:
> - Update to imxrt_defconfig
> - Devicetree
> - Clock driver
> - Pinctrl driver
> - New pll
> 
> This patch also updates some documentation for both imxrt1170 an 1050.
> 
> The i.MXRT1170 has a vast array of fetures includeing two cores. 2 Ethernet, 2 USB phy, and a 2d gpu.
> 
> It also is fetured in a new google coral board
> https://coral.ai/products/dev-board-micro
> Not affiliated unfortunaly.
> 
> Jesse Taube (12):
>    dt-bindings: arm: imx: Add i.MXRT compatible Documentation
>    dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
>    dt-bindings: pinctrl: add i.MXRT1170 pinctrl Documentation
>    dt-bindings: clock: imx: Add documentation for i.MXRT1170 clock
>    ARM: mach-imx: Add support for i.MXRT1170
>    ARM: clk: imx: Update pllv3 to support i.MXRT1170
>    dt-bindings: imx: Add clock binding for i.MXRT1170
>    clk: imx: Add initial support for i.MXRT1170 clock driver
>    pinctrl: freescale: Add i.MXRT1170 pinctrl driver support
>    ARM: dts: imxrt1170-pinfunc: Add pinctrl binding header
>    ARM: dts: imx: Add i.MXRT1170-EVK support
>    ARM: imxrt_defconfig: Add i.MXRT1170
> 
>   .../devicetree/bindings/arm/fsl.yaml          |   12 +
>   .../bindings/clock/imxrt1170-clock.yaml       |   59 +
>   .../bindings/pinctrl/fsl,imxrt1170.yaml       |   77 +
>   .../devicetree/bindings/timer/fsl,imxgpt.yaml |    2 +
>   arch/arm/boot/dts/Makefile                    |    3 +-
>   arch/arm/boot/dts/imxrt1170-evk.dts           |  126 ++
>   arch/arm/boot/dts/imxrt1170-pinfunc.h         | 1561 +++++++++++++++++
>   arch/arm/boot/dts/imxrt1170.dtsi              |  278 +++
>   arch/arm/configs/imxrt_defconfig              |   26 +
>   arch/arm/mach-imx/mach-imxrt.c                |    1 +
>   drivers/clk/imx/Kconfig                       |    7 +
>   drivers/clk/imx/Makefile                      |    1 +
>   drivers/clk/imx/clk-imxrt1170.c               |  391 +++++
>   drivers/clk/imx/clk-pllv3.c                   |   57 +-
>   drivers/clk/imx/clk.h                         |    4 +
>   drivers/pinctrl/freescale/Kconfig             |    7 +
>   drivers/pinctrl/freescale/Makefile            |    1 +
>   drivers/pinctrl/freescale/pinctrl-imxrt1170.c |  349 ++++
>   include/dt-bindings/clock/imxrt1170-clock.h   |  282 +++
>   19 files changed, 3241 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/imxrt1170-clock.yaml
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
>   create mode 100644 arch/arm/boot/dts/imxrt1170-evk.dts
>   create mode 100644 arch/arm/boot/dts/imxrt1170-pinfunc.h
>   create mode 100644 arch/arm/boot/dts/imxrt1170.dtsi
>   create mode 100644 drivers/clk/imx/clk-imxrt1170.c
>   create mode 100644 drivers/pinctrl/freescale/pinctrl-imxrt1170.c
>   create mode 100644 include/dt-bindings/clock/imxrt1170-clock.h
> 
Hi Freind's,

Are there any more comments on this patch set or should V2 be sent.
If there is something obviously wrong that I have missed an you haven't 
I would love to know because I haven't noticed yet.

Cheers,
Jesse Taube
