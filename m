Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66369578240
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiGRMY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiGRMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:24:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D58FDFD6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:24:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c18so2082454wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OhUXq/U+mQzaDdbSA2On+A7e4Bi+7v9DxsABGDBHvow=;
        b=LwaBKUnGLXD02D9MPrlr9wLqdouK5bKYdBynpd7Gf8F3LiygWsZdQGprESZWpTQ8RL
         +isVhRZFwos5Gw7bLYqZqoOAE7ATugttrLepwTUY1yWs0JDxYGIvBgsb3GjFADUwjmKQ
         J0UZpXr6f3A8O/qKaUpfmsrFhXew3vFM6nx4SDQ9zXxxvI4aRUR/aCRRM3UgtDfl/T0A
         dXq3yrxmXKchDyU7/Ws3f6+NZKSsiwupXBJ4o180kOKLTALvE351pqgcJ/RyIndSNHXL
         N5/4x66v3fmSTJW1MhcL1eYkuGA0Gyn9jI9cuqQ4fjASpPWLze6zZdPpCNfnwM9kstmZ
         PLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OhUXq/U+mQzaDdbSA2On+A7e4Bi+7v9DxsABGDBHvow=;
        b=tGTFKc1vdM5yEpe+Jl8GkGhLII1zOdG3g37ChL7ZTCfIPF0YbT0CEzC4cwJdBkz64C
         S/EGNvis2ab/hUOt4aANRm1oghfL0pe7yXE+Y3QTdO3Dun1sOiIf5NtI2ZlgoGjXpwcB
         wYKTddTbtVAASiqvYlEVMJ8IASs8c+cWhUEWuboLiLH+2zyGc2gDtkdMi27i8l06GB3w
         v7oRSEjbpk4ibalkg/1KlTDFw6gDH+uLXjynV67/rC/Gx3YHGVKIoNPXUuW7SfVlp72I
         dgSuB5fDnJNwBglJnp1EktZs0GJr4uQzoIWExZNTPBYvDuDO4iMXymQWnrt/zAdn1492
         cHCg==
X-Gm-Message-State: AJIora9TsQ24psTmjtfqR/aKgmfobpIQ+p/EwWs4rrf+WvQllPVlom/1
        mzbALuZkKAXiGWct98SvdfEN5w==
X-Google-Smtp-Source: AGRyM1t3lTvZo1bO4gg7kfenzEBhikg+J8N4q1FX7XhNsF9MkxSqtLvPxN0AEUI8XJ4HJi7MNysXXw==
X-Received: by 2002:a05:600c:1ca8:b0:3a3:19c9:5448 with SMTP id k40-20020a05600c1ca800b003a319c95448mr5491019wms.40.1658147090075;
        Mon, 18 Jul 2022 05:24:50 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id t19-20020a0560001a5300b0021d4aca9d1esm12292789wry.99.2022.07.18.05.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:24:49 -0700 (PDT)
Message-ID: <a1b7262a-2c9d-7495-e660-b6ef43d3ad44@linaro.org>
Date:   Mon, 18 Jul 2022 13:24:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next,v4] nvmem: core: Fix memleak in nvmem_register()
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, gongruiqi1@huawei.com,
        wangweiyang2@huawei.com
References: <20220718122120.3103545-1-cuigaosheng1@huawei.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220718122120.3103545-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/07/2022 13:21, Gaosheng Cui wrote:
> dev_set_name will alloc memory for nvmem->dev.kobj.name in
> nvmem_register, when nvmem_validate_keepouts failed, nvmem's
> memory will be freed and return, but nobody will free memory
> for nvmem->dev.kobj.name, there will be memleak, so moving
> nvmem_validate_keepouts() after device_register() and let
> the device core deal with cleaning name in error cases.
> 
> Fixes: de0534df9347 ("nvmem: core: fix error handling while validating keepout regions")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---

What changed since v3?

>   drivers/nvmem/core.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 1e3c754efd0d..6067d3bbff5d 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -829,21 +829,19 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->dev.groups = nvmem_dev_groups;
>   #endif
>   
> -	if (nvmem->nkeepout) {
> -		rval = nvmem_validate_keepouts(nvmem);
> -		if (rval) {
> -			ida_free(&nvmem_ida, nvmem->id);
> -			kfree(nvmem);
> -			return ERR_PTR(rval);
> -		}
> -	}
> -
>   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>   
>   	rval = device_register(&nvmem->dev);
>   	if (rval)
>   		goto err_put_device;
>   
> +	if (nvmem->nkeepout) {
> +		rval = nvmem_validate_keepouts(nvmem);
> +		if (rval) {

Unnecessary braces here.

--srini
> +			goto err_device_del;
> +		}
> +	}
> +
>   	if (config->compat) {
>   		rval = nvmem_sysfs_setup_compat(nvmem, config);
>   		if (rval)
