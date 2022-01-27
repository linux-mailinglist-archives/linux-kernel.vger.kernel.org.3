Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7449E4F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbiA0Oqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:46:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238054AbiA0Oqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:46:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20REfpig024671;
        Thu, 27 Jan 2022 14:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+RzLkcHlFaPXCJzhflaR4lFutXAmrNgaHURiY4V8Zg0=;
 b=D7jb2cK761AOzvsh9UFao2DCi3HT1osoFfC8gsOU9VtPGpZRxpuLUzdblqM2fTtCO0Ba
 ticZhkp06B/mh8Xs+RdCd8MPyxgFOG5LANsIPRH/1MJNSdNtv50xg2m7jZCfWOSTO71w
 l2tYejlUWzCTXNa9wIJqTVxBSY1YcEt2n9uC7QI/P108Rh8/ivU6JfvSHEhSm4kSY8In
 bMdmNqTW6GHw+SWnN/0O3PoZ2tGUZYykLnmCL6vSvMK6N2L0qUWqgRT8ZcbDFaXHjjFr
 1gswNw2JJbrOiGCHKIboeBadMCFkg9FkfVKxgm+His1nivVZH7Ts3DDzOo7tHbt3RYrH 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duun6tggv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:46:46 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20REkkeX010085;
        Thu, 27 Jan 2022 14:46:46 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duun6tggc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:46:46 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20REgUu8024436;
        Thu, 27 Jan 2022 14:46:44 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 3dr9jbvent-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:46:44 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20REkhch6095328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 14:46:43 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FF9B2805E;
        Thu, 27 Jan 2022 14:46:43 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12F0D28059;
        Thu, 27 Jan 2022 14:46:42 +0000 (GMT)
Received: from [9.65.230.214] (unknown [9.65.230.214])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 14:46:41 +0000 (GMT)
Message-ID: <cd8314ae-de2a-10ab-f604-136c76e2dac3@linux.ibm.com>
Date:   Thu, 27 Jan 2022 09:46:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Content-Language: en-US
To:     Cornelia Huck <cohuck@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
 <87k0g8scx1.fsf@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <87k0g8scx1.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gpopjw62Nw4zKlgRCwX6uyjaxBmBqZ2E
X-Proofpoint-ORIG-GUID: S8E8FkLDQQqgMCFfkTKjKHLVajLNikgG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/21 11:11, Cornelia Huck wrote:
> On Mon, Dec 13 2021, Harald Freudenberger <freude@linux.ibm.com> wrote:
>
>> On 01.12.21 15:11, Thomas Huth wrote:
>>> The crypto devices that we can use with the vfio_ap module are sitting
>>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>>> itself. With this change, the vfio_ap module now gets automatically
>>> loaded if a supported crypto adapter is available in the host.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   Note: Marked as "RFC" since I'm not 100% sure about it ...
>>>         please review carefully!
>>>
>>>   drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>>> index 4d2556bc7fe5..5580e40608a4 100644
>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>>   	{ /* end of sibling */ },
>>>   };
>>>   
>>> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>>   
>>>   /**
>>>    * vfio_ap_queue_dev_probe:
>> I had a chance to check this now.
>> First I have to apologize about the dispute with vfio devices appearing on the ap bus.
>> That's not the case with this patch. As Connie states the MODULE_DEVICE_TABLE() does not
>> change the parent of a device and vfio_ap_drv is a driver for ap devices and thus
>> belongs to the ap bus anyway.
>> So what's left is that with this change the vfio_ap kernel module is automatically loaded
>> when an ap device type 10-13 is recognized by the ap bus. So the intention of the patch
>> is fulfilled.
>> Yet another kernel module which may occupy memory but will never get used by most customers.
>> This may not be a problem but I had a glance at the list of kernel modules loaded on my
>> LPAR with and without the patch and the difference is:
>> ...
>> kvm                   512000  1 vfio_ap
>> vfio_ap                28672  0
>> ...
>> So the vfio_ap module has a dependency to the biggest kernel module ever - kvm.
>> Do I need to say something more?
>>
>> If this dependency is removed then I would not hesitate to accept this patch. However
>> this is up to Tony as he is the maintainer of the vfio ap device driver.
> I don't think you can drop the kvm reference, as the code in vfio-ap
> obviously depends on it...
>
> One possibility is simply blocking autoload of the module in userspace by
> default, and only allow it to be loaded automatically when e.g. qemu-kvm
> is installed on the system. This is obviously something that needs to be
> decided by the distros.
>
> (kvm might actually be autoloaded already, so autoloading vfio-ap would
> not really make it worse.)

The vfio_ccw module, which is automatically loaded, also requires the 
kvm module,
so autoloading vfio_ap will not make much difference.

>

