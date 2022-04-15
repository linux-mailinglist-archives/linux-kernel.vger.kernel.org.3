Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63B5028F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352736AbiDOL4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiDOL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:56:14 -0400
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04076A27C0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1650023620;
        bh=Zq+vaNpRqP4VrswkHOyz0dXQz+AjsR8Pi4S6W+jeGU4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JhtXiWFzlfmlKaSTktBV6LVRlSK2ylGGJYGg1esMtGaXVZUf1MSjoDn27JsvbGS8Q
         UOx/KYP7Fwr52Ad+uyPbGhDY3Lu2vyJrMAiPTlYXbfF066GNP7zUfREs8UZu4v1siP
         kqdW+sWWouhn3RkzEctU+pDH+2P5YARjkuSFqbk4=
Received: from [10.188.0.6] ([94.177.118.94])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id D072B49F; Fri, 15 Apr 2022 19:52:07 +0800
X-QQ-mid: xmsmtpt1650023527tskd35efu
Message-ID: <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
X-QQ-XMAILINFO: NK7mH5+t7Gn7sK/Re4oRVkbcjXaWsb3WTzOpPSwFIW2fCDXKWFWmxIykuZkbJN
         pfhPLuaY3+ftdc6yrCYq5IxXroSK0nUQRO/Qjsp7fX7DXm63vSnerKPZjOxL1rkhvJvH59MwsYcp
         68N8RvaN28KQiq2UM2gF6SvuySxyj2eQo3duSZL0YJ8fYr78XL4TaJ6c4jzHqwiUPLrK68E1T/uS
         bthagbPrrOl1hPkjmC0MLfdPC48dtJFTFDMpxlgte/vJBUsSZ3LcnrV9OoRDR8SGlmwgoYdW4lQO
         B/OlqfzRMwu49FzDJutg1CyMIeXSMHtovjTBauzEHgIhTSzL32qub3OQIunxMBxHYVUtqxmdpC6X
         vpzXA1bSZaib7LTnSNoH+MpiUwDa2yM0R89vjuWEbqjYZNNDFMm3NEuZS3+DsBTKsGkw65lqw636
         8cpZ0ZhnJcN+J4DUF8Mag6/Ras94++CS7DaaIgytzxnFKtkbV7rkhWkbW3WwaA7v4Ly+eRgPiIgX
         LtOtY/fQz8jWq1ZGEQ+Lz/jm6Ra/6PFk6wA3doDoS4mZafQ8axR6e6PYWbOEdnJz7Sf8U5rPtsEO
         nB8ztR1kEC9ITMSK5yPq6rlwfuDO+NDaRLG+0NTat9rrjvbimOPvGlnq9xLyWxoC5g/v55LlnZHR
         UvJPcEeZbG5zC8JlDU+YKrXuwhnQKI0mhDa1o7SgYrdNmxfguI1HClAi0W+QTcCM9/wgvgiz+Ufy
         0hNJwF1ORuz5rB0EX3B/tszJztAErxefEiwOKE5bYh/YDCh5lGCT4WFnaMPvVhV8GL85cf6F/UI/
         mA2n1h+u3pTzTrInMLKzHzZPiz1cczZHniCczEq1Iztw676Fq/lzy2n7nCOUTXc84y8ogXrkEzWw
         YrsG3AXUcn8mYLz7nuP50YLQ2p5evUNXzmUEC4U1fV8nwmJKO/oc7prIzkZjfQoKT3fuKbnnwncO
         K1GWjczGIquPfYykmiHxYPy8annhuJZzjd3kdAYtp8m16LhwHHGXV01iTsCrH+
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <722d4991-4c0c-23ba-a533-f496c13458c7@foxmail.com>
Date:   Fri, 15 Apr 2022 19:52:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/15 下午6:50, Fenghua Yu wrote:
> Hi, Zhangfei,
>
> On Fri, Apr 15, 2022 at 06:14:09PM +0800, zhangfei.gao@foxmail.com wrote:
>>
>> On 2022/4/15 下午5:51, Fenghua Yu wrote:
>>> On Thu, Apr 14, 2022 at 06:08:09PM +0800, zhangfei.gao@foxmail.com wrote:
>>>> On 2022/4/12 下午11:35, zhangfei.gao@foxmail.com wrote:
>>>>> Hi, Fenghua
>>>>>
>>>>> On 2022/4/12 下午9:41, Fenghua Yu wrote:
>>>   From a6444e1e5bd8076f5e5c5e950d3192de327f0c9c Mon Sep 17 00:00:00 2001
>>> From: Fenghua Yu <fenghua.yu@intel.com>
>>> Date: Fri, 15 Apr 2022 00:51:33 -0700
>>> Subject: [RFC PATCH] iommu/sva: Fix PASID use-after-free issue
>>>
>>> A PASID might be still used even though it is freed on mm exit.
>>>
>>> process A:
>>> 	sva_bind();
>>> 	ioasid_alloc() = N; // Get PASID N for the mm
>>> 	fork(): // spawn process B
>>> 	exit();
>>> 	ioasid_free(N);
>>>
>>> process B:
>>> 	device uses PASID N -> failure
>>> 	sva_unbind();
>>>
>>> Dave Hansen suggests to take a refcount on the mm whenever binding the
>>> PASID to a device and drop the refcount on unbinding. The mm won't be
>>> dropped if the PASID is still bound to it.
>>>
>>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")
>>>
>>> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
>>> Suggested-by: Dave Hansen" <dave.hansen@linux.intel.com>
>>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
>>>    drivers/iommu/intel/svm.c                       | 4 ++++
>>>    2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> index 22ddd05bbdcd..3fcb842a0df0 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> @@ -7,6 +7,7 @@
>>>    #include <linux/mmu_context.h>
>>>    #include <linux/mmu_notifier.h>
>>>    #include <linux/slab.h>
>>> +#include <linux/sched/mm.h>
>>>    #include "arm-smmu-v3.h"
>>>    #include "../../iommu-sva-lib.h"
>>> @@ -363,6 +364,9 @@ arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
>>>    	mutex_lock(&sva_lock);
>>>    	handle = __arm_smmu_sva_bind(dev, mm);
>>> +	/* Take an mm refcount on a successful bind. */
>>> +	if (!IS_ERR(handle))
>>> +		mmget(mm);
>>>    	mutex_unlock(&sva_lock);
>>>    	return handle;
>>>    }
>>> @@ -372,6 +376,8 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
>>>    	struct arm_smmu_bond *bond = sva_to_bond(handle);
>>>    	mutex_lock(&sva_lock);
>>> +	/* Drop an mm refcount. */
>>> +	mmput(bond->mm);
>>>    	if (refcount_dec_and_test(&bond->refs)) {
>>>    		list_del(&bond->list);
>>>    		arm_smmu_mmu_notifier_put(bond->smmu_mn);
>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>> index 23a38763c1d1..345a0d5d7922 100644
>>> --- a/drivers/iommu/intel/svm.c
>>> +++ b/drivers/iommu/intel/svm.c
>>> @@ -403,6 +403,8 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>>>    		goto free_sdev;
>>>    	list_add_rcu(&sdev->list, &svm->devs);
>>> +	/* Take an mm refcount on binding mm. */
>>> +	mmget(mm);
>>>    success:
>>>    	return &sdev->sva;
>>> @@ -465,6 +467,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
>>>    				kfree(svm);
>>>    			}
>>>    		}
>>> +		/* Drop an mm reference on unbinding mm. */
>>> +		mmput(mm);
>>>    	}
>>>    out:
>>>    	return ret;
>> This patch can not be applied on 5.18-rc2 for intel part.
> What error do you see? Could you please send to me errors?
>
> I download this patch from:
> https://lore.kernel.org/lkml/YllADL6uMoLllzQo@fyu1.sc.intel.com/raw
> git am to either v5.18-rc2 or the latest upstream without any issue.
It is my copy paste issue.

I have tested, nginx woks well.

Other than the following issue,
Each time /sbin/nginx will alloc ioasid but not free.
which I think it maybe nginx issue or the mis-usage, will ask there.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

>
>> It should work for arm.
>>
>> In fact I have a similar patch at hand but pending since I found an issue.
>>
>> I start & stop nginx via this cmd.
>> //start
>> sudo sbin/nginx                    // this alloc an ioasid=1
>> //stop
>> sudo sbin/nginx -s quit    // this does not free ioasid=1, but still alloc
>> ioasid=2.
>> So ioasid will keep allocated but not freed if continue start/stop nginx,
>> though not impact the nginx function.
>>
>> stop nginx with -s quit still calls
>> src/core/nginx.c
>> main -> ngx_ssl_init -> openssl engine:    bind_fn -> ... -> alloc asid
>> But openssl engine: ENGINE_free is not called
>>
>> Still in checking nginx code.
>>
>> Or do you test with nginx?
> On my X86 machine, nginx doesn't trigger the kernel sva binding function
> to allocate ioasid. I tried pre- nstalled nginx/openssl and also tried my built
> a few versions of nginx/openssl. nginx does call OPENSSL_init_ssl() but
> doesn't go to the binding function. Don't know if it's my configuration issue.
> Maybe you can give me some advice?
I am using openssl engine, which use crypto driver and using sva via uacce.
nginx -> openssl -> openssl engine -> sva related.

>
> I test the patch with a few internal test tools and observe mmget()/mmput()
> works fine in various cases.
OK, thanks


