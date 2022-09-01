Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7695A9FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiIAT0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiIAT0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:26:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544EA4E61C;
        Thu,  1 Sep 2022 12:25:21 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f24so15225826plr.1;
        Thu, 01 Sep 2022 12:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=C6sKHTsSE/X9c2+J9QgkAtiQ7L50Tlqyc0fm3w0aWMI=;
        b=UXoaUTKr0dnbx5dRk4uYqsLaXtX1VUkPS7MAikC1UpGIJ9/S21utmpR2yAEIfv0Mkh
         5dhw3yp0ZQWk6DrilvAzqqpTrL7DYq5oJ5/bdZjoElSMnfLKN1MIaQkOwaImTlGpZZ2E
         1lJC1nE21+c+T3KQyVIQyisSPYbpstmFG5uDz4NKalQxYUtZ5vdcc2jteWGoRqyeNq/A
         ob/m/QL2upUdnwNf17dqLfX6Sp/qYkL2g91CtykNG/x0L59b47TBVprgkMbCswimomkB
         RAA1vcBqJIPSVzY5yRQppNtOcJEVanrbgrHrSkxxmD043moILv55j8g9hl1Ou5my22tU
         ykBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=C6sKHTsSE/X9c2+J9QgkAtiQ7L50Tlqyc0fm3w0aWMI=;
        b=Stl4SLB/NvLyGoj+7PoP0Ke2v8Bt2nP8Ng8u4R3aTgMrH0SK6Ryi0oH9SesgcCXvop
         u/URhQsdALcp95he7T+dOqugfns8TTgEOhCEihDjpT44Et8AEECm60McnFXgzUkg7PDX
         mTZ41QiiwOnMBQElgwVZ/3mtb4QvTuvR7Rr3MWBonEf9fHTQs0hv7Si1jm8/HE+pcwEl
         e0pIdtkqCvIzCOWOPlqaWNMInm2Rm34eNC8ARghidfDp+cDAnVE70+svnS7KQWXeo+W5
         pxe/8Y2f/wRnVqQr3PHFDtSqNVkOOjqs8AnOuGBsFTTgzQgLs0YxlkugVxMpq11B294L
         voCA==
X-Gm-Message-State: ACgBeo1l9iw6pxtSy0Hy0R9dlbsKo2LxD50u1NG5v3WrWdXIE1M14Thq
        QJ0/vib3+V8szL4b+nrT5VLB04vNhbDukw==
X-Google-Smtp-Source: AA6agR40dbVSsTjS/+gDWWX+qOQDH8/azaHs9ltdhGtOQ7MpyhUH1OUjwcJajgb490PeQ0lhFq36XA==
X-Received: by 2002:a17:90a:8b82:b0:1fa:973c:1d34 with SMTP id z2-20020a17090a8b8200b001fa973c1d34mr693556pjn.31.1662060320464;
        Thu, 01 Sep 2022 12:25:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s66-20020a625e45000000b005350ea966c7sm13822199pfb.154.2022.09.01.12.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 12:25:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fa3e91f0-fae5-cfed-4656-c7be74e37a74@roeck-us.net>
Date:   Thu, 1 Sep 2022 12:25:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when
 "intel, vm-map" not defined
Content-Language: en-US
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, andriy.shevchenko@intel.com
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-3-farbere@amazon.com>
 <cddebb5a-3b83-e89d-db00-9a59ddbd6741@roeck-us.net>
 <84a68eff-be64-71ce-1533-1e228d3da2a4@amazon.com>
 <71d6d57c-2165-5fe3-515d-9395022921e2@roeck-us.net>
 <2f5c5828-87b9-f3d2-e3d3-0200adbe830c@amazon.com>
 <20220901144434.GB3477025@roeck-us.net>
 <ceef1c33-1af5-53d1-5e5b-5aeb5d2679ca@amazon.com>
 <a48f6c26-232a-f3ae-01d1-277e5c9800ee@roeck-us.net>
 <3364aecd-c1d0-3929-9f51-4d90549d8731@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <3364aecd-c1d0-3929-9f51-4d90549d8731@amazon.com>
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

On 9/1/22 11:36, Farber, Eliav wrote:
> On 9/1/2022 8:11 PM, Guenter Roeck wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> On 9/1/22 08:24, Farber, Eliav wrote:
>>> On 9/1/2022 5:44 PM, Guenter Roeck wrote:
>>>> On Thu, Sep 01, 2022 at 11:39:58AM +0300, Farber, Eliav wrote:
>>>>> On 8/31/2022 2:48 PM, Guenter Roeck wrote:
>>>>> > On 8/30/22 22:49, Farber, Eliav wrote:
>>>>> > > On 8/31/2022 8:36 AM, Guenter Roeck wrote:
>>>>> > > > On 8/30/22 12:21, Eliav Farber wrote:
>>>>> > > > > Bug fix - in case "intel,vm-map" is missing in device-tree
>>>>> > > > > ,'num' is set
>>>>> > > > > to 0, and no voltage channel infos are allocated.
>>>>> > > > >
>>>>> > > > > Signed-off-by: Eliav Farber <farbere@amazon.com>
>>>>> > > > > ---
>>>>> > > > >   drivers/hwmon/mr75203.c | 28 ++++++++++++----------------
>>>>> > > > >   1 file changed, 12 insertions(+), 16 deletions(-)
>>>>> > > > >
>>>>> > > > > diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
>>>>> > > > > index 046523d47c29..0e29877a1a9c 100644
>>>>> > > > > --- a/drivers/hwmon/mr75203.c
>>>>> > > > > +++ b/drivers/hwmon/mr75203.c
>>>>> > > > > @@ -580,8 +580,6 @@ static int mr75203_probe(struct
>>>>> > > > > platform_device *pdev)
>>>>> > > > >       }
>>>>> > > > >
>>>>> > > > >       if (vm_num) {
>>>>> > > > > -             u32 num = vm_num;
>>>>> > > > > -
>>>>> > > > >               ret = pvt_get_regmap(pdev, "vm", pvt);
>>>>> > > > >               if (ret)
>>>>> > > > >                       return ret;
>>>>> > > > > @@ -594,30 +592,28 @@ static int mr75203_probe(struct
>>>>> > > > > platform_device *pdev)
>>>>> > > > >               ret = device_property_read_u8_array(dev, "intel,vm-map",
>>>>> > > > > pvt->vm_idx, vm_num);
>>>>> > > > >               if (ret) {
>>>>> > > > > -                     num = 0;
>>>>> > > > > +                     /*
>>>>> > > > > +                      * Incase intel,vm-map property is not
>>>>> > > > > defined, we
>>>>> > > > > +                      * assume incremental channel numbers.
>>>>> > > > > +                      */
>>>>> > > > > +                     for (i = 0; i < vm_num; i++)
>>>>> > > > > + pvt->vm_idx[i] = i;
>>>>> > > > >               } else {
>>>>> > > > >                       for (i = 0; i < vm_num; i++)
>>>>> > > > >                               if (pvt->vm_idx[i] >= vm_num ||
>>>>> > > > > - pvt->vm_idx[i] == 0xff) {
>>>>> > > > > - num = i;
>>>>> > > > > + pvt->vm_idx[i] == 0xff)
>>>>> > > > > break;
>>>>> > > >
>>>>> > > > So all vm_idx values from 0x00 to 0xfe would be acceptable ?
>>>>> > > > Does the chip really have that many registers (0x200 + 0x40 +
>>>>> > > > 0x200 * 0xfe) ?
>>>>> > > > Is that documented somewhere ?
>>>>> > > According to the code vm_num is limited to 32 because the mask is
>>>>> > > only 5 bits:
>>>>> > >
>>>>> > > #define VM_NUM_MSK    GENMASK(20, 16)
>>>>> > > #define VM_NUM_SFT    16
>>>>> > > vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
>>>>> > >
>>>>> > > In practice according to the data sheet I have:
>>>>> > > 0 <= VM instances <= 8
>>>>> > >
>>>>> > Sorry, my bad. I misread the patch and thought the first part of
>>>>> > the if statement was removed.
>>>>> >
>>>>> > Anyway, what is the difference between specifying an vm_idx value of
>>>>> > 0xff and not specifying anything ? Or, in other words, taking the dt
>>>>> > example, the difference between
>>>>> >        intel,vm-map = [03 01 04 ff ff];
>>>>> > and
>>>>> >        intel,vm-map = [03 01 04];
>>>>>
>>>>> The actual number of VMs is read from a HW register:
>>>>>     ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
>>>>>     ...
>>>>>     vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
>>>>>
>>>>> Also, using:
>>>>>     ret = device_property_read_u8_array(dev, "intel,vm-map", vm_idx,
>>>>>                         vm_num);
>>>>> in the driver will fail if vm_num > sizeof array in device-tree.
>>>>>
>>>>> So, if for example vm_num = 5, but you will want to map only 3 of them
>>>>> you most set property to be:
>>>>>     intel,vm-map = [03 01 04 ff ff];
>>>>> otherwise if you set:
>>>>>     intel,vm-map = [03 01 04];
>>>>> it will assume the property doesn't, and will continue the flow in code
>>>>> as if it doesn’t exist (which is not what the user wanted, and before my
>>>>> fix also has a bug).
>>>>
>>>> There should be some error handling to catch this case (ie if the number
>>>> of entries does not match the expected count), or if a value in the array
>>>> is larger or equal to vm_num. Today the latter is silently handled as end
>>>> of entries (similar to 0xff), but that should result in an error.
>>>> This would avoid situations like
>>>>        intel,vm-map = [01 02 03 04 05];
>>>> ie where the person writing the devicetree file accidentally entered
>>>> index values starting with 1 instead of 0. A mismatch between vm_num
>>>> and the number of entries in the array is silently handled as if there
>>>> was no property at all, which is at the very least misleading and
>>>> most definitely unexpected and should also result in an error.
>>>
>>>
>>> I assume it is possible to tell according to the return value, if property
>>> doesn’t exist at all, or if it does exists and size of array in
>>> device-tree is smaller than vm_num.
>>> In [PATCH v3 17/19] Andy wrote that “code shouldn't be a YAML validator.
>>> Drop this and make sure you have correct DT schema” so I’m a bit confused
>>> if code should validate “intel,bm-map” or if it is the user responsibility.
>>> As this property was not added by me, I prefer not to fix it as part of
>>> this series of patches.
>>>
>>
>> You are changing the driver all over the place with 19 patches, including
>> this code, but you don't want to add code that validates the devicetree
>> data ? That seems odd.
>>
> OK. I have added patch #20 to validate that same VM index doesn't appear
> more than once in intel,vm-map.
> 
> u32 vm_mask = 0;
> 
> for (i = 0; i < vm_num; i++) {
>      if (vm_idx[i] >= vm_num || vm_idx[i] == 0xff)

I think "vm_idx[i] >= vm_num && vm_idx[i] != 0xff)
should also be invalid, ie.

	if (vm_idx[i] == 0xff)
		break;
	if (vm_idx[i] >= vm_num)
		return -EINVAL;

Thanks,
Guenter

>          break;
> 
>      if (vm_mask & BIT(vm_idx[i])) {
>          dev_err(dev, "Same VM appears more than once in intel,vm-map\n",
>              vm_idx[i]);
>          return EINVAL;
>      }
> 
>      vm_mask |= BIT(vm_idx[i]);
> }
> 
> 
>>>
>>>> Also, what happens if the devicetree content is something like the
>>>> following ? Would that be valid ?
>>>>        intel,vm-map = [00 01 01 01 01 01];
>>>
>>> If device-tree content would be:
>>>      intel,vm-map = [00 01 01 01 01 01];
>>> and assuming 16 channels for each VM, the hwmon sub-system will expose 90
>>> sysfs to read voltage values.
>>> In practice 16 – 31, 32 – 47, 48 – 63, 64 – 89 will all report the same
>>> input signals for VM1.
>>>
>>
>> Does that make any sense, and is there a valid reason to have a mapping
>> table like the one in this example ?
> 
> I can't find any sense in having such a mapping.
> Anyway the new patch will not allow it to happen.
> 
> -- 
> Regards, Eliav
> 

