Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B59C496093
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381006AbiAUOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:18:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7542 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346635AbiAUOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:18:29 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LEGfDb020427;
        Fri, 21 Jan 2022 14:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3wLt+ycAjcgjLUs6CGqwh/KwKLCwzJ4EQdKqDZ1VGts=;
 b=pR370LlxCVmDpkoUWx50zJ1wHcFtpRnoayba6M2vKgEb6o5KOrEknwo4H69DhWT0dbr2
 Cce+4f/lFnVn891wGJvWRRalxKQrjwRP+bAJdCQvblDModJg9003RvG2HnGJ7T7oeO12
 sxgKe0TN0G5f/7Tp5SbXqEAuyzJYMexUhTuBgqKqJZkapylVjDDMrGoFGusMqp80iAcz
 tpPsKktg4AnydhcI61a9HTuoBknG/ClIx87pfYeaExjZ82Dg7UAdDHz17obTW/BUSRbr
 ErjGvWWNzwvJXIiKXD0w+BhfZzM7T0X8EYDgAjNA8ijrbI22AXNDKZ/YK8iHwioGv/o7 HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqxf0r0cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 14:17:09 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20LEGmNU020643;
        Fri, 21 Jan 2022 14:17:09 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqxf0r0c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 14:17:08 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20LE80e6032666;
        Fri, 21 Jan 2022 14:17:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3dqjm7dd4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 14:17:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20LEH30925952616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 14:17:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 750E1A405B;
        Fri, 21 Jan 2022 14:17:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BED1EA405C;
        Fri, 21 Jan 2022 14:17:01 +0000 (GMT)
Received: from [9.171.71.185] (unknown [9.171.71.185])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Jan 2022 14:17:01 +0000 (GMT)
Message-ID: <c90abd39-375a-15cc-847a-d1d28115ca97@linux.ibm.com>
Date:   Fri, 21 Jan 2022 15:17:01 +0100
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
 <85d3899e-7da5-abad-743b-e5d6dde21800@linux.ibm.com>
In-Reply-To: <85d3899e-7da5-abad-743b-e5d6dde21800@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: deDGA7EyuMNzGC7HvsMlHlQrqpERvUdI
X-Proofpoint-GUID: T0Y8w3JbiNXDaBlx6vJ5BlCfNgMgj-Jh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=975 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 21.01.22 um 10:53 schrieb Christian Borntraeger:
> Am 20.01.22 um 16:14 schrieb Christian Borntraeger:
>>
>>
>> Am 20.01.22 um 13:03 schrieb Mark Rutland:
>>> On Thu, Jan 20, 2022 at 12:28:09PM +0100, Paolo Bonzini wrote:
>>>> On 1/19/22 20:22, Mark Rutland wrote:
>>>>> I wonder, is the s390 guest entry/exit*preemptible*  ?
>>>>>
>>>>> If a timer IRQ can preempt in the middle of the EQS, we wouldn't balance
>>>>> things before a ctx-switch to the idle thread, which would then be able
>>>>> to hit this.
>>>>>
>>>>> I'll need to go audit the other architectures for similar.
>>>>
>>>> They don't enable interrupts in the entry/exit path so they should be okay.
>>>
>>> True.
>>>
>>> So it sounds like for s390 adding an explicit preempt_{disable,enable}() is the
>>> right thing to do. I'll add that and explanatory commentary.
>>
>> That would not be trivial I guess. We do allow (and need) page faults on sie for guest
>> demand paging and
>>
>> this piece of arch/s390/mm/fault.c
>>
>>         case GMAP_FAULT:
>>                  if (faulthandler_disabled() || !mm)
>>                          goto out;
>>                  break;
>>          }
>>
>> would no longer work since faulthandler_disabled checks for the preempt count.
>>
> 
> 
> Something like this
> 
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index d30f5986fa85..1c7d45346e12 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -385,10 +385,18 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>                          return 0;
>                  goto out;
>          case USER_FAULT:
> -       case GMAP_FAULT:
>                  if (faulthandler_disabled() || !mm)
>                          goto out;
>                  break;
> +               /*
> +                * We know that we interrupted SIE and we are not in a IRQ.
> +                * preemption might be disabled thus checking for in_atomic
> +                * would result in failures
> +                */
> +       case GMAP_FAULT:
> +               if (pagefault_disabled() || !mm)
> +                       goto out;
> +               break;
>          }
> 
>          perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
> 
> seems to work with preemption disabled around sie. Not sure yet if this is correct.


No it does not work. scheduling while preemption is disabled.
[ 1880.448663] BUG: scheduling while atomic: qemu-system-s39/1806/0x00000002
[ 1880.448674] INFO: lockdep is turned off.
[ 1880.448676] Modules linked in: kvm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc mlx5_ib ib_uverbs s390_trng ib_core genwqe_card crc_itu_t vfio_ccw mdev vfio_iommu_type1 eadm_sch vfio zcrypt_cex4 sch_fq_codel configfs ip_tables x_tables mlx5_core ghash_s390 prng aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common pkey zcrypt rng_core autofs4
[ 1880.448730] Preemption disabled at:
[ 1880.448731] [<000003ff8070da88>] ckc_irq_pending+0x30/0xe0 [kvm]
[ 1880.448778] CPU: 47 PID: 1806 Comm: qemu-system-s39 Tainted: G        W         5.16.0-00007-g89e9021389e2-dirty #15
[ 1880.448782] Hardware name: IBM 3906 M04 704 (LPAR)
[ 1880.448784] Call Trace:
[ 1880.448785]  [<000000000bf001d6>] dump_stack_lvl+0x8e/0xc8
[ 1880.448794]  [<000000000b26e08a>] __schedule_bug+0xe2/0xf8
[ 1880.448801]  [<000000000b26e212>] schedule_debug+0x172/0x1a8
[ 1880.448804]  [<000000000bf0bcae>] __schedule+0x56/0x8b0
[ 1880.448808]  [<000000000bf0c570>] schedule+0x68/0x110
[ 1880.448811]  [<000000000bf13e76>] schedule_timeout+0x106/0x160
[ 1880.448815]  [<000000000bf0ddf2>] wait_for_completion+0xc2/0x110
[ 1880.448818]  [<000000000b258674>] __flush_work+0xd4/0x118
[ 1880.448823]  [<000000000b4e3c88>] __drain_all_pages+0x218/0x308
[ 1880.448829]  [<000000000b4ec3bc>] __alloc_pages_slowpath.constprop.0+0x5bc/0xc98
[ 1880.448832]  [<000000000b4ece5c>] __alloc_pages+0x3c4/0x448
[ 1880.448835]  [<000000000b5143cc>] alloc_pages_vma+0x9c/0x360
[ 1880.448841]  [<000000000b4c0d6e>] do_swap_page+0x66e/0xca0
[ 1880.448845]  [<000000000b4c3012>] __handle_mm_fault+0x29a/0x4b0
[ 1880.448869]  [<000000000b4c33ac>] handle_mm_fault+0x184/0x3a8
[ 1880.448872]  [<000000000b2062ce>] do_exception+0x136/0x490
[ 1880.448877]  [<000000000b206b9a>] do_dat_exception+0x2a/0x50
[ 1880.448880]  [<000000000bf03650>] __do_pgm_check+0x120/0x1f0
[ 1880.448882]  [<000000000bf164ee>] pgm_check_handler+0x11e/0x180
[ 1880.448885]  [<000000000bf16298>] sie_exit+0x0/0x48
[ 1880.448888] ([<000003ff8071e954>] kvm_s390_enter_exit_sie+0x64/0x98 [kvm])
[ 1880.448910]  [<000003ff807061fa>] __vcpu_run+0x2a2/0x5b8 [kvm]
[ 1880.448931]  [<000003ff807069ba>] kvm_arch_vcpu_ioctl_run+0x10a/0x270 [kvm]
[ 1880.448953]  [<000003ff806ed02c>] kvm_vcpu_ioctl+0x27c/0xa40 [kvm]
[ 1880.448975]  [<000000000b58b5c6>] __s390x_sys_ioctl+0xbe/0x100
[ 1880.448982]  [<000000000bf038fa>] __do_syscall+0x1da/0x208
[ 1880.448984]  [<000000000bf16362>] system_call+0x82/0xb0
