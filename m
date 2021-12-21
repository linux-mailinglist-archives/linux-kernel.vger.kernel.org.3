Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1147BF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhLUMYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhLUMYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:24:04 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139D0C061574;
        Tue, 21 Dec 2021 04:24:04 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x7so4409510lfu.8;
        Tue, 21 Dec 2021 04:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=WGfqbWA1U77ryXkW/KNQ213dLjGmZW9L1J0JTOkevDk=;
        b=daNA5XBBpuh+fhK63NG5K0q7MMfnOrIsmfH7Iv5GU7ANRoC9Pi4akk+CT7VwlVEFJ9
         Whcg6CAYXyf3Ga+qk3kH5v40L1WZsG8uyI2lRohXNEs2NUs2w63WHIPlFgZzl9ItqXLW
         aci/8cDeJ9sYRII011J6NphO8BFmdq7tP6giBxzT1qMrGAO/2lXvpEWTCnKxF96rup9j
         43oob5JqisamCmd3c2MykHrKvtJQiNnwJEnUV4Nm8wXXwcnC3EuMZRwlwk5OY/rJ68Zc
         eX3N6fMkrB+3LDDWpeSqzkX2zf/HBP1jbrj5+dgwKRc0Ut5mS6WZq4nOMVmRT3RSQI2R
         GxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WGfqbWA1U77ryXkW/KNQ213dLjGmZW9L1J0JTOkevDk=;
        b=q3srA3PSwp5rtYqX/javUJKjb7vqgzL64Zmi+FF+d9T5VUPfSCWWLYPLyAg9jlSuJa
         fDqHb4OfRfiX6LqjKazNn3fTJJWUCr7De0sxBzXtIySVj1udkajcySmpxknnmExGZdRu
         JE6bjPgrMDat6BNBQup85mLqZAKAEQ8URx3hKBmiqCKMMazhxNWwK1f7pC5NPZk/K8Zh
         RvTvRmY0hVUFB1hp0M/gLWlSIFFWBhnGHZ96U/MYJCaw2U02Qoo4InioL43+lEsVh1bE
         iRZedu25jywjHyvk27MpzDI+vmcXQEZYoKTJ4QGgT165lhhaLA5a73Xeks1Htg/p7wbp
         albg==
X-Gm-Message-State: AOAM532GNFVnQMPjeZRWoMecbN2nRNnl37kl+2wG1N3dveMJkutigTQj
        8ArANU26fK99hFSjCqW5jO8=
X-Google-Smtp-Source: ABdhPJxdxYQv09gLE6bL1f6tJ4kkCDkZHVYKSjlX2OtXPXKu4B0J4fhweOPjW3cjfRKTCf1WRXnZuQ==
X-Received: by 2002:a05:6512:1324:: with SMTP id x36mr2860908lfu.495.1640089442285;
        Tue, 21 Dec 2021 04:24:02 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id x15sm1336480lfd.23.2021.12.21.04.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 04:24:02 -0800 (PST)
Message-ID: <0527135c-35f5-bc63-edb3-81cb03eb03f6@gmail.com>
Date:   Tue, 21 Dec 2021 13:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH 2/2] nvmem: expose NVMEM cells in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211220064730.28806-1-zajec5@gmail.com>
 <20211220064730.28806-2-zajec5@gmail.com> <YcA4ArALDTjUedrb@kroah.com>
 <c49f2d6d-7974-5bc7-9bc1-ac265a23c2c0@gmail.com> <YcF1Kizcvgqa9ZT4@kroah.com>
 <d68ba301-7877-a8d8-8700-c601a4996818@gmail.com> <YcF4E82M89huIbSD@kroah.com>
 <3cb1d0a4-6e20-f751-6d66-c1487ef31f30@gmail.com> <YcF+g0ra5tttXOQF@kroah.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YcF+g0ra5tttXOQF@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2021 08:13, Greg Kroah-Hartman wrote:
> On Tue, Dec 21, 2021 at 07:53:32AM +0100, Rafał Miłecki wrote:
>> On 21.12.2021 07:45, Greg Kroah-Hartman wrote:
>>> On Tue, Dec 21, 2021 at 07:39:24AM +0100, Rafał Miłecki wrote:
>>>> On 21.12.2021 07:33, Greg Kroah-Hartman wrote:
>>>>> On Mon, Dec 20, 2021 at 09:39:43PM +0100, Rafał Miłecki wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> On 20.12.2021 09:00, Greg Kroah-Hartman wrote:
>>>>>>> On Mon, Dec 20, 2021 at 07:47:30AM +0100, Rafał Miłecki wrote:
>>>>>>>>      static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
>>>>>>>>      {
>>>>>>>> +	struct device *dev = &cell->nvmem->dev;
>>>>>>>> +	int err;
>>>>>>>> +
>>>>>>>>      	mutex_lock(&nvmem_mutex);
>>>>>>>>      	list_add_tail(&cell->node, &cell->nvmem->cells);
>>>>>>>>      	mutex_unlock(&nvmem_mutex);
>>>>>>>> +
>>>>>>>> +	sysfs_attr_init(&cell->battr.attr);
>>>>>>>> +	cell->battr.attr.name = cell->name;
>>>>>>>> +	cell->battr.attr.mode = 0400;
>>>>>>>> +	cell->battr.read = nvmem_cell_attr_read;
>>>>>>>> +	err = sysfs_add_bin_file_to_group(&dev->kobj, &cell->battr,
>>>>>>>> +					  nvmem_cells_group.name);
>>>>>>>
>>>>>>> Why not just use the is_bin_visible attribute instead to determine if
>>>>>>> the attribute should be shown or not instead of having to add it
>>>>>>> after-the-fact which will race with userspace and loose?
>>>>>>
>>>>>> I'm sorry I really don't see how you suggest to get it done.
>>>>>>
>>>>>> I can use .is_bin_visible() callback indeed to respect nvmem->root_only.
>>>>>
>>>>> Great.
>>>>>
>>>>>> I don't understand addig-after-the-fact part. How is .is_bin_visible()
>>>>>> related to adding attributes for newly created cells?
>>>>>
>>>>> You are adding a sysfs attribute to a device that is already registered
>>>>> in the driver core, and so the creation of that attribute is never seen
>>>>> by userspace.  The attribute needs to be attached to the device _BEFORE_
>>>>> it is registered.
>>>>>
>>>>> Also, huge hint, if a driver has to call as sysfs_*() call, something is
>>>>> wrong.
>>>>>
>>>>>> Do you mean I can
>>>>>> avoid calling sysfs_add_bin_file_to_group()?
>>>>>
>>>>> Yes.
>>>>>
>>>>>> Do you recall any existing example of such solution?
>>>>>
>>>>> Loads.
>>>>>
>>>>> Just add this attribute group to your driver as a default attribute
>>>>> group and the driver core will create it for you if needed.
>>>>>
>>>>> Or if you always need it, no need to mess sith is_bin_visible() at all,
>>>>> I can't really understand what you are trying to do here at all.
>>>>
>>>> Thanks a lot! In nvmem_register() first there is a call to the
>>>> device_register() and only later cells get added. I suppose I just have
>>>> to rework nvmem_register() order so that:
>>>> 1. Cells are collected earlier. For each cell I allocate group attribute
>>>
>>> No, add all of the attributes to the device at the beginning before you
>>> register it, there's no need to allocate anything.
>>
>> If you mean static structures I can't do that, because cells almost
>> never are static. They are not known in advance. nvmem allows cells to
>> be:
>> 1. Specified in OF
>> 2. Submitted as list while registering a NVMEM device
>>
>> So every cells gets its own structure allocated dynamically. My plan is
>> to put bin_attribute in that struct and then create a group collecting
>> all those cells.
> 
> A device has a driver associated with it, and that driver has default
> groups associated with it.  Use that, I am not saying to use static
> structures, that is not how the driver model works at all.

I'm helpless on dealing with attributes.

I tried building a list of attributes dynamically but that of course
fails:

drivers/nvmem/core.c: In function ‘nvmem_register’:
drivers/nvmem/core.c:930:31: error: assignment of member ‘bin_attrs’ in read-only object
   930 |   nvmem_cells_group.bin_attrs = nvmem->cells_bin_attrs;
       |                               ^


What I'm trying to achieve is having
/sys/bus/nvmem/devices/*/cells/*
with each file being an attribute.


Please kindly point me to a single example of "struct attribute_group"
that has a variable list of attributes with each attribute having
runtime set name.

Almost all cases in kernel look like:
static const struct attribute_group foo_attr_group = {
	.attrs = foo_attrs,
};
with "foo_attrs" being a list of attributes with *predefined* names.

Every example of dynamic attributes (runtime created) I see in a kernel
(e.g. drivers/base/node.c) uses sysfs_*().
