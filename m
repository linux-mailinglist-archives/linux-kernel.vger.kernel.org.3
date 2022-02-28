Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51614C6A38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiB1LX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiB1LX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:23:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED13D3E5C7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:23:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p4so5483512wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=I0M73zgTm6fdqFCSX4Mv+soIOBZTm2a5gGNcio24Bk8=;
        b=8KpgDRfWd4FFY6XIkzTwkIrKnjDHFyllXpUF2qr3r/8Yz6muqSJocj1AosxCfJCzM4
         eKRBlKzaTsvaGvhCGppFYVCyV86r0Tl1sNLz7tnguwgI7+poRYYgJr+48hCaooxwZikm
         Si4R1uxQJJJzhIxNQEdHdyo+wpb4uDzoB3oVpzlgEptiqkifxBjKMFltSavqK+bKkq1u
         7hUYoXAd7m+2dOzCMRSgslpnPjTgeGIFrS1vuCEagc2/ZgLBpZ9ebB80rTlCEDTMP/cx
         lgb4WskYOoIIP0h9FDyTj/OLHTHXTYXNa8lfeNUPQih0f8ea+1AI6n/aWneiIzQIXZQp
         g48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=I0M73zgTm6fdqFCSX4Mv+soIOBZTm2a5gGNcio24Bk8=;
        b=lhyzLcIg81CF7coV6QycfsZdjkUk2XtPCP82TTaH9eugzvbCM8IGuLV0AHPLc0o/yj
         KMTrwu81rhAdINZ3w9T1MAyOa6w2ppv9AyfHcDrVTGtglgagAbJdxDXq1g2S2Ur0BbGc
         AgfNFRe/xec1h6GOGn1UK6Jxn9+j1vyj6UDNDIId2bDXVbGf3UnaEPGUgFI4zUtJUw1V
         0NCCKg+DdPjQyERlf6x5s5YtbGT2A1+wZzrFWT0/JnZGkOniUJLXARb33KQPtEhMFP9B
         tHWBZrIrse4mMbhi3UP6fh+KaMhO3Hwwx+OsrqZHQdoDgVhld6vkr/dQzMCwrd2Olpqa
         4TXw==
X-Gm-Message-State: AOAM531uKxnr0bFvaX0lzyUrmJVfepGrSvMMRqSxAAJruMZpgxCFBHMS
        4MTnxvONVet77pU4YDyGnU6yAYmfwd6Klg==
X-Google-Smtp-Source: ABdhPJxlKXYK5UdjvSS5Z7A5mUd4ORlOr+vm7qeM6WOdupvKCpL9vwTi9yjzhVQUU7m1W9jhLUBt1Q==
X-Received: by 2002:a05:600c:a0a:b0:350:564b:d55e with SMTP id z10-20020a05600c0a0a00b00350564bd55emr12581037wmp.124.1646047395422;
        Mon, 28 Feb 2022 03:23:15 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b0037bf934bca3sm15943128wmq.17.2022.02.28.03.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:23:14 -0800 (PST)
References: <20220225073922.3947-1-yu.tu@amlogic.com>
 <20220225073922.3947-4-yu.tu@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V7 3/6] tty: serial: meson: Describes the calculation of
 the UART baud rate clock using a clock frame
Date:   Mon, 28 Feb 2022 12:10:36 +0100
In-reply-to: <20220225073922.3947-4-yu.tu@amlogic.com>
Message-ID: <1j4k4jxmji.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 25 Feb 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:

> Using the common Clock code to describe the UART baud rate clock
> makes it easier for the UART driver to be compatible with the
> baud rate requirements of the UART IP on different meson chips.
>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/tty/serial/meson_uart.c | 194 +++++++++++++++++++++++---------
>  1 file changed, 142 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 7570958d010c..4768d51fac70 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/console.h>
>  #include <linux/delay.h>
>  #include <linux/init.h>
> @@ -65,9 +66,7 @@
>  #define AML_UART_RECV_IRQ(c)		((c) & 0xff)
>  
>  /* AML_UART_REG5 bits */
> -#define AML_UART_BAUD_MASK		0x7fffff
>  #define AML_UART_BAUD_USE		BIT(23)
> -#define AML_UART_BAUD_XTAL		BIT(24)
>  
>  #define AML_UART_PORT_NUM		12
>  #define AML_UART_PORT_OFFSET		6
> @@ -76,6 +75,11 @@
>  #define AML_UART_POLL_USEC		5
>  #define AML_UART_TIMEOUT_USEC		10000
>  
> +struct meson_uart_data {
> +	struct clk	*baud_clk;
> +	bool		use_xtal_clk;
> +};
> +
>  static struct uart_driver meson_uart_driver;
>  
>  static struct uart_port *meson_ports[AML_UART_PORT_NUM];
> @@ -293,19 +297,17 @@ static int meson_uart_startup(struct uart_port *port)
>  
>  static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
>  {
> +	struct meson_uart_data *private_data = port->private_data;
>  	u32 val;
>  
>  	while (!meson_uart_tx_empty(port))
>  		cpu_relax();
>  
> -	if (port->uartclk == 24000000) {
> -		val = ((port->uartclk / 3) / baud) - 1;
> -		val |= AML_UART_BAUD_XTAL;
> -	} else {
> -		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
> -	}
> +	val = readl(port->membase + AML_UART_REG5);
>  	val |= AML_UART_BAUD_USE;
>  	writel(val, port->membase + AML_UART_REG5);
> +
> +	clk_set_rate(private_data->baud_clk, baud);
>  }
>  
>  static void meson_uart_set_termios(struct uart_port *port,
> @@ -395,11 +397,20 @@ static int meson_uart_verify_port(struct uart_port *port,
>  
>  static void meson_uart_release_port(struct uart_port *port)
>  {
> -	/* nothing to do */
> +	struct meson_uart_data *private_data = port->private_data;
> +
> +	clk_disable_unprepare(private_data->baud_clk);
>  }
>  
>  static int meson_uart_request_port(struct uart_port *port)
>  {
> +	struct meson_uart_data *private_data = port->private_data;
> +	int ret;
> +
> +	ret = clk_prepare_enable(private_data->baud_clk);
> +	if (ret)
> +		return ret;
> +

I think we already discussed that. This is yet another behavior change
Previously, enabling the clock was done at probe time.

It's fine to change it, if there is a justification, but not in the same
change as the rework of the divider

>  	return 0;
>  }
>  
> @@ -629,57 +640,106 @@ static struct uart_driver meson_uart_driver = {
>  	.cons		= MESON_SERIAL_CONSOLE,
>  };
>  
> -static inline struct clk *meson_uart_probe_clock(struct device *dev,
> -						 const char *id)
> -{
> -	struct clk *clk = NULL;
> -	int ret;
> -
> -	clk = devm_clk_get(dev, id);
> -	if (IS_ERR(clk))
> -		return clk;
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "couldn't enable clk\n");
> -		return ERR_PTR(ret);
> -	}
> +static const struct clk_div_table xtal_div_table[] = {
> +	{ 0, 3 },
> +	{ 1, 1 },
> +	{ 2, 2 },
> +	{ 3, 2 },
> +};
>  
> -	devm_add_action_or_reset(dev,
> -			(void(*)(void *))clk_disable_unprepare,
> -			clk);
> +static u32 use_xtal_mux_table;
>  
> -	return clk;
> -}
> -
> -static int meson_uart_probe_clocks(struct platform_device *pdev,
> -				   struct uart_port *port)
> +static int meson_uart_probe_clocks(struct uart_port *port)
>  {
> -	struct clk *clk_xtal = NULL;
> -	struct clk *clk_pclk = NULL;
> -	struct clk *clk_baud = NULL;
> +	struct meson_uart_data *private_data = port->private_data;
> +	struct clk *clk_baud, *clk_xtal;
> +	struct clk_hw *hw, *clk81_div4_hw;
> +	char clk_name[32];
> +	struct clk_parent_data use_xtal_mux_parents;
>  
> -	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
> -	if (IS_ERR(clk_pclk))
> -		return PTR_ERR(clk_pclk);
> +	clk_baud = devm_clk_get(port->dev, "baud");
> +	if (IS_ERR(clk_baud)) {
> +		dev_err(port->dev, "Failed to get the 'baud' clock\n");
> +		return PTR_ERR(clk_baud);
> +	}

Calling devm_clk_get() would not be necessary if you used "fw_name" in
the parent table. Same bellow

>  
> -	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
> +	clk_xtal = devm_clk_get(port->dev, "xtal");
>  	if (IS_ERR(clk_xtal))
> -		return PTR_ERR(clk_xtal);
> -
> -	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
> -	if (IS_ERR(clk_baud))
> -		return PTR_ERR(clk_baud);
> +		return dev_err_probe(port->dev, PTR_ERR(clk_xtal),
> +				     "Failed to get the 'xtal' clock\n");
> +
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 "clk81_div4");
> +	clk81_div4_hw = devm_clk_hw_register_fixed_factor(port->dev,
> +							  clk_name,
> +							  __clk_get_name(clk_baud),
> +							  CLK_SET_RATE_NO_REPARENT,
> +							  1, 4);
> +	if (IS_ERR(clk81_div4_hw))
> +		return PTR_ERR(clk81_div4_hw);

So, whatever the chip type - you register a fixed 4 divider ....

> +
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 "xtal_div");
> +	hw = devm_clk_hw_register_divider_table(port->dev,
> +						clk_name,
> +						__clk_get_name(clk_baud),
> +						CLK_SET_RATE_NO_REPARENT,
> +						port->membase + AML_UART_REG5,
> +						26, 2,
> +						CLK_DIVIDER_READ_ONLY,
> +						xtal_div_table, NULL);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	if (private_data->use_xtal_clk) {
> +		use_xtal_mux_table = 1;
> +		use_xtal_mux_parents.hw = hw;
> +	} else {
> +		use_xtal_mux_parents.hw = clk81_div4_hw;

... which you may end up not using in the end
This is bad.

> +	}
>  
> -	port->uartclk = clk_get_rate(clk_baud);
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 "use_xtal");
> +	hw = __devm_clk_hw_register_mux(port->dev, NULL,
> +					clk_name,
> +					1,
> +					NULL, NULL,
> +					&use_xtal_mux_parents,
> +					CLK_SET_RATE_PARENT,
> +					port->membase + AML_UART_REG5,
> +					24, 0x1,
> +					CLK_MUX_READ_ONLY,
> +					&use_xtal_mux_table, NULL);
> +
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	port->uartclk = clk_hw_get_rate(hw);
> +
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 "baud_div");
> +	hw = devm_clk_hw_register_divider(port->dev,
> +					  clk_name,
> +					  clk_hw_get_name(hw),
> +					  CLK_SET_RATE_PARENT,
> +					  port->membase + AML_UART_REG5,
> +					  0, 23,
> +					  CLK_DIVIDER_ROUND_CLOSEST,
> +					  NULL);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	private_data->baud_clk = hw->clk;
>  
>  	return 0;
>  }
>  
>  static int meson_uart_probe(struct platform_device *pdev)
>  {
> +	struct meson_uart_data *private_data;
>  	struct resource *res_mem;
>  	struct uart_port *port;
> +	struct clk *pclk;
>  	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>  	int ret = 0;
>  	int irq;
> @@ -705,6 +765,15 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	if (!res_mem)
>  		return -ENODEV;
>  
> +	pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
> +				     "Failed to get the 'pclk' clock\n");
> +
> +	ret = clk_prepare_enable(pclk);
> +	if (ret)
> +		return ret;
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> @@ -724,9 +793,13 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	if (IS_ERR(port->membase))
>  		return PTR_ERR(port->membase);
>  
> -	ret = meson_uart_probe_clocks(pdev, port);
> -	if (ret)
> -		return ret;
> +	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
> +				    GFP_KERNEL);
> +	if (!private_data)
> +		return -ENOMEM;
> +
> +	if (device_get_match_data(&pdev->dev))
> +		private_data->use_xtal_clk = true;

As long as the device matches a compatible below, the flag will end up
'true', regardless of values in the the dt_match table.

I don't think this is the intended behavior.
It highlights that proper testing of this series is important.

Being at Amlogic, I'm sure you can test on more than just g12a and s4

>  
>  	port->iotype = UPIO_MEM;
>  	port->mapbase = res_mem->start;
> @@ -740,6 +813,11 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	port->x_char = 0;
>  	port->ops = &meson_uart_ops;
>  	port->fifosize = fifosize;
> +	port->private_data = private_data;
> +
> +	ret = meson_uart_probe_clocks(port);
> +	if (ret)
> +		return ret;
>  
>  	meson_ports[pdev->id] = port;
>  	platform_set_drvdata(pdev, port);
> @@ -766,10 +844,22 @@ static int meson_uart_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id meson_uart_dt_match[] = {
> -	{ .compatible = "amlogic,meson6-uart" },
> -	{ .compatible = "amlogic,meson8-uart" },
> -	{ .compatible = "amlogic,meson8b-uart" },
> -	{ .compatible = "amlogic,meson-gx-uart" },
> +	{
> +		.compatible = "amlogic,meson6-uart",
> +		.data = (void *)false,
> +	},
> +	{
> +		.compatible = "amlogic,meson8-uart",
> +		.data = (void *)false,
> +	},
> +	{
> +		.compatible = "amlogic,meson8b-uart",
> +		.data = (void *)false,
> +	},
> +	{
> +		.compatible = "amlogic,meson-gx-uart",
> +		.data = (void *)true,
> +	},
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_uart_dt_match);

