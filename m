Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18EE50E283
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiDYOCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiDYOCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:02:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4767CDF5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:59:25 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23PDxN8M125376;
        Mon, 25 Apr 2022 08:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650895163;
        bh=ZuX+Dv5ok96kB5bh1Icur2gHnboOIZXk4RragEK6O78=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=f+DDjO3HJSDefgOAGWh+PGo/lBMYc2Qj8LNAWEO7kq48gnlMlN2B7WE1f6ZuMA+S3
         Pjnd1yhgh4iMilXkFHgglkp3JHhkSxof6rsFzkBneJ4/gM70yfl/ujZOxTueUYb6pM
         bQ94/2WSb1flWSgC1ofYRy7YIP49nZv7XVtBk+nk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23PDxNh6027153
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Apr 2022 08:59:23 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Apr 2022 08:59:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Apr 2022 08:59:23 -0500
Received: from [10.250.34.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23PDxMUa117768;
        Mon, 25 Apr 2022 08:59:23 -0500
Message-ID: <06faec69-15e8-2aca-24cd-a4d7034c5920@ti.com>
Date:   Mon, 25 Apr 2022 08:59:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and
 TEE_IOCTL_SHM_DMA_BUF
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
References: <20220422180139.13447-1-afd@ti.com>
 <20220422180139.13447-2-afd@ti.com>
 <CAFA6WYPK2NS08pdzqS5Ze5pdJic2iQ7hC6h0SK+JT=EbPkg+Sg@mail.gmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <CAFA6WYPK2NS08pdzqS5Ze5pdJic2iQ7hC6h0SK+JT=EbPkg+Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 1:46 AM, Sumit Garg wrote:
> On Fri, 22 Apr 2022 at 23:31, Andrew Davis <afd@ti.com> wrote:
>>
>> These look to be leftover from an early edition of this driver. Userspace
>> does not need this information. Checking all users of this that I have
>> access to I have verified no one is using them.
>>
>> They leak internal use flags out to userspace. Even more they are not
>> correct anymore after a45ea4efa358. Lets drop these flags before
>> someone does try to use them for something and they become ABI.
>>
> 
> Sounds reasonable to me.
> 
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/tee/tee_core.c   | 1 -
>>   include/uapi/linux/tee.h | 4 ----
>>   2 files changed, 5 deletions(-)
>>
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index 8aa1a4836b92f..650dd87a38e77 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -339,7 +339,6 @@ tee_ioctl_shm_register(struct tee_context *ctx,
>>                  return PTR_ERR(shm);
>>
>>          data.id = shm->id;
>> -       data.flags = shm->flags;
>>          data.length = shm->size;
>>
> 
> This change is required for tee_ioctl_shm_alloc() as well.
> 


Indeed it is, adding for v2.

Thanks,
Andrew


> -Sumit
> 
>>          if (copy_to_user(udata, &data, sizeof(data)))
>> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
>> index 25a6c534beb1b..23e57164693c4 100644
>> --- a/include/uapi/linux/tee.h
>> +++ b/include/uapi/linux/tee.h
>> @@ -42,10 +42,6 @@
>>   #define TEE_IOC_MAGIC  0xa4
>>   #define TEE_IOC_BASE   0
>>
>> -/* Flags relating to shared memory */
>> -#define TEE_IOCTL_SHM_MAPPED   0x1     /* memory mapped in normal world */
>> -#define TEE_IOCTL_SHM_DMA_BUF  0x2     /* dma-buf handle on shared memory */
>> -
>>   #define TEE_MAX_ARG_SIZE       1024
>>
>>   #define TEE_GEN_CAP_GP         (1 << 0)/* GlobalPlatform compliant TEE */
>> --
>> 2.17.1
>>
