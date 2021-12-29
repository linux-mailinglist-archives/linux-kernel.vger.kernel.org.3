Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C348136E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhL2NQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhL2NQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:16:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:16:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t26so44385960wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QEQ5uwylwhO+doQNQhsDt4iKXz/eqwy0hLlA6al0xtY=;
        b=kWC1WZKAkauPFhwVRLCwXKXjQz+hFAEgv3pSXljMa63lbK2cyF3T5DKVPWnOHX9sBp
         FUn321m9YvPfN8k1VIZPJde/dyHG3248zxW8uFcmzojIop8g5xu2Rm1E7TD+ItA57pym
         MybpNn2TEMIvk8uoLs/QqtsFp5H3o+9WCG6NelLbT9Jku0L2nyySq70vIqVrZhnX+K1X
         CFpKzH9oXqvbQCjrBkrc/wQtSpyC/A/V3Y3CxM1D9ZChQs5JTE+0G78mVsYHFSGaxSbv
         8E9sTVs00Qhr7donaO91wlrY6HeV3SN2tIbjCbW+R58MBbZ+20mGq2mubtfuwwDYHhGR
         38VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QEQ5uwylwhO+doQNQhsDt4iKXz/eqwy0hLlA6al0xtY=;
        b=o2ehsHOIN4HOLDWVSTtn0gT5UOpPuyZoYhJy26K/PcoTPhDUaegJZKs2sg/DmsyA06
         Y1n7rb8cJM0o5BIx+zDjDfqYqTD0NU6bMGC1vmZiO0y+2nN2uUqB0RwltoryoL1Q5SCG
         TqJRCcRV+60xg5vI+aKLNJqMJUZun0AHylLpCL0XyG8wZuxvQHKn1eSCR0ZutgN51psS
         cg+jmHBzLlEPPQVoQ4Y5kkIV1hFHMzbjchRCXrkKVLuoeFfPT3+ZIi3JmclKtB6NgoB0
         u1rK99OvJJPSIf9+WOaZKD+XvHfhatXwYpl8p0Dz6MF2/XL+8zU02y2svDoYhoQIwW0p
         qj4Q==
X-Gm-Message-State: AOAM530YpMtG+Y+W/rdYwrDPXMwO+UqyoJYnuPRZZ4s2F0Uf2TGanW1F
        vA3xzsBksQ/Cr52O79Vu0nA9Xg==
X-Google-Smtp-Source: ABdhPJyAtXYw6qFcZcLxCscQXqGXOJhNhhe0Q4d7KuuuymHIVZJJSm6eMJoaCpa+EN2gIl5mvzhg/g==
X-Received: by 2002:adf:cc83:: with SMTP id p3mr20802303wrj.680.1640783784942;
        Wed, 29 Dec 2021 05:16:24 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id o8sm24423252wry.20.2021.12.29.05.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 05:16:24 -0800 (PST)
Date:   Wed, 29 Dec 2021 13:16:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: lpc_ich: convert name to const char*
Message-ID: <YcxfprpyKecNcDtj@google.com>
References: <223bc330-5be1-136b-7b42-e4bc1331d28f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <223bc330-5be1-136b-7b42-e4bc1331d28f@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021, Heiner Kallweit wrote:

> This change reduces the memory footprint of the structs (admittedly
> not much), and it allows the compiler to store names only once.
> E.g. i2c-i801 uses name "Intel PCH" twice. All users assign static
> strings to name, and only usage of name is in iTCO_wdt_probe() for
> printing a syslog info message. So we don't really have to worry
> about potential issues like use after free.

Something about this patch makes me uneasy.

Honestly I'd rather copy this tiny amount of data over to a known safe
location than use pointers to potentially stale data structures.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mfd/lpc_ich.c                  | 2 +-
>  include/linux/mfd/lpc_ich.h            | 2 +-
>  include/linux/platform_data/itco_wdt.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
> index f10e53187..acb33a180 100644
> --- a/drivers/mfd/lpc_ich.c
> +++ b/drivers/mfd/lpc_ich.c
> @@ -889,7 +889,7 @@ static int lpc_ich_finalize_wdt_cell(struct pci_dev *dev)
>  	info = &lpc_chipset_info[priv->chipset];
>  
>  	pdata->version = info->iTCO_version;
> -	strlcpy(pdata->name, info->name, sizeof(pdata->name));
> +	pdata->name = info->name;
>  
>  	cell->platform_data = pdata;
>  	cell->pdata_size = sizeof(*pdata);
> diff --git a/include/linux/mfd/lpc_ich.h b/include/linux/mfd/lpc_ich.h
> index 39967a5ec..6dec7d992 100644
> --- a/include/linux/mfd/lpc_ich.h
> +++ b/include/linux/mfd/lpc_ich.h
> @@ -27,7 +27,7 @@ enum {
>  };
>  
>  struct lpc_ich_info {
> -	char name[32];
> +	const char *name;
>  	unsigned int iTCO_version;
>  	unsigned int gpio_version;
>  	enum intel_spi_type spi_type;
> diff --git a/include/linux/platform_data/itco_wdt.h b/include/linux/platform_data/itco_wdt.h
> index 45d860cac..c6941c089 100644
> --- a/include/linux/platform_data/itco_wdt.h
> +++ b/include/linux/platform_data/itco_wdt.h
> @@ -19,7 +19,7 @@
>   * @no_reboot_use_pmc: Use PMC BXT API to set and clear NO_REBOOT bit
>   */
>  struct itco_wdt_platform_data {
> -	char name[32];
> +	const char *name;
>  	unsigned int version;
>  	bool no_reboot_use_pmc;
>  };

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
