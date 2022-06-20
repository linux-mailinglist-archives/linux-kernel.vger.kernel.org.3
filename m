Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593C85514BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbiFTJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbiFTJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:48:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B7E113B;
        Mon, 20 Jun 2022 02:48:22 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K8DLBS024473;
        Mon, 20 Jun 2022 09:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vK00WTtUnOHp5kz0+UwjTffmHlZU91txstyWuP1ONV4=;
 b=DtxlgRJMaQzDmk8NyrZttIuvH3F6XDaLy2kPcdEkBhxHAELME3HENYpXU73UGQh+jXsh
 Sb606C9vrJY02wDLpi7nNAzAzPdSWQIUu0kd6l/pa7rIVA8lazYmOcb+gBURZstJrj28
 WshfUKVq69wuxatr2ydU8NVj6pUMKZhb/Lj2xQ3dxt2c15P7DzPO4iRH//WU8/vKF4q3
 75iBmdmp/fkAACegjHUSIUGbyZUzJlNDEtsZNPOy2uuH4NfTBJIXN9Zn2UmQcteTEJLP
 xNIzm8uSQgOjrUjla0UXGR9UhRXL5VcLzvNsyUiUtka6XMy2AUdcBmgjwoHzG+rprzbW 7w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsr4kcper-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 09:48:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25K9aiPh012771;
        Mon, 20 Jun 2022 09:48:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3gs5yhj9pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 09:48:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25K9mEc023003622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 09:48:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7138A405F;
        Mon, 20 Jun 2022 09:48:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59892A405B;
        Mon, 20 Jun 2022 09:48:14 +0000 (GMT)
Received: from [9.171.78.67] (unknown [9.171.78.67])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jun 2022 09:48:14 +0000 (GMT)
Message-ID: <9a188023-8a3e-547c-2e09-c6c7a7078ea8@linux.ibm.com>
Date:   Mon, 20 Jun 2022 11:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] s390/kvm: avoid hypfs error message
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20220620094534.18967-1-jgross@suse.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220620094534.18967-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U-iUo8iLOMG7F8g0nbCML-yh7KyhCOzT
X-Proofpoint-GUID: U-iUo8iLOMG7F8g0nbCML-yh7KyhCOzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20.06.22 um 11:45 schrieb Juergen Gross:
> When booting under KVM the following error messages are issued:
> 
> hypfs.7f5705: The hardware system does not support hypfs
> hypfs.7a79f0: Initialization of hypfs failed with rc=-61
> 
> Demote the severity of first message from "error" to "info" and issue
> the second message only in other error cases.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
> V2:
> - don't bail out if KVM, but avoid error messages instead (Christian
>    Borntraeger)
> ---
>   arch/s390/hypfs/hypfs_diag.c | 2 +-
>   arch/s390/hypfs/inode.c      | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
> index f0bc4dc3e9bf..6511d15ace45 100644
> --- a/arch/s390/hypfs/hypfs_diag.c
> +++ b/arch/s390/hypfs/hypfs_diag.c
> @@ -437,7 +437,7 @@ __init int hypfs_diag_init(void)
>   	int rc;
>   
>   	if (diag204_probe()) {
> -		pr_err("The hardware system does not support hypfs\n");
> +		pr_info("The hardware system does not support hypfs\n");
>   		return -ENODATA;
>   	}
>   
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 5c97f48cea91..ee919bfc8186 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -496,9 +496,9 @@ static int __init hypfs_init(void)
>   	hypfs_vm_exit();
>   fail_hypfs_diag_exit:
>   	hypfs_diag_exit();
> +	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
>   fail_dbfs_exit:
>   	hypfs_dbfs_exit();
> -	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
>   	return rc;
>   }
>   device_initcall(hypfs_init)
