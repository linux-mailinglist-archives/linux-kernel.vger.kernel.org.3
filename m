Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8B85370D5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiE2Lmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiE2Lm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:42:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A261208D
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:42:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f21so16070778ejh.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dSEhkI5/HjahBy6UP5TFGxBpf96/So5wb+ZELnO38Tk=;
        b=B0+dB13nGah3aoB5h0BX1vGTeSIuLpvUZVLGLtOU0Ige3ZT7Mv86eaKeDjVSl5aEvR
         5AJrO7tccJQCV7hFqelBIMJhSmPhSYXg/y78H5x0QMuIsN06pXbGaQhGGAfEsq2FDSq4
         PVZRnrNmS5gOcJntVz3solI4hbyb5WHQhXBN6XVYnA7ke33TNXQbKWRDe36YULhJLY5b
         oghCZfhfFdPHSrbVzZIqWcLAR3ZUSH9wmqvPpN+VrWPeivL/NVOmCc8bP/Cia/pFSmP9
         TnrWTCP7m210d1AaRvZaNi9wIhJtO1MEu+R2sxKBzlXSU+R0IrUGfqVNw5DADZMWPYd7
         sClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dSEhkI5/HjahBy6UP5TFGxBpf96/So5wb+ZELnO38Tk=;
        b=mFgPsSCibWhNDJVF+LioNl0oHjsA+YPoilscFqOTn2Rg+afcNiyw2Q3e0CJruKvE87
         O0k8Uh6thtjt8/dkKTjC4EaLz2amlj+P8TP1kAYLmeoootaCcyzoEcX58lluTFBRrrEo
         EJRbGu2alVPaoyZpl8KHW7j+6h3ChEBbbfaDPIVDni4nFFHSCJreljZHnH9EdaoA9Nv0
         ImshQb+ZBAORHcW0HzcpRYjPnZaKX8LCpB3Ke5xurA2USL20lX4jP1JNZj4B2zwKQugB
         S75nZk/UdSoONUjbqlWpuokUINO45c92cVMy2G3aHdazo9mYn+wfddZlQOLknFMN4VHf
         ELuw==
X-Gm-Message-State: AOAM530vQqvdAl9UBLwA7OA7Iwy5Vo1gERXwyG5zl41a5QVbkDmk7jLQ
        nTovw0Ubl2PjSzWtm0nJdCqbfw==
X-Google-Smtp-Source: ABdhPJxiDFkuQV1fhHwlypWV/rr5uUGU6p0s8cO3IcKiJRhA1hAEp0D8+jLm8ghYfFiA/G/QDwr6NQ==
X-Received: by 2002:a17:907:7f0b:b0:6ff:4502:9c2f with SMTP id qf11-20020a1709077f0b00b006ff45029c2fmr8130716ejc.532.1653824545674;
        Sun, 29 May 2022 04:42:25 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709063e1000b006f4c557b7d2sm3088181eji.203.2022.05.29.04.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 04:42:25 -0700 (PDT)
Message-ID: <8c14368b-3d28-f6de-c7fa-1e00dd1ca2ba@linaro.org>
Date:   Sun, 29 May 2022 13:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] misc: uwb: nxp: sr1xx: UWB driver support for
 sr1xx series chip
Content-Language: en-US
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, ashish.deshpande@nxp.com,
        rvmanjumce@gmail.com
References: <20220527184351.3829543-1-manjunatha.venkatesh@nxp.com>
 <20220527184351.3829543-4-manjunatha.venkatesh@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220527184351.3829543-4-manjunatha.venkatesh@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2022 20:43, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol.
> 
> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 
> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> Interface (UCI).  The corresponding details are available in the FiRa
> Consortium Website (https://www.firaconsortium.org/).
> 
> Internally driver will handle two modes of operation.
> 1.HBCI mode (sr1xx BootROM Code Interface)
> Firmware download uses HBCI ptotocol packet structure which is
> Nxp proprietary,Firmware File(.bin) stored in user space context
> and during device init sequence pick the firmware packet in chunk
> and send it to the driver with write() api call.
> 
> After the firmware download sequence at the end UWBS will
> send device status notification and its indication of device entered
> UCI mode.
> Here after any command/response/notification will follow
> UCI packet structure.
> 
> 2.UCI mode (UWB Command interface)
> Once Firmware download finishes sr1xx will switch to UCI mode.
> Then driver exchange command/response/notification as per the FIRA UCI
> standard format between user space and sr1xx device.
> Any response or notification received from sr1xx through SPI line
> will convey to user space.
> 
> Its Interrupt based driver and IO Handshake needed with SR1XX Family of
> SOCs.
> This driver needs dts config update as per the sr1xx data sheet.
> Corresponding document available in Documentation/devicetree/bindings/uwb
> 
> Message-ID: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>

Same comment.


> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---
> Changes since v3:
>   - Commit Message Description updated
>   - Renamed file from sr1xx.c to nxp-sr1xx.c
>   - Removed unwanted header files
>   - Removed sr1xx.h file since its not required for single source file
> 

Thank you for your patch. There is something to discuss/improve.

>  drivers/misc/Kconfig     |  12 +
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/nxp-sr1xx.c | 834 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 847 insertions(+)
>  create mode 100644 drivers/misc/nxp-sr1xx.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..4f81d5758940 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -483,6 +483,18 @@ config OPEN_DICE
>  
>  	  If unsure, say N.
>  
> +config NXP_UWB

It is not a misc driver. It is communication driver, so closer to
network. Please find appropriate subsystem.

> +        tristate "Nxp UCI(Uwb Command Interface) protocol driver support"

Isn't the name of company NXP?

> +        depends on SPI
> +        help
> +        This option enables the UWB driver for Nxp sr1xx

The same...

> +        device. Such device supports UCI packet structure,
> +        FiRa compliant.
> +
> +        Say Y here to compile support for sr1xx into the kernel or
> +        say M to compile it as a module. The module will be called
> +        sr1xx.ko
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 70e800e9127f..d4e6e4f1ec29 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
>  obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> +obj-$(CONFIG_NXP_UWB) 		+= nxp-sr1xx.o

Looks like wrong order.

> diff --git a/drivers/misc/nxp-sr1xx.c b/drivers/misc/nxp-sr1xx.c
> new file mode 100644
> index 000000000000..25648712a61b
> --- /dev/null
> +++ b/drivers/misc/nxp-sr1xx.c
> @@ -0,0 +1,834 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SPI driver for UWB SR1xx
> + * Copyright (C) 2018-2022 NXP.
> + *
> + * Author: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> + */
> +#include <linux/miscdevice.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_gpio.h>
> +#include <linux/spi/spi.h>
> +
> +#define SR1XX_MAGIC 0xEA
> +#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
> +#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)
> +
> +#define UCI_HEADER_LEN 4
> +#define HBCI_HEADER_LEN 4
> +#define UCI_PAYLOAD_LEN_OFFSET 3
> +
> +#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET 1
> +#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET_MASK 0x80
> +#define UCI_EXT_PAYLOAD_LEN_OFFSET 2
> +
> +#define SR1XX_TXBUF_SIZE 4200
> +#define SR1XX_RXBUF_SIZE 4200
> +#define SR1XX_MAX_TX_BUF_SIZE 4200
> +
> +#define MAX_RETRY_COUNT_FOR_IRQ_CHECK 100
> +#define MAX_RETRY_COUNT_FOR_HANDSHAKE 1000
> +

(...)

> +
> +static const struct dev_pm_ops sr1xx_dev_pm_ops = { SET_SYSTEM_SLEEP_PM_OPS(
> +	sr1xx_dev_suspend, sr1xx_dev_resume) };
> +
> +static struct spi_driver sr1xx_driver = {
> +	.driver = {
> +		   .name = "sr1xx",
> +		   .pm = &sr1xx_dev_pm_ops,
> +		   .bus = &spi_bus_type,
> +		   .owner = THIS_MODULE,

No, this was removed some years ago... Please run all regular static
tools on your code sparse, smatch and coccinelle.

There is no need for us to do the review of things pointed out by tools.


> +		   .of_match_table = sr1xx_dt_match,
> +		    },
> +	.probe = sr1xx_probe,
> +	.remove = sr1xx_remove,
> +};
> +
> +static int __init sr1xx_dev_init(void)
> +{
> +	return spi_register_driver(&sr1xx_driver);
> +}
> +
> +module_init(sr1xx_dev_init);
> +
> +static void __exit sr1xx_dev_exit(void)
> +{
> +	spi_unregister_driver(&sr1xx_driver);
> +}

Why this isn't a module_spi_driver?

> +
> +module_exit(sr1xx_dev_exit);
> +
> +MODULE_AUTHOR("Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>");
> +MODULE_DESCRIPTION("NXP SR1XX SPI driver");
> +MODULE_LICENSE("GPL");


Best regards,
Krzysztof
