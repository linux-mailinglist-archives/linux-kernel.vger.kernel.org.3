Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C139495D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379792AbiAUJzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:55:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231417AbiAUJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:55:01 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L9GIvn034248;
        Fri, 21 Jan 2022 09:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=485MDmBnmvFszLypd8YNgqsg2hcA9x9L8Ewt8xnZNPU=;
 b=JqQbjBiOqPkLRqaQOglyjJqn8LEkYnGlluRvzMc4WvltywVduZ9d2pY3C3UMdxMecil0
 hgNGHyqP+ahUZX/NRya+951Z5YbBy/HuczS3GJ/zIM5C/gGnvkfaMGfbCP5fHCQhAgqP
 TSIvUl5WN/TcR9NmqGokOmfl8vBbdbNDHFzFuQDyrkQvrspqrXCUHrQL2/n/jSMGfTl8
 trguFvzdaP2K1UigE61rA7fzgKNxz6T9J/UhZbUzSe0/p7PQXOl+Ee2cFEmbhb5c1+bS
 VX6XvXPeMAafkx8xkzLgGJMq6kxagc1xcP7HSTk/ilMiFoNKAXszl9gpt1gm3r0MqbNJ dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqt27rn4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 09:53:18 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20L9GYAn035176;
        Fri, 21 Jan 2022 09:53:17 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqt27rn44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 09:53:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20L9lvdk024252;
        Fri, 21 Jan 2022 09:53:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3dqj37u92s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 09:53:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20L9rBDa45154640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 09:53:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60243AE04D;
        Fri, 21 Jan 2022 09:53:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8C4AAE051;
        Fri, 21 Jan 2022 09:53:09 +0000 (GMT)
Received: from [9.171.71.185] (unknown [9.171.71.185])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Jan 2022 09:53:09 +0000 (GMT)
Message-ID: <85d3899e-7da5-abad-743b-e5d6dde21800@linux.ibm.com>
Date:   Fri, 21 Jan 2022 10:53:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/7] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
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
In-Reply-To: <ff673e4e-c395-701f-f891-36ffa260c3bd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4BrCuuvRD4q3hOGHSeFY2uPbXTTh5QR-
X-Proofpoint-GUID: unWVda4D96LtBvEETfNKpa3-xFsLwD0t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=868
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.01.22 um 16:14 schrieb Christian Borntraeger:
> 
> 
> Am 20.01.22 um 13:03 schrieb Mark Rutland:
>> On Thu, Jan 20, 2022 at 12:28:09PM +0100, Paolo Bonzini wrote:
>>> On 1/19/22 20:22, Mark Rutland wrote:
>>>> I wonder, is the s390 guest entry/exit*preemptible*  ?
>>>>
>>>> If a timer IRQ can preempt in the middle of the EQS, we wouldn't balance
>>>> things before a ctx-switch to the idle thread, which would then be able
>>>> to hit this.
>>>>
>>>> I'll need to go audit the other architectures for similar.
>>>
>>> They don't enable interrupts in the entry/exit path so they should be okay.
>>
>> True.
>>
>> So it sounds like for s390 adding an explicit preempt_{disable,enable}() is the
>> right thing to do. I'll add that and explanatory commentary.
> 
> That would not be trivial I guess. We do allow (and need) page faults on sie for guest
> demand paging and
> 
> this piece of arch/s390/mm/fault.c
> 
>         case GMAP_FAULT:
>                  if (faulthandler_disabled() || !mm)
>                          goto out;
>                  break;
>          }
> 
> would no longer work since faulthandler_disabled checks for the preempt count.
> 


Something like this


diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index d30f5986fa85..1c7d45346e12 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -385,10 +385,18 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
                         return 0;
                 goto out;
         case USER_FAULT:
-       case GMAP_FAULT:
                 if (faulthandler_disabled() || !mm)
                         goto out;
                 break;
+               /*
+                * We know that we interrupted SIE and we are not in a IRQ.
+                * preemption might be disabled thus checking for in_atomic
+                * would result in failures
+                */
+       case GMAP_FAULT:
+               if (pagefault_disabled() || !mm)
+                       goto out;
+               break;
         }
  
         perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);

seems to work with preemption disabled around sie. Not sure yet if this is correct.
