Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2740847585F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbhLOMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:06:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236954AbhLOMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639569958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nFpQ6cduCeSMbccEFc0gIMqs2KB4TheEAXhDJB6cHg=;
        b=dSBu4Mi/k2obBGbT591gKcfEs/gtyo/8/uKjb8QMrLuPNAomyFE5oGTkjgWuxU+z1mwvqs
        8yyCjvNhz0URKwAv+AUSId2jrvVvJTXmIghwB1D3Ab+N5T2Mwj65WyIKfOqBmIDoFDG7Ep
        bdgwvWB7WgUrJXYF3QmOh2FaURJKQfs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-IKJ1UGfZNWGVUFm_w_WOeA-1; Wed, 15 Dec 2021 07:05:56 -0500
X-MC-Unique: IKJ1UGfZNWGVUFm_w_WOeA-1
Received: by mail-wr1-f70.google.com with SMTP id h7-20020adfaa87000000b001885269a937so5884993wrc.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=5nFpQ6cduCeSMbccEFc0gIMqs2KB4TheEAXhDJB6cHg=;
        b=JPhZOmRENgaEsYGI7yI1EfMs4q9PSyREEyRpwG2ITs9+1PGe1CNL8DIXPqiWlFRFhZ
         vNi/C70CyR6aZ4ynva8Bk+7IpIRm+rxkG20To4yE57vAwv9C2ARO4lT78J3PM9PVT1h1
         kGJlZ8zkoObvzN0wJ0LFH08IZXoliMH9inPLocc+1cA4wjh8yvEimzAtKniVWalyZDLc
         RgIcDOU7GxC1t61mEemLyZzJnXtZK0L7cIeCeNB8aMJDqylxwashFnY+FcXTwKF29CVg
         cbDuF9rDZwEShOhj13RFhf00YOMPqTm29nNeavKsakeflWDYL34vbWGifDW14H/y0ajY
         gLKw==
X-Gm-Message-State: AOAM530nXI7r3qp5X8TivO6oSGVwY7tTl3YuMRyGRwK7YN0f91KRqR/L
        te9aDcxo/1/+zrYQak4uxoNN/S85WBdVt3lKON/BelkeAYeqNFkI/XhnVb3P8rJh6/96Ygl77D7
        bWVWpGLpwPQH3Ns4fT3EybCih
X-Received: by 2002:a5d:5912:: with SMTP id v18mr4046379wrd.144.1639569955593;
        Wed, 15 Dec 2021 04:05:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxnVBjLRjVoyS6pA2ah+8a/ieDtsvKK9/J9/tJ54F2erl5Katslc3OMv9ZF9ctr1FZVwPxVg==
X-Received: by 2002:a5d:5912:: with SMTP id v18mr4046365wrd.144.1639569955366;
        Wed, 15 Dec 2021 04:05:55 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id m20sm5369211wmq.11.2021.12.15.04.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 04:05:54 -0800 (PST)
Message-ID: <6aaf6c60-a258-29e3-fcec-82c77d3945a4@redhat.com>
Date:   Wed, 15 Dec 2021 13:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
 <87k0g8scx1.fsf@redhat.com>
 <1eb9ca5c-b1bb-b768-64ee-e4a1b31bb171@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
In-Reply-To: <1eb9ca5c-b1bb-b768-64ee-e4a1b31bb171@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 22.55, Tony Krowiak wrote:
> 
> 
> On 12/13/21 11:11, Cornelia Huck wrote:
>> On Mon, Dec 13 2021, Harald Freudenberger <freude@linux.ibm.com> wrote:
>>
>>> On 01.12.21 15:11, Thomas Huth wrote:
>>>> The crypto devices that we can use with the vfio_ap module are sitting
>>>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>>>> itself. With this change, the vfio_ap module now gets automatically
>>>> loaded if a supported crypto adapter is available in the host.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   Note: Marked as "RFC" since I'm not 100% sure about it ...
>>>>         please review carefully!
>>>>
>>>>   drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>>>> b/drivers/s390/crypto/vfio_ap_drv.c
>>>> index 4d2556bc7fe5..5580e40608a4 100644
>>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>>>       { /* end of sibling */ },
>>>>   };
>>>> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>>>   /**
>>>>    * vfio_ap_queue_dev_probe:
>>> I had a chance to check this now.
>>> First I have to apologize about the dispute with vfio devices appearing 
>>> on the ap bus.
>>> That's not the case with this patch. As Connie states the 
>>> MODULE_DEVICE_TABLE() does not
>>> change the parent of a device and vfio_ap_drv is a driver for ap devices 
>>> and thus
>>> belongs to the ap bus anyway.
>>> So what's left is that with this change the vfio_ap kernel module is 
>>> automatically loaded
>>> when an ap device type 10-13 is recognized by the ap bus. So the 
>>> intention of the patch
>>> is fulfilled.
>>> Yet another kernel module which may occupy memory but will never get used 
>>> by most customers.
>>> This may not be a problem but I had a glance at the list of kernel 
>>> modules loaded on my
>>> LPAR with and without the patch and the difference is:
>>> ...
>>> kvm                   512000  1 vfio_ap
>>> vfio_ap                28672  0
>>> ...
>>> So the vfio_ap module has a dependency to the biggest kernel module ever 
>>> - kvm.
>>> Do I need to say something more?
>>>
>>> If this dependency is removed then I would not hesitate to accept this 
>>> patch. However
>>> this is up to Tony as he is the maintainer of the vfio ap device driver.
>> I don't think you can drop the kvm reference, as the code in vfio-ap
>> obviously depends on it...
>>
>> One possibility is simply blocking autoload of the module in userspace by
>> default, and only allow it to be loaded automatically when e.g. qemu-kvm
>> is installed on the system. This is obviously something that needs to be
>> decided by the distros.
>>
>> (kvm might actually be autoloaded already, so autoloading vfio-ap would
>> not really make it worse.)
> 
> Of the vfio_ccw module is automatically loaded, then the kvm
> module will also get loaded. I startup up a RHEL8.3 system and
> sure enough, the vfio_ccw module is loaded along with the
> kvm, vfio and mdev modules. If this is true for all distros, then
> it wouldn't make much difference if the vfio_ap module is
> autoloaded too.

I think I don't mind too much if we auto-load vfio-ap or not - but I think 
we should make it consistent with vfio-ccw. So either auto-load both modules 
(if the corresponding devices are available), or remove the 
MODULE_DEVICE_TABLE() entries from both modules?

  Thomas

