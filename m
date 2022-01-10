Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC448984C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245257AbiAJML6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:11:58 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34720 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiAJMLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:11:53 -0500
Received: by mail-ed1-f51.google.com with SMTP id u25so52762595edf.1;
        Mon, 10 Jan 2022 04:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T+iudPL3VsSt2x3iV93K9ZbDpXljZOLz6OJ0OF++B6M=;
        b=kxyEZtT7twNKprr6H0lbxoqTSL0nNqh7spc3wmGeZJrjSFuJkt41HUDBt/0YjAqFVs
         MoZ5y9qWUMkuhAnyBojG22WDNhNv2SES/lyPlUHFn2oV3LgQYFmfXADKncQWBq58Ccjp
         yhTjLDFVd1gJRTapM3saiRtNjriTfTDx5ohr0CKeOMzfGBPBnO6vzl4YKedyjpU2c+99
         WIrfY2g+TC54NLFLmgVxb/s9x1/yuOeHPDiyhwtnO5JTV8uwnxSVs1zCj7MQw/ph/IZo
         A70I3h6yBbfEIpi+ApeNqrjvqG7zTXG0mOSKNkV2X4mkfcOHfMZt4lHiLQpvyBLy6C3m
         HALQ==
X-Gm-Message-State: AOAM533cJPJrMCpVs+WxgZDfbVTGjtCKqgMLYxII0saohjh4TO8pbFm8
        dF4Vvtf5kz7iLMQ8B7oJDOr5583amz0=
X-Google-Smtp-Source: ABdhPJzif/Q6w3VWyChKykI+EyyNWMu2HjoCoAm9Z3a7c06y9baypapeH1oO72ya4VqWTG2OIpc8YA==
X-Received: by 2002:a17:906:f01:: with SMTP id z1mr29711599eji.346.1641816712256;
        Mon, 10 Jan 2022 04:11:52 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id d9sm3436280edy.55.2022.01.10.04.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 04:11:51 -0800 (PST)
Message-ID: <327f985f-bbf1-00ba-d203-cc9d5bbd955c@kernel.org>
Date:   Mon, 10 Jan 2022 13:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V5 3/5] tty: serial: meson: Using the common clock code
 describe.
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110104214.25321-1-yu.tu@amlogic.com>
 <20220110104214.25321-4-yu.tu@amlogic.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220110104214.25321-4-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Subject: Using the common clock code describe."

Please reformulate that ^^^ -- I cannot make any sense of it. And avoid 
adding a period to the subject. PLease see others' commit logs.

On 10. 01. 22, 11:42, Yu Tu wrote:
> Using the common Clock code to describe the UART baud rate clock
> makes it easier for the UART driver to be compatible with the
> baud rate requirements of the UART IP on different meson chips.



> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/meson_uart.c | 224 +++++++++++++++++++++++---------
>   1 file changed, 163 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 7570958d010c..1004fd0b0c9e 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>   #include <linux/console.h>
>   #include <linux/delay.h>
>   #include <linux/init.h>
> @@ -65,9 +66,7 @@
>   #define AML_UART_RECV_IRQ(c)		((c) & 0xff)
>   
>   /* AML_UART_REG5 bits */
> -#define AML_UART_BAUD_MASK		0x7fffff
>   #define AML_UART_BAUD_USE		BIT(23)
> -#define AML_UART_BAUD_XTAL		BIT(24)
>   
>   #define AML_UART_PORT_NUM		12
>   #define AML_UART_PORT_OFFSET		6
> @@ -76,6 +75,13 @@
>   #define AML_UART_POLL_USEC		5
>   #define AML_UART_TIMEOUT_USEC		10000
>   
> +struct meson_uart_data {
> +	struct uart_port	port;
> +	struct clk		*pclk;
> +	struct clk		*baud_clk;
> +	bool			use_xtal_clk;
> +};
> +
>   static struct uart_driver meson_uart_driver;
>   
>   static struct uart_port *meson_ports[AML_UART_PORT_NUM];
> @@ -268,14 +274,11 @@ static void meson_uart_reset(struct uart_port *port)
>   static int meson_uart_startup(struct uart_port *port)
>   {
>   	u32 val;
> -	int ret = 0;
> +	int ret;
>   
> -	val = readl(port->membase + AML_UART_CONTROL);
> -	val |= AML_UART_CLEAR_ERR;
> -	writel(val, port->membase + AML_UART_CONTROL);
> -	val &= ~AML_UART_CLEAR_ERR;
> -	writel(val, port->membase + AML_UART_CONTROL);
> +	meson_uart_reset(port);

Why is this OK? We didn't use to reset it.

And why is this not done in a separate patch?


> +	val = readl(port->membase + AML_UART_CONTROL);
>   	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
>   	writel(val, port->membase + AML_UART_CONTROL);
>   
> @@ -293,19 +296,17 @@ static int meson_uart_startup(struct uart_port *port)
>   
>   static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
>   {
> +	struct meson_uart_data *private_data = port->private_data;
>   	u32 val;
>   
>   	while (!meson_uart_tx_empty(port))
>   		cpu_relax();
>   
> -	if (port->uartclk == 24000000) {
> -		val = ((port->uartclk / 3) / baud) - 1;
> -		val |= AML_UART_BAUD_XTAL;
> -	} else {
> -		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
> -	}
> +	val = readl(port->membase + AML_UART_REG5);
>   	val |= AML_UART_BAUD_USE;
>   	writel(val, port->membase + AML_UART_REG5);
> +
> +	clk_set_rate(private_data->baud_clk, baud);
>   }
>   
>   static void meson_uart_set_termios(struct uart_port *port,
> @@ -395,11 +396,27 @@ static int meson_uart_verify_port(struct uart_port *port,
>   
>   static void meson_uart_release_port(struct uart_port *port)
>   {
> -	/* nothing to do */
> +	struct meson_uart_data *private_data = port->private_data;
> +
> +	clk_disable_unprepare(private_data->baud_clk);
> +	clk_disable_unprepare(private_data->pclk);
>   }
>   
>   static int meson_uart_request_port(struct uart_port *port)
>   {
> +	struct meson_uart_data *private_data = port->private_data;
> +	int ret;
> +
> +	ret = clk_prepare_enable(private_data->pclk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(private_data->baud_clk);
> +	if (ret) {
> +		clk_disable_unprepare(private_data->pclk);
> +		return ret;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -629,55 +646,105 @@ static struct uart_driver meson_uart_driver = {
>   	.cons		= MESON_SERIAL_CONSOLE,
>   };
>   
> -static inline struct clk *meson_uart_probe_clock(struct device *dev,
> -						 const char *id)
> +#define CLK_NAME(name) \
> +({\
> +	char clk_name[32];\
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev), #name);\
> +	clk_name;\
> +})

This is cryptic and duplicates the variable on the stack. Why not expand 
the macro and delete it then?

> +
> +static struct clk_div_table xtal_div_table[] = {
> +	{ 0, 3  },

An extra space here and there:

> +	{ 1, 1  },
> +	{ 2, 2  },
> +	{ 3, 2  },
> +};
> +
> +static int meson_uart_probe_clocks(struct uart_port *port)
>   {
> -	struct clk *clk = NULL;
> -	int ret;
> +	struct meson_uart_data *private_data = port->private_data;
> +	struct clk *clk_baud, *clk_xtal;
> +	struct clk_hw *hw;
> +	struct clk_parent_data use_xtal_mux_parents[2] = {
> +		{ .index = -1, },
> +		{ .index = -1, },
> +	};
>   
> -	clk = devm_clk_get(dev, id);
> -	if (IS_ERR(clk))
> -		return clk;
> +	private_data->pclk = devm_clk_get(port->dev, "pclk");
> +	if (IS_ERR(private_data->pclk))
> +		return dev_err_probe(port->dev, PTR_ERR(private_data->pclk),
> +				     "Failed to get the 'pclk' clock\n");
>   
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "couldn't enable clk\n");
> -		return ERR_PTR(ret);
> +	clk_baud = devm_clk_get(port->dev, "baud");
> +	if (IS_ERR(clk_baud)) {
> +		dev_err(port->dev, "Failed to get the 'baud' clock\n");
> +		return PTR_ERR(clk_baud);
>   	}
>   
> -	devm_add_action_or_reset(dev,
> -			(void(*)(void *))clk_disable_unprepare,
> -			clk);
> -
> -	return clk;
> -}
> -
> -static int meson_uart_probe_clocks(struct platform_device *pdev,
> -				   struct uart_port *port)
> -{
> -	struct clk *clk_xtal = NULL;
> -	struct clk *clk_pclk = NULL;
> -	struct clk *clk_baud = NULL;
> -
> -	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
> -	if (IS_ERR(clk_pclk))
> -		return PTR_ERR(clk_pclk);
> -
> -	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
> +	clk_xtal = devm_clk_get(port->dev, "xtal");
>   	if (IS_ERR(clk_xtal))
> -		return PTR_ERR(clk_xtal);
> -
> -	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
> -	if (IS_ERR(clk_baud))
> -		return PTR_ERR(clk_baud);
> +		return dev_err_probe(port->dev, PTR_ERR(clk_xtal),
> +				     "Failed to get the 'xtal' clock\n");
> +
> +	if (private_data->use_xtal_clk) {
> +		hw = devm_clk_hw_register_divider_table(port->dev,
> +							CLK_NAME(xtal_div),
> +							__clk_get_name(clk_baud),
> +							CLK_SET_RATE_NO_REPARENT,
> +							port->membase + AML_UART_REG5,
> +							26, 2,
> +							CLK_DIVIDER_READ_ONLY,
> +							xtal_div_table, NULL);
> +		if (IS_ERR(hw))
> +			return PTR_ERR(hw);
> +
> +		use_xtal_mux_parents[1].hw = hw;
> +	} else {
> +		hw = devm_clk_hw_register_fixed_factor(port->dev,
> +						       CLK_NAME(clk81_div4),
> +						       __clk_get_name(clk_baud),
> +						       CLK_SET_RATE_NO_REPARENT,
> +						       1, 4);
> +		if (IS_ERR(hw))
> +			return PTR_ERR(hw);
> +
> +		use_xtal_mux_parents[0].hw = hw;
> +	}
>   
> -	port->uartclk = clk_get_rate(clk_baud);
> +	hw = __devm_clk_hw_register_mux(port->dev, NULL,
> +					CLK_NAME(use_xtal),
> +					ARRAY_SIZE(use_xtal_mux_parents),
> +					NULL, NULL,
> +					use_xtal_mux_parents,
> +					CLK_SET_RATE_PARENT,
> +					port->membase + AML_UART_REG5,
> +					24, 0x1,
> +					CLK_MUX_READ_ONLY,
> +					NULL, NULL);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	port->uartclk = clk_hw_get_rate(hw);
> +
> +	hw = devm_clk_hw_register_divider(port->dev,
> +					  CLK_NAME(baud_div),
> +					  clk_hw_get_name(hw),
> +					  CLK_SET_RATE_PARENT,
> +					  port->membase + AML_UART_REG5,
> +					  0, 23,
> +					  CLK_DIVIDER_ROUND_CLOSEST,
> +					  NULL);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	private_data->baud_clk = clk_hw_get_clk(hw, "baud_rate");
>   
>   	return 0;
>   }



-- 
js
suse labs
