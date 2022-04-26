Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3A50F934
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348050AbiDZJvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347935AbiDZJvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:51:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1871EEEB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:08:07 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q81LhC010635;
        Tue, 26 Apr 2022 09:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PIxu2E71rfXmR81PBhoZhEk7raaOGzgfbCl1jKf0/Ww=;
 b=i8He8qGGONPEZeZEInotHUaxIq8zKJ0K/CyExeXLF/R5M9MfVYLrVjvMf/NEOf5Eu/dE
 PoFVXVO5ljTjFA4q5wwkhhCw6DghgGmgS9CSl+Fi8Gz8GATthVuUWSSQkOU8ZjNIfDV2
 13TAyLpct8WTBytC9uO+tD78J4StBs9Vep1o3seNTJHatBkyhl30cbFgftJt7MXubI/j
 NHysMXJaPkvfhPp9LzU/5mLN6hjckyBFe+VzpoiIbBZMX7HJ/IAp2FnE5002IvnbllUT
 uYTPxhF2D5fnP8YPfsbk1hWXFtQO2kg2Jg6p5R28onqpGqokvi4qNf+fGPUC3F2PlVeT Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpcv3h6gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:08:02 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q90YHb006620;
        Tue, 26 Apr 2022 09:08:02 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpcv3h6g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:08:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q92PQd021384;
        Tue, 26 Apr 2022 09:08:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938v371-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:08:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q97v7t47972818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 09:07:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3FA952052;
        Tue, 26 Apr 2022 09:07:57 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9BB7A5204E;
        Tue, 26 Apr 2022 09:07:55 +0000 (GMT)
Message-ID: <63b0c4ab-861c-3d07-4912-e6cd842d0bfd@linux.ibm.com>
Date:   Tue, 26 Apr 2022 14:37:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Content-Language: en-US
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, shy828301@gmail.com,
        weixugc@google.com, gthelen@google.com, dan.j.williams@intel.com
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
 <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
 <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
 <085260285e48093f48d889994aaa500a78577bf2.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <085260285e48093f48d889994aaa500a78577bf2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0hQfjNpTbWfuiBtKpDO6Ix7kQ8pHlbac
X-Proofpoint-ORIG-GUID: YyvYEz6fG-GOM4uwq7y66KJooeJnqEVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=849 spamscore=0 phishscore=0
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

On 4/26/22 1:25 PM, ying.huang@intel.com wrote:
> On Mon, 2022-04-25 at 16:45 +0530, Jagdish Gediya wrote:
>> On Sun, Apr 24, 2022 at 11:19:53AM +0800, ying.huang@intel.com wrote:
>>> On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:
>>>> Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
>>>> NUMA node which are N_MEMORY and slow memory(persistent memory)
>>>> only NUMA node which are also N_MEMORY. As the current demotion
>>>> target finding algorithm works based on N_MEMORY and best distance,
>>>> it will choose DRAM only NUMA node as demotion target instead of
>>>> persistent memory node on such systems. If DRAM only NUMA node is
>>>> filled with demoted pages then at some point new allocations can
>>>> start falling to persistent memory, so basically cold pages are in
>>>> fast memor (due to demotion) and new pages are in slow memory, this
>>>> is why persistent memory nodes should be utilized for demotion and
>>>> dram node should be avoided for demotion so that they can be used
>>>> for new allocations.
>>>>
>>>> Current implementation can work fine on the system where the memory
>>>> only numa nodes are possible only for persistent/slow memory but it
>>>> is not suitable for the like of systems mentioned above.
>>>
>>> Can you share the NUMA topology information of your machine?  And the
>>> demotion order before and after your change?
>>>
>>> Whether it's good to use the PMEM nodes as the demotion targets of the
>>> DRAM-only node too?
>>
>> $ numactl -H
>> available: 2 nodes (0-1)
>> node 0 cpus: 0 1 2 3 4 5 6 7
>> node 0 size: 14272 MB
>> node 0 free: 13392 MB
>> node 1 cpus:
>> node 1 size: 2028 MB
>> node 1 free: 1971 MB
>> node distances:
>> node   0   1
>>    0:  10  40
>>    1:  40  10
>>
>> 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
>>     for 0 even when 1 is DRAM node and there is no demotion targets for 1.
>>
>> $ cat /sys/bus/nd/devices/dax0.0/target_node
>> 2
>> $
>> # cd /sys/bus/dax/drivers/
>> :/sys/bus/dax/drivers# ls
>> device_dax  kmem
>> :/sys/bus/dax/drivers# cd device_dax/
>> :/sys/bus/dax/drivers/device_dax# echo dax0.0 > unbind
>> :/sys/bus/dax/drivers/device_dax# echo dax0.0 >  ../kmem/new_id
>> :/sys/bus/dax/drivers/device_dax# numactl -H
>> available: 3 nodes (0-2)
>> node 0 cpus: 0 1 2 3 4 5 6 7
>> node 0 size: 14272 MB
>> node 0 free: 13380 MB
>> node 1 cpus:
>> node 1 size: 2028 MB
>> node 1 free: 1961 MB
>> node 2 cpus:
>> node 2 size: 0 MB
>> node 2 free: 0 MB
>> node distances:
>> node   0   1   2
>>    0:  10  40  80
>>    1:  40  10  80
>>    2:  80  80  10
>>
> 
> This looks like a virtual machine, not a real machine.  That's
> unfortunate.  I am looking forward to a real issue, not a theoritical
> possible issue.
> 

This is the source of confusion i guess. A large class of ppc64 systems 
are virtualized. The firmware include a hypervisor (PowerVM) and end 
user creates guest (aka LPAR) on them. That is the way end user will use 
this system. There is no baremetal access on this (There is an openpower 
variant, but all new systems built by IBM these days do have PowerVM on 
them).


So this is not a theoretical possibility.

-aneesh
