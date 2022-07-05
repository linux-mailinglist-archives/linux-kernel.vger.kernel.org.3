Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C32566858
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiGEKmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiGEKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:41:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF2915A05;
        Tue,  5 Jul 2022 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657017674;
        bh=1cwsQ0VREEl3nisNFp1v4bKpUuTZ+JfPwfXl3rk7ZyQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KHQ3RJ+uYSs5MZCLfzeutChf90YZlVUSvi9mKWQzb8NTK8/As9C2UlmyPMfKtnc+o
         afmi5pFNBA48WcBewBd6oDD9jw2BJFHS2l2i8bG18Q6ShlY2I1TKMqYlueV7pvIpDO
         3QRRJ5Xxq0pQOYw2v6T9sDuDL+ujSzpd7akE91gc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.214]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacSe-1ncNRQ2Fcg-00cBxy; Tue, 05
 Jul 2022 12:41:14 +0200
Message-ID: <02c4e59b-5aa5-7fe3-02a5-06bff5cee661@gmx.de>
Date:   Tue, 5 Jul 2022 12:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] serial: Embed rs485_supported to uart_port
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220704094515.6831-1-ilpo.jarvinen@linux.intel.com>
 <20220704094515.6831-2-ilpo.jarvinen@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20220704094515.6831-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g4ShHq5T8H6vtAOHKZnNtZ4uculNq20A5Bkgx9yya8nM+tTZ8MG
 XNC3f0xPmwyssqGS3qMWmeCulBnpOZCal/kpJM60aGpHWuG28CnT0xWYs1V1H/F1fDJM0Ex
 z7WYkQ0XEoFKVl2k3lXkOGutsOoeFOp2NK/AAQkGPozwk0nU69c3OLJFdft5iF4AASyKTuj
 v+geWh1qE10f0vuGJLS/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EfQMsLJha5s=:JcCMNIKkRguVXZiCVs90DD
 2a+uV616ZwkCg9pW4NkfBDMKKw6tsobqPtrC/RRDmMLe0fwddXZjz4YM5mQ/J0KlbazLpKuk2
 jChq6z6oIEK7WAUY3bTOBE4/m0dbwb6RQk0qrgJiEB/ZO7qrLt7ok/jz8rE1GGeIhMHgu4VQ0
 1M3uGdGl9JGBZL6Gk7WvdDSOzoue1e43kCkihwJ8GbpXC2d6O1KChYum4TfhIYh0NSPj6QehN
 HiB8CKruCvInro9xTj3ME332EUIQ5eR8MaPdreEUOODw5KWBsfDPHorStO/sM8S89jqxO2dQr
 5gxDV1uU8UnF4OB4OpReA00nM9bGlAkHiy1dQEbs84RqaNQNakuRw/kDw33i9Z37lCOFW2BXk
 RC44SvegjxEA1d6xLqWsZbnawV/2vZCnum//U5h9/bmmzC8A2CkhZ2b6ULMzJ0UGQOd4GaxpB
 tPAen++gHQhHGRj6uFNt/QkjiWhVihJO0f/MdBCUhTIjd7vvIsOPEPjUm80TMEyIkbJRDyEXw
 K5TzF5BQb77PPeHugRFyV55Tt2W0DI4Yvb0yTo4fgO+m2wNcgbYFS3psufb8KBXRq5ofoxcwU
 J4bhtMksPTEJOP2emKGoLJ3a0C82ZQvpMb1tb2JmPZAiBvXYR8khMYc8DiJfOW9F1A3fYM73x
 PAWjdgwYCek0a197KYCo22vux0q7Qwwetpm+9d6Y2bikhoHcJ2YuJ13dJ6f2HVNkZuHTG0w0Q
 L/Uu9rYlXqStpESLahyh1mcv5sWf/PItvSBsmDPqO31l0SkvtTRAWWuNV7OGoe5E+46EwTJgy
 zpQRu3KyIJrlgrK6M+OwhuG8sc0WEpSKhfY/RYcSzgZvbuG1XlwilJCTdj0qxAaUSlBmkGu01
 bXkF5Rwu4UpDHfNK3PDmlH+zgDONePt4HkwW1Tru9iaZUI6xcCf3QrZVQYsjkTVU8S2inUqjr
 z9AKPSYRkFfdkY/uZD5UrPABHfaApmv4orpsvCWK+uxyAEEulVWp2GCqr74L+A3+m28gopP37
 dVi3CIPbJS25g6sIUMtl3QR/A0p4ZPMbvUHKu1KmgBvxbsUFI955ub5p+89krewkTII+obgoA
 Oh0pJAJUgkKmokzL97qGvMjBkLcAkuqR8dGAL7rctcH7jgSTdb4/PNRIQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.07.22 11:45, Ilpo J=C3=A4rvinen wrote:
> Embed rs485_supported to uart_port to allow serial core to tweak it as
> needed.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_bcm2835aux.c | 2 +-
>  drivers/tty/serial/8250/8250_dwlib.c      | 4 ++--
>  drivers/tty/serial/8250/8250_exar.c       | 2 +-
>  drivers/tty/serial/8250/8250_fintek.c     | 4 ++--
>  drivers/tty/serial/8250/8250_lpc18xx.c    | 2 +-
>  drivers/tty/serial/8250/8250_of.c         | 2 +-
>  drivers/tty/serial/8250/8250_pci.c        | 2 +-
>  drivers/tty/serial/amba-pl011.c           | 2 +-
>  drivers/tty/serial/ar933x_uart.c          | 4 ++--
>  drivers/tty/serial/atmel_serial.c         | 2 +-
>  drivers/tty/serial/fsl_lpuart.c           | 2 +-
>  drivers/tty/serial/imx.c                  | 4 ++--
>  drivers/tty/serial/max310x.c              | 2 +-
>  drivers/tty/serial/mcf.c                  | 4 ++--
>  drivers/tty/serial/omap-serial.c          | 2 +-
>  drivers/tty/serial/sc16is7xx.c            | 2 +-
>  drivers/tty/serial/serial_core.c          | 8 ++++----
>  drivers/tty/serial/stm32-usart.c          | 2 +-
>  include/linux/serial_core.h               | 2 +-
>  19 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/ser=
ial/8250/8250_bcm2835aux.c
> index d9f1e618cfbd..047e14ccb165 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -108,7 +108,7 @@ static int bcm2835aux_serial_probe(struct platform_d=
evice *pdev)
>  	up.port.flags =3D UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE |
>  			UPF_SKIP_TEST | UPF_IOREMAP;
>  	up.port.rs485_config =3D serial8250_em485_config;
> -	up.port.rs485_supported =3D &serial8250_em485_supported;
> +	up.port.rs485_supported =3D serial8250_em485_supported;
>  	up.rs485_start_tx =3D bcm2835aux_rs485_start_tx;
>  	up.rs485_stop_tx =3D bcm2835aux_rs485_stop_tx;
>
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8=
250/8250_dwlib.c
> index a8bbed74ea70..2c3b1468bd88 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -255,10 +255,10 @@ void dw8250_setup_port(struct uart_port *p)
>  	if (pd->hw_rs485_support) {
>  		p->rs485_config =3D dw8250_rs485_config;
>  		up->lsr_save_mask =3D LSR_SAVE_FLAGS | DW_UART_LSR_ADDR_RCVD;
> -		p->rs485_supported =3D &dw8250_rs485_supported;
> +		p->rs485_supported =3D dw8250_rs485_supported;
>  	} else {
>  		p->rs485_config =3D serial8250_em485_config;
> -		p->rs485_supported =3D &serial8250_em485_supported;
> +		p->rs485_supported =3D serial8250_em485_supported;
>  		up->rs485_start_tx =3D serial8250_em485_start_tx;
>  		up->rs485_stop_tx =3D serial8250_em485_stop_tx;
>  	}
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/82=
50/8250_exar.c
> index f5344cfe303c..314a05e009df 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -550,7 +550,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci=
_dev *pcidev,
>
>  	port->port.uartclk =3D baud * 16;
>  	port->port.rs485_config =3D platform->rs485_config;
> -	port->port.rs485_supported =3D platform->rs485_supported;
> +	port->port.rs485_supported =3D *(platform->rs485_supported);
>
>  	/*
>  	 * Setup the UART clock for the devices on expansion slot to
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/=
8250/8250_fintek.c
> index eea693f5b577..65b6b3cbaff6 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -433,9 +433,9 @@ static void fintek_8250_set_rs485_handler(struct uar=
t_8250_port *uart)
>  	case CHIP_ID_F81865:
>  		uart->port.rs485_config =3D fintek_8250_rs485_config;
>  		if (!pdata->index)
> -			uart->port.rs485_supported =3D &fintek_8250_rs485_supported_port0;
> +			uart->port.rs485_supported =3D fintek_8250_rs485_supported_port0;
>  		else
> -			uart->port.rs485_supported =3D &fintek_8250_rs485_supported;
> +			uart->port.rs485_supported =3D fintek_8250_rs485_supported;
>  		break;
>
>  	default: /* No RS485 Auto direction functional */
> diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial=
/8250/8250_lpc18xx.c
> index d7cb3bb52069..d6ca0d47e9d5 100644
> --- a/drivers/tty/serial/8250/8250_lpc18xx.c
> +++ b/drivers/tty/serial/8250/8250_lpc18xx.c
> @@ -161,7 +161,7 @@ static int lpc18xx_serial_probe(struct platform_devi=
ce *pdev)
>  	uart.port.uartclk =3D clk_get_rate(data->clk_uart);
>  	uart.port.private_data =3D data;
>  	uart.port.rs485_config =3D lpc18xx_rs485_config;
> -	uart.port.rs485_supported =3D &lpc18xx_rs485_supported;
> +	uart.port.rs485_supported =3D lpc18xx_rs485_supported;
>  	uart.port.serial_out =3D lpc18xx_uart_serial_out;
>
>  	uart.dma =3D &data->dma;
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250=
/8250_of.c
> index 65cccd559db2..1b461fba15a3 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -165,7 +165,7 @@ static int of_platform_serial_setup(struct platform_=
device *ofdev,
>
>  	port->dev =3D &ofdev->dev;
>  	port->rs485_config =3D serial8250_em485_config;
> -	port->rs485_supported =3D &serial8250_em485_supported;
> +	port->rs485_supported =3D serial8250_em485_supported;
>  	up->rs485_start_tx =3D serial8250_em485_start_tx;
>  	up->rs485_stop_tx =3D serial8250_em485_stop_tx;
>
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/825=
0/8250_pci.c
> index d31d2350a9db..8a39ae072c65 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1607,7 +1607,7 @@ static int pci_fintek_setup(struct serial_private =
*priv,
>  	port->port.iotype =3D UPIO_PORT;
>  	port->port.iobase =3D iobase;
>  	port->port.rs485_config =3D pci_fintek_rs485_config;
> -	port->port.rs485_supported =3D &pci_fintek_rs485_supported;
> +	port->port.rs485_supported =3D pci_fintek_rs485_supported;
>
>  	data =3D devm_kzalloc(&pdev->dev, sizeof(u8), GFP_KERNEL);
>  	if (!data)
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-p=
l011.c
> index c8f52945a4aa..abeceeefdece 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2779,7 +2779,7 @@ static int pl011_probe(struct amba_device *dev, co=
nst struct amba_id *id)
>  	uap->port.irq =3D dev->irq[0];
>  	uap->port.ops =3D &amba_pl011_pops;
>  	uap->port.rs485_config =3D pl011_rs485_config;
> -	uap->port.rs485_supported =3D &pl011_rs485_supported;
> +	uap->port.rs485_supported =3D pl011_rs485_supported;
>  	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
>
>  	ret =3D pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
> diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933=
x_uart.c
> index b73ce13683db..f931ecbc0bc0 100644
> --- a/drivers/tty/serial/ar933x_uart.c
> +++ b/drivers/tty/serial/ar933x_uart.c
> @@ -778,7 +778,7 @@ static int ar933x_uart_probe(struct platform_device =
*pdev)
>  	port->fifosize =3D AR933X_UART_FIFO_SIZE;
>  	port->ops =3D &ar933x_uart_ops;
>  	port->rs485_config =3D ar933x_config_rs485;
> -	port->rs485_supported =3D &ar933x_rs485_supported;
> +	port->rs485_supported =3D ar933x_rs485_supported;
>
>  	baud =3D ar933x_uart_get_baud(port->uartclk, AR933X_UART_MAX_SCALE, 1)=
;
>  	up->min_baud =3D max_t(unsigned int, baud, AR933X_UART_MIN_BAUD);
> @@ -802,7 +802,7 @@ static int ar933x_uart_probe(struct platform_device =
*pdev)
>  	    !up->rts_gpiod) {
>  		dev_err(&pdev->dev, "lacking rts-gpio, disabling RS485\n");
>  		port->rs485.flags &=3D ~SER_RS485_ENABLED;
> -		port->rs485_supported =3D &ar933x_no_rs485;
> +		port->rs485_supported =3D ar933x_no_rs485;
>  	}
>
>  #ifdef CONFIG_SERIAL_AR933X_CONSOLE
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atme=
l_serial.c
> index bc6004679585..30ba9eef7b39 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2498,7 +2498,7 @@ static int atmel_init_port(struct atmel_uart_port =
*atmel_port,
>  	port->mapbase		=3D mpdev->resource[0].start;
>  	port->irq		=3D platform_get_irq(mpdev, 0);
>  	port->rs485_config	=3D atmel_config_rs485;
> -	port->rs485_supported	=3D &atmel_rs485_supported;
> +	port->rs485_supported	=3D atmel_rs485_supported;
>  	port->iso7816_config	=3D atmel_config_iso7816;
>  	port->membase		=3D NULL;
>
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lp=
uart.c
> index 8fe0494d4057..fc7d235a1e27 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2655,7 +2655,7 @@ static int lpuart_probe(struct platform_device *pd=
ev)
>  		sport->port.rs485_config =3D lpuart32_config_rs485;
>  	else
>  		sport->port.rs485_config =3D lpuart_config_rs485;
> -	sport->port.rs485_supported =3D &lpuart_rs485_supported;
> +	sport->port.rs485_supported =3D lpuart_rs485_supported;
>
>  	sport->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
>  	if (IS_ERR(sport->ipg_clk)) {
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 3457006cea3f..522445a8f666 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2285,9 +2285,9 @@ static int imx_uart_probe(struct platform_device *=
pdev)
>  	sport->port.rs485_config =3D imx_uart_rs485_config;
>  	/* RTS is required to control the RS485 transmitter */
>  	if (sport->have_rtscts || sport->have_rtsgpio)
> -		sport->port.rs485_supported =3D &imx_rs485_supported;
> +		sport->port.rs485_supported =3D imx_rs485_supported;
>  	else
> -		sport->port.rs485_supported =3D &imx_no_rs485;
> +		sport->port.rs485_supported =3D imx_no_rs485;
>  	sport->port.flags =3D UPF_BOOT_AUTOCONF;
>  	timer_setup(&sport->timer, imx_uart_timeout, 0);
>
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index e162bfb44080..ab10ca4a45b5 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1370,7 +1370,7 @@ static int max310x_probe(struct device *dev, const=
 struct max310x_devtype *devty
>  		s->p[i].port.membase	=3D (void __iomem *)~0;
>  		s->p[i].port.uartclk	=3D uartclk;
>  		s->p[i].port.rs485_config =3D max310x_rs485_config;
> -		s->p[i].port.rs485_supported =3D &max310x_rs485_supported;
> +		s->p[i].port.rs485_supported =3D max310x_rs485_supported;
>  		s->p[i].port.ops	=3D &max310x_ops;
>  		s->p[i].regmap		=3D regmaps[i];
>
> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
> index 73c5287b8e5e..f4aaaadd0742 100644
> --- a/drivers/tty/serial/mcf.c
> +++ b/drivers/tty/serial/mcf.c
> @@ -506,7 +506,7 @@ int __init early_mcf_setup(struct mcf_platform_uart =
*platp)
>  		port->uartclk =3D MCF_BUSCLK;
>  		port->flags =3D UPF_BOOT_AUTOCONF;
>  		port->rs485_config =3D mcf_config_rs485;
> -		port->rs485_supported =3D &mcf_rs485_supported;
> +		port->rs485_supported =3D mcf_rs485_supported;
>  		port->ops =3D &mcf_uart_ops;
>  	}
>
> @@ -634,7 +634,7 @@ static int mcf_probe(struct platform_device *pdev)
>  		port->ops =3D &mcf_uart_ops;
>  		port->flags =3D UPF_BOOT_AUTOCONF;
>  		port->rs485_config =3D mcf_config_rs485;
> -		port->rs485_supported =3D &mcf_rs485_supported;
> +		port->rs485_supported =3D mcf_rs485_supported;
>  		port->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
>
>  		uart_add_one_port(&mcf_driver, port);
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-=
serial.c
> index 196bae704f85..0aa666e247d5 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1643,7 +1643,7 @@ static int serial_omap_probe(struct platform_devic=
e *pdev)
>  	up->port.flags =3D omap_up_info->flags;
>  	up->port.uartclk =3D omap_up_info->uartclk;
>  	up->port.rs485_config =3D serial_omap_config_rs485;
> -	up->port.rs485_supported =3D &serial_omap_rs485_supported;
> +	up->port.rs485_supported =3D serial_omap_rs485_supported;
>  	if (!up->port.uartclk) {
>  		up->port.uartclk =3D DEFAULT_CLK_SPEED;
>  		dev_warn(&pdev->dev,
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7=
xx.c
> index 8cb92a3b3fb8..259e08cc347c 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1461,7 +1461,7 @@ static int sc16is7xx_probe(struct device *dev,
>  		s->p[i].port.iotype	=3D UPIO_PORT;
>  		s->p[i].port.uartclk	=3D freq;
>  		s->p[i].port.rs485_config =3D sc16is7xx_config_rs485;
> -		s->p[i].port.rs485_supported =3D &sc16is7xx_rs485_supported;
> +		s->p[i].port.rs485_supported =3D sc16is7xx_rs485_supported;
>  		s->p[i].port.ops	=3D &sc16is7xx_ops;
>  		s->p[i].old_mctrl	=3D 0;
>  		s->p[i].port.line	=3D sc16is7xx_alloc_line();
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seria=
l_core.c
> index 85ef7ef00b82..a9cf1044a9fa 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1285,7 +1285,7 @@ static int uart_check_rs485_flags(struct uart_port=
 *port, struct serial_rs485 *r
>  	 * For any bit outside of the legacy ones that is not supported by
>  	 * the driver, return -EINVAL.
>  	 */
> -	if (flags & ~port->rs485_supported->flags)
> +	if (flags & ~port->rs485_supported.flags)
>  		return -EINVAL;
>
>  	/* Asking for address w/o addressing mode? */
> @@ -1304,7 +1304,7 @@ static int uart_check_rs485_flags(struct uart_port=
 *port, struct serial_rs485 *r
>
>  static void uart_sanitize_serial_rs485(struct uart_port *port, struct s=
erial_rs485 *rs485)
>  {
> -	u32 supported_flags =3D port->rs485_supported->flags;
> +	u32 supported_flags =3D port->rs485_supported.flags;
>
>  	if (!(rs485->flags & SER_RS485_ENABLED)) {
>  		memset(rs485, 0, sizeof(*rs485));
> @@ -1323,7 +1323,7 @@ static void uart_sanitize_serial_rs485(struct uart=
_port *port, struct serial_rs4
>  		supported_flags |=3D SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND;
>  	}
>
> -	if (!port->rs485_supported->delay_rts_before_send) {
> +	if (!port->rs485_supported.delay_rts_before_send) {
>  		if (rs485->delay_rts_before_send) {
>  			dev_warn_ratelimited(port->dev,
>  				"%s (%d): RTS delay before sending not supported\n",
> @@ -1337,7 +1337,7 @@ static void uart_sanitize_serial_rs485(struct uart=
_port *port, struct serial_rs4
>  			port->name, port->line, rs485->delay_rts_before_send);
>  	}
>
> -	if (!port->rs485_supported->delay_rts_after_send) {
> +	if (!port->rs485_supported.delay_rts_after_send) {
>  		if (rs485->delay_rts_after_send) {
>  			dev_warn_ratelimited(port->dev,
>  				"%s (%d): RTS delay after sending not supported\n",
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32=
-usart.c
> index 13992e64a7df..ff5c7e0ebc4c 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -1401,7 +1401,7 @@ static int stm32_usart_init_port(struct stm32_port=
 *stm32port,
>  	port->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_STM32_CONSOLE);
>  	port->irq =3D irq;
>  	port->rs485_config =3D stm32_usart_config_rs485;
> -	port->rs485_supported =3D &stm32_rs485_supported;
> +	port->rs485_supported =3D stm32_rs485_supported;
>
>  	ret =3D stm32_usart_init_rs485(port, pdev);
>  	if (ret)
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index b7b86ee3cb12..a6fa7c40c330 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -255,7 +255,7 @@ struct uart_port {
>  	struct attribute_group	*attr_group;		/* port specific attributes */
>  	const struct attribute_group **tty_groups;	/* all attributes (serial c=
ore use only) */
>  	struct serial_rs485     rs485;
> -	const struct serial_rs485	*rs485_supported;	/* Supported mask for seri=
al_rs485 */
> +	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs48=
5 */
>  	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
>  	struct serial_iso7816   iso7816;
>  	void			*private_data;		/* generic platform data pointer */

Reviewed-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>


Regards,
Lino


