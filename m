Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD57650B750
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447525AbiDVMdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447514AbiDVMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:33:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F75D42A35
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:30:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso5281168wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=v7ecTnOqbdsbk7Pw227c6DG9vOtIAPt6MKtYrhXpkiQ=;
        b=VwVPMiD+CefKqOujb+T8az2fLb5De9m+2SHuVfSXI8rwPC3AyUz3yEXjXhB3muH1Yx
         A2XlvIC8M0k593cQ/tEekEYlQgwNyfDYKyl6zd6yLpGnb74/wHAPF2On4IB2y22Y3uC/
         orBwzbK0jKpsYybd545214GpzMCk3VRBioGmOZOoeFDq2dDVyg2jI+J5XCoHtFk8uV9k
         FFZBe7waycOAg9fkM0w4cTIGJIVhadLq1zwhPp7RcH+FY1M1GAET5ag4oC6sXMZIq61t
         b6pOpvMjiPW6KDWftcBNkPnWMjTAeoftFC1NM4beVi7fit/eC3c409yCsQmoTY6swysk
         CmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=v7ecTnOqbdsbk7Pw227c6DG9vOtIAPt6MKtYrhXpkiQ=;
        b=zm3sBin66847ZtqpSTVKyH0NX3fMvWyn+wHHk+s7h1zFljNnwTPk2w3SYMa6OC+2D2
         VAcpOKFWPxa4YlVtBmbXkxjNYJmCcDN57PpU+93JAqBWRdeTW6k30Kx6bE9B1jBFI26H
         jPiXmDagmIdvCWLcBAK3SfnIqfMBsarIctFpqWh8tGYQYVdeB38fzTx0NKdj8vVfJbMI
         iDUHTozRDlLhsH2W7xdE14WsksMMUbic4ivJ4b4vIOwfQtjPmk/mLeKc/LXSYpl6/8Wl
         6gZ3WYYaX9TKhggLOtZ4nyHO4ERE/kO7hy38PiCXBjnLAm6sd3jfkzrWtXX4hY+FXfPa
         v5jw==
X-Gm-Message-State: AOAM532CwMlFkzd54QJSRQ03rCsVWmjXGyKgXvs/RoX7r9vNeAslTokz
        bxENrwjV6qo0v9/h+C6awUAFVw==
X-Google-Smtp-Source: ABdhPJyAlAVcFMr1BGoeseZyuFPXHnY5LyfLff3YpdPx7SxnhN6lS408cqrbj01PbjPgGfIF3POBbQ==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr13456690wmp.22.1650630608626;
        Fri, 22 Apr 2022 05:30:08 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49? ([2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b0020a992ce354sm1930835wrc.76.2022.04.22.05.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 05:30:07 -0700 (PDT)
Message-ID: <d4d7e8a1-6eee-ac2d-cf8f-0a71dd4dabd8@baylibre.com>
Date:   Fri, 22 Apr 2022 14:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 1/2] tty: serial: meson: Add a 12MHz internal clock
 rate to calculate baud rate in order to meet the baud rate requirements of
 special BT modules
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220422111320.19234-1-yu.tu@amlogic.com>
 <20220422111320.19234-2-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220422111320.19234-2-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 13:13, Yu Tu wrote:
> A /2 divider over XTAL was introduced since G12A, and is preferred
> to be used over the still present /3 divider since it provides much
> closer frequencies vs the request baudrate. Especially the BT module
> uses 3Mhz baud rate. 8Mhz calculations can lead to baud rate bias,
> causing some problems.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/meson_uart.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 8e59624935af..58bd2723c004 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -68,6 +68,7 @@
>   #define AML_UART_BAUD_MASK		0x7fffff
>   #define AML_UART_BAUD_USE		BIT(23)
>   #define AML_UART_BAUD_XTAL		BIT(24)
> +#define AML_UART_BAUD_XTAL_DIV2		BIT(27)
>   
>   #define AML_UART_PORT_NUM		12
>   #define AML_UART_PORT_OFFSET		6
> @@ -80,6 +81,10 @@ static struct uart_driver meson_uart_driver;
>   
>   static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>   
> +struct meson_uart_data {
> +	bool has_xtal_div2;
> +};
> +
>   static void meson_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>   {
>   }
> @@ -293,13 +298,20 @@ static int meson_uart_startup(struct uart_port *port)
>   
>   static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
>   {
> -	u32 val;
> +	const struct meson_uart_data *private_data = port->private_data;
> +	u32 val = 0;
>   
>   	while (!meson_uart_tx_empty(port))
>   		cpu_relax();
>   
>   	if (port->uartclk == 24000000) {
> -		val = DIV_ROUND_CLOSEST(port->uartclk / 3, baud) - 1;
> +		unsigned int xtal_div = 3;
> +
> +		if (private_data && private_data->has_xtal_div2) {
> +			xtal_div = 2;
> +			val |= AML_UART_BAUD_XTAL_DIV2;
> +		}
> +		val |= DIV_ROUND_CLOSEST(port->uartclk / xtal_div, baud) - 1;
>   		val |= AML_UART_BAUD_XTAL;
>   	} else {
>   		val =  DIV_ROUND_CLOSEST(port->uartclk / 4, baud) - 1;
> @@ -749,6 +761,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	port->x_char = 0;
>   	port->ops = &meson_uart_ops;
>   	port->fifosize = fifosize;
> +	port->private_data = (void *)device_get_match_data(&pdev->dev);
>   
>   	meson_ports[pdev->id] = port;
>   	platform_set_drvdata(pdev, port);

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
