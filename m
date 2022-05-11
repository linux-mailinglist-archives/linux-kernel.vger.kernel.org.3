Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004A6523D50
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbiEKTV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346743AbiEKTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:21:24 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A535AA44;
        Wed, 11 May 2022 12:21:23 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e2fa360f6dso4048201fac.2;
        Wed, 11 May 2022 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FOGb83gh0B4t5TMaKCDb4y5EtmPQl9IuuPX9Uog2s5c=;
        b=Kkxoe2mKc5EtL6uY6MFINdhc6GDFJrdoI6XvxPZoAVtXblS91W0j27vb7y+UAaKD+v
         wikp6ZMt7f7M09cKXUqUGhsN+5lXyuohjbFC6JAM8A6A7EHNnfY6eQJOTrbnO1Wtpx+i
         hK+f7KpCqoCeQW7NiFdUndh7jfjBpp78WraztRGKMP4C7EOxJ7GmB3/el8G2EJFANWJk
         f80Hy4TNas9PBAKIxSe4RG6wf/ioRbGyLOzoR2DZSwcOLLpfkoaJ5vCBvz7vG44KrsIR
         DVOTeixW1wf3rBzd7w1E3s8mib7dUxYveE5Jl+5kZHcxqAGFz/OLkyoRvSWDrvp9AZgP
         2Iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FOGb83gh0B4t5TMaKCDb4y5EtmPQl9IuuPX9Uog2s5c=;
        b=EIFuGlC0flRZU9vh9zFMkKpjBB8llZkqG/drdyEPAsSqgsILKyKgcYEEPwacZ/v7Lb
         BZm+Am3yo4ZluPAs4wXOUFJY3zZinIYplocV5zIGC9vhh1CiMlv6iadqRKrjNq/qf9bG
         /8i/xRTfQbhdsbpR98ujxEx/W1bSABwAei/1H2RYOiJ/HjENsK4cjTtWYTRsrU20z2J6
         X702EYRJzhmTooa61xVZ4gsHg6PeuFE1GRbnBYAlePFNO6G3AlXxpY1JXMtI2FqPXoLk
         xEqzsruyCzVgtciR1eh94lweRoW6fGA4kBs+FwXr5yhY08W8W0aLWGDRHp0GTzJyshGJ
         IcPQ==
X-Gm-Message-State: AOAM5314mm7FkKHLO/56fU1PkkaemONvDvAwnpF52M/wIbEI9fuc4Iao
        zX8uvH6UVncDf8QUjszJVWM=
X-Google-Smtp-Source: ABdhPJwKeqnUpEXQLb+TheYbgCxz702S6d71N8wzoKShYtVEJ4qCZjcmwrHZ+u+ievXUuN2hJZ5xaw==
X-Received: by 2002:a05:6870:548f:b0:ed:a0e8:881b with SMTP id f15-20020a056870548f00b000eda0e8881bmr3660428oan.25.1652296882911;
        Wed, 11 May 2022 12:21:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y132-20020acae18a000000b00326e2284976sm1085094oig.15.2022.05.11.12.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 12:21:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <637ed1af-8914-96b5-3a3f-04db94d16b38@roeck-us.net>
Date:   Wed, 11 May 2022 12:21:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] hwmon: Introduce and use
 hwmon_device_register_for_thermal
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220511151230.2983227-1-linux@roeck-us.net>
 <CAJZ5v0gk19uQG-+_gm7J_Gk+H2mtH+SmEojnPcEDiFdPoyjCzw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAJZ5v0gk19uQG-+_gm7J_Gk+H2mtH+SmEojnPcEDiFdPoyjCzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 11:21, Rafael J. Wysocki wrote:
> On Wed, May 11, 2022 at 5:12 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> The thermal subsystem registers a hwmon driver without providing
>> chip information or sysfs group information. This is for legacy reasons
>> and would be difficult to change.
>>
>> At the same time, several attempts have been made to convert hwmon
>> drivers using the deprecated hwmon_device_register() to use
>> hwmon_device_register_with_info() by just providing NULL parameters.
>> This is an abuse of the hwmon API. To prevent this abuse, we want to
>> enforce that a parent device pointer as well as chip information is
>> provided when registering a hwmon device using
>> hwmon_device_register_with_info().
>>
>> To be able to do this, introduce and use a special API for use only by
>> the thermal subsystem (patches 1 and 2). Patch 3 makes the 'dev' and 'chip'
>> parameters of hwmon_device_register_with_info() mandatory.
>>
>> ----------------------------------------------------------------
>> Guenter Roeck (3):
>>        hwmon: Introduce hwmon_device_register_for_thermal
>>        thermal/drivers/thermal_hwmon: Use hwmon_device_register_for_thermal()
>>        hwmon: Make chip parameter for with_info API mandatory
>>
>>   Documentation/hwmon/hwmon-kernel-api.rst |  2 +-
>>   drivers/hwmon/hwmon.c                    | 41 ++++++++++++++++++++++++++++++++---------
>>   drivers/thermal/thermal_hwmon.c          |  6 ++++--
>>   include/linux/hwmon.h                    |  3 +++
>>   4 files changed, 40 insertions(+), 12 deletions(-)
> 
> This looks good to me from the thermal perspective, so please feel
> free to add my ACKs to the first two patches.
> 

Thanks!

Guenter

