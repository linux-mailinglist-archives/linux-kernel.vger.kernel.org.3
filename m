Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9280474D38
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhLNV2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:28:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230337AbhLNV2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:28:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEJsiN7005031;
        Tue, 14 Dec 2021 21:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IPOYqQ+fpOXacem3DF88eCw7LIuyQ+Dt/C2Am+Xsiy4=;
 b=O9wUmDJsSDO2bVNcvztzoUxI8NGOEs6n5VuKuxl93JQtiNRdstfO3/GwQQqdDDYIiQEL
 vNEzu71MTggiFIofUWzYBy+XJsu9lPGQB9eq2OCEf0KWBh7kjgDpHfmH/zoOPmH8stDV
 zrugu1BeDagLBMj0mScvK3T9lcY+F8qDruPfT835C6x3VyPlglhZWu3+8jtDHJWnuL/p
 V3jXwUG7lM5I4jerVJ/cXT7Pv4ujyMLyss6R1bGe1AmN/pwIOqJ2x/RudI+brzRC+KRi
 zkjVkGEeULSH5YSd5We4yexbLsg4tGHsk1EI23jW/o6Bqdg5aM8rnUx9uXdx3b5UpjHM MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r9c4mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 21:28:15 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BELSFZf017931;
        Tue, 14 Dec 2021 21:28:15 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r9c4m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 21:28:15 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BEL7ohx030357;
        Tue, 14 Dec 2021 21:28:14 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3cvkmbg27t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 21:28:14 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BELSDEm23331148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 21:28:13 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CAA0AE067;
        Tue, 14 Dec 2021 21:28:13 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B643FAE066;
        Tue, 14 Dec 2021 21:28:12 +0000 (GMT)
Received: from [9.160.9.199] (unknown [9.160.9.199])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 Dec 2021 21:28:12 +0000 (GMT)
Message-ID: <e0558344-54a0-eebb-44e0-af61575a4769@linux.ibm.com>
Date:   Tue, 14 Dec 2021 16:28:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Content-Language: en-US
To:     Harald Freudenberger <freude@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KQCJIa7c8Duu1O_kSRTDDb-fpatth2GG
X-Proofpoint-ORIG-GUID: SA_kjiIyjhiDcSQaeNZzAshPcY8pr_O_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/21 10:44, Harald Freudenberger wrote:
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
> I had a chance to check this now.
> First I have to apologize about the dispute with vfio devices appearing on the ap bus.
> That's not the case with this patch. As Connie states the MODULE_DEVICE_TABLE() does not
> change the parent of a device and vfio_ap_drv is a driver for ap devices and thus
> belongs to the ap bus anyway.
> So what's left is that with this change the vfio_ap kernel module is automatically loaded
> when an ap device type 10-13 is recognized by the ap bus. So the intention of the patch
> is fulfilled.
> Yet another kernel module which may occupy memory but will never get used by most customers.
> This may not be a problem but I had a glance at the list of kernel modules loaded on my
> LPAR with and without the patch and the difference is:
> ...
> kvm                   512000  1 vfio_ap
> vfio_ap                28672  0
> ...
> So the vfio_ap module has a dependency to the biggest kernel module ever - kvm.
> Do I need to say something more?
>
> If this dependency is removed then I would not hesitate to accept this patch. However
> this is up to Tony as he is the maintainer of the vfio ap device driver.

The vfio_ap device driver has a dependency on kvm, it can not be removed.
If the user base for vfio_ap is minimal, then I see no reason why the 
vfio_ap
module should be automatically loaded when an AP device type 10-13 is
recognized by the AP bus. The module is needed only to pass through AP
queue devices to a KVM guest.

>
>

