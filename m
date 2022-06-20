Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9FC551465
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbiFTJ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240875AbiFTJ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:29:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98EF11A30;
        Mon, 20 Jun 2022 02:29:08 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K8210g031692;
        Mon, 20 Jun 2022 09:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/icXKhk9Bv2anenjWw0ZJd9+T6gPl6ZneKWtgbAm2jo=;
 b=bwAbG5RHlwo3QH7wA0jfoktZQKJSukByRBJA2cjIXm/3WxX03h6y5UkSlfQcdyd5A45g
 oMORV/zkZ+B0KCMFh89LaFsbHOI0Zbx6NWVQvsf0F6DXk4YMaNjIQ/8BWJcR4gOKetlV
 7nMcAQgZdrDRz+shhkNlfhgzQUYSXEUd3QoFBWIc2X3wnqXsZfIOCcY/1wgP6C2hcf1f
 1EpsOnvCfSSUIvuPuZiHlpU6V41c3uFOJOot5W2nO2RPuEMeNWfbsuApfnG4wDveAYsg
 gSd3f8y9u09zfWq2I1ip4cZZvo8j5/uNs18+tAcoKOHiDm2IUIadIFikp3dOQgUf9D/U bg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsr27vnhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 09:29:05 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25K9Kx4h016537;
        Mon, 20 Jun 2022 09:29:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3gs6b8ss5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 09:29:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25K9Sx8T23265710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 09:28:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8661A405C;
        Mon, 20 Jun 2022 09:28:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82495A405B;
        Mon, 20 Jun 2022 09:28:59 +0000 (GMT)
Received: from [9.171.78.67] (unknown [9.171.78.67])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jun 2022 09:28:59 +0000 (GMT)
Message-ID: <8e894b5d-186d-8381-2c1f-f51361800241@linux.ibm.com>
Date:   Mon, 20 Jun 2022 11:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] s390/kvm: avoid hypfs error message
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20220607123314.10255-1-jgross@suse.com>
 <5431f626-9bd3-ed54-9889-aafbba9ca3e0@suse.com>
 <9ef06123-b44f-b009-5bf5-60ad27bbede7@linux.ibm.com>
 <YrA7lHb38Sj74+4U@osiris> <c9a84a02-ca69-fc2a-c738-a796b7197693@suse.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <c9a84a02-ca69-fc2a-c738-a796b7197693@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AtTBMZPRjZbIGOWhg0fEjYa-r8zqk6IK
X-Proofpoint-ORIG-GUID: AtTBMZPRjZbIGOWhg0fEjYa-r8zqk6IK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20.06.22 um 11:25 schrieb Juergen Gross:
> On 20.06.22 11:19, Heiko Carstens wrote:
>> On Mon, Jun 20, 2022 at 09:18:37AM +0200, Christian Borntraeger wrote:
>>> Am 20.06.22 um 08:03 schrieb Juergen Gross:
>>>> Ping?
>>>>
>>>> On 07.06.22 14:33, Juergen Gross wrote:
>>>>> When booting under KVM the following error messages are issued:
>>>>>
>>>>> hypfs.7f5705: The hardware system does not support hypfs
>>>>> hypfs.7a79f0: Initialization of hypfs failed with rc=-61
>>>>>
>>>>> While being documented, they can easily be avoided by bailing out of
>>>>> hypfs_init() early in case of running as a KVM guest.
>>>>>
>>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>>> ---
>>>>>    arch/s390/hypfs/inode.c | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
>>>>> index 5c97f48cea91..bdf078f3c641 100644
>>>>> --- a/arch/s390/hypfs/inode.c
>>>>> +++ b/arch/s390/hypfs/inode.c
>>>>> @@ -464,6 +464,9 @@ static int __init hypfs_init(void)
>>>>>    {
>>>>>        int rc;
>>>>> +    if (MACHINE_IS_KVM)
>>>>> +        return -ENODATA;
>>>>> +
>>>>>        hypfs_dbfs_init();
>>>>>        if (hypfs_diag_init()) {
>>>
>>> In case KVM implements hypfs this check would then be wrong.
>>> Question to people on CC/TO.
>>> Would it be an option to still check with KVM but avoid the error message.
>>> So basically changing hypfs_diag_init and fail_dbfs_exit to check
>>> for KVM on error?
>>> Or is this worse?
>>
>> I'd say just move the pr_err("Initialization of hypfs failed with...")
>> one label above to fail_hypfs_diag_exit. Then we still get the message
>> that the hardware system doesn't support hypfs, which seems to be
>> wanted, and the error message only appears for an error.
>>
>> Even though I personally dislike printing everything to the console
>> this seems to be what is/was preferred. So let's keep that.
> 
> Works for me.
> 
> Would you be fine with additionally:
> 
> @@ __init int hypfs_diag_init(void)
>           int rc;
> 
>           if (diag204_probe()) {
> -                pr_err("The hardware system does not support hypfs\n");
> +                pr_info("The hardware system does not support hypfs\n");
>                   return -ENODATA;
>           }
> 
> As this not really an error.

Yes, makes sense.
