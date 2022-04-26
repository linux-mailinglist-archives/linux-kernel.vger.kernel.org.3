Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1650F92F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbiDZJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348005AbiDZJsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:48:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6FFF3E68
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:04:03 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q81JMq010497;
        Tue, 26 Apr 2022 09:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=iPn4N13Gu2b13HcnQYpQPq+Hi4/bJkKu2jyoPSyGNhc=;
 b=l2PzmmGqCwRSs6caXfhA7JOJ/CkRK/5hBdo2hWd2jcd5yDPCyqnkxktmyi/ItUJkE0g6
 IRTiBcwJg/Fdn/OK2WTrLaSRyy8bMmOd7i2qtUYW9CCwym33RfInyZPNoXxSUwE01V1j
 g6XCjmfmbZllK+TeDtnm91rDYKhnHa+mgfsDlxZy8San5r9t3Dxit9AD2lMs9hlcW5vG
 nPy/USIwCyUjLthSXlEg1lT/962DrppJlSyXrcFl9ToLQXl0b3/N/YRogaaCHnzuKTLy
 7GRkKU5aX1kz9TUWeLenLUVFpxqDxU/BgUK/87AJb5xgAGFrh3HZsaLn/pFwIX3jDnvk Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpcv3h36g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:03:44 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q8j6gM033986;
        Tue, 26 Apr 2022 09:03:43 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpcv3h2vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:03:43 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q92Ovp031849;
        Tue, 26 Apr 2022 09:02:46 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj441w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:02:46 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q8nh8r35127796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 08:49:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5779352052;
        Tue, 26 Apr 2022 09:02:44 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3102B5204E;
        Tue, 26 Apr 2022 09:02:41 +0000 (GMT)
Message-ID: <038e0e5f-2ac7-8afe-fae0-6974be68c7e3@linux.ibm.com>
Date:   Tue, 26 Apr 2022 14:32:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Content-Language: en-US
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>
References: <CAAPL-u_pSWD6U0yQ8Ws+_Yfb_3ZEmNXJsYcRJjAFBkyDk=nq8g@mail.gmail.com>
 <ea73f6fda9cafdd0cb6ba8351139e6f4b47354a8.camel@intel.com>
 <CAAPL-u-aeceXFUNdok_GYb2aLhZa0zBBuSqHxFznQob3PbJt7Q@mail.gmail.com>
 <a80647053bba44623094995730e061f0e6129677.camel@intel.com>
 <CAAPL-u89Jxutu1VH0LnO5VGdMbkLvc2M9eapuwP-y9oG9QSsrA@mail.gmail.com>
 <610ccaad03f168440ce765ae5570634f3b77555e.camel@intel.com>
 <CAAPL-u9ktM82zAW_OVwqTmQsr-XC8XOPmAsjoiCLo18cxUWA=A@mail.gmail.com>
 <8e31c744a7712bb05dbf7ceb2accf1a35e60306a.camel@intel.com>
 <CAAPL-u9uP+FUh7Yn0ByOECo+EP32ZABnCvNPKQB9JCA68VHEqQ@mail.gmail.com>
 <78b5f4cfd86efda14c61d515e4db9424e811c5be.camel@intel.com>
 <YmKKwXa2XI/nwac0@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
 <200e95cf36c1642512d99431014db8943fed715d.camel@intel.com>
 <8735i1zurt.fsf@linux.ibm.com>
 <ea9d01e16de655af85c0041c96964d83f59fb6d2.camel@intel.com>
 <c576a992-5a50-5dd3-644c-a45d4338fc85@linux.ibm.com>
 <9a0fe756ae3af78f2612dcf2df9673053a7ebab2.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <9a0fe756ae3af78f2612dcf2df9673053a7ebab2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bwySwxcDEQZX5QRPeJbm4MJs19F1bdvK
X-Proofpoint-ORIG-GUID: 8GctJYehZNsZKyYbQU_P6kj8HB8VRskQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260060
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 2:12 PM, ying.huang@intel.com wrote:
> On Mon, 2022-04-25 at 13:39 +0530, Aneesh Kumar K V wrote:
>> On 4/25/22 11:40 AM, ying.huang@intel.com wrote:
>>> On Mon, 2022-04-25 at 09:20 +0530, Aneesh Kumar K.V wrote:
>>>> "ying.huang@intel.com" <ying.huang@intel.com> writes:
>>>>
>>>>> Hi, All,
>>>>>
>>>>> On Fri, 2022-04-22 at 16:30 +0530, Jagdish Gediya wrote:
>>>>>
>>>>> [snip]
>>>>>
>>>>>> I think it is necessary to either have per node demotion targets
>>>>>> configuration or the user space interface supported by this patch
>>>>>> series. As we don't have clear consensus on how the user interface
>>>>>> should look like, we can defer the per node demotion target set
>>>>>> interface to future until the real need arises.
>>>>>>
>>>>>> Current patch series sets N_DEMOTION_TARGET from dax device kmem
>>>>>> driver, it may be possible that some memory node desired as demotion
>>>>>> target is not detected in the system from dax-device kmem probe path.
>>>>>>
>>>>>> It is also possible that some of the dax-devices are not preferred as
>>>>>> demotion target e.g. HBM, for such devices, node shouldn't be set to
>>>>>> N_DEMOTION_TARGETS. In future, Support should be added to distinguish
>>>>>> such dax-devices and not mark them as N_DEMOTION_TARGETS from the
>>>>>> kernel, but for now this user space interface will be useful to avoid
>>>>>> such devices as demotion targets.
>>>>>>
>>>>>> We can add read only interface to view per node demotion targets
>>>>>> from /sys/devices/system/node/nodeX/demotion_targets, remove
>>>>>> duplicated /sys/kernel/mm/numa/demotion_target interface and instead
>>>>>> make /sys/devices/system/node/demotion_targets writable.
>>>>>>
>>>>>> Huang, Wei, Yang,
>>>>>> What do you suggest?
>>>>>
>>>>> We cannot remove a kernel ABI in practice.  So we need to make it right
>>>>> at the first time.  Let's try to collect some information for the kernel
>>>>> ABI definitation.
>>>>>
>>>>> The below is just a starting point, please add your requirements.
>>>>>
>>>>> 1. Jagdish has some machines with DRAM only NUMA nodes, but they don't
>>>>> want to use that as the demotion targets.  But I don't think this is a
>>>>> issue in practice for now, because demote-in-reclaim is disabled by
>>>>> default.
>>>>
>>>> It is not just that the demotion can be disabled. We should be able to
>>>> use demotion on a system where we can find DRAM only NUMA nodes. That
>>>> cannot be achieved by /sys/kernel/mm/numa/demotion_enabled. It needs
>>>> something similar to to N_DEMOTION_TARGETS
>>>>
>>>
>>> Can you show NUMA information of your machines with DRAM-only nodes and
>>> PMEM nodes?  We can try to find the proper demotion order for the
>>> system.  If you can not show it, we can defer N_DEMOTION_TARGETS until
>>> the machine is available.
>>
>>
>> Sure will find one such config. As you might have noticed this is very
>> easy to have in a virtualization setup because the hypervisor can assign
>> memory to a guest VM from a numa node that doesn't have CPU assigned to
>> the same guest. This depends on the other guest VM instance config
>> running on the system. So on any virtualization config that has got
>> persistent memory attached, this can become an easy config to end up with.
>>
> 
> Why they want to do that?  I am looking forward to a real issue, not
> theoritical possibility.
> 


Can you elaborate this more? That is a real config.


>>
>>>>> 2. For machines with PMEM installed in only 1 of 2 sockets, for example,
>>>>>
>>>>> Node 0 & 2 are cpu + dram nodes and node 1 are slow
>>>>> memory node near node 0,
>>>>>
>>>>> available: 3 nodes (0-2)
>>>>> node 0 cpus: 0 1
>>>>> node 0 size: n MB
>>>>> node 0 free: n MB
>>>>> node 1 cpus:
>>>>> node 1 size: n MB
>>>>> node 1 free: n MB
>>>>> node 2 cpus: 2 3
>>>>> node 2 size: n MB
>>>>> node 2 free: n MB
>>>>> node distances:
>>>>> node   0   1   2
>>>>>     0:  10  40  20
>>>>>     1:  40  10  80
>>>>>     2:  20  80  10
>>>>>
>>>>> We have 2 choices,
>>>>>
>>>>> a)
>>>>> node	demotion targets
>>>>> 0	1
>>>>> 2	1
>>>>
>>>> This is achieved by
>>>>
>>>> [PATCH v2 1/5] mm: demotion: Set demotion list differently
>>>>
>>>>>
>>>>> b)
>>>>> node	demotion targets
>>>>> 0	1
>>>>> 2	X
>>>>
>>>>
>>>>>
>>>>> a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
>>>>> traffic.  Both are OK as defualt configuration.  But some users may
>>>>> prefer the other one.  So we need a user space ABI to override the
>>>>> default configuration.
>>>>>
>>>>> 3. For machines with HBM (High Bandwidth Memory), as in
>>>>>
>>>>> https://lore.kernel.org/lkml/39cbe02a-d309-443d-54c9-678a0799342d@gmail.com/
>>>>>
>>>>>> [1] local DDR = 10, remote DDR = 20, local HBM = 31, remote HBM = 41
>>>>>
>>>>> Although HBM has better performance than DDR, in ACPI SLIT, their
>>>>> distance to CPU is longer.  We need to provide a way to fix this.  The
>>>>> user space ABI is one way.  The desired result will be to use local DDR
>>>>> as demotion targets of local HBM.
>>>>
>>>>
>>>> IMHO the above (2b and 3) can be done using per node demotion targets. Below is
>>>> what I think we could do with a single slow memory NUMA node 4.
>>>
>>> If we can use writable per-node demotion targets as ABI, then we don't
>>> need N_DEMOTION_TARGETS.
>>
>>
>> Not sure I understand that. Yes, once you have a writeable per node
>> demotion target it is easy to build any demotion order.
> 
> Yes.
> 
>> But that doesn't
>> mean we should not improve the default unless you have reason to say
>> that using N_DEMOTTION_TARGETS breaks any existing config.
>>
> 
> Becuase N_DEMOTTION_TARGETS is a new kernel ABI to override the default,
> not the default itself.  [1/5] of this patchset improve the default
> behavior itself, and I think that's good.
> 

we are improving the default by using N_DEMOTION_TARGETS because the 
current default breaks configs which can get you memory only NUMA nodes. 
I would not consider it an override.

> Because we must maintain the kernel ABI almost for ever, we need to be
> careful about adding new ABI and add less if possible.  If writable per-
> node demotion targets can address your issue.  Then it's unnecessary to
> add another redundant kernel ABI for that.

This means on platform like powerpc, we would always need to have a 
userspace managed demotion because we can end up with memory only numa 
nodes for them. Why force that?


> 
>>>> /sys/devices/system/node# cat node[0-4]/demotion_targets
>>>> 4
>>>> 4
>>>> 4
>>>> 4
>>>>
>>>> /sys/devices/system/node# echo 1 > node1/demotion_targets
>>>> bash: echo: write error: Invalid argument
>>>> /sys/devices/system/node# cat node[0-4]/demotion_targets
>>>> 4
>>>> 4
>>>> 4
>>>> 4
>>>>
>>>> /sys/devices/system/node# echo 0 > node1/demotion_targets
>>>> /sys/devices/system/node# cat node[0-4]/demotion_targets
>>>> 4
>>>> 0
>>>> 4
>>>> 4
>>>>
>>>> /sys/devices/system/node# echo 1 > node0/demotion_targets
>>>> bash: echo: write error: Invalid argument
>>>> /sys/devices/system/node# cat node[0-4]/demotion_targets
>>>> 4
>>>> 0
>>>> 4
>>>> 4
>>>>
>>>> Disable demotion for a specific node.
>>>> /sys/devices/system/node# echo > node1/demotion_targets
>>>> /sys/devices/system/node# cat node[0-4]/demotion_targets
>>>> 4
>>>>
>>>> 4
>>>> 4
>>>>
>>>> Reset demotion to default
>>>> /sys/devices/system/node# echo -1 > node1/demotion_targets
>>>> /sys/devices/system/node# cat node[0-4]/demotion_targets
>>>> 4
>>>> 4
>>>> 4
>>>> 4
>>>>
>>>> When a specific device/NUMA node is used for demotion target via the user interface, it is taken
>>>> out of other NUMA node targets.
>>>
>>> IMHO, we should be careful about interaction between auto-generated and
>>> overridden demotion order.
>>>
>>
>> yes, we should avoid loop between that.
> 
> In addition to that, we need to get same result after hot-remove then
> hot-add the same node.  That is, the result should be stable after NOOP.
> I guess we can just always,
> 
> - Generate the default demotion order automatically without any
> overriding.
> 
> - Apply the overriding, after removing the invalid targets, etc.
> 
>> But if you agree for the above
>> ABI we could go ahead and share the implementation code.
> 
> I think we need to add a way to distinguish auto-generated and overriden
> demotion targets in the output of nodeX/demotion_targets.  Otherwise it
> looks good to me.
> 


something like:

/sys/devices/system/node# echo 4 > node1/demotion_targets
/sys/devices/system/node# cat node[0-4]/demotion_targets
-
4 (userspace override)
-
-
-

-aneesh
