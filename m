Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1C8533F33
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbiEYO3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244820AbiEYO3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:29:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348213F67
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:28:11 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PE4fsN009606;
        Wed, 25 May 2022 14:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UWZSwr4apSHlTMsRIuz0yVYAH7SCvORDiD4BeImtR8g=;
 b=I/NmfraU0Jxha0Hh/LwMZODabgAaYxY8BCE+kuQCkdsxN62GvD2v80NUglDlWM+4j+3g
 Upm9SU1dpGEZm8BNDD8zLLCJ23QeVX8Sxn7FY7GdS5enWgSE4pqbntbsY83/HyJTAk40
 Q/wXtVOJPd/4EZmKqLurqjHjlT7+1OjnUIfjz+ANsZl5DonGS72Wj2XuvJsYlycgzL/n
 3jBs5xa5QJ5SPSGFhwQrtHypHHtRJKwPmxPokDin/6o1SG9/HGKlr7lKTCnvAnDFwesh
 QwG8JF/fqBam/aFUQbESJwI8XJYt0W/tqLZrkRe/U2Q5cFD6R/w5zdTuDfJHaFgowbLJ Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9hfnx94j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 14:26:51 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24PEKBjP019343;
        Wed, 25 May 2022 14:26:50 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9hfnx93s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 14:26:50 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24PEHl76021115;
        Wed, 25 May 2022 14:26:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3g93vc1cap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 14:26:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24PECbVe42008860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 14:12:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE4B75204F;
        Wed, 25 May 2022 14:26:45 +0000 (GMT)
Received: from [9.43.97.219] (unknown [9.43.97.219])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 400635204E;
        Wed, 25 May 2022 14:26:40 +0000 (GMT)
Message-ID: <e9ddbcfe-f8d4-e542-deab-a0fadf86c6eb@linux.ibm.com>
Date:   Wed, 25 May 2022 19:56:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 7/7] x86/crash: Add x86 crash hotplug support for
 kexec_load
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
 <20220505184603.1548-8-eric.devolder@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20220505184603.1548-8-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZKcWKRMI6loqY-FQfdgB-InlGA8lJt2D
X-Proofpoint-ORIG-GUID: 1d8G_JNICD8TRwtzEQtoio6Qf331eN2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_04,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205250072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 06/05/22 00:16, Eric DeVolder wrote:
> For kexec_file_load support, the loading of the crash kernel occurs
> entirely within the kernel, and as such the elfcorehdr is readily
> identified (so that it can be modified upon hotplug events).
>
> This change enables support for kexec_load by identifying the
> elfcorehdr segment in the arch_crash_handle_hotplug_event(),
> if it has not already been identified.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   arch/x86/kernel/crash.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 951ef365f0a7..845d7c77854d 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -485,6 +485,30 @@ void arch_crash_handle_hotplug_event(struct kimage *image,
>   	void *elfbuf = NULL;
>   	unsigned long mem, memsz;
>   
> +	/*
> +	 * When the struct kimage is alloced, it is wiped to zero, so
> +	 * the elfcorehdr_index_valid defaults to false. It is set on the
> +	 * kexec_file_load path, or here for kexec_load, if not already
> +	 * identified.
> +	 */
> +	if (!image->elfcorehdr_index_valid) {
> +		unsigned int n;
> +
> +		for (n = 0; n < image->nr_segments; n++) {
> +			mem = image->segment[n].mem;
> +			memsz = image->segment[n].memsz;
> +			ptr = map_crash_pages(mem, memsz);
> +			if (ptr) {
> +				/* The segment containing elfcorehdr */
> +				if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> +					image->elfcorehdr_index = (int)n;
> +					image->elfcorehdr_index_valid = true;

How about finding elfcorehdr index on kexec_load path post 
kimage_load_segment call in
do_kexec_load (kernel/kexec.c) or other suitable place? This way we can 
avoid checking for
elfcorehdr index for every hotplug. Also we might not need 
image->elfcorehdr_index_valid.

Thanks,
Sourabh Jain


