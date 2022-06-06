Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55DB53EB47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiFFKNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiFFKNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:13:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE7179C3F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:10:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x17so19176427wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=EEtIczXOb290W+pz7uEsvHrOu4FcL6xx1WeEBPLY3Hw=;
        b=k+0ldaxsPStEdYkYtq1feLWsz9sDXg7qx7pwcgrtt+joqLVBPgMCa3QRHr2WCmXLw3
         93vbDgVNXS1/A4pljwJI95bsvtzl8vE6uZIPIKhEvxjmgTaSEKIkstoM9KWI9BoZIKBZ
         khKu+rjUT+j3UMdbbWNcyaXdVwEJ6EkngIL0UR3C6uaKMXBIUPwXwbLMcdxWQ1RxSL4K
         hILIo+a0vs8qfcjygC41tTQQLy0Yeyo5z+pMGVggHM0KgW9SlGZcHjbDKAd9Ik0tsk1k
         Ohb1Jy8s81aMtJBNBZLiew/9C5Rkl5wrkJlHKn1xf3pRSo1YFt92OqrGAqc6hlmdmKgp
         +RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EEtIczXOb290W+pz7uEsvHrOu4FcL6xx1WeEBPLY3Hw=;
        b=b2BVaBI/E26Dr1f9sGuEucCzTuHaZ3nHhPPbCxUFmWKg0L3scvmv7W69WIM7uqfReP
         ZC/IG+B7xm+hzqd68L7unQn31AcsAbAbgtU+H7kz3wgMhBAUH0Tq267PQTkkbbZ6QRAo
         Tspjkw5tpoK+X0HZveZIyXDbmjCesBaKNW04hvBzeZPaoYL4Na6tngzkc5mjrzL/NW5M
         mdIJypc7IGS6NKpHPuHrg2MX1uFALhUn53AjFrYbXrIAWh+jbSxmLJOdheDtQcELxOuI
         e+brxW/z1mBJipqMGe3j/DDOEn61fMU4/lsB6SvrymQhmtwM8/8n2IPk29eXwrDfv8HN
         ttXQ==
X-Gm-Message-State: AOAM533t6ps+pfTksqUM/kcpLdr/8cphmi+XWVQkStaXT2/rTh/XAtOd
        gGtNvzVpNNGjiWZPDNbkGxUrfygpE2KVWeGR
X-Google-Smtp-Source: ABdhPJxM5KE+vxnYfWDTOxBGJUXvolZxgAVtIxd+SN85NugA4dvW6DbnIy3/F1PGAMbEfYS+qGVfhQ==
X-Received: by 2002:a05:6000:1091:b0:213:b515:f46f with SMTP id y17-20020a056000109100b00213b515f46fmr17644027wrw.632.1654510224309;
        Mon, 06 Jun 2022 03:10:24 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id b12-20020a5d4b8c000000b0020feb9c44c2sm14955968wrt.20.2022.06.06.03.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 03:10:23 -0700 (PDT)
Message-ID: <a9ce408f-eaea-40db-34be-26e51cbb3515@linaro.org>
Date:   Mon, 6 Jun 2022 11:10:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drivers: slimbus: Directly use ida_alloc()/free()
Content-Language: en-US
To:     keliu <liuke94@huawei.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220527073053.2402630-1-liuke94@huawei.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220527073053.2402630-1-liuke94@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/05/2022 08:30, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

Applied thanks,

--srini
> ---
>   drivers/slimbus/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 78480e332ab8..219483b79c09 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -250,7 +250,7 @@ int slim_register_controller(struct slim_controller *ctrl)
>   {
>   	int id;
>   
> -	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&ctrl_ida, GFP_KERNEL);
>   	if (id < 0)
>   		return id;
>   
> @@ -299,7 +299,7 @@ int slim_unregister_controller(struct slim_controller *ctrl)
>   {
>   	/* Remove all clients */
>   	device_for_each_child(ctrl->dev, NULL, slim_ctrl_remove_device);
> -	ida_simple_remove(&ctrl_ida, ctrl->id);
> +	ida_free(&ctrl_ida, ctrl->id);
>   
>   	return 0;
>   }
> @@ -323,7 +323,7 @@ void slim_report_absent(struct slim_device *sbdev)
>   	sbdev->is_laddr_valid = false;
>   	mutex_unlock(&ctrl->lock);
>   	if (!ctrl->get_laddr)
> -		ida_simple_remove(&ctrl->laddr_ida, sbdev->laddr);
> +		ida_free(&ctrl->laddr_ida, sbdev->laddr);
>   	slim_device_update_status(sbdev, SLIM_DEVICE_STATUS_DOWN);
>   }
>   EXPORT_SYMBOL_GPL(slim_report_absent);
