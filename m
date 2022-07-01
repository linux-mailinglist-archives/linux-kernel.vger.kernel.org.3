Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4244B56310F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiGAKKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiGAKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:10:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1B017594;
        Fri,  1 Jul 2022 03:10:26 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261A3W2m020456;
        Fri, 1 Jul 2022 10:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UmCQjA2ABCVvbRbvlQlcH+BQVveyAfSCV76NYtzcJMQ=;
 b=lRTeTe4JAIqo1bOU6r8rZrO5jFYNPr2QmO5l/kIzN8rb6/35/7sxx65xXFL3juz9pjrq
 GKkbmes5c7ULSxwAuvjSV4w/ZbiwzvYxlcLervIZyk7Z4nWLtQj3K9x9apiOyz2cqSgW
 iETWHEKRj3HMsmybnrOq6zw1zXAEkNCIkJ+yXLFZjTSO+QayrgGeS6yUG436xCPJ9iXu
 LusKUyV3TcbsgtqhBbXGIIEQLjujMuXBR+elmb9elz9SFXiHZr5iSFOANgneit0p7bO5
 gau8/6VjTGBnYFN7BgUYp0yrF8pBOj8jwGJ+ljOR50fPudA7osMMm7VZXXAylDbLz+pX Qw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1xua869a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 10:10:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 261A5NrD012209;
        Fri, 1 Jul 2022 10:10:22 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt091gr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 10:10:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 261AARl328377528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 10:10:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C000AE055;
        Fri,  1 Jul 2022 10:10:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEE3FAE04D;
        Fri,  1 Jul 2022 10:10:18 +0000 (GMT)
Received: from [9.171.7.21] (unknown [9.171.7.21])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 10:10:18 +0000 (GMT)
Message-ID: <1a2a885b-d408-0426-8e8c-ad1c56f4c215@linux.ibm.com>
Date:   Fri, 1 Jul 2022 12:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] s390/hwcaps: Add HWCAP_UV
Content-Language: en-US
To:     Steffen Eiden <seiden@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
References: <20220701100210.5482-1-seiden@linux.ibm.com>
 <20220701100210.5482-2-seiden@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220701100210.5482-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HnRw0gHl-MraEG-yNXmflP3eDogCoNE0
X-Proofpoint-ORIG-GUID: HnRw0gHl-MraEG-yNXmflP3eDogCoNE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.07.22 um 12:02 schrieb Steffen Eiden:
> This patch adds a hardware capability for the Ultravisor.
> This capability will be present if facility 158 is enabled.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/include/asm/elf.h  | 2 ++
>   arch/s390/kernel/processor.c | 5 +++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
> index 70a30ae258b7..3a5e89ce4fd0 100644
> --- a/arch/s390/include/asm/elf.h
> +++ b/arch/s390/include/asm/elf.h
> @@ -115,6 +115,7 @@ enum {
>   	HWCAP_NR_NNPA		= 20,
>   	HWCAP_NR_PCI_MIO	= 21,
>   	HWCAP_NR_SIE		= 22,
> +	HWCAP_NR_UV		= 23,
>   	HWCAP_NR_MAX
>   };

question for Heiko, Vasily, Alexander. This certainly works.
An alternative implementation would be to separate module_cpu_feature_match
from HWCAP. (so uv would not be shown in /proc/cpuinfo and it would be
seen in the aux vector). I would imagine that we might have more drivers
in the future that depend on a facility but this facility is not really
useful for userspace to know.

See arch/s390/include/asm/cpufeature.h
  * Restrict the set of exposed CPU features to ELF hardware capabilities for
  * now.  Additional machine flags can be indicated by values larger than
  * MAX_ELF_HWCAP_FEATURES.

Any preference from your side?

>   
> @@ -142,6 +143,7 @@ enum {
>   #define HWCAP_NNPA		BIT(HWCAP_NR_NNPA)
>   #define HWCAP_PCI_MIO		BIT(HWCAP_NR_PCI_MIO)
>   #define HWCAP_SIE		BIT(HWCAP_NR_SIE)
> +#define HWCAP_UV		BIT(HWCAP_NR_UV)
>   
>   /*
>    * These are used to set parameters in the core dumps.
> diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
> index aa0e0e7fc773..80ccd57a2b00 100644
> --- a/arch/s390/kernel/processor.c
> +++ b/arch/s390/kernel/processor.c
> @@ -141,6 +141,7 @@ static void show_cpu_summary(struct seq_file *m, void *v)
>   		[HWCAP_NR_NNPA]		= "nnpa",
>   		[HWCAP_NR_PCI_MIO]	= "pcimio",
>   		[HWCAP_NR_SIE]		= "sie",
> +		[HWCAP_NR_UV]		= "uv",
>   	};
>   	int i, cpu;
>   
> @@ -249,6 +250,10 @@ static int __init setup_hwcaps(void)
>   	if (sclp.has_sief2)
>   		elf_hwcap |= HWCAP_SIE;
>   
> +	/* ultravisor-call (secure execution) */
> +	if (test_facility(158))
> +		elf_hwcap |= HWCAP_UV;
> +
>   	return 0;
>   }
>   arch_initcall(setup_hwcaps);
