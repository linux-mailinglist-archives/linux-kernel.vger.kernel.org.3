Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B92E507C65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357752AbiDSWLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbiDSWLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:11:05 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7DB3B29B;
        Tue, 19 Apr 2022 15:08:21 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e5e8523fcbso71070fac.10;
        Tue, 19 Apr 2022 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UengR8EXwoi99sl+0v/VkxO2Wro5UnJAJe1MiM+zYBg=;
        b=EyxeeAL5cqxhXMtnwg0zICaKaV3hPzxTOkSrVkmUuamldURGloDGg1fqnmDD/pQV65
         cUgy+YO+CvzE60OyZy8YpmA0I/grGUUcCPex6B0La0HnT3/GwtMfcHDyWp63HoXP0jQl
         jRUDxhCWcqwjJF+zENtRk7vl0t0QuFu7xVAHGPa1YtdMCa2dpxYQpJfHmNak475VZSsZ
         rVvJ7leskZwAgOh6W0fqwYPRYi2YseQ+cRUjr3dUb96NT1vxtBm9Tit3e3J3Ukj+smCs
         q9V8SrCtG6Z4zVSqLHVJVhCwVsYtQN4a2/l4p8Jamo8bowMwc9crIdAoTucwDYpCyCws
         PloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UengR8EXwoi99sl+0v/VkxO2Wro5UnJAJe1MiM+zYBg=;
        b=emQ7xXUXrTf8NUmCPa8zFdKktZPVnkpLOYperPxKj+D9QN+LzmWg+BtnvmYbkcyrZG
         +30iWfnVJyU6YoLQG+puRmf0is1g692lIxvgPdzX1XrUznmNp/1N77/lOZCZ0u97K4Nc
         5Ta7rCrgvDPzsVMWeaggbxGx0O4RkcnjxX/oqby6zAbRrVsZPB6w5b5mXUpqK4OrO2PP
         gUlfcE2Zm8tiFNe8ga49uxCAkYQonjTTedEKsiidZTyAl6RYXtDpewardPXikJ7+LouE
         en0fVuAheNfYmFFVoTZqifJaQIqbH08WQftYA/9kbkHzJZypH/8aIPzyeXxzUE/PjdAo
         2hcg==
X-Gm-Message-State: AOAM532ywg1ONgwgRTtxNq3fmxm98aQM2A/dPPc5rSvFaJ7roPlM4xQZ
        glA+Y2TjawRP1gptje7DWnmhH2wuQPs=
X-Google-Smtp-Source: ABdhPJzkss2BVw/K3XCJMf0ggsPOyEqhxVx5aoIjvJkXru5L0+6R0LFFzHpa70Uh/Vtk20PRfqEegA==
X-Received: by 2002:a05:6870:c142:b0:dd:d5a3:767c with SMTP id g2-20020a056870c14200b000ddd5a3767cmr303112oad.291.1650406101088;
        Tue, 19 Apr 2022 15:08:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n35-20020a05687055a300b000e1e2ab91e4sm5533130oao.39.2022.04.19.15.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 15:08:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <23a10930-e78b-d795-056e-879e52e2b45f@roeck-us.net>
Date:   Tue, 19 Apr 2022 15:08:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hwmon: (pmbus) allow to use a custom read_byte_data
 function for PMBUS_CAPABILITY
Content-Language: en-US
To:     Adam Wujek <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220419215149.309760-1-dev_public@wujek.eu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220419215149.309760-1-dev_public@wujek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 14:52, Adam Wujek wrote:
> Some devices returns a wrong value in PMBUS_CAPABILITY register.
> Allow the use of read_byte_data function defined in a driver for
> a specific device.

Those devices should set PMBUS_NO_CAPABILITY.

Guenter

> 
> Signed-off-by: Adam Wujek <dev_public@wujek.eu>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index f8ca36759b0a..ef9989be8f89 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2011,7 +2011,7 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>   	}
> 
>   	/* Enable PEC if the controller supports it */
> -	ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
> +	ret = _pmbus_read_byte_data(client, -1, PMBUS_CAPABILITY);
>   	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
>   		client->flags |= I2C_CLIENT_PEC;
>   	else
> --
> 2.17.1
> 
> 

