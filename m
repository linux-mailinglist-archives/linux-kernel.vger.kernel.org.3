Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB79508A96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379681AbiDTOTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380264AbiDTOSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:18:46 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA5DEFC;
        Wed, 20 Apr 2022 07:15:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q129so2178391oif.4;
        Wed, 20 Apr 2022 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=gbllx+zYcqJDDzwcpoWdcYZQmSKhFnQL5hSmsALhTPk=;
        b=hzipemxVxo+MVpHqws+M38o17ysnggup9oNWAxF4UIn97NG9G/h8B9JOWAXQuS0AUT
         9iKnLYMpUqPXgPUhtEwqsXtJtcoQHqsUn7PqjBhr4m8jPvLTe7r5nh6hpdOYTKtiA1BB
         X8wPDUpjhoOUEqfZH0FNeusKAvcpUNuDZRtXgON9CaklT2piYAfEt4o/PNDzFX7/MQ/w
         ygjMxhNEQ2ZDcJr+M2t7upM8S32iir3lsSxsQx0qJYDlraiUjoWIdo1w8z6eq+kspWOt
         cdKRM/nREZOCzpoBO4z+NcGEHYah1YU9FYpru5Nbk157mngO8RZtkJBkKvYcwvMNCp4n
         1WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=gbllx+zYcqJDDzwcpoWdcYZQmSKhFnQL5hSmsALhTPk=;
        b=fAVqlEVELf59WaK4vYBgs8eV9pQA8XmjRYwlO1JLPeioruNHn+ZRN6L4oZzhSJKhz6
         oNeXat5mSMg1PsBGx9ObAlNJCFc3qSpdr/UECBY9KG4xZQ/pVDAiFqt9xsrT7dCLMefD
         9UgbxMwxRhozEm/OG41wrlu1PBBFvCmciOM2vJt1lWKtip/RFzLbrwU8VcnG6LmsorH+
         ubmvlb7lzYYMDnwD0s+9bgodZskJt3AqqZpg9szZrwMYuHIvoulMV/ykfgaRvZVbp+fp
         3hupcTHn869CGqdoZxVZK1PdM8l8Go4Fw+E8EK5tvkXNP0Xy48tkMqHorISp+A/fRwNx
         QpoQ==
X-Gm-Message-State: AOAM533zMCOLSSgRnucpBbx+SFLlpxE5zs0STLedB0qosKQW9/q7G/i2
        Y76DEspSpOCl7HthxPPtR4k=
X-Google-Smtp-Source: ABdhPJz/Jgy5A/q7ITH2562syP2+iOUzNPBeF8m6CT9NsLyL8lCuja7TiK/VFBU0i5IqMZ1l2ajGpw==
X-Received: by 2002:a05:6808:13d1:b0:2da:7f74:3f45 with SMTP id d17-20020a05680813d100b002da7f743f45mr1853538oiw.119.1650464111454;
        Wed, 20 Apr 2022 07:15:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n18-20020a056820055200b003299b79f3e2sm6781408ooj.9.2022.04.20.07.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 07:15:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6f697b2c-58aa-6ca4-966b-147bcc184dad@roeck-us.net>
Date:   Wed, 20 Apr 2022 07:15:09 -0700
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] hwmon: (pmbus) add MFR_* registers to debugfs
In-Reply-To: <PFzjnraIDClF6umMOqlCKCzxG6q5lIhBLHpynRA6juh6gXSp5Y7SLPpzXZGNU6L7OGCEwl_F-niJn1jTflifWnqm9PX3Rcfqbtdo6rmPAT4=@wujek.eu>
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

On 4/20/22 06:58, wujek dev wrote:
> ------- Original Message -------
> On Wednesday, April 20th, 2022 at 15:53, Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>
>>
>> On 4/20/22 05:22, Adam Wujek wrote:
>>
>>> Add registers to debugfs:
>>> PMBUS_MFR_ID
>>> PMBUS_MFR_MODEL
>>> PMBUS_MFR_REVISION
>>> PMBUS_MFR_LOCATION
>>> PMBUS_MFR_DATE
>>> PMBUS_MFR_SERIAL
>>>
>>> Signed-off-by: Adam Wujek dev_public@wujek.eu
>>
>>
>> Where is patch 1/2, and why did you resend this patch ?
>>
> There should be no "1/2" since this and the second patch are unrelated.
> I resend it because I rebased it on master.
> 
Please provide change logs and version your patches in the future.

> Adam
> 
>> Guenter
>>
>>> ---
>>> drivers/hwmon/pmbus/pmbus_core.c | 84 ++++++++++++++++++++++++++++++++
>>> 1 file changed, 84 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>>> index 0af7a3d74f47..1dc186780ccf 100644
>>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>>> @@ -2625,6 +2625,30 @@ static int pmbus_debugfs_get_status(void *data, u64 *val)
>>> DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugfs_get_status,
>>> NULL, "0x%04llx\n");
>>>
>>> +static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __user *buf,
>>> + size_t count, loff_t *ppos)
>>> +{
>>> + int rc;
>>> + struct pmbus_debugfs_entry *entry = file->private_data;
>>> + char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
>>> +
>>> + rc = i2c_smbus_read_block_data(entry->client, entry->reg, data);
>>> + if (rc < 0)
>>> + return rc;
>>> +
>>> + data[rc] = '\n';
>>> + rc += 2;

Why +2 ?

>>> +
>>> + return simple_read_from_buffer(buf, count, ppos, data, rc);
>>> +}
>>> +
>>> +static const struct file_operations pmbus_debugfs_ops_mfr = {
>>> + .llseek = noop_llseek,
>>> + .read = pmbus_debugfs_mfr_read,
>>> + .write = NULL,
>>> + .open = simple_open,
>>> +};
>>> +
>>> static int pmbus_debugfs_get_pec(void *data, u64 *val)
>>> {
>>> struct i2c_client *client = data;
>>> @@ -2801,6 +2825,66 @@ static int pmbus_init_debugfs(struct i2c_client *client,
>>> &entries[idx++],
>>> &pmbus_debugfs_ops);
>>> }
>>> +
>>> + if (pmbus_check_byte_register(client, i, PMBUS_MFR_ID)) {
>>> + entries[idx].client = client;
>>> + entries[idx].page = i;
>>> + entries[idx].reg = PMBUS_MFR_ID;
>>> + scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_id", i);
>>> + debugfs_create_file(name, 0444, data->debugfs,
>>> + &entries[idx++],
>>> + &pmbus_debugfs_ops_mfr);
>>> + }

You are adding several debugfs entries without increasing the size
of the entries array. That means that up to 16 debugfs entries are
now created into an array of size 10. That won't work.

Guenter
