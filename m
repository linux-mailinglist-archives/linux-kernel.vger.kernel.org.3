Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBA5493FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356781AbiASSaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:30:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356768AbiASSaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:30:05 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JIBS6i006108;
        Wed, 19 Jan 2022 18:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+aLeCFeXFChXXFDM099BJ1uKbHwE/lNmeoMnc2ch4Ts=;
 b=L6uBN4waFGwZvKPrYkGPS2+slac0G4GOWn7jIEKmbmaH8fb87IXNZNHr3qJY3v7ZGQ1u
 LxasSg5KVl+l/B8ExytL5yw5WzHkLFUjEKdeDnWbHWCaDoiT7hgSmLDCCJJMB6JLqidL
 k5mGrHSagexncERQxPVR/5MPXUKQ4hKyIHXsS3MeVIGKUehlUce2HiB0ZNpLEnZFQ3Vy
 1iIDYH7aqE0GYUrze5uzQu2ls/GLs8IA7iX4RSJIaJAhVtYjHcVhn7EMjUuC7k1qiZwW
 tIf4Yg632tB4Lptt2kWoNHUVZyA0e+Kwngf3YnU7dMQg21aW0Xk+cnr5DpBq3UmU/7GV fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpqgyrkd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 18:28:56 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20JICp70010910;
        Wed, 19 Jan 2022 18:28:55 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpqgyrkcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 18:28:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JIHrIM013309;
        Wed, 19 Jan 2022 18:28:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhjsfp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 18:28:52 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JISnO931392136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 18:28:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E482EA4064;
        Wed, 19 Jan 2022 18:28:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25335A405C;
        Wed, 19 Jan 2022 18:28:47 +0000 (GMT)
Received: from [9.171.34.112] (unknown [9.171.34.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jan 2022 18:28:47 +0000 (GMT)
Message-ID: <57184d6d-c038-b6e3-be63-fc342e6d36af@linux.ibm.com>
Date:   Wed, 19 Jan 2022 19:28:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/7] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
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
In-Reply-To: <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oiNETzftFBTrwFX12lr2T8VpX77Lgtd7
X-Proofpoint-GUID: Kag7MJ11SCZtWKKm6Er_Y73D5OCxgfex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_10,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxlogscore=959 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [  457.151295] ------------[ cut here ]------------
> [  457.151311] WARNING: CPU: 14 PID: 0 at kernel/rcu/tree.c:613 rcu_eqs_enter.constprop.0+0xf8/0x118
> [  457.151324] Modules linked in: vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_tcpudp nft_compat nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter kvm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc mlx5_ib ib_uverbs s390_trng ib_core genwqe_card crc_itu_t vfio_ccw mdev vfio_iommu_type1 eadm_sch vfio zcrypt_cex4 sch_fq_codel configfs ip_tables x_tables mlx5_core ghash_s390 prng aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common pkey zcrypt rng_core autofs4
> [  457.151422] CPU: 14 PID: 0 Comm: swapper/14 Not tainted 5.16.0-00007-g89e9021389e2 #3
> [  457.151428] Hardware name: IBM 3906 M04 704 (LPAR)
> [  457.151432] Krnl PSW : 0404d00180000000 00000000a7c0495c (rcu_eqs_enter.constprop.0+0xfc/0x118)
> [  457.151440]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> [  457.151445] Krnl GPRS: ffffffffebd81d31 4000000000000000 0000000000000070 00000000a7fd7024
> [  457.151450]            0000000000000000 0000000000000001 0000000000000000 0000000000000000
> [  457.151454]            000000000000000e 000000000000000e 00000000a84d3a88 0000001fd8645c00
> [  457.151458]            0000000000000000 0000000000000000 00000000a7c04882 0000038000653dc0
> [  457.151468] Krnl Code: 00000000a7c0494c: ebaff0a00004    lmg    %r10,%r15,160(%r15)
>                            00000000a7c04952: c0f4fffffef7    brcl    15,00000000a7c04740
>                           #00000000a7c04958: af000000        mc    0,0
>                           >00000000a7c0495c: a7f4ffa3        brc    15,00000000a7c048a2
>                            00000000a7c04960: c0e500003f70    brasl    %r14,00000000a7c0c840
>                            00000000a7c04966: a7f4ffcd        brc    15,00000000a7c04900
>                            00000000a7c0496a: c0e500003f6b    brasl    %r14,00000000a7c0c840
>                            00000000a7c04970: a7f4ffde        brc    15,00000000a7c0492c
> [  457.151527] Call Trace:
> [  457.151530]  [<00000000a7c0495c>] rcu_eqs_enter.constprop.0+0xfc/0x118
> [  457.151536] ([<00000000a7c04882>] rcu_eqs_enter.constprop.0+0x22/0x118)
> [  457.151540]  [<00000000a7c14cd2>] default_idle_call+0x62/0xd8
> [  457.151545]  [<00000000a6f816c6>] do_idle+0xf6/0x1b0
> [  457.151553]  [<00000000a6f81a06>] cpu_startup_entry+0x36/0x40
> [  457.151558]  [<00000000a7c16abe>] restart_int_handler+0x6e/0x90
> [  457.151563] no locks held by swapper/14/0.
> [  457.151567] Last Breaking-Event-Address:
> [  457.151570]  [<00000000a7c0489e>] rcu_eqs_enter.constprop.0+0x3e/0x118
> [  457.151574] irq event stamp: 608654
> [  457.151578] hardirqs last  enabled at (608653): [<00000000a70190d8>] tick_nohz_idle_enter+0xb0/0x130
> [  457.151584] hardirqs last disabled at (608654): [<00000000a6f8173e>] do_idle+0x16e/0x1b0
> [  457.151589] softirqs last  enabled at (608586): [<00000000a7c1861a>] __do_softirq+0x4ba/0x668
> [  457.151594] softirqs last disabled at (608581): [<00000000a6f367c6>] __irq_exit_rcu+0x13e/0x170
> [  457.151600] ---[ end trace 2ae2154f9724de86 ]---
> 
> I can not see right now whats wrong, your patches look sane.


Now followed by (might be a followup to the error above).

[  574.301736] =============================
[  574.301741] WARNING: suspicious RCU usage
[  574.301746] 5.16.0-00007-g89e9021389e2 #3 Tainted: G        W
[  574.301751] -----------------------------
[  574.301755] kernel/rcu/tree.c:821 Bad RCU  dynticks_nmi_nesting counter
                !
[  574.301760]
                other info that might help us debug this:

[  574.301764]
                rcu_scheduler_active = 2, debug_locks = 1
[  574.301769] 2 locks held by CPU 0/KVM/8327:
[  574.301773]  #0: 00000001521956b8 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x9a/0xa40 [kvm]
[  574.301843]  #1: 000000016e92c6a8 (&kvm->srcu){....}-{0:0}, at: __vcpu_run+0x332/0x5b8 [kvm]
[  574.301873]
                stack backtrace:
[  574.301878] CPU: 46 PID: 8327 Comm: CPU 0/KVM Tainted: G        W         5.16.0-00007-g89e9021389e2 #3
[  574.301884] Hardware name: IBM 3906 M04 704 (LPAR)
[  574.301888] Call Trace:
[  574.301892]  [<00000000a7c001c6>] dump_stack_lvl+0x8e/0xc8
[  574.301903]  [<00000000a6fee70e>] rcu_irq_exit_check_preempt+0x136/0x1c8
[  574.301913]  [<00000000a6ff9d1a>] irqentry_exit_cond_resched+0x32/0x80
[  574.301921]  [<00000000a7c0521c>] irqentry_exit+0xac/0x130
[  574.301927]  [<00000000a7c16626>] ext_int_handler+0xe6/0x120
[  574.301933]  [<00000000a6fc2482>] lock_acquire.part.0+0x12a/0x258
[  574.301939] ([<00000000a6fc2450>] lock_acquire.part.0+0xf8/0x258)
[  574.301944]  [<00000000a6fc2660>] lock_acquire+0xb0/0x200
[  574.302053]  [<000003ff807092ce>] __vcpu_run+0x376/0x5b8 [kvm]
[  574.302076]  [<000003ff807099ba>] kvm_arch_vcpu_ioctl_run+0x10a/0x270 [kvm]
[  574.302098]  [<000003ff806f002c>] kvm_vcpu_ioctl+0x27c/0xa40 [kvm]
[  574.302120]  [<00000000a728b5b6>] __s390x_sys_ioctl+0xbe/0x100
[  574.302129]  [<00000000a7c038ea>] __do_syscall+0x1da/0x208
[  574.302133]  [<00000000a7c16352>] system_call+0x82/0xb0
[  574.302138] 2 locks held by CPU 0/KVM/8327:
[  574.302143]  #0: 00000001521956b8 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x9a/0xa40 [kvm]
[  574.302172]  #1: 000000016e92c6a8 (&kvm->srcu){....}-{0:0}, at: __vcpu_run+0x332/0x5b8 [kvm]

