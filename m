Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBCD4CB87C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiCCINA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiCCIMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:12:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267F170D4B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:12:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d3so6515231wrf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LJqUL43XcbGuz68y/4lEqQ5dRFIUxBQ8RyqcTDZsiaE=;
        b=2F5HIdxRy5kJPzBGqgI+tIttT04lYafSyVZoXlykcFs8CjKXvXaEOKOsL2u2O16rzh
         YhRsCrcK6hylj/OLa0A+0exW4kZBFCTJWQBQAmzgFwrNBN73NcnOyJMr8AU+t98Pgo9g
         HrRhzkjiUPGwQLOzBzFvdV6OJe0iJ3TaNIxjpHVmbOBqnlpVVqBicl/KHSxR71EFj+w4
         o+r+nLAN1Us7A4cseX8KR5PwiKeSsSK1fgeGxJZX/JbsM9EXu6BQ43P0QZDhOjl6+ZYt
         XlRGaUyhUaVrp6VOt5uhoTguog925JmOpFRRYRj0MECAL+qXb/6BiW4r+erOA7eEWt9C
         N1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LJqUL43XcbGuz68y/4lEqQ5dRFIUxBQ8RyqcTDZsiaE=;
        b=NwRU0W0PLLRi+lLuZoZ/ua0+IaOlxgHYwvpgYGDcJRsi/a5hSIbN+XvYLpPWintLGK
         Mz8sEbveBa0/n5J2P4nWwyt6JKBIfKbzHpi95oRi9q+IRxpbvWkrk8Rx6pYBAPYtyIAn
         W1XcHWPhpGFX5ViVPo1St4jNin46USW5Hydhj8m6Pa4HPRmDfDmEF7gozcf6mG/a6/HH
         5XDGvxvSWiefFn+n2pgrDsRMxvDza3g2XNwi1bfLEwsKixJXc/et+xOWcSxXVnIYPJjC
         W3PjHuDSq0ZCwl7ftvR/M3wX0udag858op55ZNKXklAFml6+OsiXWBwrj0uvUW1LUkLi
         TWIA==
X-Gm-Message-State: AOAM5309JLF+AKJ46SHfPtgJdngIIEDJ95mKyrtm/p2OBk4ryeFQLbqo
        k4YvFu0uayubOKsRSIEu0+ylSg==
X-Google-Smtp-Source: ABdhPJzKINeaPPH4W3c+lQwH+lbSqxtZ9RLhAndsAGTg0w8w9Jn5I+YFIyKdtv+guSsNnw80xokivA==
X-Received: by 2002:a5d:44d2:0:b0:1f0:247d:8cf7 with SMTP id z18-20020a5d44d2000000b001f0247d8cf7mr5702562wrr.475.1646295127475;
        Thu, 03 Mar 2022 00:12:07 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:37d4:6d61:9015:27a5? ([2001:861:44c0:66c0:37d4:6d61:9015:27a5])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c1d1000b003816edb5711sm8463782wms.26.2022.03.03.00.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 00:12:06 -0800 (PST)
Message-ID: <07d15deb-ef49-54ec-4486-0b527df82fe2@baylibre.com>
Date:   Thu, 3 Mar 2022 09:12:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] serial: make uart_console_write->putchar()'s character
 an unsigned char
Content-Language: en-US
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <peter@korsgaard.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220303080831.21783-1-jslaby@suse.cz>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220303080831.21783-1-jslaby@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 09:08, Jiri Slaby wrote:
> Currently, uart_console_write->putchar's second parameter (the
> character) is of type int. It makes little sense, provided uart_console_write()
> accepts the input string as "const char *s" and passes its content -- the
> characters -- to putchar(). So switch the character's type to unsigned
> char.
> 
> We don't use char as that is signed on some platforms. That would cause
> troubles for drivers which (implicitly) cast the char to u16 when
> writing to the device. Sign extension would happen in that case and the
> value written would be completely different to the provided char. DZ is
> an example of such a driver -- on MIPS, it uses u16 for dz_out in
> dz_console_putchar().
> 
> Note we do the char -> uchar conversion implicitly in
> uart_console_write(). Provided we do not change size of the data type,
> sign extension does not happen there, so the problem is void.
> 
> This makes the types consistent and unified with the rest of the uart
> layer, which uses unsigned char in most places already. One exception is
> xmit_buf, but that is going to be converted later.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Acked-by: Richard Genoud <richard.genoud@gmail.com> [atmel_serial]
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Taichi Sugaya <sugaya.taichi@socionext.com>
> Cc: Takao Orito <orito.takao@socionext.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Korsgaard <peter@korsgaard.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
> [v2] make it unsigned
> [v3] fix also sunsab
> [v4] fix also sunplus (added quite recently)
> 
>   drivers/tty/goldfish.c                     | 2 +-
>   drivers/tty/hvc/hvc_dcc.c                  | 2 +-
>   drivers/tty/serial/21285.c                 | 2 +-
>   drivers/tty/serial/8250/8250_early.c       | 2 +-
>   drivers/tty/serial/8250/8250_ingenic.c     | 2 +-
>   drivers/tty/serial/8250/8250_port.c        | 2 +-
>   drivers/tty/serial/altera_jtaguart.c       | 4 ++--
>   drivers/tty/serial/altera_uart.c           | 2 +-
>   drivers/tty/serial/amba-pl010.c            | 2 +-
>   drivers/tty/serial/amba-pl011.c            | 6 +++---
>   drivers/tty/serial/apbuart.c               | 2 +-
>   drivers/tty/serial/ar933x_uart.c           | 2 +-
>   drivers/tty/serial/arc_uart.c              | 2 +-
>   drivers/tty/serial/atmel_serial.c          | 2 +-
>   drivers/tty/serial/bcm63xx_uart.c          | 2 +-
>   drivers/tty/serial/clps711x.c              | 2 +-
>   drivers/tty/serial/digicolor-usart.c       | 2 +-
>   drivers/tty/serial/dz.c                    | 2 +-
>   drivers/tty/serial/earlycon-arm-semihost.c | 2 +-
>   drivers/tty/serial/earlycon-riscv-sbi.c    | 2 +-
>   drivers/tty/serial/fsl_linflexuart.c       | 4 ++--
>   drivers/tty/serial/fsl_lpuart.c            | 4 ++--
>   drivers/tty/serial/imx.c                   | 2 +-
>   drivers/tty/serial/imx_earlycon.c          | 2 +-
>   drivers/tty/serial/ip22zilog.c             | 2 +-
>   drivers/tty/serial/lantiq.c                | 2 +-
>   drivers/tty/serial/liteuart.c              | 2 +-
>   drivers/tty/serial/lpc32xx_hs.c            | 2 +-
>   drivers/tty/serial/meson_uart.c            | 2 +-
>   drivers/tty/serial/milbeaut_usio.c         | 2 +-
>   drivers/tty/serial/mps2-uart.c             | 4 ++--
>   drivers/tty/serial/mvebu-uart.c            | 4 ++--
>   drivers/tty/serial/mxs-auart.c             | 2 +-
>   drivers/tty/serial/omap-serial.c           | 4 ++--
>   drivers/tty/serial/owl-uart.c              | 2 +-
>   drivers/tty/serial/pch_uart.c              | 2 +-
>   drivers/tty/serial/pic32_uart.c            | 2 +-
>   drivers/tty/serial/pmac_zilog.c            | 2 +-
>   drivers/tty/serial/pxa.c                   | 2 +-
>   drivers/tty/serial/qcom_geni_serial.c      | 2 +-
>   drivers/tty/serial/rda-uart.c              | 2 +-
>   drivers/tty/serial/sa1100.c                | 2 +-
>   drivers/tty/serial/samsung_tty.c           | 4 ++--
>   drivers/tty/serial/sb1250-duart.c          | 2 +-
>   drivers/tty/serial/sccnxp.c                | 2 +-
>   drivers/tty/serial/serial_core.c           | 2 +-
>   drivers/tty/serial/serial_txx9.c           | 2 +-
>   drivers/tty/serial/sh-sci.c                | 2 +-
>   drivers/tty/serial/sifive.c                | 4 ++--
>   drivers/tty/serial/sprd_serial.c           | 4 ++--
>   drivers/tty/serial/st-asc.c                | 2 +-
>   drivers/tty/serial/stm32-usart.c           | 2 +-
>   drivers/tty/serial/sunplus-uart.c          | 5 +++--
>   drivers/tty/serial/sunsab.c                | 2 +-
>   drivers/tty/serial/sunsu.c                 | 2 +-
>   drivers/tty/serial/sunzilog.c              | 4 ++--
>   drivers/tty/serial/uartlite.c              | 4 ++--
>   drivers/tty/serial/vr41xx_siu.c            | 2 +-
>   drivers/tty/serial/vt8500_serial.c         | 2 +-
>   drivers/tty/serial/xilinx_uartps.c         | 2 +-
>   drivers/tty/serial/zs.c                    | 2 +-
>   include/linux/serial_core.h                | 2 +-
>   62 files changed, 77 insertions(+), 76 deletions(-)
> 

[...]

> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -516,7 +516,7 @@ static void meson_uart_enable_tx_engine(struct uart_port *port)
>   	writel(val, port->membase + AML_UART_CONTROL);
>   }
>   
> -static void meson_console_putchar(struct uart_port *port, int ch)
> +static void meson_console_putchar(struct uart_port *port, unsigned char ch)
>   {
>   	if (!port->membase)
>   		return;

[...]
Acked-by: Neil Armstrong <narmstrong@baylibre.com> # meson_serial
