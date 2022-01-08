Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BADE4884CF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiAHRGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:06:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234693AbiAHRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:06:12 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 208FaV3Q004554;
        Sat, 8 Jan 2022 17:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=j0OUCLfNHaU034PxN9KRvkQFqMCKb6Yc7XYLUNXq7tE=;
 b=kP368OksrP8zfbMLGZOFgcKXKzwP2HG38BButvBqynkjGYVHghTa6fyTifAEFOEMQxNA
 Ejrxg81AF5CTTZDpWWjlHERjR9QcrUBTMT5QX/y9DPf+ZtI4uurnY2J2WX4DdO0v+hZ7
 hotw84ECL6u29ZozuNsflWQs/gcf06jnBE72viozNeNMRnEt24vnx0ZE9NKqKZzIDk48
 vRCnu7CMHYqtpdmU2VVfL46uGBBPalou+yxPVv7BWOmniV2tYguG6I+N11rEynKxALA2
 tKWl+gwpy64lK1qnh2J8WaUCa6RganUyA8F174QqxsBh2eMKis6S3XZu7VM4yaHW4Zrf Xg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3df38b87f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jan 2022 17:06:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 208H3fuo011969;
        Sat, 8 Jan 2022 17:06:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3df1vhanxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jan 2022 17:06:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 208H65JS40632826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jan 2022 17:06:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 415F542045;
        Sat,  8 Jan 2022 17:06:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAFF242042;
        Sat,  8 Jan 2022 17:06:04 +0000 (GMT)
Received: from osiris (unknown [9.145.35.196])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  8 Jan 2022 17:06:04 +0000 (GMT)
Date:   Sat, 8 Jan 2022 18:06:03 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/dasd: use default_groups in kobj_type
Message-ID: <YdnEe5sEoRLEBK3Y@osiris>
References: <20220106095401.3274637-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106095401.3274637-1-gregkh@linuxfoundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: enGDZqK2eR6_X9sBQLx3ShLFIIhoOj8f
X-Proofpoint-ORIG-GUID: enGDZqK2eR6_X9sBQLx3ShLFIIhoOj8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-08_06,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=812 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201080133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:54:01AM +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the s390 dasd sysfs code to use default_groups field which
> has been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: Stefan Haberland <sth@linux.ibm.com>
> Cc: Jan Hoeppner <hoeppner@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/s390/block/dasd_devmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks!
