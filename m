Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440324CF283
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiCGHWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiCGHWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:22:12 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76101B784
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:21:18 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2275UL2Y019219;
        Mon, 7 Mar 2022 07:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BOwRRfZpfUhqe0Ay4uOmMd/ccJcQ+3BiIeWlO5KYAT8=;
 b=eCX9ekB6fiesq3lPR5MUldKbULRqqXcA6EVjLlXw9GwPztTzeSxkV9VWksu7qiOiAoh3
 63Kl3M8AV7ZQudYUYRtvf7cfHnmtKg3PdZhkiTdhT211dhQUKm0Tukoo2SpoLkUt57eR
 HegXYxu7BkVFP6Ec3dVIXkfMgPBUJU38D9gr/7JQUyOvpAqu6k7i+LszLyMOHd3OtVVi
 vrsUb5+bWgSoYbvfGkKXv9ssGepVB6CTFRHhqG0X28AAsaBd3MRKHncuZV+KX0PmFP5V
 T2bV9wkhNl46h4TvU01Ex/VE41vwkYAYXFUtEgB5F+V2EIu36D6WSQc5C876R21qVBZJ mg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3emk3037c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 07:20:42 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2277Iivl027229;
        Mon, 7 Mar 2022 07:20:40 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3ekyg8bcax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 07:20:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2277Kbrb23986578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Mar 2022 07:20:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91FCD42049;
        Mon,  7 Mar 2022 07:20:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F7C142041;
        Mon,  7 Mar 2022 07:20:25 +0000 (GMT)
Received: from [9.43.33.192] (unknown [9.43.33.192])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Mar 2022 07:20:23 +0000 (GMT)
Message-ID: <4a2164f4-0667-ae6c-758a-9bcaca43410f@linux.ibm.com>
Date:   Mon, 7 Mar 2022 12:50:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 0/4] Add perf interface to expose nvdimm
Content-Language: en-US
To:     Kajol Jain <kjain@linux.ibm.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com
Cc:     santosh@fossix.org, rnsastry@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        vaibhav@linux.ibm.com, tglx@linutronix.de
References: <20220225143024.47947-1-kjain@linux.ibm.com>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20220225143024.47947-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0567EwIQSU6t0hKfjeXJorAMLqsmsw1o
X-Proofpoint-GUID: 0567EwIQSU6t0hKfjeXJorAMLqsmsw1o
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_01,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203070041
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/22 20:00, Kajol Jain wrote:
> Patchset adds performance stats reporting support for nvdimm.
> Added interface includes support for pmu register/unregister
> functions. A structure is added called nvdimm_pmu to be used for
> adding arch/platform specific data such as cpumask, nvdimm device
> pointer and pmu event functions like event_init/add/read/del.
> User could use the standard perf tool to access perf events
> exposed via pmu.
>
> Interface also defines supported event list, config fields for the
> event attributes and their corresponding bit values which are exported
> via sysfs. Patch 3 exposes IBM pseries platform nmem* device
> performance stats using this interface.
>
> Result from power9 pseries lpar with 2 nvdimm device:

Patchset looks fine to me.

Reviewed-by: Madhavan Srinivasan <maddy@in.ibm.com>


> Ex: List all event by perf list
>
> command:# perf list nmem
>
>    nmem0/cache_rh_cnt/                                [Kernel PMU event]
>    nmem0/cache_wh_cnt/                                [Kernel PMU event]
>    nmem0/cri_res_util/                                [Kernel PMU event]
>    nmem0/ctl_res_cnt/                                 [Kernel PMU event]
>    nmem0/ctl_res_tm/                                  [Kernel PMU event]
>    nmem0/fast_w_cnt/                                  [Kernel PMU event]
>    nmem0/host_l_cnt/                                  [Kernel PMU event]
>    nmem0/host_l_dur/                                  [Kernel PMU event]
>    nmem0/host_s_cnt/                                  [Kernel PMU event]
>    nmem0/host_s_dur/                                  [Kernel PMU event]
>    nmem0/med_r_cnt/                                   [Kernel PMU event]
>    nmem0/med_r_dur/                                   [Kernel PMU event]
>    nmem0/med_w_cnt/                                   [Kernel PMU event]
>    nmem0/med_w_dur/                                   [Kernel PMU event]
>    nmem0/mem_life/                                    [Kernel PMU event]
>    nmem0/poweron_secs/                                [Kernel PMU event]
>    ...
>    nmem1/mem_life/                                    [Kernel PMU event]
>    nmem1/poweron_secs/                                [Kernel PMU event]
>
> Patch1:
>          Introduces the nvdimm_pmu structure
> Patch2:
>          Adds common interface to add arch/platform specific data
>          includes nvdimm device pointer, pmu data along with
>          pmu event functions. It also defines supported event list
>          and adds attribute groups for format, events and cpumask.
>          It also adds code for cpu hotplug support.
> Patch3:
>          Add code in arch/powerpc/platform/pseries/papr_scm.c to expose
>          nmem* pmu. It fills in the nvdimm_pmu structure with pmu name,
>          capabilities, cpumask and event functions and then registers
>          the pmu by adding callbacks to register_nvdimm_pmu.
> Patch4:
>          Sysfs documentation patch
>
> Changelog
> ---
> v6 -> v7
> - Add function call to numa_map_to_online_node function inorder to
>    get online numa node. As the node id returned by function dev_to_node
>    can be offline in some scenarios and can create issue in hotplug code
>    as reported by Nageswara R Sastry.
>
> - Add function declaration of perf_pmu_register, perf_pmu_unregister
>    and  perf_pmu_migrate_context functions in nd.h file to resolve
>    the implicit-function-declaration warning as reported by kernel test
>    robot.
>    Link: https://lore.kernel.org/all/202202241242.zqzGkguy-lkp@intel.com/
>
> - Add Tested-by, Acked-by and Reported-by tags from Peter Zijlstra
>    and Nageswara R Sastry.
>
> - Link to the patchset v6: https://lkml.org/lkml/2022/2/17/857
>
> Resend v5 -> v6
> - No logic change, just a rebase to latest upstream and
>    tested the patchset.
>
> - Link to the patchset Resend v5: https://lkml.org/lkml/2021/11/15/3979
>
> v5 -> Resend v5
> - Resend the patchset
>
> - Link to the patchset v5: https://lkml.org/lkml/2021/9/28/643
>
> v4 -> v5:
> - Remove multiple variables defined in nvdimm_pmu structure include
>    name and pmu functions(event_int/add/del/read) as they are just
>    used to copy them again in pmu variable. Now we are directly doing
>    this step in arch specific code as suggested by Dan Williams.
>
> - Remove attribute group field from nvdimm pmu structure and
>    defined these attribute groups in common interface which
>    includes format, event list along with cpumask as suggested by
>    Dan Williams.
>    Since we added static defination for attrbute groups needed in
>    common interface, removes corresponding code from papr.
>
> - Add nvdimm pmu event list with event codes in the common interface.
>
> - Remove Acked-by/Reviewed-by/Tested-by tags as code is refactored
>    to handle review comments from Dan.
>
> - Make nvdimm_pmu_free_hotplug_memory function static as reported
>    by kernel test robot, also add corresponding Reported-by tag.
>
> - Link to the patchset v4: https://lkml.org/lkml/2021/9/3/45
>
> v3 -> v4
> - Rebase code on top of current papr_scm code without any logical
>    changes.
>
> - Added Acked-by tag from Peter Zijlstra and Reviewed by tag
>    from Madhavan Srinivasan.
>
> - Link to the patchset v3: https://lkml.org/lkml/2021/6/17/605
>
> v2 -> v3
> - Added Tested-by tag.
>
> - Fix nvdimm mailing list in the ABI Documentation.
>
> - Link to the patchset v2: https://lkml.org/lkml/2021/6/14/25
>
> v1 -> v2
> - Fix hotplug code by adding pmu migration call
>    incase current designated cpu got offline. As
>    pointed by Peter Zijlstra.
>
> - Removed the retun -1 part from cpu hotplug offline
>    function.
>
> - Link to the patchset v1: https://lkml.org/lkml/2021/6/8/500
>
> Kajol Jain (4):
>    drivers/nvdimm: Add nvdimm pmu structure
>    drivers/nvdimm: Add perf interface to expose nvdimm performance stats
>    powerpc/papr_scm: Add perf interface support
>    docs: ABI: sysfs-bus-nvdimm: Document sysfs event format entries for
>      nvdimm pmu
>
>   Documentation/ABI/testing/sysfs-bus-nvdimm |  35 +++
>   arch/powerpc/include/asm/device.h          |   5 +
>   arch/powerpc/platforms/pseries/papr_scm.c  | 225 ++++++++++++++
>   drivers/nvdimm/Makefile                    |   1 +
>   drivers/nvdimm/nd_perf.c                   | 328 +++++++++++++++++++++
>   include/linux/nd.h                         |  44 +++
>   6 files changed, 638 insertions(+)
>   create mode 100644 drivers/nvdimm/nd_perf.c
>
