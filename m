Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0D46944C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbhLFKyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbhLFKyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:54:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E773C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 02:50:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 133so7819454wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 02:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2oNbuF190awal+660ONrj+d8q2JGo3YTgD7d1EpaHqk=;
        b=i89RiwQhlq3M3FfqGuw9GmPJf8RHv+JeWr+tvb4jpFpDFXE2UOTV6j4WbScDjqPA+B
         OBIj9z0RPChvKMfVvQLrlfB+t8RIZMlEQulBBJKLT5sf3W0yIkrcx1yknQV3ljszZXa2
         BUvs5FZXCnxZmi7eDRjg1sfvl/agI90MjTmOfp1FxPyTC1q5P0EUTK9OP8JbFFQ6u8AE
         /P6+GuE3f63BfpXaS4j9AmskAKim8FFCyuDSFhui6hWiJcvSLUgKy5jj/4y8gINK5pXO
         KkawozG1tMWPyFHS6B1cvgWbWXAMs/Rp0dl37RxfxAuL134Z3waUi0kqR2GYkFO8gu0G
         92Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2oNbuF190awal+660ONrj+d8q2JGo3YTgD7d1EpaHqk=;
        b=GOGTnguJ8OaRSgQKfokkRfsMswDGqJJVT1hrBJhvC2QpenMjNhBoxonJ9Yz9IWWw8F
         MFTwca17hkQmv3uLqQW6slqBDsIX2/VkIJClhi7N+rRCgoC9x5DOo0guVff4LqyddUkQ
         oABMblG93w3dAsT0me6Dtl4I++MPcfLRKh4qa2ugLgnl/JCxoVqRMis53IGVdocAgQU5
         cdip62aBdAw6/t46UPWxTDjHqE31RdWdEv+mQqcjaWDKGh+Bh/FM2wsNXggBydMIFXI7
         btp5Z/RETLDfSjXP6Be96elgnTMIScNlSH0nsrZB1WPBB3hUzcuKC2M/btWb7ZtzMIbO
         hYDw==
X-Gm-Message-State: AOAM533tr3B/KmWxJ5PaT2/U6Xn2onslxa6e3sHHopRj2Oe3BHCH+5jL
        oooVCCG9nhM767pE0nSvmE2LlzQb3pJVtsDo
X-Google-Smtp-Source: ABdhPJzjgIxXGz1rRBspyqg6QUOKotxqaGgwdPATY0T4gaZw2DgV1Omn5/eBhdD3I5da5Q5lbhdUgA==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr37494357wmg.86.1638787843591;
        Mon, 06 Dec 2021 02:50:43 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:70c1:5ce3:e1aa:1275? ([2001:861:44c0:66c0:70c1:5ce3:e1aa:1275])
        by smtp.gmail.com with ESMTPSA id y7sm10771027wrw.55.2021.12.06.02.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 02:50:43 -0800 (PST)
Subject: Re: [PATCH] serial: meson: make the current driver compatible with S4
To:     "xianwei.zhao" <xianwei.zhao@amlogic.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20211206100200.31914-1-xianwei.zhao@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <4d07d6c0-e320-60cf-740f-c39bfed19c0d@baylibre.com>
Date:   Mon, 6 Dec 2021 11:50:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211206100200.31914-1-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/12/2021 11:02, xianwei.zhao wrote:
> Because S4 UART use a different clock source, the baud rate calculation need to be updated.
> Reset the UART during initialization to clear previous status.
> 
> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/tty/serial/meson_uart.c | 50 +++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index efee3935917f..15a992ee6a28 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -65,9 +65,11 @@
>  #define AML_UART_RECV_IRQ(c)		((c) & 0xff)
>  
>  /* AML_UART_REG5 bits */
> -#define AML_UART_BAUD_MASK		0x7fffff
> +#define AML_UART_BAUD_MASK		GENMASK(22, 0)
>  #define AML_UART_BAUD_USE		BIT(23)
>  #define AML_UART_BAUD_XTAL		BIT(24)
> +#define AML_UART_BAUD_XTAL_TICK		BIT(26)
> +#define AML_UART_BAUD_XTAL_DIV2		BIT(27)
>  
>  #define AML_UART_PORT_NUM		12
>  #define AML_UART_PORT_OFFSET		6
> @@ -80,6 +82,14 @@ static struct uart_driver meson_uart_driver;
>  
>  static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>  
> +/*
> + * struct aml_uart - device data
> + * @xtal_tick_en: A clock source that calculates baud rates
> + */
> +struct aml_uart {

please change to a better name like meson_uart_data and pass it as data of meson_uart_dt_match

> +	unsigned int xtal_tick_en;
> +};
> +
>  static void meson_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
>  }
> @@ -103,7 +113,7 @@ static void meson_uart_stop_tx(struct uart_port *port)
>  	u32 val;
>  
>  	val = readl(port->membase + AML_UART_CONTROL);
> -	val &= ~AML_UART_TX_INT_EN;
> +	val &= ~AML_UART_TX_EN;

Seems to be a cosmetic change, please split this in a separate patch.

>  	writel(val, port->membase + AML_UART_CONTROL);
>  }
>  
> @@ -121,12 +131,12 @@ static void meson_uart_shutdown(struct uart_port *port)
>  	unsigned long flags;
>  	u32 val;
>  
> -	free_irq(port->irq, port);
> +	devm_free_irq(port->dev, port->irq, port);

Please split this in a separate patch

>  
>  	spin_lock_irqsave(&port->lock, flags);
>  
>  	val = readl(port->membase + AML_UART_CONTROL);
> -	val &= ~AML_UART_RX_EN;
> +	val &= ~(AML_UART_RX_EN | AML_UART_TX_EN);

Seems it fixes a bug, split in a separate patch.

>  	val &= ~(AML_UART_RX_INT_EN | AML_UART_TX_INT_EN);
>  	writel(val, port->membase + AML_UART_CONTROL);
>  
> @@ -270,6 +280,7 @@ static int meson_uart_startup(struct uart_port *port)
>  	u32 val;
>  	int ret = 0;
>  
> +	meson_uart_reset(port);

Same, split in a separate patch

>  	val = readl(port->membase + AML_UART_CONTROL);
>  	val |= AML_UART_CLEAR_ERR;
>  	writel(val, port->membase + AML_UART_CONTROL);
> @@ -285,24 +296,37 @@ static int meson_uart_startup(struct uart_port *port)
>  	val = (AML_UART_RECV_IRQ(1) | AML_UART_XMIT_IRQ(port->fifosize / 2));
>  	writel(val, port->membase + AML_UART_MISC);
>  
> -	ret = request_irq(port->irq, meson_uart_interrupt, 0,
> -			  port->name, port);
> +	ret = devm_request_irq(port->dev, port->irq, meson_uart_interrupt,
> +			       IRQF_SHARED, port->name, port);

Same, split in a separate patch

>  
>  	return ret;
>  }
>  
>  static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
>  {
> +	struct aml_uart *aml_uart_data = port->private_data;
>  	u32 val;
>  
>  	while (!meson_uart_tx_empty(port))
>  		cpu_relax();
>  
> +	val = readl_relaxed(port->membase + AML_UART_REG5);
> +	val &= ~AML_UART_BAUD_MASK;
> +
>  	if (port->uartclk == 24000000) {
> -		val = ((port->uartclk / 3) / baud) - 1;
> -		val |= AML_UART_BAUD_XTAL;
> +		if (aml_uart_data->xtal_tick_en) {
> +			val = (port->uartclk / 2 + baud / 2) / baud  - 1;
> +			val |= (AML_UART_BAUD_XTAL | AML_UART_BAUD_XTAL_DIV2);

This should be triggered by a value in match data with a new compatible.

> +		} else {
> +			val = ((port->uartclk / 3) + baud / 2) / baud  - 1;
> +			val &= (~(AML_UART_BAUD_XTAL_TICK |
> +				AML_UART_BAUD_XTAL_DIV2));
> +			val |= AML_UART_BAUD_XTAL;
> +		}
>  	} else {
>  		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
> +		val &= (~(AML_UART_BAUD_XTAL | AML_UART_BAUD_XTAL_TICK |
> +			AML_UART_BAUD_XTAL_DIV2));
>  	}
>  	val |= AML_UART_BAUD_USE;
>  	writel(val, port->membase + AML_UART_REG5);
> @@ -715,6 +739,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>  {
>  	struct resource *res_mem, *res_irq;
>  	struct uart_port *port;
> +	struct aml_uart *aml_uart_data;
>  	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>  	int ret = 0;
>  
> @@ -754,6 +779,14 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	if (!port)
>  		return -ENOMEM;
>  
> +	aml_uart_data = devm_kzalloc(&pdev->dev, sizeof(struct aml_uart),
> +				     GFP_KERNEL);
> +	if (!aml_uart_data)
> +		return -ENOMEM;
> +
> +	of_property_read_u32(pdev->dev.of_node, "xtal_tick_en",
> +			     &aml_uart_data->xtal_tick_en);

This property is not documented in the bindings, instead introduce
a new compatible for the S4 and pass the "aml_uart" as the meson_uart_dt_match
data pointer.

And don't forget to submit the bindings change in another separate patch.

> +
>  	/* Use legacy way until all platforms switch to new bindings */
>  	if (of_device_is_compatible(pdev->dev.of_node, "amlogic,meson-uart"))
>  		ret = meson_uart_probe_clocks_legacy(pdev, port);
> @@ -775,6 +808,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	port->x_char = 0;
>  	port->ops = &meson_uart_ops;
>  	port->fifosize = fifosize;
> +	port->private_data = aml_uart_data;
>  
>  	meson_ports[pdev->id] = port;
>  	platform_set_drvdata(pdev, port);
> 
> base-commit: 3f19fed8d0daed6e0e04b130d203d4333b757901
> 

Thanks,
Neil
