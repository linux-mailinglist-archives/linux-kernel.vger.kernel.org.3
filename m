Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C022465E88
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355789AbhLBHRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:17:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355776AbhLBHRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638429219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyWSgO5pQeTpFTsjt0OJ9xXzG5MhnxSjfJQn6rTTc0E=;
        b=ehODejzf0EFJTLkixOKE4tFrKlpracdwR8mjFoyezTQkcAJrRYifaFCXiD56AWwh+0OMgS
        2QRMVmLHF+TpmW6WgKMzhreTH3bX4a+P0ztf0gpDlXOt7OksK0oyChtDiUBidRNK1Ou0dn
        se/DeuYM7whB6rOgdtDQ708z6dmZxHM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-ddQdU7VZOT-Q0_-Nc67vkw-1; Thu, 02 Dec 2021 02:13:38 -0500
X-MC-Unique: ddQdU7VZOT-Q0_-Nc67vkw-1
Received: by mail-wm1-f71.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so13511635wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 23:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=zyWSgO5pQeTpFTsjt0OJ9xXzG5MhnxSjfJQn6rTTc0E=;
        b=vXjrZrHoLqNSyeUEbR8cXRRWv1nXuA2ZE+BvQSvTey3QGUMBsaL+vwuLv/IX1f3we1
         kpQhOSgA+sIFYBDX/P4hjb5LPOMAvWgTBvr6uVpg9wx9h1RTw+7snhlpyryzxhLALxcZ
         sJI7E9IxC15O5ONkREuoewLOnZT5+axr9zByNd4qQUaGPGXrSK3GwgGuYNin63oP2Soe
         Stt/EQj33yP9yVY56UpIh13D+j/HG+2H3tIsGw5lalgo4+BiuvBX1PCBHeo1dcfjNDtx
         Bx+QwBG+VoMpPnaGlT3cdGlZ5v2fBpNaNHXnpaVT7Orup1sgJjVjcmEZVe2jqjjc+nWZ
         bKbA==
X-Gm-Message-State: AOAM533gmUHcHgSpZCwCLdexYtVcM+SeznqIXebs+8Z14AfjnCmZocV7
        74d1lWnecuj7NJrFuwCq9baJg5UxX53PHMvvVSvuukElf/1QOL41kHjz5j6iEon4aBXTS5vnUjv
        fq14IRjomsFv6lcthUsuZ5Us6
X-Received: by 2002:a1c:f418:: with SMTP id z24mr4230924wma.95.1638429216863;
        Wed, 01 Dec 2021 23:13:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIS21CrCdQKOT52ZzVeAC069eDpmA0bUNalVt51oA5fc9UfmE4W0WD8YgU5S7gOLPWOD1wvQ==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr4230894wma.95.1638429216619;
        Wed, 01 Dec 2021 23:13:36 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id f3sm1703065wrm.96.2021.12.01.23.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 23:13:36 -0800 (PST)
Message-ID: <319a5ce7-873b-b8b9-1fa8-f2a69b418ac4@redhat.com>
Date:   Thu, 2 Dec 2021 08:13:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <210e3c57-bdc2-09ed-3e41-8dab57e8f36c@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
In-Reply-To: <210e3c57-bdc2-09ed-3e41-8dab57e8f36c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 18.10, Harald Freudenberger wrote:
> On 01.12.21 15:11, Thomas Huth wrote:
>> The crypto devices that we can use with the vfio_ap module are sitting
>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>> itself. With this change, the vfio_ap module now gets automatically
>> loaded if a supported crypto adapter is available in the host.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Note: Marked as "RFC" since I'm not 100% sure about it ...
>>         please review carefully!
>>
>>   drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 4d2556bc7fe5..5580e40608a4 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>   	{ /* end of sibling */ },
>>   };
>>   
>> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>   
>>   /**
>>    * vfio_ap_queue_dev_probe:
> Hello Thomas, interesting.
> Did you test this ? I mean did you build a kernel and have it run on a s390 with crypto cards available ?

Yes, I've tested it. Without the patch, the vfio_ap module does not get 
loaded automatically if a crypto card is available. With the patch applied, 
the vfio_ap module correctly gets loaded automatically on my system (similar 
to the vfio_ccw module).

> My strong feeling is that this will make the AP bus code stumble as the code silently assumes there are exact
> two types of ap devices attached to the ap bus: ap cards and ap queues.

This is only about getting the module loaded automatically once such a 
device is available ... AFAIK it does not grab any of the devices 
automatically, so there shouldn't be any problems?

  Thomas

