Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5197C4BD703
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346439AbiBUHlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:41:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbiBUHlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:41:24 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7880267A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:41:01 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so2972668pjw.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lH8QqqX3ozBsd2B7qQFlTmT4R+1hyoS0GxD0+GxHAm4=;
        b=DPg1FWrVg0L7+dmIhjoxzH5eB5GIwwhIfLT6bdDujNnFXEG22E51P6/iKJN3GQj/Jh
         5klRdTyo5twDSFCq9ATU3iEVpibaxvDvxypyq8RGSv0AgYUW5bhvP2U+6dJAUXeJyn64
         SwPT1kV2/jPzEqSjVbbacPeG39aw/u5hu3IjeiSd8nsV6gOUbX75oH5MJwWH0+ZEerLX
         C2hRmZfxR4/W+ITPp7ieAJDfSWUBGvpvuIXpE/u6qexOUYvEK0IL0JtD0aPcXw5obZM/
         el/L9hExsNDQlaBbtA/nMUrRFd4EylmKhkXQk7+RorH3Lq5EBFZBgCJCN4cwRiLNTErI
         KQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lH8QqqX3ozBsd2B7qQFlTmT4R+1hyoS0GxD0+GxHAm4=;
        b=w4VUXrj28MlRvQBTk0aIY2h3ADvuva6VidhFmsLqKoGd2gx8Yy07MYUOLkiq9RE/od
         7I+9yE5fDQmIj3hBcHBY/aGxv3K+Yk3Jo0dSjc9tR5YMfYxI5cTptNP0eDQwg0qkzUrX
         Z/M/Q2DhdOt9g/eC/AADzZZ66czgvG1pIfkeR++2eP04bxTaVgsyg5sFaZd+gFARH4Sg
         JnCY+DZQ0NQ1eTc38IWwz10bgGzE0tmH4n3JDQwwjrlgGvXrPbtgynliUUJhZ0FLdYVd
         GIm+aWLU4riw9kcrBzgrAerMgMi3jjjL4V4PRGCE+YOnpJCjh7yM24cDq3B5cUns0GCT
         GjVQ==
X-Gm-Message-State: AOAM531ycoE041HEh4JFjlzdxW1YJ971o6JPwpxMCsC8y0gFs4NnphK/
        fHcrtcATZlp/r0O7v+f+SkU=
X-Google-Smtp-Source: ABdhPJwH9UhaiDtcbbxPsD83urvWYcqr9ZvfqfYpuFwIkn/WQ+xa7qCHm35KAYgnborVR7uWDwX6/Q==
X-Received: by 2002:a17:902:e845:b0:14f:9de8:8b43 with SMTP id t5-20020a170902e84500b0014f9de88b43mr7293268plg.39.1645429261393;
        Sun, 20 Feb 2022 23:41:01 -0800 (PST)
Received: from [192.168.1.3] (fp76ee264d.knge102.ap.nuro.jp. [118.238.38.77])
        by smtp.gmail.com with ESMTPSA id bo5-20020a17090b090500b001b9dc0e399dsm6690493pjb.9.2022.02.20.23.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 23:41:00 -0800 (PST)
Message-ID: <2e40f311-d04a-899b-acef-a8194006d8cf@gmail.com>
Date:   Mon, 21 Feb 2022 16:40:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] mtd: spi-nor: core: Add helpers to read/write any
 register
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, p.yadav@ti.com,
        michael@walle.cc, Takahiro.Kuwano@infineon.com
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, zhengxunli@mxic.com.tw,
        jaimeliao@mxic.com.tw, Bacem.Daassi@infineon.com
References: <20220210023334.408926-1-tudor.ambarus@microchip.com>
 <20220210023334.408926-2-tudor.ambarus@microchip.com>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20220210023334.408926-2-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/2022 11:33 AM, Tudor Ambarus wrote:
> There are manufacturers that use registers indexed by address. Some of
> them support "read/write any register" opcodes. Provide core methods that
> can be used by all manufacturers. SPI NOR controller ops are intentionally
> not supported as we intend to move all the SPI NOR controller drivers
> under the SPI subsystem.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c | 41 ++++++++++++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/core.h |  4 ++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 7d5e3acb0ae7..d394179689e6 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -307,6 +307,47 @@ ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>  	return nor->controller_ops->write(nor, to, len, buf);
>  }
>  
> +/**
> + * spi_nor_read_reg() - read register to flash memory
> + * @nor:        pointer to 'struct spi_nor'.
> + * @op:		SPI memory operation. op->data.buf must be DMA-able.
> + * @proto:	SPI protocol to use for the register operation.
> + *
> + * Return: zero on success, -errno otherwise
> + */
> +int spi_nor_read_reg(struct spi_nor *nor, struct spi_mem_op *op,
> +		     enum spi_nor_protocol proto)
> +{
> +	if (!nor->spimem)
> +		return -EOPNOTSUPP;
> +
> +	spi_nor_spimem_setup_op(nor, op, proto);
> +	return spi_nor_spimem_exec_op(nor, op);
> +}
> +
> +/**
> + * spi_nor_write_reg() - write register to flash memory
> + * @nor:        pointer to 'struct spi_nor'
> + * @op:		SPI memory operation. op->data.buf must be DMA-able.
> + * @proto:	SPI protocol to use for the register operation.
> + *
> + * Return: zero on success, -errno otherwise
> + */
> +int spi_nor_write_reg(struct spi_nor *nor, struct spi_mem_op *op,
> +		      enum spi_nor_protocol proto)
> +{
> +	int ret;
> +
> +	if (!nor->spimem)
> +		return -EOPNOTSUPP;
> +
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +	spi_nor_spimem_setup_op(nor, op, proto);
> +	return spi_nor_spimem_exec_op(nor, op);
> +}
> +
>  /**
>   * spi_nor_write_enable() - Set write enable latch with Write Enable command.
>   * @nor:	pointer to 'struct spi_nor'.
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index cbfb4fa7647f..c728454b5424 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -578,6 +578,10 @@ ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
>  			  u8 *buf);
>  ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>  			   const u8 *buf);
> +int spi_nor_read_reg(struct spi_nor *nor, struct spi_mem_op *op,
> +		     enum spi_nor_protocol proto);
> +int spi_nor_write_reg(struct spi_nor *nor, struct spi_mem_op *op,
> +		      enum spi_nor_protocol proto);
>  int spi_nor_erase_sector(struct spi_nor *nor, u32 addr);
>  
>  int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);

Thank you for introducing these helpers.
I revised my S25HL/HS-T series on top of this and confirmed that is
working correctly.

Tested-By: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Best Regards,
Takahiro
