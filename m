Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B434809E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhL1OZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhL1OZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:25:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 06:25:18 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id v10so14426026ilj.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 06:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jrGkg0GjQaZqyWg6VJHnXS6TpWywtIeIOU6kuR+w79A=;
        b=bY6YNYMS5NBC0WP/gMaauje8VyV0/iL/D2bUvGRmbnGj1MPW0+EbMLwNdZJJdZqqR9
         Ul6gbD0S5GYCplzAG61XxBmNmUumThINANUMP9XnBfOcYNuGEhiM7c2DIeEMXhx8anI0
         QPk6XQzG1USVEBF5GlHkjhBzXkvI4D7f++MLkJ1ibzFnpUASClKdHHEdG+6KLD0+Y2WU
         gVQicitnjRPlvmrkbGeE9HA5MIeybiX051Y6b7xzYmwYnmvx2Ph+Nj7u0ONDITR3BPuM
         fQTD7uDod/BrrnZrRx9ZeBU+bhbABwtEnkeMxzR42v4FqpDp96qPn7CNbnwJiRyVJ02V
         kXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jrGkg0GjQaZqyWg6VJHnXS6TpWywtIeIOU6kuR+w79A=;
        b=acQoP/WUZGvwUBoSObkCePQ6Is21MiN4Gq21KaE8ILXCDB0Ol+3epzGpD2LmuoRyS9
         TRchc5yec573p8PAFMaiO5UYg8IIp9JEoAFSCCwDAqzym2x+S+99rq3henZPyfRKlW3R
         38xM3Bfqc39Q7QWdDou02S0Q7SkCFWpWv5T7AsQXlbFczoO8TwI8qiY0P7wbLtaD20G7
         WzwBEyQ+ir2W7ALBRvFAN7RxFwVLcMwLYtrGlVCptcerUW1Sn46BuimaR6mUa5RlPE4c
         ldpHqzMJ8aBr77ebUc+JS90jDrVuEBISPJx5/sRV2cpIlhH5ySF/K3tPq9CCeKcogn4y
         ZeFg==
X-Gm-Message-State: AOAM53382TP4KZTw4zjQzwhOlINP39jizbBVZL0poe1oXzsPr6QY3oYx
        7jeH5zFUxG0uTZGr4O2X5U55oA==
X-Google-Smtp-Source: ABdhPJwBHI7t61Vcu/OI3LRrGbaXgP9h5utn0tKneDRxb5p5nDSZzWW/RC4/hEZgjR/prnZM3zdFgQ==
X-Received: by 2002:a05:6e02:154c:: with SMTP id j12mr9339365ilu.169.1640701517640;
        Tue, 28 Dec 2021 06:25:17 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v4sm10795800ilq.13.2021.12.28.06.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 06:25:16 -0800 (PST)
Message-ID: <4d25feae-aa07-f8f1-88b9-1209e57b9c2a@linaro.org>
Date:   Tue, 28 Dec 2021 08:25:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [greybus-dev] [PATCH] staging: greybus: auto_manager: use
 default_groups in kobj_type
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Alex Elder <elder@kernel.org>, linux-staging@lists.linux.dev,
        Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org
References: <20211228135541.380275-1-gregkh@linuxfoundation.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20211228135541.380275-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 7:55 AM, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the greybus audio code to use default_groups field which
> has been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> Cc: Mark Greer <mgreer@animalcreek.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Nice and simple to convert this (as it should be).
Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/staging/greybus/audio_manager_module.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
> index 525cf8f8394f..0a0f0a394c84 100644
> --- a/drivers/staging/greybus/audio_manager_module.c
> +++ b/drivers/staging/greybus/audio_manager_module.c
> @@ -142,11 +142,12 @@ static struct attribute *gb_audio_module_default_attrs[] = {
>   	&gb_audio_module_op_devices_attribute.attr,
>   	NULL,   /* need to NULL terminate the list of attributes */
>   };
> +ATTRIBUTE_GROUPS(gb_audio_module_default);
>   
>   static struct kobj_type gb_audio_module_type = {
>   	.sysfs_ops = &gb_audio_module_sysfs_ops,
>   	.release = gb_audio_module_release,
> -	.default_attrs = gb_audio_module_default_attrs,
> +	.default_groups = gb_audio_module_default_groups,
>   };
>   
>   static void send_add_uevent(struct gb_audio_manager_module *module)
> 

