Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3029474D64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhLNVza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:55:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234861AbhLNVz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:55:29 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BELQKLv028698;
        Tue, 14 Dec 2021 21:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sLX5EPFpUPfv8Bv6Jkd8PlSMChQNuiUe2vFUbwV0wAE=;
 b=o/RdEXCVKWezt7H1yqMFznloa+ojorGLK4cbtQkh/NmFHaxYH3S4vKAYZ1h6wEUXICOZ
 hQePdlR/Sg2Sct2wDKtZUEk7VSGAlOCpplEqtas8EyvYYEkOZftBWsDu+oyYVpGnm4b/
 MTRMLfNBCDUIfoiBwBBcuge13tIc44Ltm3jokAZ2ucqtUHCKuGD/+rRYoi/XLM1zjGfE
 2IiE2TFlXXdEThVgX5jwA4EhxeGX9022W1OrazdRoMVIzBGOdMbf/tI3HXyaSto62Jm3
 Ld3yK5xYH9SxPGkP1hDLl6EEhEdiOYkEowhEGISzWd+IosnQ01E+sQdBQWyqinlH71/J Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cx9r8vtv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 21:55:27 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BELmt7w018275;
        Tue, 14 Dec 2021 21:55:26 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cx9r8vtur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 21:55:26 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BELpubK027129;
        Tue, 14 Dec 2021 21:55:26 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3cvkmbggn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 21:55:25 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BELtOA822937882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 21:55:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C605AE06B;
        Tue, 14 Dec 2021 21:55:24 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F4F9AE063;
        Tue, 14 Dec 2021 21:55:24 +0000 (GMT)
Received: from [9.160.9.199] (unknown [9.160.9.199])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 Dec 2021 21:55:23 +0000 (GMT)
Message-ID: <1eb9ca5c-b1bb-b768-64ee-e4a1b31bb171@linux.ibm.com>
Date:   Tue, 14 Dec 2021 16:55:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
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
X-Proofpoint-ORIG-GUID: XEU4KloLoFUSuMR5UjUeswdYyQjduBpE
X-Proofpoint-GUID: TUAfek7rBiJHrbFcD03o9_bmNDDwJ8Gx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140114
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

Of the vfio_ccw module is automatically loaded, then the kvm
module will also get loaded. I startup up a RHEL8.3 system and
sure enough, the vfio_ccw module is loaded along with the
kvm, vfio and mdev modules. If this is true for all distros, then
it wouldn't make much difference if the vfio_ap module is
autoloaded too.

>

