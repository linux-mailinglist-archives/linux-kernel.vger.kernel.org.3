Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B49C49E4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbiA0OmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:42:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231443AbiA0OmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:42:21 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20REgG0F032474;
        Thu, 27 Jan 2022 14:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=P8HPDF2B+rz03P5vqpmgInihEB3XcCedq/lzSTTJ+Kg=;
 b=VowFYLIQW3e0Y6SsD7SlMg4k/zrrT4EXpehrj6JZxyaiVaDejqvMwzv0jIOXH2n9V++7
 ztauGl/XNo1dKxQO+LL5csvKRHMQ3v31rLzF+GxLMaiOnT7zfDtWze+BxA1wPhrWiNTg
 ImA/RrHn97S3XUJ2zTanVJQYG6pkZbdH3yksHKVr2qfCwsrdmW6yK21BXat0Ga8GjWUG
 HHnbZ8G50JAahQUmWAOr2fMZv0jIg1GpgWm3GPC1FSvD6CBfC8RmeMqdYgQFJgYCGSyq
 C/nMcTD5diijaYv+IEsUw4hnEG1Uu5rJTpcqZ9nI/JjO0qPss4bO7gAWBf5uXAGMexfZ 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3duumca5vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:42:19 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20REgJfX000300;
        Thu, 27 Jan 2022 14:42:19 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3duumca5md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:42:18 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20REWW6u015830;
        Thu, 27 Jan 2022 14:41:53 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 3dr9jbm82v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:41:53 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20REfpd535324286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 14:41:51 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2DF52805A;
        Thu, 27 Jan 2022 14:41:51 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CC1E28059;
        Thu, 27 Jan 2022 14:41:50 +0000 (GMT)
Received: from [9.65.230.214] (unknown [9.65.230.214])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 14:41:50 +0000 (GMT)
Message-ID: <da1b73df-f4c0-0013-0a34-229fd6057285@linux.ibm.com>
Date:   Thu, 27 Jan 2022 09:41:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Content-Language: en-US
To:     Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <210e3c57-bdc2-09ed-3e41-8dab57e8f36c@linux.ibm.com>
 <319a5ce7-873b-b8b9-1fa8-f2a69b418ac4@redhat.com>
 <15a39981-37ca-ed2d-3baf-c4cb74f8c343@linux.ibm.com>
 <0f1c6b3e-7e33-6fd1-11e7-f4857ec55105@redhat.com> <87a6hbtbqn.fsf@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <87a6hbtbqn.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lnjfUBdyydEkC-8FmM8Vfxv1SOGiOZ9e
X-Proofpoint-ORIG-GUID: vBV8AmUdl1UEQs6tZy2ADC4xZ1RP23p1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/21 09:25, Cornelia Huck wrote:
> On Wed, Dec 08 2021, Thomas Huth <thuth@redhat.com> wrote:
>
>> On 02/12/2021 09.33, Harald Freudenberger wrote:
>>> On 02.12.21 08:13, Thomas Huth wrote:
>>>> On 01/12/2021 18.10, Harald Freudenberger wrote:
>>>>> On 01.12.21 15:11, Thomas Huth wrote:
>>>>>> The crypto devices that we can use with the vfio_ap module are sitting
>>>>>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>>>>>> itself. With this change, the vfio_ap module now gets automatically
>>>>>> loaded if a supported crypto adapter is available in the host.
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>>     Note: Marked as "RFC" since I'm not 100% sure about it ...
>>>>>>           please review carefully!
>>>>>>
>>>>>>     drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>>>>>> index 4d2556bc7fe5..5580e40608a4 100644
>>>>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>>>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>>>>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>>>>>         { /* end of sibling */ },
>>>>>>     };
>>>>>>     -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>>>>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>>>>>       /**
>>>>>>      * vfio_ap_queue_dev_probe:
>>>>> Hello Thomas, interesting.
>>>>> Did you test this ? I mean did you build a kernel and have it run on a s390 with crypto cards available ?
>>>> Yes, I've tested it. Without the patch, the vfio_ap module does not get loaded automatically if a crypto card is available. With the patch applied, the vfio_ap module correctly gets loaded automatically on my system (similar to the vfio_ccw module).
>>>>
>>>>> My strong feeling is that this will make the AP bus code stumble as the code silently assumes there are exact
>>>>> two types of ap devices attached to the ap bus: ap cards and ap queues.
>>>> This is only about getting the module loaded automatically once such a device is available ... AFAIK it does not grab any of the devices automatically, so there shouldn't be any problems?
>>>>
>>>>    Thomas
>>>>
>>> Yes, of course for the automatic module load works this way. But you understand that now
>>> the vfio devices are childs of the ap bus and thus are siblings of the ap queue and ap card
>>> devices. As I wrote the ap bus code is not prepared to deal with a 3th type of devices
>>> dangling on the ap bus. So you should test what happens when there are real vfio ap devices
>>> in use together with 'regular' ap card and queue devices.
> Um, the queues/cards are devices on the bus, and just can have
> different drivers bound to them, right? The only device that the vfio-ap
> driver creates is the matrix device (which does not live on the ap bus),
> and this patch doesn't change that. It only correctly creates a table
> for a driver that already matched on the ap bus.
>
>> I pondered about this for a while, but I still do not quite understand. The
>> MODULE_DEVICE_TABLE macro only adds a __mod_something_device_table symbol to
>> the module, it does not change the hierarchy of the vfio devices ... so this
>> is really only about loading the module automatically. Or do you say that
>> there is already a problem if a user loads the module manually and thus it
>> should not get loaded automatically?
> Correct me if I'm wrong, but don't the devices on the ap bus need to be
> actually configured before they can attach to a non-default
> (i.e. vfio-ap) driver? IOW, it's not a simple bind operation, but extra
> configuration is required, so a loaded vfio-ap module should not affect
> any devices not configured to actually use it at all.

There are two bitmasks - apmask/aqmask - that identify the APQNs of the
queues to be bound to the default drivers. All others are bound to
the non-default driver (vfio_ap). So, you are correct, loading the vfio_ap
module will not affect any queue devices not configured to use it.

>
>>> However, I am still not sure if it is preferable to have the vfio ap module loaded automatically. The majority
>>> of customers will never use vfio ap devices - this is specific to kvm hosts only.
>> vfio-ccw also gets loaded automatically via MODULE_DEVICE_TABLE, so I think
>> vfio-ap should be handled the same way.
>> (Or should we maybe rather remove the MODULE_DEVICE_TABLE line from both
>> modules instead?)
> MODULE_DEVICE_TABLE declares "I can drive these devices", so it doesn't
> feel correct to remove them. If the modules should not be autoloaded,
> the system must be configured to not autoload them.
>
> Besides, is loading an extra module really causing that much harm? Does
> vfio-ap drag in too much other stuff?
>

