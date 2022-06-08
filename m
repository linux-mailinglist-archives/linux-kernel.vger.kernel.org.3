Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3915454276F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiFHHC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbiFHGHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:07:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A925D2714A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 22:09:23 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2584ni9Z020632;
        Wed, 8 Jun 2022 04:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OiluVKBUyDZlq1Kw6kaAS63EX26hVkD2lKRdwQvkYAw=;
 b=LP7ztqz59Ohu103CiBMmS9TZOWHrW/p2NOctrqeR5OpE5iujSdgxkBJwblNjqQxWinId
 cFK22oxFPqhkSTQ/qxkjRW093OcWe6L/6EwYDQCaA2rP/XKokf0t4ySyQqQVqoV/OK/m
 1CR72A8XLbD3L7/DXC3DsBbPMO7/5XsT4YsbJBtDMrilHMNa1lX0xWBhWOdR3UjlEXGm
 FY1T+I+JC6CJs6+9C++KSFOx5VccRN6kaTsmnzteyKhas+iJR0Zn2eF8stCnSapX53hC
 ZyvFB5JF4IzEsepUpNNMEClnIICXD85992jitQf2H7SwcLyOI+uvi6bIioXidW3joliB BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjn3903r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:58:55 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2584uELA010870;
        Wed, 8 Jun 2022 04:58:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjn3903q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:58:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2584o7tI002919;
        Wed, 8 Jun 2022 04:58:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19cku2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:58:51 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2584wpe323331196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 04:58:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6979E52050;
        Wed,  8 Jun 2022 04:58:49 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B80465204F;
        Wed,  8 Jun 2022 04:58:43 +0000 (GMT)
Message-ID: <2b4f053b-de25-986c-f764-5cc6a28f4953@linux.ibm.com>
Date:   Wed, 8 Jun 2022 10:28:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <CAHbLzkrWer5-HgujZ12b=qxtT2ByV0+Sy7fsYb2EBgHAGRuPpw@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAHbLzkrWer5-HgujZ12b=qxtT2ByV0+Sy7fsYb2EBgHAGRuPpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mqFmMGm7_hI-s72ja6qqoNLUbPkdf9jb
X-Proofpoint-ORIG-GUID: AnRpjh8OxVwHUdgpyFAbfDTevpU3deF5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_01,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=915 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080019
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 3:02 AM, Yang Shi wrote:
> On Fri, Jun 3, 2022 at 6:43 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> In the current kernel, memory tiers are defined implicitly via a
>> demotion path relationship between NUMA nodes, which is created
>> during the kernel initialization and updated when a NUMA node is
>> hot-added or hot-removed.  The current implementation puts all
>> nodes with CPU into the top tier, and builds the tier hierarchy
>> tier-by-tier by establishing the per-node demotion targets based
>> on the distances between nodes.
>>
>> This current memory tier kernel interface needs to be improved for
>> several important use cases,
>>
>> The current tier initialization code always initializes
>> each memory-only NUMA node into a lower tier.  But a memory-only
>> NUMA node may have a high performance memory device (e.g. a DRAM
>> device attached via CXL.mem or a DRAM-backed memory-only node on
>> a virtual machine) and should be put into a higher tier.
>>
>> The current tier hierarchy always puts CPU nodes into the top
>> tier. But on a system with HBM or GPU devices, the
>> memory-only NUMA nodes mapping these devices should be in the
>> top tier, and DRAM nodes with CPUs are better to be placed into the
>> next lower tier.
>>
>> With current kernel higher tier node can only be demoted to selected nodes on the
>> next lower tier as defined by the demotion path, not any other
>> node from any lower tier.  This strict, hard-coded demotion order
>> does not work in all use cases (e.g. some use cases may want to
>> allow cross-socket demotion to another node in the same demotion
>> tier as a fallback when the preferred demotion node is out of
>> space), This demotion order is also inconsistent with the page
>> allocation fallback order when all the nodes in a higher tier are
>> out of space: The page allocation can fall back to any node from
>> any lower tier, whereas the demotion order doesn't allow that.
>>
>> The current kernel also don't provide any interfaces for the
>> userspace to learn about the memory tier hierarchy in order to
>> optimize its memory allocations.
>>
>> This patch series address the above by defining memory tiers explicitly.
>>
>> This patch introduce explicity memory tiers with ranks. The rank
>> value of a memory tier is used to derive the demotion order between
>> NUMA nodes. The memory tiers present in a system can be found at
>>
>> /sys/devices/system/memtier/memtierN/
>>
>> The nodes which are part of a specific memory tier can be listed
>> via
>> /sys/devices/system/memtier/memtierN/nodelist
>>
>> "Rank" is an opaque value. Its absolute value doesn't have any
>> special meaning. But the rank values of different memtiers can be
>> compared with each other to determine the memory tier order.
>>
>> For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
>> their rank values are 300, 200, 100, then the memory tier order is:
>> memtier0 -> memtier2 -> memtier1, where memtier0 is the highest tier
>> and memtier1 is the lowest tier.
>>
>> The rank value of each memtier should be unique.
>>
>> A higher rank memory tier will appear first in the demotion order
>> than a lower rank memory tier. ie. while reclaim we choose a node
>> in higher rank memory tier to demote pages to as compared to a node
>> in a lower rank memory tier.
>>
>> For now we are not adding the dynamic number of memory tiers.
>> But a future series supporting that is possible. Currently
>> number of tiers supported is limitted to MAX_MEMORY_TIERS(3).
>> When doing memory hotplug, if not added to a memory tier, the NUMA
>> node gets added to DEFAULT_MEMORY_TIER(1).
>>
>> This patch is based on the proposal sent by Wei Xu <weixugc@google.com> at [1].
>>
>> [1] https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
>>
>> Suggested-by: Wei Xu <weixugc@google.com>
>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   include/linux/memory-tiers.h |  20 ++++
>>   mm/Kconfig                   |  11 ++
>>   mm/Makefile                  |   1 +
>>   mm/memory-tiers.c            | 188 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 220 insertions(+)
>>   create mode 100644 include/linux/memory-tiers.h
>>   create mode 100644 mm/memory-tiers.c
>>
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> new file mode 100644
>> index 000000000000..e17f6b4ee177
>> --- /dev/null
>> +++ b/include/linux/memory-tiers.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_MEMORY_TIERS_H
>> +#define _LINUX_MEMORY_TIERS_H
>> +
>> +#ifdef CONFIG_TIERED_MEMORY
>> +
>> +#define MEMORY_TIER_HBM_GPU    0
>> +#define MEMORY_TIER_DRAM       1
>> +#define MEMORY_TIER_PMEM       2
>> +
>> +#define MEMORY_RANK_HBM_GPU    300
>> +#define MEMORY_RANK_DRAM       200
>> +#define MEMORY_RANK_PMEM       100
>> +
>> +#define DEFAULT_MEMORY_TIER    MEMORY_TIER_DRAM
>> +#define MAX_MEMORY_TIERS  3
>> +
>> +#endif /* CONFIG_TIERED_MEMORY */
>> +
>> +#endif
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 169e64192e48..08a3d330740b 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -614,6 +614,17 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
>>   config ARCH_ENABLE_THP_MIGRATION
>>          bool
>>
>> +config TIERED_MEMORY
>> +       bool "Support for explicit memory tiers"
>> +       def_bool n
>> +       depends on MIGRATION && NUMA
>> +       help
>> +         Support to split nodes into memory tiers explicitly and
>> +         to demote pages on reclaim to lower tiers. This option
>> +         also exposes sysfs interface to read nodes available in
>> +         specific tier and to move specific node among different
>> +         possible tiers.
> 
> IMHO we should not need a new kernel config. If tiering is not present
> then there is just one tier on the system. And tiering is a kind of
> hardware configuration, the information could be shown regardless of
> whether demotion/promotion is supported/enabled or not.
> 

This was added so that we could avoid doing multiple

#if defined(CONFIG_MIGRATION) && defined(CONFIG_NUMA)

Initially I had that as def_bool y and depends on MIGRATION && NUMA. But 
it was later suggested that def_bool is not recommended for newer config.

How about

  config TIERED_MEMORY
  	bool "Support for explicit memory tiers"
-	def_bool n
-	depends on MIGRATION && NUMA
-	help
-	  Support to split nodes into memory tiers explicitly and
-	  to demote pages on reclaim to lower tiers. This option
-	  also exposes sysfs interface to read nodes available in
-	  specific tier and to move specific node among different
-	  possible tiers.
+	def_bool MIGRATION && NUMA

  config HUGETLB_PAGE_SIZE_VARIABLE
  	def_bool n

ie, we just make it a Kconfig variable without exposing it to the user?

-aneesh
