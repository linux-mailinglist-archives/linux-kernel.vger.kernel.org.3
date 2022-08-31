Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40C65A75C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiHaFhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiHaFhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:37:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB89B99F4;
        Tue, 30 Aug 2022 22:37:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j5so9285670plj.5;
        Tue, 30 Aug 2022 22:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=LeiPzwymSVIZVw3GRt09ThxmaQUoR04VQqbMh5D0t2k=;
        b=onEPhCpuvi78PPkxj/K41vDrmpqAt0GbARq29lE4i9OY1lZlf1Vxti6vCDikGwvYqL
         a3WrutZCHGSGAeOTBb1WWY9BQu0cm86TIwjV4p5QnR0pb7IcM6c1OnobCBez8hm35JgV
         lZieVby+J8SaRDLF5p3JRVDHj8LZptS+eMraHjtJxaFQsipeFjFtvbDLfSMyzt6RzYP5
         jiBeBEd0KftPkMryhFMXDT6suNqIzn3iG7TSTH3CGcNzXbWlLMz6ZcWM7DGgHpVFduZy
         J1Q8Dp+F5GpI0U1DHSUCnb2xJ6UN4s7CuL/W6yLXSXQdSK2zk7ZS7nJ1PcObPZJ0U1MV
         tpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=LeiPzwymSVIZVw3GRt09ThxmaQUoR04VQqbMh5D0t2k=;
        b=hUJmkpVMkoG2E/EGYsmmp4Kq0Eo8qaPssiTuEdpyXNdhBqDveNC6lQ7IedSvvOY1Bt
         iH/VquPwPdun7BJyOI7cRErfRuIH+Dlv1dwBaA2sFmWfU4bVO3DpXwZdw9WStYprRo+M
         4+AHVuxWPxWSy6TD4KfHnji58SNzoUWe06UYcKW8p0h2SYEjoDP0uQrIE4SJgoc0KZc0
         Vgt160wNCZNqIE3MELnJJJv652Xmbh3LY19YCZGvqYVlPP6owFvzg6xe5okMwBY7Bryz
         bY2C4fHPxct4qXdJY0w/M4YnEuX1h2MwfybyZyh3Ee5eiZiVANeFVCULUlSx/lNd96Kq
         5mqg==
X-Gm-Message-State: ACgBeo0qq59sTpgeILSPG4aUbH9R8pCleebCscI7ccrYTpgvW0fuEJ3G
        IVrUGpZFjpbBBMT6/vMXl2M=
X-Google-Smtp-Source: AA6agR6g7jbkSaI6vo48mt68MtByBJcgFVXFcEpsT6bh5wmeLv9rRla4CDEld9U/ToG4gytmX6FkAg==
X-Received: by 2002:a17:902:d4c4:b0:173:1206:cee7 with SMTP id o4-20020a170902d4c400b001731206cee7mr23963000plg.142.1661924221538;
        Tue, 30 Aug 2022 22:37:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b0016eea511f2dsm10948677plg.242.2022.08.30.22.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 22:37:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cddebb5a-3b83-e89d-db00-9a59ddbd6741@roeck-us.net>
Date:   Tue, 30 Aug 2022 22:36:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when
 "intel,vm-map" not defined
Content-Language: en-US
To:     Eliav Farber <farbere@amazon.com>, jdelvare@suse.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, rahul.tanwar@linux.intel.com,
        andriy.shevchenko@intel.com
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-3-farbere@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220830192212.28570-3-farbere@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 12:21, Eliav Farber wrote:
> Bug fix - in case "intel,vm-map" is missing in device-tree ,'num' is set
> to 0, and no voltage channel infos are allocated.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>   drivers/hwmon/mr75203.c | 28 ++++++++++++----------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 046523d47c29..0e29877a1a9c 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -580,8 +580,6 @@ static int mr75203_probe(struct platform_device *pdev)
>   	}
>   
>   	if (vm_num) {
> -		u32 num = vm_num;
> -
>   		ret = pvt_get_regmap(pdev, "vm", pvt);
>   		if (ret)
>   			return ret;
> @@ -594,30 +592,28 @@ static int mr75203_probe(struct platform_device *pdev)
>   		ret = device_property_read_u8_array(dev, "intel,vm-map",
>   						    pvt->vm_idx, vm_num);
>   		if (ret) {
> -			num = 0;
> +			/*
> +			 * Incase intel,vm-map property is not defined, we
> +			 * assume incremental channel numbers.
> +			 */
> +			for (i = 0; i < vm_num; i++)
> +				pvt->vm_idx[i] = i;
>   		} else {
>   			for (i = 0; i < vm_num; i++)
>   				if (pvt->vm_idx[i] >= vm_num ||
> -				    pvt->vm_idx[i] == 0xff) {
> -					num = i;
> +				    pvt->vm_idx[i] == 0xff)
>   					break;

So all vm_idx values from 0x00 to 0xfe would be acceptable ?
Does the chip really have that many registers (0x200 + 0x40 + 0x200 * 0xfe) ?
Is that documented somewhere ?

Thanks,
Guenter

> -				}
> -		}
>   
> -		/*
> -		 * Incase intel,vm-map property is not defined, we assume
> -		 * incremental channel numbers.
> -		 */
> -		for (i = num; i < vm_num; i++)
> -			pvt->vm_idx[i] = i;
> +			vm_num = i;
> +		}
>   
> -		in_config = devm_kcalloc(dev, num + 1,
> +		in_config = devm_kcalloc(dev, vm_num + 1,
>   					 sizeof(*in_config), GFP_KERNEL);
>   		if (!in_config)
>   			return -ENOMEM;
>   
> -		memset32(in_config, HWMON_I_INPUT, num);
> -		in_config[num] = 0;
> +		memset32(in_config, HWMON_I_INPUT, vm_num);
> +		in_config[vm_num] = 0;
>   		pvt_in.config = in_config;
>   
>   		pvt_info[index++] = &pvt_in;

