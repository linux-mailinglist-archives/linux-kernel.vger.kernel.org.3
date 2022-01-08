Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9524884CD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiAHRGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:06:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229825AbiAHRF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:05:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 208F9IIj007398;
        Sat, 8 Jan 2022 17:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vVZ67NV2qWaEFX7RxLMhevsGPFLK/83VcaU6ueag4lY=;
 b=TRmQDXI5aEL1dC039eTIrhPusQ3Aru7aT0svnL+25zvPe+JToFcLCK2tOrc4og7vMcbH
 8D4s9e9O/2jfwa/Bn4f/zYlF1kLSQdSjXkYZnoykOxGNOqL6nqQiaPENFNnRiUWlsMZL
 lHnIEuDXwJl/3Qle5kytfGGdu92sYYVeFWu1srnGILddhWs1FEiddEIk6n0D/pb8Uv4i
 FrZ3tQyD6Wfj91EoDgZd2u18X+cTGjlNQJkUFI8+r1I3ziyaOqMXxyQnSGmcYiXOrKKU
 XcMmZEmEH75j4b1P7aQVoBNxV4uyVnLed/FEw/8qy84diy+d3JNW/KeyF1sfrpA7xjh5 Ng== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3df1849sr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jan 2022 17:05:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 208H2Wkx008623;
        Sat, 8 Jan 2022 17:05:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3df288ajtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jan 2022 17:05:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 208GuvtM45482448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jan 2022 16:56:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B60FAE056;
        Sat,  8 Jan 2022 17:05:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F22EDAE053;
        Sat,  8 Jan 2022 17:05:51 +0000 (GMT)
Received: from osiris (unknown [9.145.35.196])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  8 Jan 2022 17:05:51 +0000 (GMT)
Date:   Sat, 8 Jan 2022 18:05:50 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/sclp_sd: use default_groups in kobj_type
Message-ID: <YdnEbnSg5iBKQznH@osiris>
References: <20220106095252.3273905-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106095252.3273905-1-gregkh@linuxfoundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GZ3Cc4-Y1UsuMbJRuZwuasVDRHUL7c_j
X-Proofpoint-ORIG-GUID: GZ3Cc4-Y1UsuMbJRuZwuasVDRHUL7c_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-08_06,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=747 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201080133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:52:52AM +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the sclp_sd sysfs code to use default_groups field which
> has been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/s390/char/sclp_sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Appplied, thanks!
