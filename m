Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05304BE463
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379808AbiBUQCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:02:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiBUQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:02:43 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A73113F27;
        Mon, 21 Feb 2022 08:02:19 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id x3so33092244qvd.8;
        Mon, 21 Feb 2022 08:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=SKQRm/MiaRopJH174P9FQFjCECZd9qZBsJ/qnTLpkMk=;
        b=q8I6EXImLf4lnuJmqGEZgM6olH+yMB5gmIz/q+1JT/awsTC7n2frqvUrqklAEEy9QN
         EeKJ8FA06Piz67ISWZVg2aTG7SIMPlt+aL8W5z/yF5B4lHEDs6rpfbQS3S/wpxDkIhYk
         OmB4AUVLQsxusHrZsywRy7+0o+C5t0Bv3W+svnxQMbZYlAIbnGc97o1DM56YdzDkaLjk
         RACm3/wcZK3GjxkKwMaTxmvAsWg54Icrs8LFyMrcl2Vl5eq7JUk2dB0D31LkENwyxtxU
         Pg6bZLwKVOyxN0dRgXY2k86FdYtaJ/XY2CX6W+qZuB0EzsdtRkh6YX/cg2Z7v59A3dJA
         zGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=SKQRm/MiaRopJH174P9FQFjCECZd9qZBsJ/qnTLpkMk=;
        b=etqvXd4nqlXlH1G29HUJYVA+Fi8BdhRJbnZq2xxV2WW0MVVL9wQ6eESzijAv9rPeVB
         RjiDLuEiunAtfWAc96JLUPxapNSAlU6yHvwhdkNurGvdKlLKWXLnImiCr8ZogRZIklKP
         Mb+66wpW72Wk6JWqsvM23M1NH2UO6TwWml6feWMLR1LINl6Xy32kA7j3wG2LCfTsUU6L
         VU9L/OzIWo+izOwgiJddUaM1k6vronM4kWIRw+x15W61ektBb7o31MbbKDNRsYRbb7uh
         6BX3bvfAqNB9y4zB10Z0lj6HLF8Z6Yx0b/oTFUswPn/7WR9vstJtEcliZwXZICe7iHrl
         y8bw==
X-Gm-Message-State: AOAM530YkfpiI2/Vqtmw0UWz4ASl8epcae+qfaQtWjpHA556J/NYAQzT
        flaqmkDqKUpbdG2M23kkSKhrqgVrWOucHA==
X-Google-Smtp-Source: ABdhPJwobhLve4Knfik6KEUVp+8bxBkMQMov+EQMR8EW0UE9DUj9ud8oxyspj5Fv7p8bfPxY0ooJog==
X-Received: by 2002:a05:622a:1192:b0:2d1:e58e:7659 with SMTP id m18-20020a05622a119200b002d1e58e7659mr18804470qtk.41.1645459338165;
        Mon, 21 Feb 2022 08:02:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l1sm8849821qtp.4.2022.02.21.08.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:02:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bdb8b51f-93ac-9f99-914e-e1ce16c0076d@roeck-us.net>
Date:   Mon, 21 Feb 2022 08:02:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
 <84ddad27-eb22-0ba6-594f-2fc6d098dc2a@nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
In-Reply-To: <84ddad27-eb22-0ba6-594f-2fc6d098dc2a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/21/22 07:49, Jon Hunter wrote:
> 
> On 21/02/2022 15:43, Guenter Roeck wrote:
> 
> ...
> 
>>> We observed a random null pointer deference crash somewhere in the
>>> thermal core (crash log below is not very helpful) when calling
>>> mutex_lock(). It looks like we get an interrupt when this crash
>>> happens.
>>>
>>> Looking at the lm90 driver, per the above, I now see we are calling
>>> hwmon_notify_event() from the lm90 interrupt handler. Looking at
>>> hwmon_notify_event() I see that ...
>>>
>>> hwmon_notify_event()
>>>    --> hwmon_thermal_notify()
>>>      --> thermal_zone_device_update()
>>>        --> update_temperature()
>>>          --> mutex_lock()
>>>
>>> So although I don't completely understand the crash, it does seem
>>> that we should not be calling hwmon_notify_event() from the
>>> interrupt handler.
>>>
>> As mentioned separately, this is not the problem.
> 
> Yes I can see that now.
> 
>> I think the problem may be that this is not a devicetree system
>> (or the lm90 devide does not have a devicetree node), but thermal
>> notification currently only works in such systems because the hwmon
>> subsystem uses the devicetree registration method. At the same time,
>> CONFIG_THERMAL_OF is obviously enabled. Unfortunately, the hwmon code
>> does not bail out in that situation due to another bug.
> 
> The platform I see this on does use device-tree and it does have a node for the ti,tmp451 device which uses the lm90 device. This platform uses the device-tree source arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts and the tmp451 node is in arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi.
> 

Interesting. It appears that the call to devm_thermal_zone_of_sensor_register()
in the hwmon core nevertheless returns -ENODEV which is not handled properly
in the hwmon core. I can see a number of reasons for this to happen:
- there is no devicetree node for the lm90 device
- there is no thermal-zones devicetree node
- there is no thermal zone entry in the thermal-zones node which matches
   the sensor

We'll have to revert the lm90 changes until this is sorted out.

Guenter
