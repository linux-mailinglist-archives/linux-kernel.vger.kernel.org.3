Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083284CBD05
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiCCLpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiCCLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:45:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12110BF7C;
        Thu,  3 Mar 2022 03:44:51 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223AO3Bx028647;
        Thu, 3 Mar 2022 11:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=DTIFQfAsQ9HRNExt3rNojfwxqI2Uht9mWifm6YtDZPE=;
 b=okXwPfgnbGSgqULZVsVUfhzfIHKPAosLCmSPzKTheuf0MzpUZhtnTUSqGF75a9MT77wD
 gQ7CJEYQcmpFB4io9LlyHmmqlHFYZcHreBApgUp8CQXk3AUHjvT7nkhLqz8Vr6zOailR
 dxqkaz1b/L6ieOcQK/GTRGg0kiv9Aca46XRVNNcFn5VApB2wA/T+HUThCHqViGwD4EP6
 oYUzPBhe8BQItVCtmAhcJa5tG2obw9qwojGj14L0qDSwfOc42cARFmFURshoz6GFuNzL
 63OR+WVQK/TEgOCq/mGuxvb2hMrnQuQpsb1d/su1d/oVVXZ6c/rYBrKnUBEWCqu5la1d Ag== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejuvy9he4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 11:44:26 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 223Bcd9k010957;
        Thu, 3 Mar 2022 11:44:26 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 3efbua45ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 11:44:26 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 223BiP2u51446208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 11:44:25 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29677AC062;
        Thu,  3 Mar 2022 11:44:25 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59E50AC05E;
        Thu,  3 Mar 2022 11:44:18 +0000 (GMT)
Received: from [9.43.91.43] (unknown [9.43.91.43])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  3 Mar 2022 11:44:17 +0000 (GMT)
Message-ID: <7223fa7d-56ef-ecee-218c-03d67c6aac4e@linux.vnet.ibm.com>
Date:   Thu, 3 Mar 2022 17:11:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [next-20220225] powerpc boot broken with maple tree code ?
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     linux-next <linux-next@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brian King <brking@linux.vnet.ibm.com>,
        "aneesh.kumar" <aneesh.kumar@linux.vnet.ibm.com>
References: <d36d1a56-7946-723b-a255-dab5a9a77592@linux.vnet.ibm.com>
 <20220302145225.5t2ia356ez3ewq2k@revolver>
From:   Abdul Haleem <abdhalee@linux.vnet.ibm.com>
In-Reply-To: <20220302145225.5t2ia356ez3ewq2k@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6Dz7xnxTDhSZdCYqshQEzf4H57VB7Pau
X-Proofpoint-ORIG-GUID: 6Dz7xnxTDhSZdCYqshQEzf4H57VB7Pau
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=992
 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 8:22 PM, Liam Howlett wrote:

> * Abdul Haleem <abdhalee@linux.vnet.ibm.com> [220302 01:22]:
>> Greeting's
>>
>> linux-next kernel 5.17.0-rc5-next-20220225 boot is broken on powerpc
>>
>> Is this due to Introduction of maple patch series ?
> It could be - those are certainly maple tree functions.  I do have a
> ppc64le VM booting here with a bunch of debug turned on.
>
> Could you test the maple tree branch itself?
> https://github.com/oracle/linux-uek/tree/howlett/maple/20220301

Kernel crash is not seen with howlett/maple/20220301 branch, boots fine on my powerpc box.

Thanks

>> Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
>>   BUG: Kernel NULL pointer dereference on read at 0x00000000
>>   Faulting instruction address: 0xc0000000006f1560
>>   Oops: Kernel access of bad area, sig: 11 [#1]
>>   LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>>   Modules linked in: nfnetlink tcp_diag udp_diag inet_diag unix_diag af_packet_diag ibmvnic netlink_diag bonding rfkill sunrpc pseries_rng xts vmx_crypto gf128mul sch_fq_codel binfmt_misc ip_tables ext4 mbcache jbd2 dm_service_time sd_mod t10_pi sg ibmvfc scsi_transport_fc ibmveth dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse [last unloaded: ibmvnic]
>>   CPU: 31 PID: 7527 Comm: pmpost Not tainted 5.17.0-rc5-next-20220225-autotest #1
>>   NIP:  c0000000006f1560 LR: c0000000006f6f48 CTR: 0000000000000000
>>   REGS: c0000000251732f0 TRAP: 0300   Not tainted  (5.17.0-rc5-next-20220225-autotest)
>>   MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24422888  XER: 20040000
>>   CFAR: c0000000006f17a4 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0
>>   GPR00: c0000000006feb04 c000000025173590 c0000000028d1400 c0000000251735b8
>>   GPR04: 0000000000000001 c000000028364200 c0000000251735b8 0000000000000000
>>   GPR08: 0000000000000004 0000000000000002 0000000000000000 c000000028364200
>>   GPR12: 0000000044422888 c0000013ffaa4e80 0000000000000003 c0000000355eef48
>>   GPR16: 00007ffff23ee710 00000000003a164c 0000000000000002 0000000000000001
>>   GPR20: 0000000000000000 0000000000000073 000000007fff8a79 0000000000000000
>>   GPR24: c000000018aade00 00007fff8a79ffff c000000025173680 0000000000000002
>>   GPR28: c000000000d448e8 0000000000000002 0000000000000001 c0000000251736c0
>>   NIP [c0000000006f1560] mas_ascend+0x60/0x2e0
>>   LR [c0000000006f6f48] mas_next_sibling+0xd8/0x290
>>   Call Trace:
>>   [c000000025173590] [c000000025173b18] 0xc000000025173b18 (unreliable)
>>   [c000000025173620] [c0000000006feb04] mas_wr_modify+0x6c4/0x910
>>   [c0000000251739a0] [c0000000006ff0b8] mas_wr_store_entry+0x198/0x3f0
>>   [c0000000251739d0] [c00000000070167c] mas_store_gfp+0x6c/0x190
>>   [c000000025173a80] [c0000000003b1164] mmap_region+0x304/0xda0
>>   [c000000025173bf0] [c0000000003b1fcc] do_mmap+0x3cc/0x5e0
>>   [c000000025173c90] [c000000000372ea0] vm_mmap_pgoff+0x130/0x1f0
>>   [c000000025173d20] [c0000000003adc8c] ksys_mmap_pgoff+0x6c/0x2c0
>>   [c000000025173d90] [c000000000013780] sys_mmap+0x40/0xb0
>>   [c000000025173db0] [c00000000002f7e8] system_call_exception+0x178/0x380
>>   [c000000025173e10] [c00000000000c64c] system_call_common+0xec/0x250
>>   --- interrupt: c00 at 0x7fff8a7678b8
>>   NIP:  00007fff8a7678b8 LR: 00007fff8a749e84 CTR: 0000000000000000
>>   REGS: c000000025173e80 TRAP: 0c00   Not tainted  (5.17.0-rc5-next-20220225-autotest)
>>   MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24422284  XER: 00000000
>>   IRQMASK: 0
>>   GPR00: 000000000000005a 00007ffff23ee680 00007fff8a797e00 00007fff8a790000
>>   GPR04: 0000000000000008 0000000000000003 0000000000000032 ffffffffffffffff
>>   GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>   GPR12: 0000000000000000 0000000000000000 0000000000000003 00007ffff23ee740
>>   GPR16: 00007ffff23ee710 00000000003a164c 0000000000000002 0000000000000006
>>   GPR20: 0000000000000000 00007fff8a790000 00007fff8a5fa1eb 00007fff8a793d70
>>   GPR24: 00007fff8a791178 0000000000000000 0000000000000003 00007ffff23eea40
>>   GPR28: 0000000000000000 000000000000fd04 00007fff8a793d90 00007ffff23ee7d0
>>   NIP [00007fff8a7678b8] 0x7fff8a7678b8
>>   LR [00007fff8a749e84] 0x7fff8a749e84
>>   --- interrupt: c00
>>   Instruction dump:
>>   712a0002 e8a30000 552a067a 41820264 71290086 2ba90006 419e01a8 39200003
>>   7d4a4c36 61080004 99460039 f9060018 <e9270000> 792a07e0 2eaa0000 7d4c5378
>>   ---[ end trace 0000000000000000 ]---
>>   Kernel panic - not syncing: Fatal exception
>>
>> kernel config attached
>>
>> -- 
>> Regard's
>>
>> Abdul Haleem
>> IBM Linux Technology Center

-- 
Regard's

Abdul Haleem
IBM Linux Technology Center

