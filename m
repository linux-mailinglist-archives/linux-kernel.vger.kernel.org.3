Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64148584935
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiG2BAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2BAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:00:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81205F80
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:00:12 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f65so2815757pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=USR2zvqLThZbyU5A3Qws0c7W/e7hlltOBwwvVk3Sj2g=;
        b=HT82TppWLVwueR0E/3j3UDnFBXBgTuLCOeGo3TkS8HaubmuKaiTh9JM217y+wu0938
         tRbjooD8r7hxC7T5K98Zo3a7rP9pGWHuNcYi6guo3sNoLf+ZQI0WMkQr1AE46bNSmODj
         k+oQDsiTvdvXA0zVltRYrPWFE/R0r+i69a/5H/3tA7X6hB3FlTJfYwYoo9WwQlDdBtjp
         Wd3xtj0F7c4Up//ZKhb/3TraJz2U9Gu+MMVstmYIZZpcVYxUdlzhJfqBQ/UVjkW+UJWq
         zSWo4sR/S3Sv4FLNjUeL6DZiQ6J12Ka6zTihhkIDGe5VVghLKL2dnICPXzjv0obNnMF8
         C4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=USR2zvqLThZbyU5A3Qws0c7W/e7hlltOBwwvVk3Sj2g=;
        b=cfC4CJ7Xcr1u+enS2Mi6GCC56Ymk4rgABd4IDd03iCKSwFgrOkxlJrqPlKJwaZHk9E
         KReiuoHAK/vZmwBjfK1JS26tprnpJGCzuMgwlem5CGbaGB2Ys+GWOPGF32Qh4OI5HOMy
         1oIlANfK42AhN247OgpF/Ib3waakFuH5ivzZny/5jvqb6Dj3EP4thTvMLDrIFSk4EyUP
         PnWhb0JqrpvUHrUQblutqUFOafQpCP9NGMLuRaE0CQbWiqyVMpfEJRrGEhZzkmPW/de2
         z6FsVOsK2RghBWE9RjK/pz3s+aB/XrYS7pL0KdNy87Oca+7kVVS4SOq3TrRZScfCTxPu
         wf+w==
X-Gm-Message-State: AJIora8/FRVPV11WmCV7LylYOpGJmJLxczHU49s7NVETN/luf7bjyqD0
        6m+5qPIUelSBvD6eleIRsNM=
X-Google-Smtp-Source: AGRyM1si/DG3TbMHqNqDoIa0ug0YoGaiincrRbirQlQefwA0R5+uG1WpX1JVsOdnULZbN/qJrjFNAA==
X-Received: by 2002:a63:1220:0:b0:411:f661:f819 with SMTP id h32-20020a631220000000b00411f661f819mr1064703pgl.250.1659056412359;
        Thu, 28 Jul 2022 18:00:12 -0700 (PDT)
Received: from [192.168.0.10] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b0016d5cf36ff4sm1893361plt.289.2022.07.28.18.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 18:00:11 -0700 (PDT)
Message-ID: <9db2f4c2-cc41-9c06-e0ec-7480529cad13@gmail.com>
Date:   Fri, 29 Jul 2022 10:00:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/6] mtd: spi-nor: remember full JEDEC flash ID
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20220513133520.3945820-1-michael@walle.cc>
 <20220513133520.3945820-4-michael@walle.cc>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20220513133520.3945820-4-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/2022 10:35 PM, Michael Walle wrote:
> At the moment, we print the JEDEC ID that is stored in our database. The
> generic flash support won't have such an entry in our database. To find
> out the JEDEC ID later we will have to cache it. There is also another
> advantage: If the flash is found in the database, the ID could be
> truncated because the ID of the entry is used which can be shorter. Some
> flashes still holds valuable information in the bytes after the JEDEC ID
> and come in handy during debugging of when coping with INFO6() entries.
> These are not accessible for now.
> 
> Save a copy of the ID bytes after reading and display it via debugfs.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/core.c    | 5 +++++
>  drivers/mtd/spi-nor/debugfs.c | 2 +-
>  include/linux/mtd/spi-nor.h   | 3 +++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ce5d69317d46..65cd8e668579 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1664,6 +1664,11 @@ static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
>  		return ERR_PTR(ret);
>  	}
>  
> +	/* Cache the complete flash ID. */
> +	nor->id = devm_kmemdup(nor->dev, id, SPI_NOR_MAX_ID_LEN, GFP_KERNEL);
> +	if (!nor->id)
> +		return ERR_PTR(-ENOMEM);
> +
>  	info = spi_nor_match_id(nor, id);
>  	if (!info) {
>  		dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
> diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
> index eaf84f7a0676..23d51e7ba0a7 100644
> --- a/drivers/mtd/spi-nor/debugfs.c
> +++ b/drivers/mtd/spi-nor/debugfs.c
> @@ -81,7 +81,7 @@ static int spi_nor_params_show(struct seq_file *s, void *data)
>  	int i;
>  
>  	seq_printf(s, "name\t\t%s\n", info->name);
> -	seq_printf(s, "id\t\t%*ph\n", info->id_len, info->id);
> +	seq_printf(s, "id\t\t%*ph\n", SPI_NOR_MAX_ID_LEN, nor->id);
>  	string_get_size(params->size, 1, STRING_UNITS_2, buf, sizeof(buf));
>  	seq_printf(s, "size\t\t%s\n", buf);
>  	seq_printf(s, "write size\t%u\n", params->writesize);
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 1ede4c89805a..4dd6cd7389ca 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -349,6 +349,8 @@ struct spi_nor_flash_parameter;
>   * @bouncebuf:		bounce buffer used when the buffer passed by the MTD
>   *                      layer is not DMA-able
>   * @bouncebuf_size:	size of the bounce buffer
> + * @id:			The flash's ID bytes. Always contains
> + *			SPI_NOR_MAX_ID_LEN bytes.
>   * @info:		SPI NOR part JEDEC MFR ID and other info
>   * @manufacturer:	SPI NOR manufacturer
>   * @addr_width:		number of address bytes
> @@ -379,6 +381,7 @@ struct spi_nor {
>  	struct spi_mem		*spimem;
>  	u8			*bouncebuf;
>  	size_t			bouncebuf_size;
> +	u8			*id;
>  	const struct flash_info	*info;
>  	const struct spi_nor_manufacturer *manufacturer;
>  	u8			addr_width;

Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Thanks,
Takahiro

