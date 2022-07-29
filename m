Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B332584951
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiG2BZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2BZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:25:25 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA3350065
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:25:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 23so2865582pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=OTK/VfscBXhFYYH3sJs44KtWrEvEi3UROFtYkeRJntE=;
        b=MaKszq2Wm0TDmzZdUOPeg9aA9+08vDYr3phRb3VLxC9EgDm+PhpgagX93nHTeUSsYK
         zpWSiurxcnK2nm/rJq3MUut8XjIR5/KQANlJx6QYdJy6J6LADTwZJ4UXfGMD83AUn/Qx
         cBfxL/O+2376PzG57oBOFC1QIqe+LpkUrM2c2YGfpOrxHffPpcsQdL62GitujYha/ngP
         BgTCL2gVk0JrmYyOSJvl4cy5Vsl0CD9rymCOjBJSkH4cdAOeq2dRuGXqPL6ASxkN6a7A
         wuSZ8DvNzIeZwPOmbP+Klu806JPb6HFVlew8tBeBoyzEvcQx7VtBZaKxLTXg1H4XtfR/
         DMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=OTK/VfscBXhFYYH3sJs44KtWrEvEi3UROFtYkeRJntE=;
        b=wiiEbkK3r2CeWRqwWpARIyU7ONCm9pW3Qkk50f0x1u124hmQQMuwrflcHgxkHF7Gf0
         RrYXJqFuyEqPlt1FHSzEuI4ocXdhd7NJb+7TziooLNylF+2b2sqaOhnB0gOTW6rMR4Fe
         LeNKQRZZkMsvfsofCxoCe+CGNCl0JuZWtGNvHprw+lEKLF2XmhbNwPF+2HTy3MGm8Xop
         DvLcZJI6xSHbRqoQacVEWH0ntABkdYXQ90W55hZ1u+t82r34sex3lOc4+31Jrt771aJA
         46qZDQVNmj02YQyTIebeNPmHLP61i1W/OxBD2hfigQGIF+beokKuiNdiX62YLXJvvrrR
         wAxQ==
X-Gm-Message-State: AJIora8L3Wgq9QXTLdC0Y9R2zF7uUIbj2lWYG41O1Q//64hAYmok76as
        955eBij0HrM+J4g/+BXVMYU=
X-Google-Smtp-Source: AGRyM1voyCt7VjAOfjVOeHY/3xJlVXe/F/8AEucWr3BxbdggRUMgyNl2ENa2CHABKqKrRlDn/LVEyg==
X-Received: by 2002:a05:6a00:1a8b:b0:52c:9daa:ff65 with SMTP id e11-20020a056a001a8b00b0052c9daaff65mr1130577pfv.71.1659057923440;
        Thu, 28 Jul 2022 18:25:23 -0700 (PDT)
Received: from [192.168.0.10] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id x134-20020a62868c000000b0050dc7628178sm1446314pfd.82.2022.07.28.18.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 18:25:22 -0700 (PDT)
Message-ID: <12b9347e-4ce4-6248-659e-5abe3c1dfcd2@gmail.com>
Date:   Fri, 29 Jul 2022 10:25:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] mtd: spi-nor: sysfs: print JEDEC ID for generic flash
 driver
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20220513133520.3945820-1-michael@walle.cc>
 <20220513133520.3945820-7-michael@walle.cc>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20220513133520.3945820-7-michael@walle.cc>
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
> We don't have a database entry for the generic SPI-NOR flash driver and
> thus we don't have a JEDEC ID to print. Print the (cached) JEDEC ID
> instead.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
> index 20563c1926f4..c09bb832b3b9 100644
> --- a/drivers/mtd/spi-nor/sysfs.c
> +++ b/drivers/mtd/spi-nor/sysfs.c
> @@ -35,8 +35,10 @@ static ssize_t jedec_id_show(struct device *dev,
>  	struct spi_device *spi = to_spi_device(dev);
>  	struct spi_mem *spimem = spi_get_drvdata(spi);
>  	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
> +	const u8 *id = nor->info->id_len ? nor->info->id : nor->id;
> +	u8 id_len = nor->info->id_len ?: SPI_NOR_MAX_ID_LEN;
>  
> -	return sysfs_emit(buf, "%*phN\n", nor->info->id_len, nor->info->id);
> +	return sysfs_emit(buf, "%*phN\n", id_len, id);
>  }
>  static DEVICE_ATTR_RO(jedec_id);
>  
> @@ -76,7 +78,7 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
>  
>  	if (attr == &dev_attr_manufacturer.attr && !nor->manufacturer)
>  		return 0;
> -	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len)
> +	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len && !nor->id)
>  		return 0;
>  
>  	return 0444;

Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
