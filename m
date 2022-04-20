Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4445A508CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380309AbiDTQJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380158AbiDTQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:09:14 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA130552;
        Wed, 20 Apr 2022 09:06:28 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e2afb80550so2434497fac.1;
        Wed, 20 Apr 2022 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=xUUVhcCV2MnLvckxNQgFIVhxYpI9BwVhaob+8jFGxmE=;
        b=oc2C+JoZAcCa5ezslIwZxLQJIZwS49mZnJKCFyXLCYAXqB/J9OXfL7g6jibOS/6oNv
         nr2SE8Z7cH0Zs74f65Er1RV1/K6UdES7yjVwcD7zz+amDcqM1hw9fMxUSQKayJ8Rw+H0
         NOERztMpRK//cZU5FUbfwBRYEP82fwFwpN6NnyoNzurl1DJCIsB4nxfjXVhpWUbbBA55
         3wXz/jC9TokskhGMDpoTBTS4PyJym80DvZ7fO77/yR+bbO/FYBt6BmNxJaL0L5EzzCsE
         59DTCusR7JSquzgssb/im89wP1GziIPHexlplgrAHVU7c39rvEeXBUcCy7VfYDRfl57s
         ohOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=xUUVhcCV2MnLvckxNQgFIVhxYpI9BwVhaob+8jFGxmE=;
        b=yCgUQk5su2Bclfo916pybQjtEb/iumdUQvrA4D8WguBjGSURP/rYiiBW0ofYvUduaY
         lL7hXM2rOPtEGhoPurVhtMcSHSceDQQixGq1Rr3lt40AT+ONcGXZIr5y1846cc2Ayz/5
         HIWOrTaSQTMWvj9hN2FPa2agdqS9M+ldqKAcNbL6KjOx6YLApdl+WrGSE7QWOSkZpCRO
         nY1tX+vCTYwTX1OEzoIJ1BLPhkr2XKdsntEV/Y+2VsI21/JEvBTTLVHsfROx9oxl+tBy
         9f8sKfEhZvDofUH5W+tiqf+IfxbZNoIv/xkVCG9qm2YWaeD/9KdiE2wGl/Ml9NLdqezS
         Dchg==
X-Gm-Message-State: AOAM531DUqgpS0N8uRQomnzOVT480pYrxgcw9R/rPn7x5dI18SHIMge3
        0By1agns+1Sw/mh1HsOgrggWysPmUO4=
X-Google-Smtp-Source: ABdhPJwc5QKQo8PyoeJVu08zt/5fsKFlXNotL3sz5212wczBacQh9Tvq/6BKTIGJGD0v5RpkOMQhyQ==
X-Received: by 2002:a05:6871:793:b0:db:360c:7f5e with SMTP id o19-20020a056871079300b000db360c7f5emr1921012oap.218.1650470787745;
        Wed, 20 Apr 2022 09:06:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a3-20020a9d5c83000000b006054c7ecfb6sm3705539oti.34.2022.04.20.09.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 09:06:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1b12cb3a-3d87-8254-b229-dcf83ad0bc0a@roeck-us.net>
Date:   Wed, 20 Apr 2022 09:06:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     wujek dev <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220419215326.309991-1-dev_public@wujek.eu>
 <20220420122128.411757-1-dev_public@wujek.eu>
 <f34ec7ac-7b34-6d98-25ad-31b13fe08c59@roeck-us.net>
 <PFzjnraIDClF6umMOqlCKCzxG6q5lIhBLHpynRA6juh6gXSp5Y7SLPpzXZGNU6L7OGCEwl_F-niJn1jTflifWnqm9PX3Rcfqbtdo6rmPAT4=@wujek.eu>
 <6f697b2c-58aa-6ca4-966b-147bcc184dad@roeck-us.net>
 <Liq6d7nBil1lQx274diOvpjRJ9cEYH6co7ZMjrudPfYn0TTzOsfqsjuVBK-pMpFF5nBC0jhuoFEtbtmUY4Td4uY-a4qn6j-OmQD-Qu_xdck=@wujek.eu>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] hwmon: (pmbus) add MFR_* registers to debugfs
In-Reply-To: <Liq6d7nBil1lQx274diOvpjRJ9cEYH6co7ZMjrudPfYn0TTzOsfqsjuVBK-pMpFF5nBC0jhuoFEtbtmUY4Td4uY-a4qn6j-OmQD-Qu_xdck=@wujek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 08:51, wujek dev wrote:
> ------- Original Message -------
> On Wednesday, April 20th, 2022 at 16:15, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> 
>>
>>
>> On 4/20/22 06:58, wujek dev wrote:
>>
>>> ------- Original Message -------
>>> On Wednesday, April 20th, 2022 at 15:53, Guenter Roeck linux@roeck-us.net wrote:
>>>
>>>> On 4/20/22 05:22, Adam Wujek wrote:
>>>>
>>>>> Add registers to debugfs:
>>>>> PMBUS_MFR_ID
>>>>> PMBUS_MFR_MODEL
>>>>> PMBUS_MFR_REVISION
>>>>> PMBUS_MFR_LOCATION
>>>>> PMBUS_MFR_DATE
>>>>> PMBUS_MFR_SERIAL
>>>>>
>>>>> Signed-off-by: Adam Wujek dev_public@wujek.eu
>>>>
>>>> Where is patch 1/2, and why did you resend this patch ?
>>>
>>> There should be no "1/2" since this and the second patch are unrelated.
>>> I resend it because I rebased it on master.
>>
>> Please provide change logs and version your patches in the future.
> ok, thank you for your patience.
>>
>>> Adam
>>>
>>>> Guenter
>>>>
>>>>> ---
>>>>> drivers/hwmon/pmbus/pmbus_core.c | 84 ++++++++++++++++++++++++++++++++
>>>>> 1 file changed, 84 insertions(+)
>>>>>
>>>>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>>>>> index 0af7a3d74f47..1dc186780ccf 100644
>>>>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>>>>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>>>>> @@ -2625,6 +2625,30 @@ static int pmbus_debugfs_get_status(void *data, u64 *val)
>>>>> DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugfs_get_status,
>>>>> NULL, "0x%04llx\n");
>>>>>
>>>>> +static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __user *buf,
>>>>> + size_t count, loff_t *ppos)
>>>>> +{
>>>>> + int rc;
>>>>> + struct pmbus_debugfs_entry *entry = file->private_data;
>>>>> + char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
>>>>> +
>>>>> + rc = i2c_smbus_read_block_data(entry->client, entry->reg, data);
>>>>> + if (rc < 0)
>>>>> + return rc;
>>>>> +
>>>>> + data[rc] = '\n';
>>>>> + rc += 2;
>>
>>
>> Why +2 ?
>>
> Copied from another driver.
> +1 due to '\n'
> +1 due to NULL character (smbus block transfer does not include it in the length)
> Explanation included in v3 patch.

"copied from another driver" is not really a good argument.
That other driver might just be buggy.

What do you see in userspace when you read the data ? A string that ends with
"\n\0" ? If so, does the "\0" at the end add any value ?

Guenter
