Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA7952EE76
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350515AbiETOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350552AbiETOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:48:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0861737E8;
        Fri, 20 May 2022 07:48:32 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KDhOK5010271;
        Fri, 20 May 2022 14:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2BQqrf/2UZw9BbZNKXr3rbh+d0YdvQlgVQfidEHv0RY=;
 b=BQlvwXLkoWvXPj1LUUIv/I2HTPZYdVELF8oLQqAk3xXT3NdFKsPHCRQmsUl7+r0nyM3i
 PhFUr9PQdbeITigMj7Na588NSgWfkW/wVzQEi2TLX4u796t1DmW1l+Xbl+dii2Q2dhm/
 35uund+5qxTMPsodh0ryPPcMkhm4+m0MYoQ+LWWC8BtKIyjL9r1ixfik353ESWLwFssl
 93WO+GRpx/QbIaDaXDpNSUPwMeb70RDxfEJZotEd9jxPqXm0dFwXfES+CYNr32ffJsSs
 0NtdX2ljwgNYHxAZHf5iav8jMJoNwpxZzep4QSMxkzEr6tPGlUl4RWAWliOxl2WaqoNk CA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g69jhcy1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 14:48:32 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KEgjDR022176;
        Fri, 20 May 2022 14:48:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3g2429gyh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 14:48:29 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KEmQ8644696046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 14:48:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF8F911C050;
        Fri, 20 May 2022 14:48:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C3AF11C04A;
        Fri, 20 May 2022 14:48:26 +0000 (GMT)
Received: from [9.145.62.102] (unknown [9.145.62.102])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 May 2022 14:48:26 +0000 (GMT)
Message-ID: <f190b4cf-241e-db58-fa84-bfed4a401c04@linux.ibm.com>
Date:   Fri, 20 May 2022 16:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/1] s390: Add attestation query information
Content-Language: en-US
To:     Steffen Eiden <seiden@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220518135908.1110319-1-seiden@linux.ibm.com>
 <20220518135908.1110319-2-seiden@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220518135908.1110319-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YTo8cgT42d4Ucy4cMhkBtWPZD-JOmh3z
X-Proofpoint-GUID: YTo8cgT42d4Ucy4cMhkBtWPZD-JOmh3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_04,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200102
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 15:59, Steffen Eiden wrote:
> We have information about the supported attestation header version
> and plaintext attestation flag bits.
> Let's expose it via the sysfs files.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

When Heiko's nit for the commit message is fixed:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


> ---
>   arch/s390/boot/uv.c        |  2 ++
>   arch/s390/include/asm/uv.h |  7 ++++++-
>   arch/s390/kernel/uv.c      | 20 ++++++++++++++++++++
>   3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> index 67c737c1e580..a5fa667160b2 100644
> --- a/arch/s390/boot/uv.c
> +++ b/arch/s390/boot/uv.c
> @@ -45,6 +45,8 @@ void uv_query_info(void)
>   		uv_info.supp_se_hdr_pcf = uvcb.supp_se_hdr_pcf;
>   		uv_info.conf_dump_storage_state_len = uvcb.conf_dump_storage_state_len;
>   		uv_info.conf_dump_finalize_len = uvcb.conf_dump_finalize_len;
> +		uv_info.supp_att_req_hdr_ver = uvcb.supp_att_req_hdr_ver;
> +		uv_info.supp_att_pflags = uvcb.supp_att_pflags;
>   	}
>   
>   #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 3e597bb634bd..18fe04c8547e 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -124,7 +124,10 @@ struct uv_cb_qui {
>   	u64 reservedc0;				/* 0x00c0 */
>   	u64 conf_dump_storage_state_len;	/* 0x00c8 */
>   	u64 conf_dump_finalize_len;		/* 0x00d0 */
> -	u8  reservedd8[256 - 216];		/* 0x00d8 */
> +	u64 reservedd8;				/* 0x00d8 */
> +	u64 supp_att_req_hdr_ver;		/* 0x00e0 */
> +	u64 supp_att_pflags;			/* 0x00e8 */
> +	u8 reservedf0[256 - 240];		/* 0x00f0 */
>   } __packed __aligned(8);
>   
>   /* Initialize Ultravisor */
> @@ -350,6 +353,8 @@ struct uv_info {
>   	unsigned long supp_se_hdr_pcf;
>   	unsigned long conf_dump_storage_state_len;
>   	unsigned long conf_dump_finalize_len;
> +	unsigned long supp_att_req_hdr_ver;
> +	unsigned long supp_att_pflags;
>   };
>   
>   extern struct uv_info uv_info;
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 84fe33b6af4d..c13d5a7b71f0 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -479,6 +479,24 @@ static ssize_t uv_query_max_guest_addr(struct kobject *kobj,
>   static struct kobj_attribute uv_query_max_guest_addr_attr =
>   	__ATTR(max_address, 0444, uv_query_max_guest_addr, NULL);
>   
> +static ssize_t uv_query_supp_att_req_hdr_ver(struct kobject *kobj,
> +					     struct kobj_attribute *attr, char *page)
> +{
> +	return scnprintf(page, PAGE_SIZE, "%lx\n", uv_info.supp_att_req_hdr_ver);
> +}
> +
> +static struct kobj_attribute uv_query_supp_att_req_hdr_ver_attr =
> +	__ATTR(supp_att_req_hdr_ver, 0444, uv_query_supp_att_req_hdr_ver, NULL);
> +
> +static ssize_t uv_query_supp_att_pflags(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *page)
> +{
> +	return scnprintf(page, PAGE_SIZE, "%lx\n", uv_info.supp_att_pflags);
> +}
> +
> +static struct kobj_attribute uv_query_supp_att_pflags_attr =
> +	__ATTR(supp_att_pflags, 0444, uv_query_supp_att_pflags, NULL);
> +
>   static struct attribute *uv_query_attrs[] = {
>   	&uv_query_facilities_attr.attr,
>   	&uv_query_feature_indications_attr.attr,
> @@ -490,6 +508,8 @@ static struct attribute *uv_query_attrs[] = {
>   	&uv_query_dump_storage_state_len_attr.attr,
>   	&uv_query_dump_finalize_len_attr.attr,
>   	&uv_query_dump_cpu_len_attr.attr,
> +	&uv_query_supp_att_req_hdr_ver_attr.attr,
> +	&uv_query_supp_att_pflags_attr.attr,
>   	NULL,
>   };
>   

