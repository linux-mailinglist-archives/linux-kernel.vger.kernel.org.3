Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3A2588CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiHCNYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiHCNYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:24:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBC61A072
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:24:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p10so17364742wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=85Z5S1iN+/J1slaGRiTGkYvAQoX6IpH8OXS3rjHMVr4=;
        b=MyrqTM91dzwYerfXrXZ/cXTOA1Z6HQOjjV8VJEraHmsYJfXe5LAu3ZQiwW4O7//Rdc
         6A81gMe6090bd8c/kjGWwuuQGFe3R2Wx69tvbxcv7TF+nRUD0kfDrAvNnNrOoFayoCp5
         U/e6b0zQ8t5pY85hbndFtK1TgsJQe/ceeWPDm41jZBSO66k0J/iRsNUdCDvDZsSfOiBA
         Wn+xCWEwRISv5m+CtYPXB2V7j83+iEJtFHjINrn27oacTn41IRi9eoc7rF7JOxTMFryu
         PTHXHeElBwjdB2pbXW5KCRXP2+OKTL9cPA46bqF2SOgjrk//n39z7xXAVZzJXJa+AWGF
         bImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=85Z5S1iN+/J1slaGRiTGkYvAQoX6IpH8OXS3rjHMVr4=;
        b=qMl6KWhqckNhlCRMdcCdpqVp7Z/cXQW8Dc+/HXjv7QoHQmoA7n/Vb3sjNSDdosEuA1
         aj4v8B3NU0GAptDcv+Lol1BJ6O/CMTh/pDYqX2ohJ7CwxzPh4lxjbMPD8So6VlBTuGvc
         Tcnt/49hmlSPnjpLuCcoGTU9hHte/LInabpzVZAH3r0TcZ7FT9z6Wl7ELpvJetPMzUm/
         vquxsvb7BDmYBRvJ9mCD1GjclvqM4KTA12YPorbHu+gO8Kde8c+F1BlqU872CCmRtOX5
         nHvEbQta5f9EInuW/yH9rTMYk6KbvyP2YnobjVR0ZeJo6ciq6wZ0UVGcgu/Z+Ud7MvKM
         B6sQ==
X-Gm-Message-State: ACgBeo0Csv0jRaL+Jprsjd+7Y0mgGMvPq1UD3Q9usgAZMvsUf/WIRG6T
        oxU5iMbHfYeqrLMCQR2xrSwjNw==
X-Google-Smtp-Source: AA6agR6SQuP403ZTGG7r8Fx2umHGu27U/OGO7H74VcE3w2OyPAkTBdWf1PbUbtghqBO32EAYSOKbXw==
X-Received: by 2002:a05:6000:170b:b0:220:6535:26d8 with SMTP id n11-20020a056000170b00b00220653526d8mr8570089wrc.577.1659533057704;
        Wed, 03 Aug 2022 06:24:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6e48:fbdd:280d:6dac? ([2a05:6e02:1041:c10:6e48:fbdd:280d:6dac])
        by smtp.googlemail.com with ESMTPSA id a1-20020adfe5c1000000b0021e491fd250sm12232819wrn.89.2022.08.03.06.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 06:24:17 -0700 (PDT)
Message-ID: <17261234-9a06-bc12-b188-0fc8e90b3c23@linaro.org>
Date:   Wed, 3 Aug 2022 15:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: build failure after merge of the thermal tree
Content-Language: en-US
To:     broonie@kernel.org, Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220803130500.223005-1-broonie@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220803130500.223005-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 15:05, broonie@kernel.org wrote:
> Hi all,
> 
> After merging the thermal tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> /tmp/next/build/drivers/iio/adc/sun4i-gpadc-iio.c: In function 'sun4i_gpadc_probe':
> /tmp/next/build/drivers/iio/adc/sun4i-gpadc-iio.c:640:44: error: passing argument 1 of 'thermal_of_zone_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
>    640 |   info->tzd = thermal_of_zone_register(info->sensor_device,
>        |                                        ~~~~^~~~~~~~~~~~~~~
>        |                                            |
>        |                                            struct device *
> In file included from /tmp/next/build/drivers/iio/adc/sun4i-gpadc-iio.c:31:
> /tmp/next/build/include/linux/thermal.h:301:29: note: expected 'struct device_node *' but argument is of type 'struct device *'
>    301 | struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
>        |                             ^~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/next/build/drivers/iio/adc/sun4i-gpadc-iio.c: In function 'sun4i_gpadc_remove':
> /tmp/next/build/drivers/iio/adc/sun4i-gpadc-iio.c:684:2: error: implicit declaration of function 'thermal_zone_of_sensor_unregister'; did you mean 'thermal_zone_device_unregister'? [-Werror=implicit-function-declaration]
>    684 |  thermal_zone_of_sensor_unregister(info->sensor_device, info->tzd);
>        |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |  thermal_zone_device_unregister
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>     990ee4496499ef61c06bbf ("iio/drivers/sun4i_gpadc: Switch to new of thermal API")

Fixed and linux-next branch updated



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
