Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7984C42A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiBYKnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbiBYKnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:43:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E4A182D9B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:42:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so1417222wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gXPc+s5pjp0KouMKVvylWinsKN9kqxNMhljt5z1QCQY=;
        b=w1TOdh5BGMZ/g2IxhYErCUHHjadlIG4HH3wACDfw3KwJgHHog9hPVxjOOCf5pnWbeM
         SRGHIDr+lkYrScsTHcOOViW2u0mVmwBZ0zkoOcacZVe1xCOTBOX2roI/T8x+/m0puTZa
         7bJSLQEzBnm5P/FXm2Vo+QiZTHXnzwgAuIha/I+QC+e4aLLTuEH5ye3sDwRb9puEijqz
         iYqATuXvzJhKBOIwte3Pjsv0PrguEfyMPl28xnHYqJdILFhjefOBPN1vrYr9RdEVPB3s
         gjf/Z7uB13W6XmcTaOhF4f0/2d8vwFUfh+CgCHRb29LmuxfYleiCepsu7aMBrP/97MFl
         Bz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gXPc+s5pjp0KouMKVvylWinsKN9kqxNMhljt5z1QCQY=;
        b=0+l5JR/CNWWGZJjxFSfNcI2u5lPcq3hPfYqNxuikY6fDhb61XrGj8vLNcmqnj/uGIm
         rhtw0/yVNE/GCTK1U8JrHFuGdvqkeKV1e2WGS8U1NfVu/BASdpVNLfK6CNg4iC2wPT+B
         fQ04XRH7jA2msjTT5uIHVEY4ZL7/HZAx1b364Q+vWYABq8aBDI+LSjArm11ptK30ODwX
         7EvzVNRIXe70Sebz1TX8OTg/0mngKy2Ph0KFFMEWJUyg9gsgKkCMudVqcNqUWnfk+9u8
         P66eEWQ8B+0gouDZJW7dV5r411eUodQzr4r5Jm1G28DMG+NF9JBb2EEpweXnh47iSNog
         Hlaw==
X-Gm-Message-State: AOAM531+JSmTosAgpjmlFpcbUs+hs1Em9iWIRxSu1mg76zI/ICsY23+m
        CaLYYlzv7BXD/5OXK9nwpwQJXw==
X-Google-Smtp-Source: ABdhPJwFv0DID0UGWxdYScHHDLQdXM7kOUnMKfA3kLPNkEuf3cxRqwFYos3TYYT8aMnIA2HI/Sk3oA==
X-Received: by 2002:a05:600c:4252:b0:37b:e3e0:87f0 with SMTP id r18-20020a05600c425200b0037be3e087f0mr2168756wmm.194.1645785762335;
        Fri, 25 Feb 2022 02:42:42 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id z10-20020a056000110a00b001ea75c5c218sm1808356wrw.89.2022.02.25.02.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 02:42:41 -0800 (PST)
Message-ID: <7adf0964-c787-eac3-a2b3-d8cbebc4428b@linaro.org>
Date:   Fri, 25 Feb 2022 10:42:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] nvmem: brcm_nvram: parse NVRAM content into NVMEM
 cells
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211220184226.6485-1-zajec5@gmail.com>
 <20211220184444.6693-1-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20211220184444.6693-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2021 18:44, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> NVRAM consist of header and NUL separated key-value pairs. Parse it and
> create NVMEM cell for every key-value entry.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

thanks for reminding about, it seems to be lost in my emails.

Applied thanks,

--srini
> V2: Drop dev_info() calls I used for debugging
> ---
>   drivers/nvmem/brcm_nvram.c | 90 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 90 insertions(+)
> 
> diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
> index bd2ecaaf4585..439f00b9eef6 100644
> --- a/drivers/nvmem/brcm_nvram.c
> +++ b/drivers/nvmem/brcm_nvram.c
> @@ -6,12 +6,26 @@
>   #include <linux/io.h>
>   #include <linux/mod_devicetable.h>
>   #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>   #include <linux/nvmem-provider.h>
>   #include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define NVRAM_MAGIC			"FLSH"
>   
>   struct brcm_nvram {
>   	struct device *dev;
>   	void __iomem *base;
> +	struct nvmem_cell_info *cells;
> +	int ncells;
> +};
> +
> +struct brcm_nvram_header {
> +	char magic[4];
> +	__le32 len;
> +	__le32 crc_ver_init;	/* 0:7 crc, 8:15 ver, 16:31 sdram_init */
> +	__le32 config_refresh;	/* 0:15 sdram_config, 16:31 sdram_refresh */
> +	__le32 config_ncdl;	/* ncdl values for memc */
>   };
>   
>   static int brcm_nvram_read(void *context, unsigned int offset, void *val,
> @@ -26,6 +40,75 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
>   	return 0;
>   }
>   
> +static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
> +				size_t len)
> +{
> +	struct device *dev = priv->dev;
> +	char *var, *value, *eq;
> +	int idx;
> +
> +	priv->ncells = 0;
> +	for (var = data + sizeof(struct brcm_nvram_header);
> +	     var < (char *)data + len && *var;
> +	     var += strlen(var) + 1) {
> +		priv->ncells++;
> +	}
> +
> +	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
> +	if (!priv->cells)
> +		return -ENOMEM;
> +
> +	for (var = data + sizeof(struct brcm_nvram_header), idx = 0;
> +	     var < (char *)data + len && *var;
> +	     var = value + strlen(value) + 1, idx++) {
> +		eq = strchr(var, '=');
> +		if (!eq)
> +			break;
> +		*eq = '\0';
> +		value = eq + 1;
> +
> +		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
> +		if (!priv->cells[idx].name)
> +			return -ENOMEM;
> +		priv->cells[idx].offset = value - (char *)data;
> +		priv->cells[idx].bytes = strlen(value);
> +	}
> +
> +	return 0;
> +}
> +
> +static int brcm_nvram_parse(struct brcm_nvram *priv)
> +{
> +	struct device *dev = priv->dev;
> +	struct brcm_nvram_header header;
> +	uint8_t *data;
> +	size_t len;
> +	int err;
> +
> +	memcpy_fromio(&header, priv->base, sizeof(header));
> +
> +	if (memcmp(header.magic, NVRAM_MAGIC, 4)) {
> +		dev_err(dev, "Invalid NVRAM magic\n");
> +		return -EINVAL;
> +	}
> +
> +	len = le32_to_cpu(header.len);
> +
> +	data = kcalloc(1, len, GFP_KERNEL);
> +	memcpy_fromio(data, priv->base, len);
> +	data[len - 1] = '\0';
> +
> +	err = brcm_nvram_add_cells(priv, data, len);
> +	if (err) {
> +		dev_err(dev, "Failed to add cells: %d\n", err);
> +		return err;
> +	}
> +
> +	kfree(data);
> +
> +	return 0;
> +}
> +
>   static int brcm_nvram_probe(struct platform_device *pdev)
>   {
>   	struct nvmem_config config = {
> @@ -35,6 +118,7 @@ static int brcm_nvram_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct resource *res;
>   	struct brcm_nvram *priv;
> +	int err;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -46,7 +130,13 @@ static int brcm_nvram_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->base))
>   		return PTR_ERR(priv->base);
>   
> +	err = brcm_nvram_parse(priv);
> +	if (err)
> +		return err;
> +
>   	config.dev = dev;
> +	config.cells = priv->cells;
> +	config.ncells = priv->ncells;
>   	config.priv = priv;
>   	config.size = resource_size(res);
>   
