Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6B4C6622
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiB1Jw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiB1Jw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:52:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6CB6A074
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:52:18 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d3so14496043wrf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=M/yV7fD7mHF7OTSsIIPYhLDMmhlfZbNKyzT+LzGJue4=;
        b=ud8OGDY5wYIrh7CamNCmK3sqTXwVuvkwA07RAkFMKltyntGbzNnczWNjQDqEQIi3+s
         HBq2he/ypRr6rZ72evx4KLin8zczZkQSfywuQoOxn83kfCiqQb9Gz1sVdG2HwMIocgC5
         Uylj1VMPmoPgT0jdgyQfgcwIAGzigu4lX1LOdvj7/G2U/x3G9RY+Uae8ioRxUJvkVAWZ
         OY+Ap63fcbkLectnvyZCPCJ5pUW72c1ufQkvJri9WF6pHM33q3iENhnU/a4qlmpECkXp
         hi9bfekLkkDLA05kiK9cUhOD8SA/gv+YPQdIdLs6zwhUhfWnpTLIYY8nDU0MytrfnpLH
         pRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=M/yV7fD7mHF7OTSsIIPYhLDMmhlfZbNKyzT+LzGJue4=;
        b=NmRANIwOFd31uLhj49/rZCaOfI2Tc4o4G/rG+8+rIFYNdjbSEAgRjutdnNDeO2Lelr
         +03gMn6TfpJZ+LR49R41t8Vi8JxWmekVYIRvujo8OQo1/WxgvWrJcgEklmCvvkTojkTF
         7pv2xcK8J9n7mmIKcRB6e3K4bNegyNd3iMQX23YkpPgNVuflTGqtBxPCHod8cgV7kL0A
         ue8TdeS2TSVLVySSCxocxYoTM4g9/+wHjWLrLuuJBa8jsDrRMLIQt3WAXhl1MrPdYTgz
         CKpR49ZP6LkeohKdARlNheOFqWnyE/6ZO6hpAbMeK4DNOpb7JdJb/K37NM+HinySrJzZ
         uxHA==
X-Gm-Message-State: AOAM531MAQc2SvpcRhMOCk3qYh9Cs1HeB3EgaqDLjie2Q6NQpcdcXEwO
        VkD1hpgy4OWcTqPnDNdFFkLodA==
X-Google-Smtp-Source: ABdhPJzUoTEOIDAZiRlAiW0IfHjb3TQL6fWjRKAgUiavd0Y12ITtwkuQQZKjLJZLbow4eFp397CYBQ==
X-Received: by 2002:adf:a486:0:b0:1ed:9cfe:179d with SMTP id g6-20020adfa486000000b001ed9cfe179dmr15847522wrb.113.1646041937017;
        Mon, 28 Feb 2022 01:52:17 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:6431:1dc7:b58f:6282? ([2001:861:44c0:66c0:6431:1dc7:b58f:6282])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b0038167e239a2sm3232887wmq.19.2022.02.28.01.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:52:16 -0800 (PST)
Message-ID: <790952bd-b066-0b41-545c-1f65cd4244af@baylibre.com>
Date:   Mon, 28 Feb 2022 10:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] tty: serial: meson: Fix the compile link error
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
References: <20220228090351.9976-1-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220228090351.9976-1-yu.tu@amlogic.com>
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

i,

On 28/02/2022 10:03, Yu Tu wrote:
> Describes the calculation of the UART baud rate clock using a clock
> frame. Forgot to add in Kconfig kernel test Robot compilation error
> due to COMMON_CLK dependency.
> 
> Fixes: 44023b8e1f14 ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)

AFAIK this commit is not in an uptream/feature branch, so you should simply fix your `Use CCF to describe the UART baud rate clock` instead.

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

