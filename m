Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8B149B222
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiAYKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355376AbiAYKf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:35:28 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3F8C061779
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:35:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r82-20020a1c4455000000b0034e043aaac7so857035wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uYdg+h4xUgFlS4VbgtGVuleOkynWItCXXdRK+L0ak6M=;
        b=GTubB8hv4bF/W8pl5G1QRyju+3fXfWPO83WqGYnDfxz6ak26wEZCcfjVnpmxnNX3W/
         H3A7PbnHfrdr/KHcapPP25NzGTUtX/g8yvTo/Ymjhi1hs0/b0BmLSFqfrE9o+Dz5rn5b
         K11DjI6yKNdBviS54JKQaHIiqEs5XumCs6PnIwStMPoLmVuMIqaX+CksR4xicdeivJuu
         893R0XyAXbei5Ap5+nv+TsJkY/0Ziu9ykV1bslhHNJgE2MvHrum0sTeANEEy9PplecCQ
         /Xjl0YKmNzPJFLLa7kyHEhD8MRvuie+dzmguYI4ITtNen3QTekXrFltTK6rBIgJUhyhU
         B3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uYdg+h4xUgFlS4VbgtGVuleOkynWItCXXdRK+L0ak6M=;
        b=rzwdUGNnUisjML/lsLB9KgN01VMiUA9WEhFYtDDHbjYL9kKcb5KYLUKX+s+Rtr+EDt
         46GlxZuxh02y8gLJQNGR65r/7FdvprXXMr6ycpzW3avlCLQne5ewoQ6CizHn0/JSfyAj
         IGlnyMN9ZaV0dGAI3FRz/nWJjQ9NutoK7pzQiGUPl0AW6CZqOXwNgrWlOInYchIAb5U3
         fdkjok0B4MDJRcl2KA0RwaDHTPFwOzXIE3CExb0URNdvHe6pNU6578zrayw/WAp8UqRo
         bQSPvWbPX18TE3YWtjFwAo+zU03jj2rv9rp0jRqBLU46Vn3zhhOXrrsMHl7YP67uNaQm
         UtXg==
X-Gm-Message-State: AOAM5326h4Noyoqcsb+W2MFLqtyn2yqMD41gB/TL6QsR4exw0ZHBxLJY
        i6tB8r4z2fvL9qvvbb8aVa7oQQ==
X-Google-Smtp-Source: ABdhPJx+w8z5aGYxT5A5QKy6zwet2VVfvd21nx8U+IbtSeToofaDduOXQkk2XZ3Di33nkZhxepnP/g==
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr2340963wmj.168.1643106926197;
        Tue, 25 Jan 2022 02:35:26 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id v124sm155335wme.30.2022.01.25.02.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 02:35:25 -0800 (PST)
Message-ID: <11caff0e-6bf3-9d66-6312-c2c2a6fc862a@linaro.org>
Date:   Tue, 25 Jan 2022 10:35:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/5] nvmem: core: Remove unused devm_nvmem_unregister()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
References: <20220124180040.50660-1-andriy.shevchenko@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220124180040.50660-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy for the cleanup,

On 24/01/2022 18:00, Andy Shevchenko wrote:
> There are no users and seems no will come of the devm_nvmem_unregister().
> Remove the function and remove the unused devm_nvmem_match() along with it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Applied 1/5, 2/5 and 3/5 patches.

Others can go via there own subsystems as I do not see any dependencies.

--srini
> ---
> v2: removed unused devm_nvmem_match() (lkp)
>   drivers/nvmem/core.c           | 22 ----------------------
>   include/linux/nvmem-provider.h |  8 --------
>   2 files changed, 30 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 23a38dcf0fc4..1a70b3bdb71d 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -945,28 +945,6 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(devm_nvmem_register);
>   
> -static int devm_nvmem_match(struct device *dev, void *res, void *data)
> -{
> -	struct nvmem_device **r = res;
> -
> -	return *r == data;
> -}
> -
> -/**
> - * devm_nvmem_unregister() - Unregister previously registered managed nvmem
> - * device.
> - *
> - * @dev: Device that uses the nvmem device.
> - * @nvmem: Pointer to previously registered nvmem device.
> - *
> - * Return: Will be negative on error or zero on success.
> - */
> -int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
> -{
> -	return devres_release(dev, devm_nvmem_release, devm_nvmem_match, nvmem);
> -}
> -EXPORT_SYMBOL(devm_nvmem_unregister);
> -
>   static struct nvmem_device *__nvmem_device_get(void *data,
>   			int (*match)(struct device *dev, const void *data))
>   {
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 98efb7b5660d..99c01c43d7a8 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -133,8 +133,6 @@ void nvmem_unregister(struct nvmem_device *nvmem);
>   struct nvmem_device *devm_nvmem_register(struct device *dev,
>   					 const struct nvmem_config *cfg);
>   
> -int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
> -
>   void nvmem_add_cell_table(struct nvmem_cell_table *table);
>   void nvmem_del_cell_table(struct nvmem_cell_table *table);
>   
> @@ -153,12 +151,6 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
>   	return nvmem_register(c);
>   }
>   
> -static inline int
> -devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
>   static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
>   static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
>   
