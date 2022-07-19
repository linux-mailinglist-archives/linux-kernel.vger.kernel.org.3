Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5B57A662
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbiGSSVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbiGSSVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:21:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6034E5C94E;
        Tue, 19 Jul 2022 11:21:46 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JIKu15007023;
        Tue, 19 Jul 2022 18:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4239+7A1Y1yd4OxMHATXzHvlctzuUmPhkSeGwmf2pOY=;
 b=dOoZQUhwRJAhXsWMkvwfKAeXoXMRcOaK+29NPdE8aZG6jTdCFkJR0oqs44UKE8sWOXJi
 8OLtrtFei3ElkcA0H6Mkld0lR5CZwgmcdwQFrsx4GrARkZo2+c3WkJuIaGtAX3S3d8JM
 xnfLvnxsMtTVD1/HkIQnMDYWYLfL0q7A+Dv4XjTNQ9SXLkIrsd6bThWvsMIggu1tF6CX
 xoPN6vEba1N4NB9/n66bIEnoyd2kxiE/5DzWG/C/5Z/C7JSDnd6m1Oz8D76IMzb0+LIc
 P+/i0Xa5/QAtTWcH4pzamNf6t5n0TtRQIvKQlRgrecPzMMLAGembbRymjgoIRI3DXoJX LA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he1sx01y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 18:21:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26JILSeN001788;
        Tue, 19 Jul 2022 18:21:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3hbmy8uduc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 18:21:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26JILP5b13304234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:21:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D6344204F;
        Tue, 19 Jul 2022 18:21:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3201442045;
        Tue, 19 Jul 2022 18:21:25 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.22.197])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Jul 2022 18:21:25 +0000 (GMT)
Date:   Tue, 19 Jul 2022 20:21:23 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/hmcdrv: fix Kconfig "its" grammar
Message-ID: <Ytb2I/8wZGVbuP1E@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220715020010.12678-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715020010.12678-1-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EwGe1YH4cPwI5BprbkFQShkuoyouQrvq
X-Proofpoint-ORIG-GUID: EwGe1YH4cPwI5BprbkFQShkuoyouQrvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_06,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 07:00:10PM -0700, Randy Dunlap wrote:
> Use the possessive "its" instead of the contraction "it's"
> where appropriate.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/s390/char/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/s390/char/Kconfig
> +++ b/drivers/s390/char/Kconfig
> @@ -89,7 +89,7 @@ config HMC_DRV
>  	  Management Console (HMC) drive CD/DVD-ROM. It is available as a
>  	  module, called 'hmcdrv', and also as kernel built-in. There is one
>  	  optional parameter for this module: cachesize=N, which modifies the
> -	  transfer cache size from it's default value 0.5MB to N bytes. If N
> +	  transfer cache size from its default value 0.5MB to N bytes. If N
>  	  is zero, then no caching is performed.
>  
>  config SCLP_OFB

Applied, thanks!
