Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB27849623A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381639AbiAUPl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:41:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6242 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240481AbiAUPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:41:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LEoUww021172;
        Fri, 21 Jan 2022 15:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HT3W2z4l0rnanMYFHXqjbJFKwlcueoBNazlwuG7x6ts=;
 b=OkMsOStcwtxg4r8TSHD8OuZC+FWhckDs6ga+GVAQDNjdPJm7UnkhJ0SdalgC0O3C+jDR
 Br7nncxYPAuZilbDMVLqUhVHc+NgYAHM+eGRrBFWOSLGp5elVqxgdDEmW9RY7OXRopE6
 BZJsrjQA3Pyb6OHqMBVGsc4mBUUOJ7Nz499cGk1qR3fhDf+tUA9I9ru2rN3OK9PRCptK
 KPiSjbQpXqyVC3nKy59dcfnLyFT2xErxg9IUxtv/Q0tMRjm9MUAsMXpFvjsxvzy6zj0x
 a2p7T+ZbCINClp3ZRq9QnrXp4XUV0q3t2CQ7Jl5EmsKKiedcuva4V1Tx+Gep937SejGo 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqwgf35ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 15:40:38 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20LEoW7q021406;
        Fri, 21 Jan 2022 15:40:37 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqwgf35j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 15:40:37 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20LFcLg7014797;
        Fri, 21 Jan 2022 15:40:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3dqjr55pcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 15:40:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20LFeV9c40960380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 15:40:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFC1511C04C;
        Fri, 21 Jan 2022 15:40:31 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6666411C04A;
        Fri, 21 Jan 2022 15:40:30 +0000 (GMT)
Received: from [9.171.71.185] (unknown [9.171.71.185])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Jan 2022 15:40:30 +0000 (GMT)
Message-ID: <bb51485d-1d53-3b67-f123-d9eded545454@linux.ibm.com>
Date:   Fri, 21 Jan 2022 16:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/7] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        bp@alien8.de, catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frankja@linux.ibm.com,
        frederic@kernel.org, gor@linux.ibm.com, hca@linux.ibm.com,
        james.morse@arm.com, jmattson@google.com, joro@8bytes.org,
        luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        nsaenzju@redhat.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
 <20220119192217.GD43919@C02TD0UTHF1T.local>
 <2688b779-9cb8-b6ea-f8cc-93bc8ddf72f3@redhat.com>
 <YelPnGM4kONm7ZQa@FVFF77S0Q05N>
 <ff673e4e-c395-701f-f891-36ffa260c3bd@linux.ibm.com>
 <85d3899e-7da5-abad-743b-e5d6dde21800@linux.ibm.com>
 <c90abd39-375a-15cc-847a-d1d28115ca97@linux.ibm.com>
 <YerDaItJQHvMMHIU@FVFF77S0Q05N>
 <b7912854-a7b1-caf5-aa23-e718318b0d7a@linux.ibm.com>
 <YerRbhqvJ5nEcQYT@FVFF77S0Q05N>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <YerRbhqvJ5nEcQYT@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hi8UDk1bu5Y-6btlmc7TzetHeqLDqWQq
X-Proofpoint-ORIG-GUID: P56h-WkEZVUlBNcS54gHZTLZUaGBis7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_08,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=825 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 21.01.22 um 16:29 schrieb Mark Rutland:
> On Fri, Jan 21, 2022 at 03:42:48PM +0100, Christian Borntraeger wrote:
>> Am 21.01.22 um 15:30 schrieb Mark Rutland:
>>> On Fri, Jan 21, 2022 at 03:17:01PM +0100, Christian Borntraeger wrote:
>>>> Am 21.01.22 um 10:53 schrieb Christian Borntraeger:
>>>>> Am 20.01.22 um 16:14 schrieb Christian Borntraeger:
>>>>>> Am 20.01.22 um 13:03 schrieb Mark Rutland:
>>>>>>> On Thu, Jan 20, 2022 at 12:28:09PM +0100, Paolo Bonzini wrote:
>>>>>>>> On 1/19/22 20:22, Mark Rutland wrote:
>>>>>>>>> I wonder, is the s390 guest entry/exit*preemptible*  ?
>>>>>>>>>
>>>>>>>>> If a timer IRQ can preempt in the middle of the EQS, we wouldn't balance
>>>>>>>>> things before a ctx-switch to the idle thread, which would then be able
>>>>>>>>> to hit this.
>>>>>>>>>
>>>>>>>>> I'll need to go audit the other architectures for similar.
>>>>>>>>
>>>>>>>> They don't enable interrupts in the entry/exit path so they should be okay.
>>>>>>>
>>>>>>> True.
>>>>>>>
>>>>>>> So it sounds like for s390 adding an explicit preempt_{disable,enable}() is the
>>>>>>> right thing to do. I'll add that and explanatory commentary.
>>>>>>
>>>>>> That would not be trivial I guess. We do allow (and need) page faults on sie for guest
>>>>>> demand paging and
>>>>>>
>>>>>> this piece of arch/s390/mm/fault.c
>>>>>>
>>>>>>           case GMAP_FAULT:
>>>>>>                    if (faulthandler_disabled() || !mm)
>>>>>>                            goto out;
>>>>>>                    break;
>>>>>>            }
>>>>>>
>>>>>> would no longer work since faulthandler_disabled checks for the preempt count.
>>>>>>
>>>>>
>>>>>
>>>>> Something like this
>>>>>
>>>>>
>>>>> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
>>>>> index d30f5986fa85..1c7d45346e12 100644
>>>>> --- a/arch/s390/mm/fault.c
>>>>> +++ b/arch/s390/mm/fault.c
>>>>> @@ -385,10 +385,18 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>>>>>                            return 0;
>>>>>                    goto out;
>>>>>            case USER_FAULT:
>>>>> -       case GMAP_FAULT:
>>>>>                    if (faulthandler_disabled() || !mm)
>>>>>                            goto out;
>>>>>                    break;
>>>>> +               /*
>>>>> +                * We know that we interrupted SIE and we are not in a IRQ.
>>>>> +                * preemption might be disabled thus checking for in_atomic
>>>>> +                * would result in failures
>>>>> +                */
>>>>> +       case GMAP_FAULT:
>>>>> +               if (pagefault_disabled() || !mm)
>>>>> +                       goto out;
>>>>> +               break;
>>>>>            }
>>>>>
>>>>>            perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>>>>>
>>>>> seems to work with preemption disabled around sie. Not sure yet if this is correct.
>>>>
>>>>
>>>> No it does not work. scheduling while preemption is disabled.
>>>
>>> Hmm... which exceptions do we expect to take from a guest?
>>>
>>> I wonder if we can handle those more like other architectures by getting those
>>> to immediately return from the sie64a() call with some status code that we can
>>> handle outside of the guest_state_{enter,exit}_irqoff() critical section.
>>
>> We take all kind of page faults (invalid->valid, ro->rw) on the sie instruction and
>> run that in the context of the pgm_check handler just like for userspace.
> 
> Do we only expect to tak faults from a guest (which IIUC at the GMAP_FAULT
> cases in the bit above), or are there other esceptions we expect to take from
> the middle of a SIE?
> 
>> the pgm_check handler does a sie_exit (similar to the interrupt handlers) by
>> setting the return IA.
> 
> Sure, but that sie_exit happens *after* the handler runs, where as I'm asking
> whether we can structure this like all the other architectures and turn all
> exceptions into returns from sie64a() that we can handle after having called
> guest_state_exit_irqoff().
> 
>>> On arm64 in VHE mode, we swap our exception vectors when entering/exiting the
>>> guest to allow us to do that; I wonder if we could do similar here?
> 
> Does this idea sound at all plausible?

Maybe. We already have something like that for async_pf (see kvm_arch_setup_async_pf)
where we handle the pagefault later on after first kicking off the resolution for major
page faults (via FAULT_FLAG_RETRY_NOWAIT) in the low level handler.
Let me think about it.
