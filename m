Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1D84C6F11
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiB1OOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiB1OOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:14:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE67424A5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:13:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d17so15641307wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hxrYZWbf+t1SkWdBj7V3c0s4/eY5PWXdIAHGF4Ng3mE=;
        b=sjkiMNjntMCkg8BhMsA+AT9L4II8B+wM8IUbHEQenvbEZ6m657vD5ltKHYBDGWKACo
         cbHq35b0bj3mVfcJoFPXZeY9tSQimWPqWJ9LrwBOZoWF4VlFPIk+BvVoEByVvfGzZut0
         GrnGXZlDlnOwjaEOgBUCv8hixa3e9Wz04Du8/x3MGH2SyNAmmYEccx6szKnawGOVh5av
         34+wA0d3v7HXJoVNQQIH70gTgJzp/OLMAz6tacnwa4C5s58aNhOTS5BtEUsm/0KAKCIP
         wVA38VY2eq9I7mxcpZnsXyiREXYqEAETnPDcM2eWcBn2frCHmS0usKXL8colTZ9ToMVt
         5GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hxrYZWbf+t1SkWdBj7V3c0s4/eY5PWXdIAHGF4Ng3mE=;
        b=0wlXy4LMvewylg1pMFZYyag/VPuUmB/Y0+DHN6mZ/YoDFPmQ+tNZ6V+SYuVCAmXKxy
         sQidESR/AQXeCmgcy5p7xo4KU48osZ3pwebE5PtRATL/zbrad+KEHNBIL/jaGiBd3uLi
         tEXjFFJgoPgLr6t/Jp/GpzVmLlyNecsHvi80E0pyIfDv55dK5w+gqnVCIZaA1F/KWjmT
         z2caKLE+n6Bz1apd79S8ki3+dJlfnxdGC6Hk2cH+JXL7hSRPHAtJ1CgoylOuXbJnjttg
         YvdYjUJAERLm9C/TVG/Ex9R3Ok7p62c26wSjZELv3Dj2knzrxUkMWwil4cyeZmq3BP+y
         y7sw==
X-Gm-Message-State: AOAM531uVi7du4hYcArSsQ7dY02NQ1134tV83vc0YaIaDAytd+9UzhzQ
        dtjVoff59pDc7SCnEAcjCwsQGw==
X-Google-Smtp-Source: ABdhPJwYaUoKYjigKtVEJBaIMvwSs88l9Q8uTGiDZw7db/brtNNBh2cmfs/+K0MqPnGExy27Xga+aA==
X-Received: by 2002:a5d:6052:0:b0:1ed:9fcc:3055 with SMTP id j18-20020a5d6052000000b001ed9fcc3055mr16885437wrt.438.1646057630394;
        Mon, 28 Feb 2022 06:13:50 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:6431:1dc7:b58f:6282? ([2001:861:44c0:66c0:6431:1dc7:b58f:6282])
        by smtp.gmail.com with ESMTPSA id a9-20020a05600c2d4900b0038100a95903sm14131513wmg.41.2022.02.28.06.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:13:50 -0800 (PST)
Message-ID: <29b34655-f820-39c9-4363-878481cd3f63@baylibre.com>
Date:   Mon, 28 Feb 2022 15:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220228135530.6918-1-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220228135530.6918-1-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/02/2022 14:55, Yu Tu wrote:
> Describes the calculation of the UART baud rate clock using a clock
> frame. Forgot to add in Kconfig kernel test Robot compilation error
> due to COMMON_CLK dependency.
> 
> Fixes: ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)

As I already replied on V2 of this patch, you're invited to apply these fixes directly
on the next version of your "Use CCF to describe the UART baud rate clock" patchset
and not as a separate patch.

Thanks,
Neil

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/Kconfig      |  1 +
>   drivers/tty/serial/meson_uart.c | 37 +++++++++++++++++++++++----------
>   2 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index e952ec5c7a7c..a0f2b82fc18b 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -200,6 +200,7 @@ config SERIAL_KGDB_NMI
>   config SERIAL_MESON
>   	tristate "Meson serial port support"
>   	depends on ARCH_MESON || COMPILE_TEST
> +	depends on COMMON_CLK
>   	select SERIAL_CORE
>   	help
>   	  This enables the driver for the on-chip UARTs of the Amlogic
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index bf6be5468aaf..972f210f3492 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -780,28 +780,37 @@ static int meson_uart_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> +	if (irq < 0) {
> +		ret = irq;
> +		goto err_out_clk_disable;
> +	}
>   
>   	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
>   
>   	if (meson_ports[pdev->id]) {
>   		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto err_out_clk_disable;
>   	}
>   
>   	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
> -	if (!port)
> -		return -ENOMEM;
> +	if (!port) {
> +		ret = -ENOMEM;
> +		goto err_out_clk_disable;
> +	}
>   
>   	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
> -	if (IS_ERR(port->membase))
> -		return PTR_ERR(port->membase);
> +	if (IS_ERR(port->membase)) {
> +		ret = PTR_ERR(port->membase);
> +		goto err_out_clk_disable;
> +	}
>   
>   	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
>   				    GFP_KERNEL);
> -	if (!private_data)
> -		return -ENOMEM;
> +	if (!private_data) {
> +		ret = -ENOMEM;
> +		goto err_out_clk_disable;
> +	}
>   
>   	if (device_get_match_data(&pdev->dev))
>   		private_data->use_xtal_clk = true;
> @@ -822,7 +831,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   
>   	ret = meson_uart_probe_clocks(port);
>   	if (ret)
> -		return ret;
> +		goto err_out_clk_disable;
>   
>   	meson_ports[pdev->id] = port;
>   	platform_set_drvdata(pdev, port);
> @@ -831,9 +840,15 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	meson_uart_reset(port);
>   
>   	ret = uart_add_one_port(&meson_uart_driver, port);
> -	if (ret)
> +	if (ret) {
>   		meson_ports[pdev->id] = NULL;
> +		goto err_out_clk_disable;
> +	}
> +
> +	return 0;
>   
> +err_out_clk_disable:
> +	clk_disable_unprepare(pclk);
>   	return ret;
>   }
>   
> 
> base-commit: c2faf737abfb10f88f2d2612d573e9edc3c42c37

