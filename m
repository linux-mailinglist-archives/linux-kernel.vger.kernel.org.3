Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB9F530B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiEWIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiEWIhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:37:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC8DEBC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:37:33 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N80s28009021;
        Mon, 23 May 2022 08:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aIYJtoWSOlgd2x3x6LGPKKtHwcLIIqdz8DtGn4Q2nsI=;
 b=XUlHE3Dk3UVVTUTS23gVocEBYjBfFFKwMkBb9wsXATdVX7iLv4C2OOvCfGB7rME/PECK
 H5Ld7oxQvlJ7HzlAHE8cnQ13X7Tg9HanGlPabJiAdqneA+xd5kmEZ7a9zS9+sknU7xH2
 BeYWbL4DViKgWENPRl9lSUq0N38vnIjq/JiOQncdohfpgyQxcmIAh9N8gYsLiiDBK0FS
 Da6WYQVL6nK6JrTrRzQ2U3LaZfrFYc3+uRhIPhfSP/CH1X9WCA48vhPNxY4zxnNWtktY
 YQtZqWBZCuzYum+aLIdc3zxVlpmCorkqmzaydjA2uf4xItW4QWrsjD0haVfTFt2bOX+v 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g72av520e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 08:36:53 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24N8BAF3023514;
        Mon, 23 May 2022 08:36:53 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g72av51yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 08:36:52 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24N8Kp9c011936;
        Mon, 23 May 2022 08:36:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3g6qq9a237-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 08:36:50 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24N8amWv18350436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 08:36:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFDF452050;
        Mon, 23 May 2022 08:36:48 +0000 (GMT)
Received: from [9.43.25.210] (unknown [9.43.25.210])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4D7355204E;
        Mon, 23 May 2022 08:36:43 +0000 (GMT)
Message-ID: <88ec248e-e00f-a84e-c652-97e49fbf2674@linux.ibm.com>
Date:   Mon, 23 May 2022 14:06:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20220505184603.1548-4-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ucY61C0vhBuL6I4PmANBmaioCtzeJNoX
X-Proofpoint-ORIG-GUID: WKgCXfjce8UsHA743xW4Z4VVQvna_QxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_02,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230045
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 06/05/22 00:15, Eric DeVolder wrote:
> CPU and memory change notifications are received in order to
> regenerate the elfcorehdr.
>
> To support cpu hotplug, a callback is registered to capture the
> CPUHP_AP_ONLINE_DYN online and offline events via
> cpuhp_setup_state_nocalls().
>
> To support memory hotplug, a notifier is registered to capture the
> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>
> The cpu callback and memory notifiers call handle_hotplug_event()
> to handle the hot plug/unplug event. Then handle_hotplug_event()
> dispatches the event to the architecture specific
> arch_crash_handle_hotplug_event(). During the process, the
> kexec_mutex is held.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   include/linux/crash_core.h | 10 +++++
>   include/linux/kexec.h      |  5 +++
>   kernel/crash_core.c        | 92 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 107 insertions(+)
>
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..a240f84348aa 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -84,4 +84,14 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
>   
> +#define KEXEC_CRASH_HP_REMOVE_CPU		0
> +#define KEXEC_CRASH_HP_ADD_CPU			1
> +#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
> +#define KEXEC_CRASH_HP_ADD_MEMORY		3
> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
> +
> +struct kimage;
> +void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
> +									unsigned int cpu);
> +
>   #endif /* LINUX_CRASH_CORE_H */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f93f2591fc1e..5935bc78ed7f 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -308,6 +308,11 @@ struct kimage {
>   	struct purgatory_info purgatory_info;
>   #endif
>   
> +	bool hotplug_event;
> +	unsigned int offlinecpu;
> +	bool elfcorehdr_index_valid;
> +	int elfcorehdr_index;
How about keeping above kimage elements under below config?
#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)

Thanks,
Sourabh Jain
