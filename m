Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFFD49225C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbiARJPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:15:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49832 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240550AbiARJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:15:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20I8SCrW009764;
        Tue, 18 Jan 2022 09:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=xFDTL+y+53UJYvU29HtOdFhWRpsfui3wq0YRriYeVYI=;
 b=BDAt+6B3lUF6Zt+sw0QZFGDnAl5CVajtps7gYPGB0BbQ18ejRzsV7gE2m6f2UDp7dgvP
 jqW3GdKWFDq98As0JwVEqHC6/vmx9ZCddNLC02COSo5gJfWsRXSOiMa9y8uYnZVSwiII
 RGA2+6bmSdGiR/Jv8u3EIKoTTqKLpEZcTL3ra/O7F8bmaIiR9+MMrAjqt9zsSF7oXohN
 yQeFoYOeFPUvgajfEE4MRLfe8t5KhmfF2Sjhz9T2hTk8PpWdig8wkMf8Gk2Rsw/ObHxz
 2sbjFwOb5+zgawu4XDOYETlPpG+S+OfTCann0uPYlumnimOoyVXTj5optfZG6Mw9L7Xx KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnt2m0u2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 09:15:37 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20I9CaWa009676;
        Tue, 18 Jan 2022 09:15:37 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnt2m0u1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 09:15:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20I9DYug002972;
        Tue, 18 Jan 2022 09:15:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhjadtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 09:15:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20I9FWlX31195586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 09:15:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1584D52059;
        Tue, 18 Jan 2022 09:15:32 +0000 (GMT)
Received: from osiris (unknown [9.145.173.74])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id AA0F75205A;
        Tue, 18 Jan 2022 09:15:31 +0000 (GMT)
Date:   Tue, 18 Jan 2022 10:15:30 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     cgel.zte@gmail.com
Cc:     oleg@redhat.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] arch/s390/kernel: remove unneeded rc variable
Message-ID: <YeaFMspieut8Y6tJ@osiris>
References: <20220118075115.925468-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118075115.925468-1-chi.minghao@zte.com.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ltU9_hDbkiSkduJFuQr1CgVQT2_Rj1qb
X-Proofpoint-GUID: a1cxWxBiZ7YSt3qLMwbcA9Ypt5P0Wtp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_02,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 mlxscore=0 spamscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=659
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 07:51:15AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from user_regset_copyin() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  arch/s390/kernel/ptrace.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
...
> -	int rc;
> -
>  	if (!MACHINE_HAS_VX)
>  		return -ENODEV;
>  	if (target == current)
>  		save_fpu_regs();
>  
> -	rc = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>  				target->thread.fpu.vxrs + __NUM_VXRS_LOW, 0, -1);
> -	return rc;

This "breaks" indentation. Could you guys please stop sending such
semi-automated generated questionable patches? I really don't see any
benefit besides code churn, and the possibility of introducing bugs.

Thanks!
