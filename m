Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F4E56FB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 11:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiGKJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiGKJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:24:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73BE5E309
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:14:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n10so6149929wrc.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=toTJieFv9f/pSHX/0n3XdcIK9rJ0wxvA9fZtkf2IMTU=;
        b=rmqN/9K7W+rjXou0xRQVst21CLoD4meHcdq4UoisXooZHOETqScwd1+LGSflf4jK8T
         JDNdBA99A6g5+pkL1lnmAYseWAv+UFcUUytorP9k2UWqLp+N7sGRhujdfqKr2ZNycYlx
         pFCKL/LZtpoDnPTD39z4i0w+FMGmqGgcFaMYlKUFO3jpEZstOTG2uxhTD/VxWoB3bcH9
         eX5t0cyEc8fOhQpaBfQgL+5mdYkFqCMM/zavTh+Jb0BBSzPczkmHG4QqCcsdSh3Kvqw+
         3Y1+e/4LMJnBFhA3GVemzAOHMpQKJphT9BQZvclHoyPS4uAFj8OGhoMN2EZKB5q+6MT5
         XEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=toTJieFv9f/pSHX/0n3XdcIK9rJ0wxvA9fZtkf2IMTU=;
        b=8ErZHhlO8nzkBDpK8U0rsDvoN3WOG0f3TfDsm1gx/gsynCHM/jkvnlqjWC6gxyP3MT
         V/uKevJ8K8NOPzPC1ONINiPgnLpO/QvLnjaOnY36yqRE8niUJtfRN1RIIzrJwW5k0/pB
         XbiqZFuWfVKUwb7pM+nAY4AZo0lGb7uUddzezzt1jYbsKIG773uZd4x4ytv1psfWABHW
         hqqfjbhpvM2dHTcGY+pxmmw5F0NrNevgVI9y/tlvH0/1Xkp1mtd51fgWqn2p3CgVrM/X
         5bkpUNxCPQK6Q5kd9CCF4GDNtvReIVx1N94Y2CIihNU43sEABUKA1reaC17DxfpkZiQj
         oQMg==
X-Gm-Message-State: AJIora8pGk1qi13f654ZRCyYpMbSL/JMm9IlXrFySnhPaO6j44yokjLI
        m7ykhviUMQoK2CoKgUjyUxyK/Q==
X-Google-Smtp-Source: AGRyM1uKnt27o24VXDAxHEF/Z1WFQnlsz18DorttQo+uJFB7N/f4MjHn3Nlow83bySlWLAIqNTjDzg==
X-Received: by 2002:a05:6000:10c1:b0:21d:76e0:c6de with SMTP id b1-20020a05600010c100b0021d76e0c6demr15695289wrx.623.1657530849366;
        Mon, 11 Jul 2022 02:14:09 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c7c0:6823:f3ce:2447? ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.googlemail.com with ESMTPSA id z15-20020a056000110f00b0021d6c7a9f50sm5511386wrw.41.2022.07.11.02.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 02:14:08 -0700 (PDT)
Message-ID: <e50842cf-0179-7b70-3925-dacb4ce728ea@linaro.org>
Date:   Mon, 11 Jul 2022 11:14:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 25/33] ata/drivers/ahci_imx: Switch to new of thermal
 API
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-26-daniel.lezcano@linexp.org>
 <a424890d-8647-48c5-68ab-742a95bb6865@opensource.wdc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a424890d-8647-48c5-68ab-742a95bb6865@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 01:18, Damien Le Moal wrote:
> On 7/11/22 06:24, Daniel Lezcano wrote:
>> The thermal OF code has a new API allowing to migrate the OF
>> initialization to a simpler approach.
>>
>> Use this new API.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
>> ---
>>   drivers/ata/ahci_imx.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
>> index 79aa9f285312..5ad9a890e71a 100644
>> --- a/drivers/ata/ahci_imx.c
>> +++ b/drivers/ata/ahci_imx.c
>> @@ -327,7 +327,7 @@ static int read_adc_sum(void *dev, u16 rtune_ctl_reg, void __iomem * mmio)
>>   }
>>   
>>   /* SATA AHCI temperature monitor */
>> -static int sata_ahci_read_temperature(void *dev, int *temp)
>> +static int __sata_ahci_read_temperature(void *dev, int *temp)
>>   {
>>   	u16 mpll_test_reg, rtune_ctl_reg, dac_ctl_reg, read_sum;
>>   	u32 str1, str2, str3, str4;
>> @@ -416,6 +416,11 @@ static int sata_ahci_read_temperature(void *dev, int *temp)
>>   	return 0;
>>   }
>>   
>> +static int sata_ahci_read_temperature(struct thermal_zone_device *tz, int *temp)
>> +{
>> +	return __sata_ahci_read_temperature(tz->devdata, temp);
>> +}
>> +
>>   static ssize_t sata_ahci_show_temp(struct device *dev,
>>   				   struct device_attribute *da,
>>   				   char *buf)
>> @@ -423,14 +428,14 @@ static ssize_t sata_ahci_show_temp(struct device *dev,
>>   	unsigned int temp = 0;
>>   	int err;
>>   
>> -	err = sata_ahci_read_temperature(dev, &temp);
>> +	err = __sata_ahci_read_temperature(dev, &temp);
>>   	if (err < 0)
>>   		return err;
>>   
>>   	return sprintf(buf, "%u\n", temp);
>>   }
> 
> I do not see why the above changes are necessary. Please explain.

sata_ahci_read_temperature() is used by sata_ahci_show_temp() also.

So in order to change the function prototype for the get_temp ops which 
does not take a void* but a thermal_zone_device* structure, this 
function wraps the call.

Do you prefer sata_ahci_read_temperature() becomes sata_ahci_get_temp() 
and keep __sata_ahci_read_temperature() name untouched ?

>>   
>> -static const struct thermal_zone_of_device_ops fsl_sata_ahci_of_thermal_ops = {
>> +static struct thermal_zone_device_ops fsl_sata_ahci_of_thermal_ops = {
> 
> Why remove the const ?
> 
>>   	.get_temp = sata_ahci_read_temperature,
>>   };
>>   
>> @@ -1131,8 +1136,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
>>   			ret = PTR_ERR(hwmon_dev);
>>   			goto disable_clk;
>>   		}
>> -		devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
>> -					     &fsl_sata_ahci_of_thermal_ops);
>> +		devm_thermal_of_zone_register(hwmon_dev, 0, hwmon_dev,
>> +					      &fsl_sata_ahci_of_thermal_ops);
> 
> This is the only change that seems necessary.
> 
>>   		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
>>   	}
>>   
> 
> And it is hard to review a patch without the full series for context.
> Please send all patches next time.
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
